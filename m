Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045FAC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C096820776
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="gE6D95oR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C096820776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl91S-0008S0-TE
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl90R-0006tm-73
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:39:51 -0400
Received: from mail-db8eur05on2134.outbound.protection.outlook.com
 ([40.107.20.134]:62689 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl90P-0002xj-Dg
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:39:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBAd0VQMzaFWrRYxrExPyA9dFX56XlgT/OE9NvZbCNQ0VxIA5yK6rZy7PnDmHgPcp0Ngh7T+u0T0MqkY3irg18STH0qhT4SbfY+SdSmmv0PdbgLoIXe37nuh8YBzNGrSXwEig3wrgdhvSBkbh+x9+42e5aZidzcMAEUyJkGgxM9VoIWhorbwB4Tc31/4DQXdaKuWKOUN308OlZq9HuPRFFXThrQzxDO3PCdLJQGMwNDKXHWOr+iuWvgZPrz5Tmce4E0qS53g2xSi+qC95eHnJG/RY6adn5q/UT0jlywBqArpFBSlMFftG1G4EFSutHjrexR34vC0ir1Ss8EaLAY35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2T/my9LqTMcwLuou1CYoXMRuC+N9Y0bcI0lG9ts/Dk=;
 b=df8fpIAENF+ypjDShkcYHxeMc5uR/XjivA+5Bymk3bdgUuo6YF6MF91N9h3Ecoi3v9Dvwh3D7Bha3//XIsYnQ6D382Yf28L5/L/odNuqZh0mL3gmELrAa6kpndHr9qJMmwmOWoFtWIvqL0soNCDrdWwhvmOcL7fZXsdzYQ83xwVsqR7inF7xlzKKSo8Tx3ay1lLrrsksY/UqVuxcNuvlp1F7EGBH+0hWZOAaI60tKCOcCkhFHQ1taLagJDX0xcX++EnqgA7zHASnxECvJocZ9Nbx4E6wDLD+WRCCQHVLSu5jWdkXU6+6hnY0GiB6AyIXq+fav5Cmhn7Ms+x6lFscRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2T/my9LqTMcwLuou1CYoXMRuC+N9Y0bcI0lG9ts/Dk=;
 b=gE6D95oRfRGg8QAa1uAG3yHWQ/bg85T0wetHo238abpsmoh5jgDQoJ8cDMuRv3rHTzc0pDfyL3/cxZx0PoDzOrQqXxZDgFghFfImQg8ArdHnOOHctgPKcn4WB+NErrkv8xInHVkqT9I6+TUCLr1+URixUGpQegyU+UZA3ML+QRQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3960.eurprd03.prod.outlook.com (2603:10a6:20b:25::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 10:39:42 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 10:39:42 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/6] linux-user: Add strace support for a group of syscalls
Date: Tue, 16 Jun 2020 12:39:23 +0200
Message-Id: <20200616103927.20222-3-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616103927.20222-1-filip.bozuta@syrmia.com>
References: <20200616103927.20222-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::15) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 10:39:41 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21373464-7de3-4525-7b0a-08d811e193d9
X-MS-TrafficTypeDiagnostic: AM6PR03MB3960:
X-Microsoft-Antispam-PRVS: <AM6PR03MB3960B7F3424EEB3F64E6C485EB9D0@AM6PR03MB3960.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERPSFsmufYes9DElCSsV1aaX574ueJo+i6S+uwNlsRjxWSZUH2wws4pg0VsqRN07qecjzH3VHlmR9UYO0LujFtoMi5Uz3PMJR3z9h9EDyKJrQwLT5EQC/Oa+UWrtPsnAn1pWvKZ8HQxQ4WaYYBZv7OPrN4PY6XdisbiN0TeaMfJpuyuXQSZoh5CVyZL38jZKuoDItlQzGFO3czy7UtRqEet4ixzCJZOVPaRuQnmYsyQqH7QukmkV0tVif0NynyGDq2Z5wmLxZbt1hU8IE9frIr+9yEvupJLWE12/nJG8nbFNbQv//TcZEeGNUVQ8tnhX4txN/NRlSJdbqnOIMORTQRXrYyhS9jGmYEIwX5t4teAJ55Y9JsfqpyraGUwnBkGfPnF0Ii0Onh9BMH+pxFynUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(346002)(366004)(376002)(39830400003)(136003)(966005)(5660300002)(83380400001)(86362001)(508600001)(8936002)(316002)(6666004)(66476007)(6916009)(7696005)(36756003)(2616005)(52116002)(66946007)(66556008)(956004)(44832011)(26005)(1076003)(2906002)(4326008)(16526019)(6486002)(186003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 11tO2hUmbc2routHygtyySwhGUooFg4yVnb2NbryVYEiN0YLi/Y/kDOfmvmzgBlwDXjV67iDxA7m1M8L1mXSjoikXnC6idzn2E143+tTpZx/ytJeisVP8h1Wb5DFIAUIi2Qcs4z25IqgToiRSnqjFX5Vvmob3La8nxhJvt9lH8fekbWmJFdVEE4wZY4Wr76K6ZNbEsVC3ZmKtQMDigpwhqMWP4kcmb+D5NFOc98GFuI2k/qnvjZ3DDH/i+6jOvBUK2dW+yat2ClM45M9ST4Hs79c+Ga9FKVkCmvcZ8kKs9eQlLQ3UOfoOolr1oSBBuNbUNwvKsxkiiPvZRciuTSJb3k8zgdSmnRpwTWly5fnJDjxI4xdY3Y3zKWIeqFNuGpeN2ZYevVf8O0tS6p+BlpZv7z4pBo/Bvp+PLBCIEfb+PMgbh0li6QZVJAe4Je6hawD3qhZh4Zsvjt0TT8Nr51KV/61BJgRlyANcnA+Y+9KPZY=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21373464-7de3-4525-7b0a-08d811e193d9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 10:39:41.9841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBNwOk2xIO1CtbA2C4yoQVWWrkoZXup/HieWV11Yigi7SoqDGs3MYK0sOpp0poF9vDdxG+5s7B/DtIruy0HeOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3960
Received-SPF: pass client-ip=40.107.20.134;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 06:39:47
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements strace argument printing functionality for following syscalls:

    *acct - switch process accounting on or off

        int acct(const char *filename)
        man page: https://www.man7.org/linux/man-pages/man2/acct.2.html

    *fsync, fdatasync - synchronize a file's in-core state with storage device

        int fsync(int fd)
        int fdatasync(int fd)
        man page: https://www.man7.org/linux/man-pages/man2/fsync.2.html

    *listen - listen for connections on a socket

        int listen(int sockfd, int backlog)
        man page: https://www.man7.org/linux/man-pages/man2/listen.2.html

