Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED5ACA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59C220856
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="act9dtTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59C220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpPh-0007Vd-2O
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 10:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIP-0004zT-1B
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIN-0007Gl-OP
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:00 -0400
Received: from mail-eopbgr800133.outbound.protection.outlook.com
 ([40.107.80.133]:23904 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIN-00079I-Il
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:49:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRuHoDrbYWkf/Mg3/XLjRB8YbG1Qxtsy9ePrVHOesezX/s05jcwlI7IPpWol8LCJWkKJr0XmEWOP66noGFtRj857dpVPauz9up8oa8B9pEvDIOSKj2keSmD+b3sPw2qXLoLzL5673eOFDexhnoNbHh5/YG23+B7dQCYuIXIO5eFnEz6HMoBNU9PMGqLch/Ns7c4wfB3y6pD+56UiGOwvCqe6BTNrigWIvZ6aUHZQZicwBX7bq4kmrtWyDVlleDDONccXck4fagasVDZfHOZJxSNi67CQNfgQRDhqTCRy7RwF5gWC16VLjq5EhU9BwcuVMpTFXfuCCGnLu1xvqLQHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyTLxcwPUri6KyiHEnlfaVVxabER7ITxYC5q2iw6ErU=;
 b=CyxRuzQKZUK/acqRMY4hk8JUMQnr+r0Uwd/sd0JmUp3XzMJp/Ow4+d4kFAQ9pTI3xBMy6Ct1YgX12jw1swHekpzpJyenQqp5yCIQvg6cQQXKTU7ANwFNS6+1/et+0CEPwUvsIHVa/2dym1sYcFSkfgeTuXJjxsyhHVddH2jxgcaO/yAo95cgk3Dr/xgoCFT2PQvJcPZZBFKaYz2SYe65GDSxiP+Gb93Pr3zb0YrqMNhDBI4Lx7g2XFOzsrQipTOVvwSwnohYrMmbCOdd+cT05pa6k+dzpUuKEruyI/6AN8IO4emAAuPeyL7VfbuUYYvFIevOxgT7BYAi4fwZ7Nq7Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyTLxcwPUri6KyiHEnlfaVVxabER7ITxYC5q2iw6ErU=;
 b=act9dtTfOr6WNPcpj6X8+WI6lTi+ptRDErffA8noACGvzTIV9JY9HSqShhEO6HGjkVMqRU8DrcpAZlPG2qizHO9+N/OadNJvm/UK32LWLFgsINQ0MXPUXjKO3arEdQNl0d6N1fRj68QKkKavia8YEDJmYDIKIgvRklLZJ8XWEmc=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5054.namprd03.prod.outlook.com (52.132.170.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Wed, 30 Oct 2019 14:49:51 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:49:51 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 04/20] qtest: add qtest_server_send abstraction
Thread-Topic: [PATCH v4 04/20] qtest: add qtest_server_send abstraction
Thread-Index: AQHVjzFIpASyVcuc7k24aWX+rvoPGw==
Date: Wed, 30 Oct 2019 14:49:51 +0000
Message-ID: <20191030144926.11873-5-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 1d944365-7338-4fd8-82c1-08d75d486afd
x-ms-traffictypediagnostic: MN2PR03MB5054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB505498AFCACC48FEFD2493FCBA600@MN2PR03MB5054.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(2501003)(36756003)(476003)(86362001)(88552002)(386003)(256004)(316002)(5640700003)(1076003)(99286004)(6916009)(75432002)(486006)(786003)(11346002)(6506007)(4326008)(54906003)(186003)(2906002)(66946007)(26005)(6116002)(14454004)(446003)(2616005)(6512007)(305945005)(71200400001)(478600001)(71190400001)(81166006)(102836004)(66556008)(64756008)(50226002)(8676002)(81156014)(66446008)(6436002)(2351001)(25786009)(5660300002)(66066001)(52116002)(66476007)(6486002)(3846002)(8936002)(7736002)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5054;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HRCoxCCkRdtv+jq1S3b2u1rbgkpKHdkYpL3nyFxp0TQ31qUuq4aJkdidDbyicj9M7V3f/DcEKlp8M52UWz5OVNvUlIUJyDt9tvjkWkTWJjLyioyXTEKepeMpFWHhUKTAj1tG3pykg8TcSk32ahzNTq5BFFhkUzLLRQgSHkvKaQ/ETytG00h2v7HNF3W167VcswWNBlUyD8tps9zQxnAvETaRui5tmdbyfqJy6Gyo+7eS26oZk6QgEI9Nqo0gfen+4JnC+WM7951W2bzfn6ORnNvnJ4WNBviEHZqxQSFfwXHfGQxIWfUgy/blm/p0uX4cbAN1yGJaPv2M+jNPNHDcvmmCJRGI4mcS2XGl58XGnDubWfycl1NcY/mm89jjd8nkpmnKFGpmiOp3vwTTCr5TXsjIXEMGqVMpH3kudSgWM33Nh9mnL9MDyiaAHIW9UYVl
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d944365-7338-4fd8-82c1-08d75d486afd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:49:51.2650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUtDrmhE9EinycPjtC3eBHzlkNTFG3rKXu08dhPqLqTe5WnUw1cldsGLdfU/gaRE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5054
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.133
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

qtest_server_send is a function pointer specifying the handler used to
transmit data to the qtest client. In the standard configuration, this
calls the CharBackend handler, but now it is possible for other types of
handlers, e.g direct-function calls if the qtest client and server
exist within the same process (inproc)

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 include/sysemu/qtest.h |  3 +++
 qtest.c                | 17 +++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index 5ed09c80b1..fda7000d2c 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -26,4 +26,7 @@ bool qtest_driver(void);
=20
 void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Er=
ror **errp);
=20
+void qtest_server_set_tx_handler(void (*send)(void *, const char *, size_t=
),
+                                 void *opaque);
+
 #endif
