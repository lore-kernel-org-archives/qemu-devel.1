Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DE8C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1282068F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="Q8wMRH8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1282068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juv8Z-0000O2-4g
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1juv7p-0007w7-1e
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:51:53 -0400
Received: from mail-eopbgr20139.outbound.protection.outlook.com
 ([40.107.2.139]:39808 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1juv7m-0001Wn-R5
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:51:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxPoIUQHYKrCngw9ipUZwgHbehiYjqcd6rENROCxPeuAxK/UAmn0SGChUA3gvzX5uW7ve33fORsLNe03JTZf83GX0hhuZFSRFBgfA9CMydCMwjhPW2RgilKsjQCn/OyAL9Tr9dJUnXQYbca5S6TXt7SUAiSp2mDvvbOEjkr24UzScQMzM6uMxG2UwCnlfGGuFsOjcVTt2t4grO47gys6BytTWCCgYdLs9gu86340KDMcbKUWux/jQeIJLQ4UahzMVRb8zYH8W44+mM78vPZrl3ojlCBMU6q+VoqbNojjKbNCl3s3ASC+hphwgWyZd3vJ8ufP3FJwKOeEVuiQ/1xlnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8Uvwoqm2zHomWYbib7oPa5omJGDkuDdXQJqZ30ofGg=;
 b=gei1Ga3mgeeR514TAXRsPtMdXPjYOut9xrH35pDmia0m0OUJOZQk+GKOL75pCjqijDCoHL8O3nY5TROlzlgcyGrgpskAhhsJreeKVC4cXUwM0APtpuyVjrAgDtQI0Ebaq3eqycPfJpC6jGR8D93Lq5rLdJiGIcVmtMUkuO6hgfaP0762AYfWC75/Arqw2axnt68rWBpI1IN32De1zNoOlMu/XG6KeDAENRgPdRi13hqS/1yF88dwzZZFeiO5ZtYvOLP8WtH3OSWnR7cwse8vwB0pw0ybMPUdIaPrrO/YHAGHlH0s9IsTorcPlAw9zysOVq7sIPaI9MN1GNYqLO7k1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8Uvwoqm2zHomWYbib7oPa5omJGDkuDdXQJqZ30ofGg=;
 b=Q8wMRH8hc1kfqKy53SLPm1kEqLe8E/uNbSuazSDJSqfqockpbrtqMv0F6meTT1VObDDQWAPcIbGWQnOTaoMApKmuUELUP37lOAobxxoJdAkdURfvcXPnDVtkZu1XShK7FFFChUjQSUvpBAw7+/wedp5zDXoMavfvr3WW3Fj3Qcw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5234.eurprd03.prod.outlook.com (2603:10a6:20b:c3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 09:51:16 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 09:51:16 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] linux-user: Add strace support for printing arguments
 of truncate()/ftruncate() and getsid()
Date: Mon, 13 Jul 2020 11:50:56 +0200
Message-Id: <20200713095058.106624-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713095058.106624-1-Filip.Bozuta@syrmia.com>
References: <20200713095058.106624-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0050.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::19) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.238) by
 GV0P278CA0050.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:29::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Mon, 13 Jul 2020 09:51:15 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c435efa8-cc2a-42b1-1f7f-08d82712490e
