Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8681FC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569682071E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="nYks4REd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569682071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwg3m-0007vg-Fa
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfzY-0007jf-4b
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfzW-0001tb-U3
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:20 -0500
Received: from mail-mw2nam10on2091.outbound.protection.outlook.com
 ([40.107.94.91]:22496 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfzW-0001pW-NP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPCEaghrozgBTzi9d8mE7NBnqKMHAwZkraDImEM0mbxkmxncXAdRA4lyitxilTNE9wyRZcJft7DEUolF6MukTYWBmpAwF2kiwqMsp0UTQurdDnSTkcAJoAoJVpUA5UXsw25mUn7foMzaTkPTZDk8WPEiJJcDXR5RoZHTaYKS1K6pRkO9clk/NkG7Av24XSaADcW6tMLStgrpnU7EdgdpVnX1yv6ss78gk5JFEqvoz+KCk5lYKsV9pAJvSwlSSxdG8H4yMD1Dr8WowDGdiXylYUzNPbsQTnUybOyACYCfunb3x39nRqRVlffNQ3BMeNx/6Syau2NKfKvjMy7dILSyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKcOoJCL17pZWw8iaVvIqTC73gmiBUaK4eT5muvua7g=;
 b=FWisoDW+2Yn76EUyGGlZTtuiy8MfAVHrsQdgmD7ENIOy3IaAw4LC67gzGPvJI5t2wXwJK0httyMy+CkqO6tMdSXuSzTS5JwhRY/eYrwY1eEvtFE2oZTZgWbolAlSQ7tiFEylqsyioyciik55FlmDS83rLrbRmLGBILnn8CplcvtbJnQ+gi90LaUUCcm/x1FgbuD2m9JIp4p0tTBkw+VGc9NGNaJLywUP85aMtiPX+Q/CkA+v5gMuQasdIjTh42rK8jJOzILpJevD1EzIjuKUR6kb8A4OIqx2wFi2n8UYYC+rfhu4fKbFBwu1YyiUswLhJHEMUAC+jhM1hD/z0PxbJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKcOoJCL17pZWw8iaVvIqTC73gmiBUaK4eT5muvua7g=;
 b=nYks4REdrr8GBcSzKWoC/6Q2ub7ggJjsIn43STXHqdtCdsXUjTDvO6Ooiq/SOGfIwJO/M2auAOZHJcXTBkdI5q8Bex6AnhYQWGMRE6msDxPYq7RechTHTFL56uyNBn/GbQxt4pRffLpXBEtVhrrCSAwBLTAHFMoDQNSPp1oBJjk=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:14 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:14 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:14 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 04/21] qtest: add qtest_server_send abstraction
Thread-Topic: [PATCH v8 04/21] qtest: add qtest_server_send abstraction
Thread-Index: AQHV1mW+BDWXA2PNSUu9WUST2iJ9rQ==
Date: Wed, 29 Jan 2020 05:34:14 +0000
Message-ID: <20200129053357.27454-5-alxndr@bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
In-Reply-To: <20200129053357.27454-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:c0::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bcd7225-13f2-45bd-b6ba-08d7a47ce07f
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB42062557B0CC9C7A1428BEA7BA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(478600001)(75432002)(36756003)(316002)(6916009)(2906002)(786003)(4326008)(54906003)(26005)(186003)(956004)(2616005)(6486002)(7696005)(52116002)(16526019)(1076003)(5660300002)(71200400001)(86362001)(66446008)(66556008)(66946007)(66476007)(8936002)(81156014)(81166006)(64756008)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4206;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYtKZ12pZbBBMPBuvL33liFt4Cz9huKb0u5sBmtIDSTOkwi5Z/TJ3fLqTJe9QTmZk7KJtpKvzZGnPo2/SVy4c5E5mQ+AdT/xqu7fF07tUtArsBwg+hEVXZvoiU/JZyMwyOM5xLvGmR3lY4gWO5gP/PmVJxUVs5Er4998wLYuu/YxW0BnkWvC6bSNEDhlboyNegdqDCnnOKB87zVGacm4SFsdsbmFjtdb5zJaOC4yC3tOhxW9Q1zdWdaKnJbo0vbULSzZLZQ4wYwZTJRByARmFGlfpCzxovLj5M5VLZ+GNCdPXEfKTN212hzRr1WWAA+HMFb6gKdjabdVszZ9hmy88FGxPTWDNOd8iMQZ/lqIcLG5hf1rHjiW3/WGaWjd9Ejc8rlmvlwg9+7jryP8o9mxOL+4fZCBYO9uU666rj/6YZkL+IBaZ9OUj1kheqNLqShh
x-ms-exchange-antispam-messagedata: OLRqm7qUwHW+RZFheqPAhAeA/j4z9/Q6INH2HcMciVcF/OCGzMyBSPwZp9WQB6/Z8MUi7i0mKtPUCpbzIUEsIvU3b9QUEBMFvU5kE949m+/5UvTsPc+7g1wZiJY3zk/fEyK/u9Oh0ESgunsDd4Gv2g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcd7225-13f2-45bd-b6ba-08d7a47ce07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:14.7809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kjA1h0an1YHx4PWlTMb/pIudwQqm+ZuU2xXlA+cs1A/PMpdgdwQiBlgv6OCj0+P2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4206
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.91
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


