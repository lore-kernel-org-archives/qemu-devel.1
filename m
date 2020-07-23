Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11F9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 21:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DA7206E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 21:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="r43yj2Zz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DA7206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyiO8-0002R6-Eq
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 17:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyiNC-0001LU-QM
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 17:03:26 -0400
Received: from mail-db8eur05on2102.outbound.protection.outlook.com
 ([40.107.20.102]:7264 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyiN9-0006NN-H7
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 17:03:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MU+kIZ3ssPHUaVU3pUT0HUrMsGKXO7SoiLTofZiM7kV5TnBarjPyIeKZd+fh8QsasbjesCbpnKXvEd3OSigFc/iueML0hHoBQ5UUSnIt7mn0sm5tYQ2NPtWrwuxhXWR8FdOMhmx5OITKZtBdWjpdvgadsMlgGnsqnzZRsUvUU/eVeWks/w9VBJBmqHTqNottQKGLFVO9trZ3rv9D0O0kvl7L7gR5yoWQUG59U5ZCJA4e073pF/nH58Qlm64vopaJmFcE4sOp+GSaXWxe8wA3hM5Brcxdi9SijdorpdHGx+/KX36czJ8DNhVLst2Lp97UmAdCSt9R7l2svf5eNRAoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNoz9Kfwk5pYS3AHhzEr+iuR/rfcAhq5AwKEDMsSS58=;
 b=UlC4MIj9I3HZniPzflwAq9J+R1rTL4yBbJktiXOUmDcuFdQZuJ94zUljb9CJx5V6j+mzGz4FcN4+GQVXMao8FV44RX5UmMMcedB8NAzMKOCnQOzVWumP54zIoeBl6ojxfWvrYDjf/+7Bo+H/Dv7igwWIzUV2aGr7CEV3Dxnotd5eXNIhX/4wSpPnvq/FgHaq68SzzwKCK/UsnglGNRQ8X4dGpiyn7Zdh3+E45h3304H1+3sJivRSGX/Ycyms8PIerwypGUT2WEb44jlFdywnSPO1KV1u7PibDVxpjRApWrl3+4fhjaiKuCObI9TEDdbNWHyvsZsGfUhJ+pa87XdXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNoz9Kfwk5pYS3AHhzEr+iuR/rfcAhq5AwKEDMsSS58=;
 b=r43yj2ZzCfxpOYBSBF+Euw+t0SRhZ4ca9NrxLpvyWl7Fq72tzhrzFGLsB7+og3LqT2/v3TmpqtCFK3kGgWqq/4WB6+ZrzUZtuT8yckuue/xMB4rZyRwK0hgkVri9q45mP4RoWX7/IldrM1DOAPC3t3zCCr45A+965pCF8lgfUxo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5687.eurprd03.prod.outlook.com (2603:10a6:20b:ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 23 Jul
 2020 21:02:49 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.022; Thu, 23 Jul 2020
 21:02:49 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] linux-user: Add missing termbits types and values
 definitions
Date: Thu, 23 Jul 2020 23:02:32 +0200
Message-Id: <20200723210233.349690-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723210233.349690-1-Filip.Bozuta@syrmia.com>
References: <20200723210233.349690-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0259.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::31) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.236) by
 LO2P265CA0259.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Thu, 23 Jul 2020 21:02:49 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.236]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00df2520-3645-410d-0185-08d82f4bc1f0
