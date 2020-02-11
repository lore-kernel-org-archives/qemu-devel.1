Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB056C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E09820659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="lv4k0O1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E09820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cLf-0006r7-E5
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cFu-0006RL-LN
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFm-0008G9-RE
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:34 -0500
Received: from mail-bn8nam11on2135.outbound.protection.outlook.com
 ([40.107.236.135]:55392 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFl-0008Dh-8V
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiwbszkbtT5FFE1Y3AlHLf1PdlQNgkgtgejpRWiS09P8A0mWkNlLYEfg/mIONKqyuCyc7ldqXANVMcDkw7NVzdqWRh/gJIsZ6ZvhxTC7WC82ppRnTaOyAnXd3YRBj5wqV8jkNKVMMEc6EynwoudZnMvWerWNHCvljcjzPoq6YBYX3SQ/MUvhQfZN2Z2W/yWA5+/97MwNMqlR5LVUAsBh7mkQyk1Vv3vnxO+8nfHGjkWp6sCa7DjV50MzU/mJTC1puRI2AHXjD1uIjYVwbZlJmYduEjKkUmM6S62H7XYJF4nsQFhAhW+Uhx1M8RrC3mxa+ZfzEHa8gOB7htKpZtyf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBiT+0qsUNVdCJeGAm7aVIBl9MNXqasktQGcxSWQ3oM=;
 b=UsCux0EaCBNb3uDQ8aIagO0YOz2PjG134HP90YL4euw+rILqHQL2+kfMh/MA50wRU03RYFvYxaGFREsinJsuZqxXell1e+jY81DUhZG9VOIugxkzFGuRmXPVBXwdhBSJDVj83jxSMkJRCW9ave5/583sXc0gaIdw2P1UW7p4tMVE6cswGui9QiuJHLEMjP4ZWhdG3mRMOF1lJ06SxEYddqJdrR7ikU2iFkJpaZoDReSerM0g3uXQ0z2uAGMaXqV+phaYzhBu4KVt264jSQu9nb/xzEmlBnvR2WSLRJtyk5pY8i9xyOhlEelX5EFWSObGZ7Tp2ArbGEXk/XLFMu0eZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBiT+0qsUNVdCJeGAm7aVIBl9MNXqasktQGcxSWQ3oM=;
 b=lv4k0O1eU9z7i5mjWvyecciLUgCzRY5JtheOgWgR6cgq5jN2PqAFmHSOy/w5y5brIvaZ0mLDPzC2x8J+SGLW9K5L7LFP0Dc7u6xUpt3R26t6TXhML8wF6xDpV8GlglJvMNHeTD+9jRoNyxnxuKgmblYj5tRsdM+mGOTQ9M5bnzE=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB3599.namprd03.prod.outlook.com (52.135.87.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 20:35:27 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:27 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 06/23] qtest: add qtest_server_send abstraction
Date: Tue, 11 Feb 2020 15:34:53 -0500
Message-ID: <20200211203510.3534-7-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:26 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6df2fe18-8a39-452f-693e-08d7af31edbf
X-MS-TrafficTypeDiagnostic: SN6PR03MB3599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB359982C186537EEE9C57B9D6BA180@SN6PR03MB3599.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(36756003)(52116002)(7696005)(478600001)(6666004)(54906003)(316002)(786003)(8676002)(8936002)(956004)(2616005)(4326008)(81156014)(5660300002)(75432002)(1076003)(81166006)(2906002)(66556008)(66476007)(66946007)(6486002)(26005)(186003)(16526019)(86362001)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3599;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pKH8Hy7+y+zEK58r15g65sXdAb8Qpsxg1YD29NzCTSPH8Prf3juHytVnq+X3q/YWOWn6oHSVIw81D9oLamQ5+/89QX6CU7qxYoQAbFsCuCXTGfgVFN0R3vhZJTc/uYLV9CN863rkhrVtIFKHK7ytHFo9gQvmcYs3RQcSLzTYVx61gUKzPIklu0WLPqr3pXxXi1BKyvbXAT0k42G8K2cFNIEMvzS1pPL2GTjsnORTkh8AvOWrrCduWIgsbwLctBzwVMoAaToPXxqXSYzhq9kAabq/53BbA1h+YB5dMOQnsjbuk0FXuo8/yJcA+wmADG0fhf7ZL/JjQoOlO0f6ASVaCCzIEevPty5eFho4gderrtJv6f4XQGFs8r4QkXUIu1Es+rdDXS7lZ0QydA9uceYMWiKohIH/v0KalfVLm313xyJKQ6TcaL5gOTQ2FSbk03H
X-MS-Exchange-AntiSpam-MessageData: Jk13ytOMuF5jmVR4CqMFeI3qAVGkkM2L2N07WxgRN+T7sgsuEpIx9Ta6N5+egiwXg6IQvjLJGDB1ttm1Sq45hLXSjQLzz1zJYWwOWGRT7YovOPO0NCzbxMXjqB8kVjYoaK2xHFYHYYu50BboKjRv/Q==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df2fe18-8a39-452f-693e-08d7af31edbf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:27.4836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nfJkeNfoVjBpJL082p/UgJTCuwi82alL3uRA1l1kKFfoXpYD0FqIhMiLdxVw2Hv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3599
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 40.107.236.135
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
 darren.kenny@oracle.com, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
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
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
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
2.25.0