X-MS-TrafficTypeDiagnostic: AM6PR03MB5234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB5234CF088371D5F529B005A1EB600@AM6PR03MB5234.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jcbrnJ0G9bGPrF+ZQnKR0+/XsARADuzymkhWWbeVNVgL7F9vBp5BC1NAc0qNNL2CgjR+jdH2OxVosMZVnzMdf2t4E3BJ/QJv0mURwsRtb7sdaXFyAzMR9hqjZJqOofHxBWOB8uSli/H5stJKul+CzDCmtasC4FOAQKFgQeWaQq/oKdKZ15dIVBXSblFfSRwg91BdqdLeFJjyzVgBf+R/Wq78LRioI6rYMqAU2m78ssqVE17dL8dYnUYMG8hqJ3SZ8vA6uXr5QFva5yiFw0PgkqilKtNSKoqFJmPzUOaEPxH06SSqealRO9gjOb1FaUfQ9CK1XoA2XwwyHUt2BNP/XS+SnePCbXKRJVuDBQgbK9I5VV+aRGHVcPjPRJbvfxd/4JZDff0e1QzI4PvjroEeX6Iu+0v0ZJ7kDPdXHYr2EEqhHJ1Y+7q2xdr6vnZ9ZS89ZoMNS7Z+8VGDNdkKpD/yGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(366004)(136003)(396003)(39830400003)(54906003)(86362001)(6916009)(16526019)(8676002)(69590400007)(6486002)(2616005)(26005)(8936002)(316002)(186003)(956004)(508600001)(83380400001)(4326008)(966005)(107886003)(66556008)(66946007)(66476007)(52116002)(6506007)(1076003)(5660300002)(6512007)(6666004)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cuyivAPis2hBc5ssKo0gbtnUuD1be/ag8cBqP51u2sZ+NrCrt7C5x4fRHbTO1IsEcRYYj+4EmOlIKaQNOeBe4yd47YBQLyQm5XigS6BxXOyAbG2KM1X8lCkvrYqbp7XiOLTY2rWXYcXHINlpFQ7ocyGoYS0QluAsUsF/V8NMHySlrVjKqbmsvMvlAwPkJ72VKAlbgWlLg/zOjai8AWaAmwFIgGfBeJxirqSj05MGffaZt0qKrl2iKfZ2NdzWklQanBbmoapolDVLayG6t6obu7G73ANToflijrW15J2PvaftK7zQCvcNfP1h6xACL1RgrPD2zzTw9HA7U19DqDlRWTxY3wd8DmBfoKCyLTXfenbc33PtqaXStTksUrxkuuLI/mD2/ewlkJzJhn6Y0h7xnvO0Fy27spJE9N4B3eWVxC7v94K+iEts1ggadi34R9QJhgY1UaG0I66RHOo9BBq2+WIU0B+BkGmoBWjbpJKjNdc=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c435efa8-cc2a-42b1-1f7f-08d82712490e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 09:51:16.3221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIe16i2XKRVWJhg3SaY+RScEfz5rVhRMwlfd2z1gNc5TVl5NH/jAEDtxemGXka2UWryk4lFrzryXPjEBV6tQAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5234
Received-SPF: pass client-ip=40.107.2.139;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 05:51:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements strace argument printing functionality for following syscalls:

    * truncate, ftruncate - truncate a file to a specified length

        int truncate/truncate64(const char *path, off_t length)
        int ftruncate/ftruncate64(int fd, off_t length)
        man page: https://man7.org/linux/man-pages/man2/truncate.2.html

    * getsid - get session ID

        pid_t getsid(pid_t pid)
        man page: https://man7.org/linux/man-pages/man2/getsid.2.html

Implementation notes:

    Syscalls truncate/truncate64 take string argument types and thus a
    separate print function "print_truncate/print_truncate64" is stated in
    file "strace.list". This function is defined and implemented in "strace.c"
    by using an existing function used to print string arguments: "print_string()".
    For syscall ftruncate64, a separate printing function was also stated in
    "strace.c" as it requires a special kind of handling.
    The other syscalls have only primitive argument types, so the rest of the
    implementation was handled by stating an appropriate printing format in file
    "strace.list".
    Function "regpairs_aligned()" was cut & pasted from "syscall.c" to "qemu.h"
    as it is used by functions "print_truncate64()" and "print_ftruncate64()"
    to print the offset arguments of "truncate64()" and "ftruncate64()".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/qemu.h      | 35 +++++++++++++++++++++++++++++++
 linux-user/strace.c    | 47 ++++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list | 10 ++++-----
 linux-user/syscall.c   | 32 ----------------------------
 4 files changed, 87 insertions(+), 37 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 63ddfe86fd..f431805e57 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -706,6 +706,41 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
 }
 #endif /* TARGET_ABI_BITS != 32 */
 
