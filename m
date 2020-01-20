Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBA5C33CB7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 05:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEFC42073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 05:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="x96VEo9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFC42073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQ3f-0000T6-8i
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 00:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1P-0006pT-KM
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1O-0006IC-Fp
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:47 -0500
Received: from mail-bn7nam10on2110.outbound.protection.outlook.com
 ([40.107.92.110]:23840 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1O-0006Gh-Ae
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:54:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCeSI3rXWPLC8/PicHQRvM2HzPjlz0WlEF541nmzfl1XlXO9zCVxRi9AvNkCds9/3plGFhOz1vxRo7wZv2tNqoGJIFK/5TB6OKk0Y+Xr9hf0u7PdoU0GqyKhNIVNJM2grGx655LGASvn/vY5NRYysfpn3zzIZPXm76gEMza53MLSma8lq2gt3Nuns6OxkFafCQ39PgLT38XHd1XugscuycyKq9Ee6KygV+G4LYXqSH1Q/fw1a5uzo4rpgL1NdDUIBYDISfq4y6DhXFLU/Ibt8rXUAzv4HP4mxW1wO0AMjDPRHwTv3+APFusPBQyN1cn7hASFGxJopkR10amSMHOxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKcOoJCL17pZWw8iaVvIqTC73gmiBUaK4eT5muvua7g=;
 b=mxrWVcp6ysq2hxpsStavM3UBU/Ld/xeWppJC9KFuMTFkjeBgRwQZADHjZWg9iDYAR+xmwUBj87VzcPPeQdLZIDwMfbXmOdnOIBoDSZ1ER7ViWE3y6vg7lOVh3ZwaZ0JLt75/ko8RHt5ed3psVy/mbeWVvY7FB8Qpul9LrsgVPpVi1WpojXLfm8NUlPxMwCKWNO/F7X5m59f26TAXFtWJH+Z/8YQbmT8cJUO7gdN5NfVQB1J/iZltJGRS3gAsBgYhB6Cm4X5SXCW4V6ZtgxjpbubyjfgSrPvhC3c8wP+IoDyg4fgQXE6nTP2EQvqq92nQ6weaZ+Z4bFJcu6Spee9QqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKcOoJCL17pZWw8iaVvIqTC73gmiBUaK4eT5muvua7g=;
 b=x96VEo9Er0IXWCLqFjFS4DcfLEb9Wpc2baQ3wRbivaG5x71ecMA9H3tA45rhQ2X1KS7G6g13CwerW68Fm7oLHeYKuFrb4wSlQHW/Ph3z0jPBhTLGLJE7lBBDwAZDb/mO8l5HltqY2isBVzqBvG1JwuXbcejp/KiKWpEUq+J1Bhw=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:54:45 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:54:45 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:54:44 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 04/20] qtest: add qtest_server_send abstraction
