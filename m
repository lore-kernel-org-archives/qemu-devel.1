Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63E8C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EEC7215A5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="PZt5Gif/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEC7215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iao9t-00015y-9u
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:50:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianui-00006r-Qa
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianuf-0002uJ-L2
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:56 -0500
Received: from mail-eopbgr740102.outbound.protection.outlook.com
 ([40.107.74.102]:45028 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianuf-0002ik-GX
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VflXiF0WqJ9GTSTeUm5ZRJkw04UYtgeVk+XSbbflaTuDyXTabfFNq1+6VteR/q8st8TJauVLYTiqdmShNBnu4/EHx3V2qqB62XvIsGE16fsCalFNApRhuPP6G18s2YmDp2YxoojNM6n3EgGB/vFKTbp/vIVL8pMok6OFlZKI5dv6tPU+SSznmX/i62nIlcW3IIguEiFCrmZb0blQ1iVMfxPPa7gfdDRqoAKU+NHbAtWsyoccrlXaD5xga/xJg8U2YJ3bNJP+ikXAPAMLt+xixCsJKiOqp4ojMUWPhpKmfNvq4svXCt+E+y49iIrvBbl1HKV0EVDcqoCdGHwMw41CXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMdGj5IX5OPg61D0y3/wZLsV6Zx4ahn0IVp5rB7tC/o=;
 b=aRjOnN853On5KlieGZ54RZso1nEIxXqGyV1jm9NwiC2YAH9GBcRxy+ydxtv88cXeQtKB9fjGC1vHdrUfxQak3fGBpEDbLeez1oGRwh3/UGl9O1zN96o/BpzPE9Ej/yYg6GqV5NgnlJGTEqinIOpCRLTPD6PzQqTNpqU/nqgMQs0LDz8R2IjZWeMgzJ3hxgf/dblJFUxN9W2TvxMxf7UF+GhKjYuyVQdCAAB9HVFAB5wQ4WQlgH9BX0xXnwG2KVrS/S9RwGb8EOnyjxVyxne4b5Gb1s4YNlEm5Nl5V6pu+2F+1Va5L0Nmj07jcdRo8JsqKnFokEULyi8AnvSGJ6wLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMdGj5IX5OPg61D0y3/wZLsV6Zx4ahn0IVp5rB7tC/o=;
 b=PZt5Gif/UHJHA4lM0AU8BldgbOhG6m6gipOMeWfvg6DHGXcyLRrEQMtTUiTa+ZWee6uwJW1VRngImoVGpzjUNoORbSwEKPe0Pm6F42g0AKqzOJag5pJR0XEdKKfrHrL23U1rtXZEwQP68yyKyOXmcJp84zqJJGh9ACEZxyEhpvA=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:46 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:46 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 11/21] libqtest: make bufwrite rely on the TransportOps
Thread-Topic: [PATCH v6 11/21] libqtest: make bufwrite rely on the TransportOps
Thread-Index: AQHVpvzSGewKScuhkEiKp4HmTD3BMA==
Date: Fri, 29 Nov 2019 21:34:46 +0000
Message-ID: <20191129213424.6290-12-alxndr@bu.edu>
References: <20191129213424.6290-1-alxndr@bu.edu>
In-Reply-To: <20191129213424.6290-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) To DM6PR03MB4795.namprd03.prod.outlook.com
 (2603:10b6:5:18c::22)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9eb8fb28-6188-4a24-4ed3-08d77513f4ad
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB5050251C4C9CDC7E310DAF75BA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(81156014)(81166006)(66066001)(6436002)(3846002)(8936002)(66946007)(6116002)(1076003)(66446008)(64756008)(66476007)(256004)(66556008)(316002)(786003)(8676002)(6512007)(102836004)(6486002)(478600001)(71190400001)(71200400001)(2351001)(86362001)(6506007)(14454004)(2501003)(75432002)(386003)(5640700003)(2906002)(6916009)(7736002)(2616005)(25786009)(26005)(52116002)(88552002)(99286004)(5660300002)(76176011)(186003)(446003)(11346002)(305945005)(50226002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR03MB5050;
 H:DM6PR03MB4795.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A97V41Rgqkje6U66tmA5FTa15wzegwJzqcOPugKaNcD8wWw/opMEVEE2vCHTtAc3oo3r+y2wZqacrBekXP87JSNHlNbhj12bbyuI9uCFlyYGu1aZAuSSr0lcMhsmWFjiFlhz0hMo9AfxSqFLJSp+Uc2Yd8qXJTQFkQHtS55hMGOAt0bdvSqFTQfArryDBdGGKPxGauyRsRRvlBKOloqHeczgV3X/YijW+4WvgMy1L8E5SZxTUkrFwFcg/0uVI9V6x+f6TPsuuaMbBz4LFQinFtsqrW/7jncsC3tM02LPROCr06gZW/xWM2ehNVyOP+pJPVZjtkSoduou+ejkxT0LGKcGntm64krnBBt/Qe1T4RjPpi4mNf39XOidJTNsBqAKbg15763JChyToiDRNzAejkvqDTXxEfo/LlSL558rwaOl+lM7Zv1z97dfCsOCyvg7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb8fb28-6188-4a24-4ed3-08d77513f4ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:46.8140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYblGwUyZ+ptxxoPT4lpEpcooR7DZMUio4Y4qAP/1cSiWIiffbk0kAVSLm0lu0xx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.102
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using qtest "in-process" communication, qtest_sendf directly calls
a function in the server (qtest.c). Previously, bufwrite used
socket_send, which bypasses the TransportOps enabling the call into
qtest.c. This change replaces the socket_send calls with ops->send,
maintaining the benefits of the direct socket_send call, while adding
support for in-process qtest calls.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/libqtest.c | 4 ++--
 tests/libqtest.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index ac4b6ab5f0..a7df92319a 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1080,8 +1080,8 @@ void qtest_bufwrite(QTestState *s, uint64_t addr, con=
st void *data, size_t size)
=20
     bdata =3D g_base64_encode(data, size);
     qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
-    socket_send(s->fd, bdata, strlen(bdata));
-    socket_send(s->fd, "\n", 1);
+    s->ops.send(s, bdata);
+    s->ops.send(s, "\n");
     qtest_rsp(s, 0);
     g_free(bdata);
 }
diff --git a/tests/libqtest.h b/tests/libqtest.h
index c9e21e05b3..0e9b8908ef 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -729,4 +729,7 @@ bool qtest_probe_child(QTestState *s);
  */
 void qtest_set_expected_status(QTestState *s, int status);
=20
+QTestState *qtest_inproc_init(bool log, const char* arch,
+                    void (*send)(void*, const char*));
+void qtest_client_inproc_recv(void *opaque, const char *str);
 #endif
--=20
2.23.0