X-MS-TrafficTypeDiagnostic: AM6PR03MB5687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB5687B9F029F8856B3E874D92EB760@AM6PR03MB5687.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9tVsgN2U6tQxv3r+VzyBzeHW1uITt/V9ILIcw1nnEfBkT2xkHLcqW5d0SD/kqSqziSZuswDqujuVS1hhUfv2AMTY7BxmetiCDP5FeZc1la5hTO4EZ0ua+6bUR+ln4SFX9DmDGD4I99Uk46m1RqrOYM6ZjFd39gdLtYxd7RpjYPUoTlGlYkbfTuTfc2vwVH9ouspqUJg8HdQDw1gfXJBjL+uGvMtyX4xpasgk5aNDpco9/+S8VMG3v+lpsAxu5hOTRHrslYcv9gzjTCNfNo0MHPOEY47N/v7ZKrdMOeekLpHm+c2d7nX+DVLunhJlH/3zTHaMh1jvwq9a0HbCw5i83/2Vt0cmiRPlUmC44PXof93eZEhEARTBgSmvOsYR2nl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(376002)(366004)(39830400003)(346002)(396003)(69590400007)(6486002)(86362001)(6916009)(6666004)(26005)(66556008)(956004)(66946007)(66476007)(2616005)(83380400001)(1076003)(54906003)(508600001)(316002)(4326008)(6512007)(2906002)(5660300002)(6506007)(8936002)(30864003)(52116002)(8676002)(16526019)(186003)(107886003)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8kh8bb2UiZ3P1KyEB0EMKmSSC+NJpY0AbtVA5Tjf372f9tuANnW5ABqHIG0RZmcVpeTdqFgqWkLy5mb3Sql825lxgBTHSTOsQOwMXqDN2Td0PASvM2D4cv/5tsggYTdlBRpc7pIikXmsD7cOIQM+Bvg09GKje6afa/Ezij0ors/p+KwcVEMBDUujyxbRFphxqsbFVoswyiwWLyOag7aFMhUHBimmxB5/mf47LZ5zlOcIa55Tx88S4Mb3EJiGiZeTManA36ewLFpI8qcaZL7BzBJmfCO2y+9t1EXNUT9WG3d+ePO+q5pcx3TgFn7hc4db8Wr7M1yM3bxZ7R1GACy7hJ4QR/1/DEnhxcahaLnvBTHY5Kf8vtojVyRN9inajRtXKNXDezPVzwaK9fiAVf7RYWPhOMETakl5cVezE4fEUaR+z2KGX52ytTZr5sQsC4Pz6K6C8P305xS+tZo136xWQ6fuTqv/pm2HOucjXC6aqf8=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00df2520-3645-410d-0185-08d82f4bc1f0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 21:02:49.8657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vHFzODEHMY2P6T8WdgeCzxG5C+siZkVod2Y2hLLBokp+xbx1Z/pWove+Lfqe/Aaipmymm+3+DEnhqE9A2fJYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5687
Received-SPF: pass client-ip=40.107.20.102;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 17:03:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch introduces missing target types ('target_flag_t', 'target_cc_t',
'target_speed_t') in a few 'termibts.h' header files. Also, two missing
values ('TARGET_IUTF8' and 'TARGET_EXTPROC') were also added. These values
were also added in file 'syscall.c' in bitmask tables 'iflag_tbl[]' and
'lflag_tbl[]' which are used to convert values of 'struct termios' between
target and host.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/alpha/termbits.h   |  1 +
 linux-user/cris/termbits.h    | 18 ++++++++----
 linux-user/hppa/termbits.h    | 17 +++++++----
 linux-user/mips/termbits.h    | 17 +++++++----
 linux-user/ppc/termbits.h     | 21 ++++++++------
 linux-user/sh4/termbits.h     | 19 +++++++++----
 linux-user/sparc/termbits.h   | 18 ++++++++----
 linux-user/sparc64/termbits.h | 18 ++++++++----
 linux-user/syscall.c          | 34 +++++++++++-----------
 linux-user/xtensa/termbits.h  | 53 ++++++++++++++++++-----------------
 10 files changed, 130 insertions(+), 86 deletions(-)

