Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD724C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D3020809
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="npP4cM5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D3020809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGG5-0003ck-Qa
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGDj-0007BH-2s
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:34:11 -0400
Received: from mail-eopbgr00110.outbound.protection.outlook.com
 ([40.107.0.110]:51142 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGDh-0003z4-8N
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:34:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgtZSHMb6yNWqAETI7xmXtLSwqa5TEc5DKpI8jl/uL5FBRChntd15TDwPtUVusjGyUjZZVk9pr6yc1Ku8qOCBOMsh8uCvuM4BA8zhDPbA2vlIK0dqlwed6rUGrvUOoqOZitJjzVTEzspuwSmZdaEocAHSCNK35DjY87zqfvSqXg7/RmoYmkv3ee8wi1MPRNLgLVGACsXucJQvY08zY2uMvKQ3a4bFN0pE6DmjpNBc2cqQUYoMEAFX75H+tXlKamUurY0eq1Ejlbe95MbYXnCwKX/Rii1NpdNCV62Svm3Y1BhSj5ALZg9qd6mgud9ht1L6vCB4CTrZ7hfoamiqUdMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoBKQCFk0HsH39fgbPv9dwoCdbsHxrdk6cY3L0Rk7TA=;
 b=DNLnuJHJE6qpZBpLeZaLGp9iJa4/57zyxzeX+sgLIkYejsdm002qyOy/NqcvNm7T7eRH4lfZsgMpU4vbW0ESjrO8hNyZcUG6ccFtwT6J39iJhp4DJQ94toWwbBcg3SlBqyOYcD6jKaX1SwxSJfqbIOLzshgKEMu/sDllKQqR2hl6f+t1b/Fp2O7BIXbD6lqHkMjmigAxbWP+9cNBVVu66LOcxgDLwnSy4dMk3SG3f5AZMmeU+RUj3KUHboH5qTiCp02rjt8vzeBpHQM3wLsFTqZi+TdbKgTpr5nh7kGV4KxBCMHCiSynqGBYvSCKTLwG4BkUCLm6HyUjZvCaFjfUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoBKQCFk0HsH39fgbPv9dwoCdbsHxrdk6cY3L0Rk7TA=;
 b=npP4cM5PdyOOK1KF0MEJ5OffQ+VS833N8DmSyFSnrAjCgizacpBTGeIgB5yljHqmcAyAvzAOnK/ZxfEhQU8B7MBrbYVfKeK7S8LQk/1DrA6xDCGyyEQY9zouC3hg9flW/P9pH2y985H86912+2qZSHQioKu0C+JyNJjFCx1Qzm4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5315.eurprd03.prod.outlook.com (2603:10a6:20b:d1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 12:33:46 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 12:33:46 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 4/6] linux-user: Add strace support for printing arguments
 of lseek()
Date: Fri, 19 Jun 2020 14:33:29 +0200
Message-Id: <20200619123331.17387-5-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619123331.17387-1-filip.bozuta@syrmia.com>
References: <20200619123331.17387-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::10) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 12:33:46 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c43bea46-f80f-45ed-b810-08d8144d02da
X-MS-TrafficTypeDiagnostic: AM6PR03MB5315:
X-Microsoft-Antispam-PRVS: <AM6PR03MB53156EEFF301413C8B5BDE59EB980@AM6PR03MB5315.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLUt3wGPCi11MOnt3meEvLYA0BFyyELUoPz7F3NezCuyFG8aePWmF2L1362WSNVk8UdOiuB1BZzknEIWf3BpM7niAUB+FgmLZPZ/8kQlGTIXLZ9bnK9r53piAkaBJ8UokuMB6grcZQUwIjtyKR3mvw5tKAtmicIisVKYn1MxGiaS1oWuUBjEMpEvU4Ke2LRagzZzxMnvvUOz0yGyiceDjsx5sqNt5AY6BoGGcnLs2eV05cdPCcYD+7213SBCQgH/5IZLsDPaxBMhQpW4fD9tVOkr6rqYux+wkoBBpNjwInlXo12WMYmGrFIOLLaOZjQN0YweDnVjxtfm4X3TE3zem7QckKFi7pq3TRBTzlAJHRw8u9NLMVsfWl/FJpzBqUeVX2+upOFzK1aM7IvPMG4B3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(376002)(136003)(39830400003)(396003)(7696005)(52116002)(4326008)(186003)(36756003)(6916009)(2616005)(26005)(16526019)(66946007)(66476007)(316002)(956004)(66556008)(1076003)(83380400001)(2906002)(508600001)(6486002)(966005)(5660300002)(6666004)(8936002)(86362001)(44832011)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fl3F9kDcMv3SlE9FVGRShA+sf/DdaqaigenMbgWq7ZarIYRgYwzyt/q12ysHYiHArnRZTYfrDGM3uUy3ujwIbk2dRCy8GgOQ/pnDeNXLXLS6wIzePdxgw6N3Wp6qSMR90XFd1/KIrA1puHLdWp77fXARK3arYkWRSt4HTjs5rfuN02k0PKXH8Ou3z4QtrRRWB4fl1L87m55Knk8dqhhYd3CEbarnV42O1UYATvGdeHOlREtk3odAONj798xx5OyC/oKaQrfr6p/eGypJCK1NW8+D7WJP9ShmT882NFnyZyX9bcaMMbqfT+WKFGVwpZi5ZwlbBE0sSYriQ9VnhzIZJ4WMiaJKcQMnjtoj8K9SF7kB6Wj7LlsA7bFtjxwy8HPKyVDGPSLoAAUvb8sL8qNflGF3xd+hJWOMfLupVDYxH1xTQzGoePvQfN1mYhfmXpaBcw8ZmnuUpRg0Dw0QpmvhRzx9emmjLAS9ZS4Xp5IQhN8=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43bea46-f80f-45ed-b810-08d8144d02da
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 12:33:46.7509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oh3Oisow5U+3YIWmHd9nVelLR0ukYOtB6rRtF+GkGtmkuRcY8siSEKnmhL7FtS+1pBOc2H9OZ929o7FL2kg3qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5315
Received-SPF: pass client-ip=40.107.0.110;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 08:33:52
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements strace argument printing functionality for syscall:

    *lseek - reposition read/write file offset

         off_t lseek(int fd, off_t offset, int whence)
         man page: https://www.man7.org/linux/man-pages/man2/lseek.2.html