diff --git a/qtest.c b/qtest.c
index 8b50e2783e..ae7e6d779d 100644
--- a/qtest.c
+++ b/qtest.c
@@ -42,6 +42,8 @@ static GString *inbuf;
 static int irq_levels[MAX_IRQ];
 static qemu_timeval start_time;
 static bool qtest_opened;
+static void (*qtest_server_send)(void*, const char*, size_t);
+static void *qtest_server_send_opaque;
=20
 #define FMT_timeval "%ld.%06ld"
=20
@@ -228,8 +230,9 @@ static void GCC_FMT_ATTR(1, 2) qtest_log_send(const cha=
r *fmt, ...)
     va_end(ap);
 }
=20
-static void do_qtest_send(CharBackend *chr, const char *str, size_t len)
+static void qtest_server_char_be_send(void *opaque, const char *str, size_=
t len)
 {
+    CharBackend* chr =3D (CharBackend *)opaque;
     qemu_chr_fe_write_all(chr, (uint8_t *)str, len);
     if (qtest_log_fp && qtest_opened) {
         fprintf(qtest_log_fp, "%s", str);
@@ -238,7 +241,7 @@ static void do_qtest_send(CharBackend *chr, const char =
*str, size_t len)
=20
 static void qtest_send(CharBackend *chr, const char *str)
 {
-    do_qtest_send(chr, str, strlen(str));
+    qtest_server_send(qtest_server_send_opaque, str, strlen(str));
 }
=20
 static void GCC_FMT_ATTR(2, 3) qtest_sendf(CharBackend *chr,
@@ -783,6 +786,16 @@ void qtest_server_init(const char *qtest_chrdev, const=
 char *qtest_log, Error **
     qemu_chr_fe_set_echo(&qtest_chr, true);
=20
     inbuf =3D g_string_new("");
+
+    if (!qtest_server_send) {
+        qtest_server_set_tx_handler(qtest_server_char_be_send, &qtest_chr)=
;
+    }
+}
+
+void qtest_server_set_tx_handler(void (*send)(void*, const char*, size_t),=
 void *opaque)
+{
+    qtest_server_send =3D send;
+    qtest_server_send_opaque =3D opaque;
 }
=20
 bool qtest_driver(void)
--=20
2.23.0