diff --git a/linux-user/alpha/termbits.h b/linux-user/alpha/termbits.h
index a71425174a..4a4b1e96f2 100644
--- a/linux-user/alpha/termbits.h
+++ b/linux-user/alpha/termbits.h
@@ -159,6 +159,7 @@ struct target_termios {
 #define TARGET_FLUSHO	0x00800000
 #define TARGET_PENDIN	0x20000000
 #define TARGET_IEXTEN	0x00000400
+#define TARGET_EXTPROC  0x10000000
 
 #define TARGET_FIOCLEX		TARGET_IO('f', 1)
 #define TARGET_FIONCLEX	TARGET_IO('f', 2)
diff --git a/linux-user/cris/termbits.h b/linux-user/cris/termbits.h
index 475ee70fed..0c8d8fc051 100644
--- a/linux-user/cris/termbits.h
+++ b/linux-user/cris/termbits.h
@@ -5,13 +5,17 @@
 
 #define TARGET_NCCS 19
 
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
+
 struct target_termios {
-    unsigned int c_iflag;               /* input mode flags */
-    unsigned int c_oflag;               /* output mode flags */
-    unsigned int c_cflag;               /* control mode flags */
-    unsigned int c_lflag;               /* local mode flags */
-    unsigned char c_line;                    /* line discipline */
-    unsigned char c_cc[TARGET_NCCS];                /* control characters */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
 };
 
 /* c_iflag bits */
@@ -29,6 +33,7 @@ struct target_termios {
 #define TARGET_IXANY   0004000
 #define TARGET_IXOFF   0010000
 #define TARGET_IMAXBEL 0020000
+#define TARGET_IUTF8   0040000
 
 /* c_oflag bits */
 #define TARGET_OPOST   0000001
@@ -118,6 +123,7 @@ struct target_termios {
 #define TARGET_FLUSHO  0010000
 #define TARGET_PENDIN  0040000
 #define TARGET_IEXTEN  0100000
+#define TARGET_EXTPROC 0200000
 
 /* c_cc character offsets */
 #define TARGET_VINTR	0
diff --git a/linux-user/hppa/termbits.h b/linux-user/hppa/termbits.h
index 8fba839dd4..11fd4eed62 100644
--- a/linux-user/hppa/termbits.h
+++ b/linux-user/hppa/termbits.h
@@ -5,13 +5,17 @@
 
 #define TARGET_NCCS 19
 
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
+
 struct target_termios {
-    unsigned int c_iflag;               /* input mode flags */
-    unsigned int c_oflag;               /* output mode flags */
-    unsigned int c_cflag;               /* control mode flags */
-    unsigned int c_lflag;               /* local mode flags */
-    unsigned char c_line;                    /* line discipline */
-    unsigned char c_cc[TARGET_NCCS];                /* control characters */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
 };
 
 /* c_iflag bits */
@@ -120,6 +124,7 @@ struct target_termios {
 #define TARGET_FLUSHO  0010000
 #define TARGET_PENDIN  0040000
 #define TARGET_IEXTEN  0100000
+#define TARGET_EXTPROC 0200000
 
 /* c_cc character offsets */
 #define TARGET_VINTR    0
diff --git a/linux-user/mips/termbits.h b/linux-user/mips/termbits.h
index 3287cf6df8..e8b4b58d87 100644
--- a/linux-user/mips/termbits.h
+++ b/linux-user/mips/termbits.h
@@ -5,13 +5,17 @@
 
 #define TARGET_NCCS 23
 
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
+
 struct target_termios {
-    unsigned int c_iflag;               /* input mode flags */
-    unsigned int c_oflag;               /* output mode flags */
-    unsigned int c_cflag;               /* control mode flags */
-    unsigned int c_lflag;               /* local mode flags */
-    unsigned char c_line;                    /* line discipline */
-    unsigned char c_cc[TARGET_NCCS];                /* control characters */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
 };
 
 /* c_iflag bits */
@@ -133,6 +137,7 @@ struct target_termios {
 #define TARGET_PENDIN  0040000
 #define TARGET_TOSTOP  0100000
 #define TARGET_ITOSTOP TARGET_TOSTOP
+#define TARGET_EXTPROC 0200000
 
 /* c_cc character offsets */
 #define TARGET_VINTR	0
diff --git a/linux-user/ppc/termbits.h b/linux-user/ppc/termbits.h
index 19e4c6eda8..7066d1e552 100644
--- a/linux-user/ppc/termbits.h
+++ b/linux-user/ppc/termbits.h
@@ -5,15 +5,19 @@
 
 #define TARGET_NCCS 19
 
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
+
 struct target_termios {
-    unsigned int c_iflag;               /* input mode flags */
-    unsigned int c_oflag;               /* output mode flags */
-    unsigned int c_cflag;               /* control mode flags */
-    unsigned int c_lflag;               /* local mode flags */
-    unsigned char c_cc[TARGET_NCCS];                /* control characters */
-    unsigned char c_line;                    /* line discipline */
-    unsigned int c_ispeed;		/* input speed */
-    unsigned int c_ospeed;		/* output speed */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
+    target_speed_t c_ispeed;               /* input speed */
+    target_speed_t c_ospeed;               /* output speed */
 };
 
 /* c_cc character offsets */
@@ -158,6 +162,7 @@ struct target_termios {
 #define TARGET_FLUSHO	0x00800000
 #define TARGET_PENDIN	0x20000000
 #define TARGET_IEXTEN	0x00000400
+#define TARGET_EXTPROC  0x10000000
 
 /* ioctls */
 
diff --git a/linux-user/sh4/termbits.h b/linux-user/sh4/termbits.h
index dd125b6a2b..f91b5c51cf 100644
--- a/linux-user/sh4/termbits.h
+++ b/linux-user/sh4/termbits.h
@@ -5,15 +5,20 @@
 
 #define TARGET_NCCS 19
 
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
+
 struct target_termios {
-	unsigned int c_iflag;			/* input mode flags */
-	unsigned int c_oflag;			/* output mode flags */
-	unsigned int c_cflag;			/* control mode flags */
-	unsigned int c_lflag;			/* local mode flags */
-	unsigned char c_line;			/* line discipline */
-	unsigned char c_cc[TARGET_NCCS];	/* control characters */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
 };
 
+
 /* c_cc characters */
 #define TARGET_VINTR 0
 #define TARGET_VQUIT 1
@@ -150,6 +155,8 @@ struct target_termios {
 #define TARGET_FLUSHO	0010000
 #define TARGET_PENDIN	0040000
 #define TARGET_IEXTEN	0100000
+#define TARGET_EXTPROC  0200000
+
 
 /* tcflow() and TCXONC use these */
 #define TARGET_TCOOFF		0
diff --git a/linux-user/sparc/termbits.h b/linux-user/sparc/termbits.h
index f85219ed71..704bee1c42 100644
--- a/linux-user/sparc/termbits.h
+++ b/linux-user/sparc/termbits.h
@@ -5,15 +5,20 @@
 
 #define TARGET_NCCS 19
 
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
+
 struct target_termios {
-    unsigned int c_iflag;               /* input mode flags */
-    unsigned int c_oflag;               /* output mode flags */
-    unsigned int c_cflag;               /* control mode flags */
-    unsigned int c_lflag;               /* local mode flags */
-    unsigned char c_line;                    /* line discipline */
-    unsigned char c_cc[TARGET_NCCS];                /* control characters */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
 };
 
+
 /* c_cc characters */
 #define TARGET_VINTR    0
 #define TARGET_VQUIT    1
@@ -170,6 +175,7 @@ struct target_termios {
 #define TARGET_FLUSHO	0x00002000
 #define TARGET_PENDIN	0x00004000
 #define TARGET_IEXTEN	0x00008000
+#define TARGET_EXTPROC  0x00010000
 
 /* ioctls */
 
diff --git a/linux-user/sparc64/termbits.h b/linux-user/sparc64/termbits.h
index 11b5abcf84..1ab1e80db5 100644
--- a/linux-user/sparc64/termbits.h
+++ b/linux-user/sparc64/termbits.h
@@ -5,15 +5,20 @@
 
 #define TARGET_NCCS 19
 
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
+
 struct target_termios {
-    unsigned int c_iflag;               /* input mode flags */
-    unsigned int c_oflag;               /* output mode flags */
-    unsigned int c_cflag;               /* control mode flags */
-    unsigned int c_lflag;               /* local mode flags */
-    unsigned char c_line;                    /* line discipline */
-    unsigned char c_cc[TARGET_NCCS];                /* control characters */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
 };
 
+
 /* c_cc characters */
 #define TARGET_VINTR    0
 #define TARGET_VQUIT    1
@@ -170,6 +175,7 @@ struct target_termios {
 #define TARGET_FLUSHO	0x00002000
 #define TARGET_PENDIN	0x00004000
 #define TARGET_IEXTEN	0x00008000
+#define TARGET_EXTPROC  0x00010000
 
 /* ioctls */
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 24d915f0ff..e815f14bac 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5508,6 +5508,7 @@ static const bitmask_transtbl iflag_tbl[] = {
         { TARGET_IXANY, TARGET_IXANY, IXANY, IXANY },
         { TARGET_IXOFF, TARGET_IXOFF, IXOFF, IXOFF },
         { TARGET_IMAXBEL, TARGET_IMAXBEL, IMAXBEL, IMAXBEL },
+        { TARGET_IUTF8, TARGET_IUTF8, IUTF8, IUTF8},
         { 0, 0, 0, 0 }
 };
 
@@ -5575,22 +5576,23 @@ static const bitmask_transtbl cflag_tbl[] = {
 };
 
 static const bitmask_transtbl lflag_tbl[] = {
-	{ TARGET_ISIG, TARGET_ISIG, ISIG, ISIG },
-	{ TARGET_ICANON, TARGET_ICANON, ICANON, ICANON },
-	{ TARGET_XCASE, TARGET_XCASE, XCASE, XCASE },
-	{ TARGET_ECHO, TARGET_ECHO, ECHO, ECHO },
-	{ TARGET_ECHOE, TARGET_ECHOE, ECHOE, ECHOE },
-	{ TARGET_ECHOK, TARGET_ECHOK, ECHOK, ECHOK },
-	{ TARGET_ECHONL, TARGET_ECHONL, ECHONL, ECHONL },
-	{ TARGET_NOFLSH, TARGET_NOFLSH, NOFLSH, NOFLSH },
-	{ TARGET_TOSTOP, TARGET_TOSTOP, TOSTOP, TOSTOP },
-	{ TARGET_ECHOCTL, TARGET_ECHOCTL, ECHOCTL, ECHOCTL },
-	{ TARGET_ECHOPRT, TARGET_ECHOPRT, ECHOPRT, ECHOPRT },
-	{ TARGET_ECHOKE, TARGET_ECHOKE, ECHOKE, ECHOKE },
-	{ TARGET_FLUSHO, TARGET_FLUSHO, FLUSHO, FLUSHO },
-	{ TARGET_PENDIN, TARGET_PENDIN, PENDIN, PENDIN },
-	{ TARGET_IEXTEN, TARGET_IEXTEN, IEXTEN, IEXTEN },
-	{ 0, 0, 0, 0 }
+  { TARGET_ISIG, TARGET_ISIG, ISIG, ISIG },
+  { TARGET_ICANON, TARGET_ICANON, ICANON, ICANON },
+  { TARGET_XCASE, TARGET_XCASE, XCASE, XCASE },
+  { TARGET_ECHO, TARGET_ECHO, ECHO, ECHO },
+  { TARGET_ECHOE, TARGET_ECHOE, ECHOE, ECHOE },
+  { TARGET_ECHOK, TARGET_ECHOK, ECHOK, ECHOK },
+  { TARGET_ECHONL, TARGET_ECHONL, ECHONL, ECHONL },
+  { TARGET_NOFLSH, TARGET_NOFLSH, NOFLSH, NOFLSH },
+  { TARGET_TOSTOP, TARGET_TOSTOP, TOSTOP, TOSTOP },
+  { TARGET_ECHOCTL, TARGET_ECHOCTL, ECHOCTL, ECHOCTL },
+  { TARGET_ECHOPRT, TARGET_ECHOPRT, ECHOPRT, ECHOPRT },
+  { TARGET_ECHOKE, TARGET_ECHOKE, ECHOKE, ECHOKE },
+  { TARGET_FLUSHO, TARGET_FLUSHO, FLUSHO, FLUSHO },
+  { TARGET_PENDIN, TARGET_PENDIN, PENDIN, PENDIN },
+  { TARGET_IEXTEN, TARGET_IEXTEN, IEXTEN, IEXTEN },
+  { TARGET_EXTPROC, TARGET_EXTPROC, EXTPROC, EXTPROC},
+  { 0, 0, 0, 0 }
 };
 
 static void target_to_host_termios (void *dst, const void *src)
diff --git a/linux-user/xtensa/termbits.h b/linux-user/xtensa/termbits.h
index d1e09e61a6..2a603ecae6 100644
--- a/linux-user/xtensa/termbits.h
+++ b/linux-user/xtensa/termbits.h
@@ -15,40 +15,40 @@
 
 #include <linux/posix_types.h>
 
-typedef unsigned char   cc_t;
-typedef unsigned int    speed_t;
-typedef unsigned int    tcflag_t;
+typedef unsigned char   target_cc_t;        /* cc_t */
+typedef unsigned int    target_speed_t;     /* speed_t */
+typedef unsigned int    target_tcflag_t;    /* tcflag_t */
 
-#define TARGET_NCCS 19
 struct target_termios {
-    tcflag_t c_iflag;       /* input mode flags */
-    tcflag_t c_oflag;       /* output mode flags */
-    tcflag_t c_cflag;       /* control mode flags */
-    tcflag_t c_lflag;       /* local mode flags */
-    cc_t c_line;            /* line discipline */
-    cc_t c_cc[TARGET_NCCS]; /* control characters */
+    target_tcflag_t c_iflag;               /* input mode flags */
+    target_tcflag_t c_oflag;               /* output mode flags */
+    target_tcflag_t c_cflag;               /* control mode flags */
+    target_tcflag_t c_lflag;               /* local mode flags */
+    target_cc_t c_line;                    /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
 };
 
+
 struct target_termios2 {
-    tcflag_t c_iflag;       /* input mode flags */
-    tcflag_t c_oflag;       /* output mode flags */
-    tcflag_t c_cflag;       /* control mode flags */
-    tcflag_t c_lflag;       /* local mode flags */
-    cc_t c_line;            /* line discipline */
-    cc_t c_cc[TARGET_NCCS]; /* control characters */
-    speed_t c_ispeed;       /* input speed */
-    speed_t c_ospeed;       /* output speed */
+    target_tcflag_t c_iflag;       /* input mode flags */
+    target_tcflag_t c_oflag;       /* output mode flags */
+    target_tcflag_t c_cflag;       /* control mode flags */
+    target_tcflag_t c_lflag;       /* local mode flags */
+    target_cc_t c_line;            /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS]; /* control characters */
+    target_speed_t c_ispeed;       /* input speed */
+    target_speed_t c_ospeed;       /* output speed */
 };
 
 struct target_ktermios {
-    tcflag_t c_iflag;       /* input mode flags */
-    tcflag_t c_oflag;       /* output mode flags */
-    tcflag_t c_cflag;       /* control mode flags */
-    tcflag_t c_lflag;       /* local mode flags */
-    cc_t c_line;            /* line discipline */
-    cc_t c_cc[TARGET_NCCS]; /* control characters */
-    speed_t c_ispeed;       /* input speed */
-    speed_t c_ospeed;       /* output speed */
+    target_tcflag_t c_iflag;       /* input mode flags */
+    target_tcflag_t c_oflag;       /* output mode flags */
+    target_tcflag_t c_cflag;       /* control mode flags */
+    target_tcflag_t c_lflag;       /* local mode flags */
+    target_cc_t c_line;            /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS]; /* control characters */
+    target_speed_t c_ispeed;       /* input speed */
+    target_speed_t c_ospeed;       /* output speed */
 };
 
 /* c_cc characters */
@@ -195,6 +195,7 @@ struct target_ktermios {
 #define TARGET_FLUSHO   0010000
 #define TARGET_PENDIN   0040000
 #define TARGET_IEXTEN   0100000
+#define TARGET_EXTPROC  0200000
 
 /* tcflow() and TCXONC use these */
 
-- 
2.25.1


