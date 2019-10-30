Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65D1CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9972420874
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="IPYQVNVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9972420874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpV5-0006Fe-Q5
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 11:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIP-00050A-Fp
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIN-0007H3-W8
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:01 -0400
Received: from mail-eopbgr690115.outbound.protection.outlook.com
 ([40.107.69.115]:23033 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIN-0007Ax-Om
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:49:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk9XJGQhe2HsG7t7VfXJ+uA965Yxde4MT7Ognxv3t4p1b/OqryHAY8+P2PAG1LuzLKg+My2ltJduTSp4vF1NUdzgstAJAOqzEHSeYKdlo1e7qIDSP6D2cU3TVsuYYPUzt1ViYyriLzAnf1MUEJT5/VZE62TYuPYuimJBe0k+EcUGjZzLbwEgY+i8uiVtwbppyfz8QEguDnPRcGrT4MZuC125vLqKXonRk+5LVbT8E8xI5rg+5EZ/HlROrl4Vralgujp/f/GaRar7OFMgdvy+zMO9GYcG6Jzz6SkKJHLGrxDhfs8Kejlh/J/sLzPjbN1od4oBa3u7gP1/b7z+l0TwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5sgL4kkRD77xB+hq+p0VcS0k4XgsH5CHmlSdf6ZUvc=;
 b=V60MDBT13JpKtIe041pJ3IRIy88S9lUa2ZE585+ngTWE79utYkbHXuk3TwLjCl051DWNIm5z5y9LlyfVZL61NL4z89KVdO5zt+HyfcSTiPH++YoZ5JWpgNx2NNEiVPPyc9AUAGqKw5revWn3bdcur3ieHON7+qDTMgHuOeZVPuW0U8WiTapFS45jwzGVyKLgjX7IG4AZAafqbjH0opavHSe3YiLMNCZr3SLaKVPs2ttED14NBG9KTo/lhDu63ES6N/3+tqx6ma9+0WqklsexDzdMPDK2aUg4CLKTvhRGFzUD2P7ImqtdsjMiQJaz5Knjy3T4CBEMqjXbAOTlGhcBBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5sgL4kkRD77xB+hq+p0VcS0k4XgsH5CHmlSdf6ZUvc=;
 b=IPYQVNVxDzKWUKebDj8THxCYy3B1njjTycwvOZb1SjY1b7trmca21E+B30C9YP7ZcUDKrG9Ro+NQYayIVTWxV8VVISb4mAfHjjeih/nqka2wXJSDuZh64FsHDbkUPkwcfpnXTgmhBZDhH1E51TDM/f6klTRhzZFY3ApOxBlbS3s=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB4959.namprd03.prod.outlook.com (52.132.168.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 30 Oct 2019 14:49:57 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:49:57 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 11/20] libqtest: make qtest_bufwrite send "atomic"
Thread-Topic: [PATCH v4 11/20] libqtest: make qtest_bufwrite send "atomic"
Thread-Index: AQHVjzFMkTj1zf9vkEGJEPFn4TIi9A==
Date: Wed, 30 Oct 2019 14:49:57 +0000
Message-ID: <20191030144926.11873-12-alxndr@bu.edu>
References: <20191030144926.11873-1-alxndr@bu.edu>
In-Reply-To: <20191030144926.11873-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: DM5PR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:4:60::37) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2bea292-7ee6-4e83-ec6f-08d75d486eb8
x-ms-traffictypediagnostic: MN2PR03MB4959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB49591DD8AD039D930176578EBA600@MN2PR03MB4959.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:449;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(102836004)(386003)(6506007)(66946007)(66446008)(64756008)(66476007)(2616005)(186003)(2351001)(446003)(26005)(36756003)(66556008)(3846002)(6116002)(2501003)(14454004)(11346002)(66066001)(256004)(4326008)(6916009)(305945005)(1076003)(6486002)(486006)(5660300002)(71190400001)(50226002)(71200400001)(476003)(86362001)(88552002)(7736002)(52116002)(76176011)(2906002)(478600001)(99286004)(786003)(316002)(8676002)(81166006)(5640700003)(81156014)(4744005)(25786009)(6436002)(54906003)(75432002)(8936002)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB4959;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: phr6d/yQ94mvtM1pM4XiSiIm0jpAdYg7qnXbaLE7nSRyLcLiNIHg01Z14OcPCdnyf36/si1gdXl50soeuJ0U9rxpcjbH9Do7RC6q8JSFGO2GascBmSM8EAlQJYuQar5GLQX1v+iWUPfAvrlsQqLRHdicdpdcSeRNxoS3dU3r5GEkcG2+UzOyeEJL7nwW2bR1OamDgTqxqR4dFYqhVnIrvPcaFk4BadJZTpHnqQPazbAouawCbxSmaqWUccONWGBJS6nIIwAeZWcXciCTnd/hCv+PL4H8SAiPtLamVVQsmU8rm2INQLnve4CD6rTdiaKqr5kchichzx/O+Y6wq7XKuiciVm3V4U7rXRzPj79NMJmqVNc8X0KKZZ8V5zrGCYKP4R1KtTwOfjOpCq20XmR8Zkgh7U01A7A45rqBCnSjAK0O5oZfJhtCYK06jYUDYThU
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bea292-7ee6-4e83-ec6f-08d75d486eb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:49:57.5614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBXU/zUltKb0n4EV9GvYsm47Tqi9vhBo5HPWVKCJk5qbTx/nXX62FNFdhXVuWGBs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4959
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.115
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Oleinik, Alexander" <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Oleinik <alxndr@bu.edu>

When using qtest "in-process" communication, qtest_sendf directly calls
a function in the server (qtest.c). Combining the contents of the
subsequent socket_sends into the qtest_sendf, makes it so the server can
immediately handle the command, without building a local buffer and
waiting for a newline.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/libqtest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 822bfe208b..ff3153daf2 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1083,8 +1083,8 @@ void qtest_bufwrite(QTestState *s, uint64_t addr, con=
st void *data, size_t size)
=20
     bdata =3D g_base64_encode(data, size);
     qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
-    socket_send(s->fd, bdata, strlen(bdata));
-    socket_send(s->fd, "\n", 1);
+    s->ops.send(s, bdata, strlen(bdata));
+    s->ops.send(s, "\n", 1);
     qtest_rsp(s, 0);
     g_free(bdata);
 }
--=20
2.23.0


