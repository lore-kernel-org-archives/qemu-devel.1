Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5B8C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5FEC206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="IRiWgP9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FEC206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1hP-0004Pc-It
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 18:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TR-00084e-Ad
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TP-0007gb-I9
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:53 -0500
Received: from mail-eopbgr820113.outbound.protection.outlook.com
 ([40.107.82.113]:22310 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TP-0007aZ-AD
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgmr/4Ca71vLHDdCrIXj4ajI72UikI9m0QEmkqhGW8if/4zSza368B4Rpp7b3EpaK+fIGs7PmRSmbT2BZiDyqha/CfxOGwSbMFRrqEJMjnnZtMoWq0hf2k0ND7HyNW3/5IB4UFWt4ael3+lSVFAxnG0w90O5J0Sw1I59bFcEuxAnuNG8mBUzgQgYVs7OIHXRaj0/YSA8RXh808hT9IgWZYsMhlbmrkVBFm4t58ZhPR4heW2VjkxEo4S9zmHWD2+sUestgVa7192F+YgKgToXPAK1yV/GpQMCSS4mXyTkXc1zPDUpOibguUOzSE5U/Q2oum5HhhYwWqun3hqOsV4SHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dUqV08PqCrdbuRjPPA7i2HqDaLXyfJoEpaRBuKiyME=;
 b=S8AACylzQEuk1VoqpO6B7KrJkhBBodvwlwCL2k0KRIPmiCI3m0gfEauLrbptuCStsJTlnps+YcsgX1ZNMTxkEHiScfzerBxgxWpiS83qpV6/aszjewARaJCWHpf4ZWSfRdsrsctSSjrlyctclYwErc8Zsk6QOgD4z0PPbjJvOvGS2/nqvlTdJg1oalRuavQdF0Jox6FFomQY1jKhlBdsWsXasbLFwTNKSL56RnnIc34O/9/hgjXgAPqxk+7RgidfquBhOwG2YVlsZ6wnGSjy8juW9VUYItM+K0aoT+LvlGP0nmdN7Of7yrksYfX+g0b7DIsI39thZqfiyj0h4zUZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dUqV08PqCrdbuRjPPA7i2HqDaLXyfJoEpaRBuKiyME=;
 b=IRiWgP9n8KnfL2GerYqPLk54rEamAY0Djt5W5kIEkdXsgewzG1lL/XbGh5xdiHpm62niUZj7NAGoYJe/B/gUhhVqHpnynHoVu464GQp28Su9i69cxmSTNZ0pFy10nX8dOR11J8GxjF4SY9v795utesr1QbiVInx10BkZrUrDrFA=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:48 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:48 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 11/20] libqtest: make bufwrite rely on the TransportOps
Thread-Topic: [PATCH v5 11/20] libqtest: make bufwrite rely on the TransportOps
Thread-Index: AQHVmnTKOHCi1HU6sE+aXU4EYMuRlA==
Date: Wed, 13 Nov 2019 22:50:48 +0000
Message-ID: <20191113225030.17023-12-alxndr@bu.edu>
References: <20191113225030.17023-1-alxndr@bu.edu>
In-Reply-To: <20191113225030.17023-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de05b49a-50a7-47d4-2966-08d7688bed0f
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB5024C1EAE743C660BAFF464BBA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nXGWY75+A45m0k/mvwmz9buTWmhBIjmjduxHWIOchGR0yXE7IqvZR5QEC0kd70AruoYHXqmTfXa0u3Q+y7zVn5EzL4Jp0kz1JxcMleaGc+gR/STDsxKLmoQZ5AJHlyoyFtKT+dqwGfFEdqPazNwnbTRg7jRXnYIlAzDHyLPAjy0TDeUzdzW3C/PdwBciRTkzm1Tez0Ywdnt5gRyYCKI+WMVyTEGBbhFXRZGCqQdn9Q1SfkRJb1YQhEBa1seA7rnzI7W3kacalhd3rinJc0wsuPS0ob+8yBV/mA5nq3C5vRdx5cpWS3PaMr7Pfd0K5GLcziPWiF5UDeN25QT96Ey7LIEX2ERSWS7+7PpPBZzukPBcnVkHKu0k2l+/c2JUeND0lvOIqWi/rS+apxDxcQEGVRtkBR8ox3bfn990Q+sQfXv1rMcI6+jrDECC9iWbB93b
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: de05b49a-50a7-47d4-2966-08d7688bed0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:48.5849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MKLVNijB5uPEldAwUA1h0HKcklLKn8IdnUJwDjDtsJjahwlCKTVkDDMguv08nE5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.113
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
index c406b2ea09..6d3bcb6766 100644
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