+
+/* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
+#ifdef TARGET_ARM
+static inline int regpairs_aligned(void *cpu_env, int num)
+{
+    return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
+}
+#elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+#elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
+/*
+ * SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
+ * of registers which translates to the same as ARM/MIPS, because we start with
+ * r3 as arg1
+ */
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+#elif defined(TARGET_SH4)
+/* SH4 doesn't align register pairs, except for p{read,write}64 */
+static inline int regpairs_aligned(void *cpu_env, int num)
+{
+    switch (num) {
+    case TARGET_NR_pread64:
+    case TARGET_NR_pwrite64:
+        return 1;
+
+    default:
+        return 0;
+    }
+}
+#elif defined(TARGET_XTENSA)
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+#else
+static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
+#endif
+
 /**
  * preexit_cleanup: housekeeping before the guest exits
  *
diff --git a/linux-user/strace.c b/linux-user/strace.c
index ff3d584ccc..ce02f62efc 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1962,6 +1962,53 @@ print_lseek(void *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_truncate
+static void
+print_truncate(void *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_truncate64
+static void
+print_truncate64(void *cpu_env, const struct syscallname *name,
+                 abi_long arg0, abi_long arg1, abi_long arg2,
+                 abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    if (regpairs_aligned(cpu_env, TARGET_NR_truncate64)) {
+        arg1 = arg2;
+        arg2 = arg3;
+    }
+    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_ftruncate64
+static void
+print_ftruncate64(void *cpu_env, const struct syscallname *name,
+                  abi_long arg0, abi_long arg1, abi_long arg2,
+                  abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    if (regpairs_aligned(cpu_env, TARGET_NR_ftruncate64)) {
+        arg1 = arg2;
+        arg2 = arg3;
+    }
+    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_socket)
 static void
 print_socket(void *cpu_env, const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index a04706a524..8e5303d035 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -258,10 +258,10 @@
 { TARGET_NR_ftime, "ftime" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_ftruncate
-{ TARGET_NR_ftruncate, "ftruncate" , NULL, NULL, NULL },
+{ TARGET_NR_ftruncate, "ftruncate" , "%s(%d," TARGET_ABI_FMT_ld ")", NULL, NULL },
 #endif
 #ifdef TARGET_NR_ftruncate64
-{ TARGET_NR_ftruncate64, "ftruncate64" , NULL, NULL, NULL },
+{ TARGET_NR_ftruncate64, "ftruncate64" , NULL, print_ftruncate64, NULL },
 #endif
 #ifdef TARGET_NR_futex
 { TARGET_NR_futex, "futex" , NULL, print_futex, NULL },
@@ -372,7 +372,7 @@
 { TARGET_NR_getrusage, "getrusage" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getsid
-{ TARGET_NR_getsid, "getsid" , NULL, NULL, NULL },
+{ TARGET_NR_getsid, "getsid" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_getsockname
 { TARGET_NR_getsockname, "getsockname" , NULL, NULL, NULL },
@@ -1535,10 +1535,10 @@
 { TARGET_NR_tkill, "tkill" , NULL, print_tkill, NULL },
 #endif
 #ifdef TARGET_NR_truncate
-{ TARGET_NR_truncate, "truncate" , NULL, NULL, NULL },
+{ TARGET_NR_truncate, "truncate" , NULL, print_truncate, NULL },
 #endif
 #ifdef TARGET_NR_truncate64
-{ TARGET_NR_truncate64, "truncate64" , NULL, NULL, NULL },
+{ TARGET_NR_truncate64, "truncate64" , NULL, print_truncate64, NULL },
 #endif
 #ifdef TARGET_NR_tuxcall
 { TARGET_NR_tuxcall, "tuxcall" , NULL, NULL, NULL },
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 703e068b74..b9e86eddef 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -501,38 +501,6 @@ static inline int next_free_host_timer(void)
 }
 #endif
 
-/* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
-#ifdef TARGET_ARM
-static inline int regpairs_aligned(void *cpu_env, int num)
-{
-    return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
-}
-#elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
-#elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
-/* SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
- * of registers which translates to the same as ARM/MIPS, because we start with
- * r3 as arg1 */
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
-#elif defined(TARGET_SH4)
-/* SH4 doesn't align register pairs, except for p{read,write}64 */
-static inline int regpairs_aligned(void *cpu_env, int num)
-{
-    switch (num) {
-    case TARGET_NR_pread64:
-    case TARGET_NR_pwrite64:
-        return 1;
-
-    default:
-        return 0;
-    }
-}
-#elif defined(TARGET_XTENSA)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
-#else
-static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
-#endif
-
 #define ERRNO_TABLE_SIZE 1200
 
 /* target_to_host_errno_table[] is initialized from
-- 
2.25.1