Implementation notes:

    Syscall acct() takes string as its only argument and thus a separate
    print function "print_acct" is stated in file "strace.list". This
    function is defined and implemented in "strace.c" by using an
    existing function used to print string arguments: "print_string()".
    All the other syscalls have only primitive argument types, so the
    rest of the implementation was handled by stating an appropriate
    printing format in file "strace.list".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 13 ++++++++++++-
 linux-user/strace.list |  8 ++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 805fcb9fd1..6d7accaa4c 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1364,6 +1364,18 @@ print_access(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_acct
+static void
+print_acct(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_brk
 static void
 print_brk(const struct syscallname *name,
@@ -1628,7 +1640,6 @@ print_fcntl(const struct syscallname *name,
 #define print_fcntl64   print_fcntl
 #endif
 
-
 #ifdef TARGET_NR_futimesat
 static void
 print_futimesat(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index d49a1e92a8..fb9799e7e6 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -13,7 +13,7 @@
 { TARGET_NR_access, "access" , NULL, print_access, NULL },
 #endif
 #ifdef TARGET_NR_acct
-{ TARGET_NR_acct, "acct" , NULL, NULL, NULL },
+{ TARGET_NR_acct, "acct" , NULL, print_acct, NULL },
 #endif
 #ifdef TARGET_NR_add_key
 { TARGET_NR_add_key, "add_key" , NULL, NULL, NULL },
@@ -215,7 +215,7 @@
 { TARGET_NR_fcntl64, "fcntl64" , NULL, print_fcntl64, NULL },
 #endif
 #ifdef TARGET_NR_fdatasync
-{ TARGET_NR_fdatasync, "fdatasync" , NULL, NULL, NULL },
+{ TARGET_NR_fdatasync, "fdatasync" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_fgetxattr
 { TARGET_NR_fgetxattr, "fgetxattr" , NULL, NULL, NULL },
@@ -251,7 +251,7 @@
 { TARGET_NR_fstatfs64, "fstatfs64" , "%s(%d,%p)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_fsync
-{ TARGET_NR_fsync, "fsync" , NULL, NULL, NULL },
+{ TARGET_NR_fsync, "fsync" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_ftime
 { TARGET_NR_ftime, "ftime" , NULL, NULL, NULL },
@@ -492,7 +492,7 @@
 { TARGET_NR_Linux, "Linux" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_listen
-{ TARGET_NR_listen, "listen" , NULL, NULL, NULL },
+{ TARGET_NR_listen, "listen" , "%s(%d,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_listxattr
 { TARGET_NR_listxattr, "listxattr" , NULL, NULL, NULL },
-- 
2.17.1