Implementation notes:

    The syscall's third argument "whence" has predefined values:
    "SEEK_SET","SEEK_CUR","SEEK_END","SEEK_DATA","SEEK_HOLE"
    and thus a separate printing function "print_lseek" was stated
    in file "strace.list". This function is defined in "strace.c"
    by using an existing function "print_raw_param()" to print
    the first and second argument and a switch(case) statement
    for the predefined values of the third argument.
    Values "SEEK_DATA" and "SEEK_HOLE" are defined in kernel version 3.1.
    That is the reason why case statements for these values are
    enwrapped in #ifdef directive.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 31 +++++++++++++++++++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 760020132b..a26736516b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1833,6 +1833,37 @@ print__llseek(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_lseek
+static void
+print_lseek(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, arg1, 0);
+    switch (arg2) {
+    case SEEK_SET:
+        qemu_log("SEEK_SET"); break;
+    case SEEK_CUR:
+        qemu_log("SEEK_CUR"); break;
+    case SEEK_END:
+        qemu_log("SEEK_END"); break;
+#ifdef SEEK_DATA
+    case SEEK_DATA:
+        qemu_log("SEEK_DATA"); break;
+#endif
+#ifdef SEEK_HOLE
+    case SEEK_HOLE:
+        qemu_log("SEEK_HOLE"); break;
+#endif
+    default:
+        print_raw_param("%#x", arg2, 1);
+    }
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_socket)
 static void
 print_socket(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index af12b23276..905a9c395c 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -516,7 +516,7 @@
 { TARGET_NR_lremovexattr, "lremovexattr" , NULL, print_lremovexattr, NULL },
 #endif
 #ifdef TARGET_NR_lseek
-{ TARGET_NR_lseek, "lseek" , NULL, NULL, NULL },
+{ TARGET_NR_lseek, "lseek" , NULL, print_lseek, NULL },
 #endif
 #ifdef TARGET_NR_lsetxattr
 { TARGET_NR_lsetxattr, "lsetxattr" , NULL, NULL, NULL },
-- 
2.17.1