Thread-Topic: [PATCH v7 04/20] qtest: add qtest_server_send abstraction
Thread-Index: AQHVz1YdkBRcp/nvekGe+H+4f1sQyg==
Date: Mon, 20 Jan 2020 05:54:45 +0000
Message-ID: <20200120055410.22322-6-alxndr@bu.edu>
References: <20200120055410.22322-1-alxndr@bu.edu>
In-Reply-To: <20200120055410.22322-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:208:e8::45) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0af5f6b-a531-4a69-a917-08d79d6d4010
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB4399BCB0E3BB5B79DAC043ADBA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(956004)(2616005)(8936002)(86362001)(6916009)(6486002)(7696005)(1076003)(52116002)(316002)(71200400001)(16526019)(186003)(786003)(478600001)(2906002)(26005)(81166006)(66946007)(66476007)(64756008)(36756003)(8676002)(75432002)(81156014)(66446008)(4326008)(66556008)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4399;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bxfh8wO6frw/oVbZkEu3yjqGAjUa/Hy1EbiFD/tv5mXjjfyFekNs6TzuaB9kcEMulR6+wTo6QofYmE+obDyJrv6zg+327LTWYyDnYq2l+euJKaPuS6t1NPMWBoTqb1eAv7kkYrleyllbllvyNRlfMJNeMSaFDMOCC9BhT4+fyHhwYZ3kN5m3G0cwoDZuQ7GDE6CvhiG0KWWgS6jEoPWV+04HgSnmgA6itDTrCUcVqOOMnTk+2hYqI3dTTCzFjnREd6lHFn8KIShR9GJrm3YcOVkcavPZjb17cZDpE0rB1ejo1SggB/U9OxJdkbKZHAAszp/EGPxP/fbSmoMmFCwDZXg6+g5KD4lVkBrOxUOtT7m9RXrPlhk4eNCbETBuS7odd8tc16JYkFpoox20O35i9ZrxV+Fgu9q1/E3++6u5pRhJIsiDEVXBBRZhH5UbPnAt
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c0af5f6b-a531-4a69-a917-08d79d6d4010
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:54:45.1872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxW6CNDIOYogVsRl453OzGE6VCFHIRSff8u195CP2q6wPSkWMhK9irHjJi7GCU6Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.110
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
 "Bulekov, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qtest_server_send is a function pointer specifying the handler used to
transmit data to the qtest client. In the standard configuration, this
calls the CharBackend handler, but now it is possible for other types of
handlers, e.g direct-function calls if the qtest client and server
exist within the same process (inproc)

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 include/sysemu/qtest.h |  3 +++
 qtest.c                | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index 5ed09c80b1..e2f1047fd7 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -26,4 +26,7 @@ bool qtest_driver(void);
=20
 void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Er=
ror **errp);
=20
+void qtest_server_set_send_handler(void (*send)(void *, const char *),
+                                 void *opaque);
+
 #endif
diff --git a/qtest.c b/qtest.c
index 12432f99cf..938c3746d6 100644
--- a/qtest.c
+++ b/qtest.c
@@ -42,6 +42,8 @@ static GString *inbuf;
 static int irq_levels[MAX_IRQ];
 static qemu_timeval start_time;
 static bool qtest_opened;
+static void (*qtest_server_send)(void*, const char*);
+static void *qtest_server_send_opaque;
=20
 #define FMT_timeval "%ld.%06ld"
=20
@@ -228,8 +230,10 @@ static void GCC_FMT_ATTR(1, 2) qtest_log_send(const ch=
ar *fmt, ...)
     va_end(ap);
 }
=20
-static void do_qtest_send(CharBackend *chr, const char *str, size_t len)
+static void qtest_server_char_be_send(void *opaque, const char *str)
 {
+    size_t len =3D strlen(str);
+    CharBackend* chr =3D (CharBackend *)opaque;
     qemu_chr_fe_write_all(chr, (uint8_t *)str, len);
     if (qtest_log_fp && qtest_opened) {
         fprintf(qtest_log_fp, "%s", str);
@@ -238,7 +242,7 @@ static void do_qtest_send(CharBackend *chr, const char =
*str, size_t len)
=20
 static void qtest_send(CharBackend *chr, const char *str)
 {
-    do_qtest_send(chr, str, strlen(str));
+    qtest_server_send(qtest_server_send_opaque, str);
 }
=20
 static void GCC_FMT_ATTR(2, 3) qtest_sendf(CharBackend *chr,
@@ -783,6 +787,16 @@ void qtest_server_init(const char *qtest_chrdev, const=
 char *qtest_log, Error **
     qemu_chr_fe_set_echo(&qtest_chr, true);
=20
     inbuf =3D g_string_new("");
+
+    if (!qtest_server_send) {
+        qtest_server_set_send_handler(qtest_server_char_be_send, &qtest_ch=
r);
+    }
+}
+
+void qtest_server_set_send_handler(void (*send)(void*, const char*), void =
*opaque)
+{
+    qtest_server_send =3D send;
+    qtest_server_send_opaque =3D opaque;
 }
=20
 bool qtest_driver(void)
--=20
2.23.0


