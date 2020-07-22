Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0DBC433E5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 20:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526B320771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 20:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="zWzdrjBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526B320771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyL0I-0007qs-En
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 16:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyKzI-00068o-OJ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 16:05:12 -0400
Received: from mail-eopbgr150133.outbound.protection.outlook.com
 ([40.107.15.133]:53875 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyKzG-0002ER-2Z
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 16:05:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRTmBZsi5mlFJ/tjg249M/fiWAKVpig8VPjNSb1dF8HJZ8sbnqZ+GDdYGwuCnzAcbetCwTNKDyTqVz3FVzctI6fi9qkwpjmaXLMF0XryDaqtcuwJChZmoqIqdIxvQGgGtJG0lDsiMtB6VmiMK8zlLXnT/upbY8hmPMVA4JC+j2Pzw8rHNjIKhV+moFrBWTY91HyMS7mIQQRHKCdbVh4k6CyFdQgUABu/i4AOnXeV+ydKojyQ4dJ4TPRg0ecXLrHFPj6WU4LMv6NTDeVha8DXhGD5S2tw5ZjTDxPWgL0AvmcvY9MHxLaksRTi+9WQ/ByyWOvN4BWjfWtkSNw/aRaefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLD+OtB8TKOhhWgBGPqEGM5ZNDc670cXryGJXvvL5Bo=;
 b=cfEH/yZbLLjjJXuZptjXH/i4cAL5NmzctCumSW28q8waXsw2xyapCv/VHcirDwIvoWJZgSq5i1JDMcptxViiTQLwMAWvrgXsiX48C7SCLlg9+XlqKGonQld0gzrlN9EDcHglwkU12hve68HUCdsJMyjVh1NAkK6JGXkNfvHt0bNOZ1RScW2ye6bCsIPL2VxKDfSlORI0eG2fdp9OaCnMfCB+SaQPV7FML4oNgUu3hcct7Wl4orOnmgHMLmZzPNFP3RifWg9ox8LmCXRqmES1WkhJnzSTFYjkywsCWja3/UatgOojRocFCHpry6IMLlVCgz5i/yddstU8wEe5H6sFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLD+OtB8TKOhhWgBGPqEGM5ZNDc670cXryGJXvvL5Bo=;
 b=zWzdrjBxboQkO8v1m3sr6i5Rq9/oU94IXJjnX2/yDTouPB9YY0CVWPeyKTgtjipXvRTJuCQUXbaL9ZeFh2/KsAh1SxbWKrSCazfgp/TT4k9aFQrlynqcBv+qEnlDW9L4FphqR9ISEUp36tSBnKLDrIXUMN63kDrJyMtAEihZmwk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM7PR03MB6563.eurprd03.prod.outlook.com (2603:10a6:20b:1c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 20:04:57 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.022; Wed, 22 Jul 2020
 20:04:57 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/5] linux-user: Add strace support for printing arguments
 of some clock and time functions
Date: Wed, 22 Jul 2020 22:04:37 +0200
Message-Id: <20200722200437.312767-6-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722200437.312767-1-Filip.Bozuta@syrmia.com>
References: <20200722200437.312767-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::16) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.237) by
 ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Wed, 22 Jul 2020 20:04:56 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.237]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 763d47b1-ff91-4636-986a-08d82e7a8164
X-MS-TrafficTypeDiagnostic: AM7PR03MB6563:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR03MB6563FC5E9C40F4F511844CF1EB790@AM7PR03MB6563.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuzNtifmU3GZyfrLhgxkgapZbESkFZWnyZNN0KQ8XYPNnOo6Of9gPF2KUWbR5i112tibfSV1drKtNQF5fLtleSa7WYM6zZ18dPE32yLb5F/6FPUElgvrLhFKMEfrOaSFivl3KqFpNvk8xL6eTDNVOA4TzWe53saxcusC/ES9qk4RQ4BHz0ZwY0TzHEqXlewFzlJbTHcBM8LQJrGlzHHbiQajn2ryyPncrgoFVRVrnRzpI1ZBdpKU6qQJ+YhqkEqCBwgDRFk6lk66XwspYejU3RX+mftL22xHnDBl/TcG/fgWCedlP3wq+IgtM3SKnjlGFbyzLaCE0uGnh3ywB4Euw/CmMeKm7rXXbcikJnC763dqNWC3EXZfwng/4kHpjqkFvrJ21MgRG44bXoszIX1fmWhmlqgXak3PgfTHlf1nlIre8O3EDGtsSV2qCeri1yvLq3jy3is/PzXHbOY9DeKQNF16c0H0MWEn64wqWD3oKno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(366004)(376002)(346002)(39830400003)(136003)(107886003)(956004)(54906003)(26005)(316002)(6666004)(2616005)(1076003)(69590400007)(8936002)(30864003)(2906002)(86362001)(5660300002)(4326008)(66556008)(6486002)(966005)(6916009)(36756003)(6512007)(8676002)(186003)(16526019)(66946007)(83380400001)(508600001)(52116002)(66476007)(6506007)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8NewnG38EPXa7BM2Zg9mPDC1UbdO0W+kSxASWJk/ZkjndVcDwi8lOLUTtvFbcxD7BwPU2YJcJEyl/Ara+pEKCUeUUCr2eZkQ/rwUqEB3tN6UREDMthjsIDFiKb24xYN1KCAs//ftyETmwL/D3Q8bdAI+N9awCEZla5DMn0NNGFl1fzntg+IQUzdfOEcG06UL4lVnjGNz/ErPCrQrRNpP7GiUw6ua2aTfu2gcmy7EA5qOmi9fox+uriR4UXauErURoXUmtXX7rNSStCnJDYH+83WPrPDiUmSb3RhStVNvzJ3MO9k0Y0o/B8oKlG6C+ajDKhViSw0mgCF3G3svPHQdlkD/ceNa4FRJjSV7EfDpErT1oHtaDqARZ94K6MEJ/n/ui1rRkUgRu4cT1q75aefz0CdpSPrBJg9FXl/G1Q2uyaEcMD+aab6vMToOxjB+sAOWTaWnshv1zgzQDktDJRABwrAgrw5VeK2YzWeiauKqe0Y=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763d47b1-ff91-4636-986a-08d82e7a8164
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 20:04:56.7384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3T1ghdo0i2+QPaiClMJhuQdHsufUlL8VP0vxVWX/lNSKqxMzVJievl9Hw+VpKc5K55SwssNK/DuYspnBcS+Q1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6563
Received-SPF: pass client-ip=40.107.15.133;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 16:04:53
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements strace argument printing functionality for following syscalls:

    * clock_getres, clock_gettime, clock_settime - clock and time functions

        int clock_getres(clockid_t clockid, struct timespec *res)
        int clock_gettime(clockid_t clockid, struct timespec *tp)
        int clock_settime(clockid_t clockid, const struct timespec *tp)
        man page: https://man7.org/linux/man-pages/man2/clock_getres.2.html

    * gettimeofday - get time

        int gettimeofday(struct timeval *tv, struct timezone *tz)
        man page: https://man7.org/linux/man-pages/man2/gettimeofday.2.html

    * getitimer, setitimer - get or set value of an interval timer

        int getitimer(int which, struct itimerval *curr_value)
        int setitimer(int which, const struct itimerval *new_value,
                      struct itimerval *old_value)
        man page: https://man7.org/linux/man-pages/man2/getitimer.2.html

Implementation notes:

    All of the syscalls have some structue types as argument types and thus
    a separate printing function was stated in file "strace.list" for each
    of them. All of these functions use existing functions for their
    appropriate structure types ("print_timeval()" and "print_timezone()").

    Functions "print_timespec()" and "print_itimerval()" were added in this
    patch so that they can be used to print types "struct timespec" and
    "struct itimerval" used by some of the syscalls. Function "print_itimerval()"
    uses the existing function "print_timeval()" to print fields of the
    structure "struct itimerval" that are of type "struct timeval".

    Function "print_enums()", which was introduced in the previous patch, is used
    to print the interval timer type which is the first argument of "getitimer()"
    and "setitimer()". Also, this function is used to print the clock id which
    is the first argument of "clock_getres()" and "clock_gettime()". For that
    reason, the existing function "print_clockid()" was removed in this patch.
    Existing function "print_clock_adjtime()" was also changed for this reason
    to use "print_enums()".

    The existing function "print_timeval()" was changed a little so that it
    prints the field names beside the values.

    Syscalls "clock_getres()" and "clock_gettime()" have the same number
    and types of arguments and thus their print functions "print_clock_getres"
    and "print_clock_gettime" share a common definition in file "strace.c".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/strace.c    | 285 +++++++++++++++++++++++++++++++----------
 linux-user/strace.list |  17 ++-
 2 files changed, 230 insertions(+), 72 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index def92c4d73..aa5539f468 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -78,7 +78,9 @@ UNUSED static void print_string(abi_long, int);
 UNUSED static void print_buf(abi_long addr, abi_long len, int last);
 UNUSED static void print_raw_param(const char *, abi_long, int);
 UNUSED static void print_timeval(abi_ulong, int);
+UNUSED static void print_timespec(abi_ulong, int);
 UNUSED static void print_timezone(abi_ulong, int);
+UNUSED static void print_itimerval(abi_ulong, int);
 UNUSED static void print_number(abi_long, int);
 UNUSED static void print_signal(abi_ulong, int);
 UNUSED static void print_sockaddr(abi_ulong, abi_long, int);
@@ -578,69 +580,6 @@ print_fdset(int n, abi_ulong target_fds_addr)
 }
 #endif
 
-#ifdef TARGET_NR_clock_adjtime
-/* IDs of the various system clocks */
-#define TARGET_CLOCK_REALTIME              0
-#define TARGET_CLOCK_MONOTONIC             1
-#define TARGET_CLOCK_PROCESS_CPUTIME_ID    2
-#define TARGET_CLOCK_THREAD_CPUTIME_ID     3
-#define TARGET_CLOCK_MONOTONIC_RAW         4
-#define TARGET_CLOCK_REALTIME_COARSE       5
-#define TARGET_CLOCK_MONOTONIC_COARSE      6
-#define TARGET_CLOCK_BOOTTIME              7
-#define TARGET_CLOCK_REALTIME_ALARM        8
-#define TARGET_CLOCK_BOOTTIME_ALARM        9
-#define TARGET_CLOCK_SGI_CYCLE             10
-#define TARGET_CLOCK_TAI                   11
-
-static void
-print_clockid(int clockid, int last)
-{
-    switch (clockid) {
-    case TARGET_CLOCK_REALTIME:
-        qemu_log("CLOCK_REALTIME");
-        break;
-    case TARGET_CLOCK_MONOTONIC:
-        qemu_log("CLOCK_MONOTONIC");
-        break;
-    case TARGET_CLOCK_PROCESS_CPUTIME_ID:
-        qemu_log("CLOCK_PROCESS_CPUTIME_ID");
-        break;
-    case TARGET_CLOCK_THREAD_CPUTIME_ID:
-        qemu_log("CLOCK_THREAD_CPUTIME_ID");
-        break;
-    case TARGET_CLOCK_MONOTONIC_RAW:
-        qemu_log("CLOCK_MONOTONIC_RAW");
-        break;
-    case TARGET_CLOCK_REALTIME_COARSE:
-        qemu_log("CLOCK_REALTIME_COARSE");
-        break;
-    case TARGET_CLOCK_MONOTONIC_COARSE:
-        qemu_log("CLOCK_MONOTONIC_COARSE");
-        break;
-    case TARGET_CLOCK_BOOTTIME:
-        qemu_log("CLOCK_BOOTTIME");
-        break;
-    case TARGET_CLOCK_REALTIME_ALARM:
-        qemu_log("CLOCK_REALTIME_ALARM");
-        break;
-    case TARGET_CLOCK_BOOTTIME_ALARM:
-        qemu_log("CLOCK_BOOTTIME_ALARM");
-        break;
-    case TARGET_CLOCK_SGI_CYCLE:
-        qemu_log("CLOCK_SGI_CYCLE");
-        break;
-    case TARGET_CLOCK_TAI:
-        qemu_log("CLOCK_TAI");
-        break;
-    default:
-        qemu_log("%d", clockid);
-        break;
-    }
-    qemu_log("%s", get_comma(last));
-}
-#endif
-
 /*
  * Sysycall specific output functions
  */
@@ -839,6 +778,81 @@ print_syscall_ret_adjtimex(void *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_clock_gettime) || defined(TARGET_NR_clock_getres)
+static void
+print_syscall_ret_clock_gettime(void *cpu_env, const struct syscallname *name,
+                                abi_long ret, abi_long arg0, abi_long arg1,
+                                abi_long arg2, abi_long arg3, abi_long arg4,
+                                abi_long arg5)
+{
+    if (!print_syscall_err(ret)) {
+        qemu_log(TARGET_ABI_FMT_ld, ret);
+        qemu_log(" (");
+        print_timespec(arg1, 1);
+        qemu_log(")");
+    }
+
+    qemu_log("\n");
+}
+#define print_syscall_ret_clock_getres     print_syscall_ret_clock_gettime
+#endif
+
+#ifdef TARGET_NR_gettimeofday
+static void
+print_syscall_ret_gettimeofday(void *cpu_env, const struct syscallname *name,
+                               abi_long ret, abi_long arg0, abi_long arg1,
+                               abi_long arg2, abi_long arg3, abi_long arg4,
+                               abi_long arg5)
+{
+    if (!print_syscall_err(ret)) {
+        qemu_log(TARGET_ABI_FMT_ld, ret);
+        qemu_log(" (");
+        print_timeval(arg0, 0);
+        print_timezone(arg1, 1);
+        qemu_log(")");
+    }
+
+    qemu_log("\n");
+}
+#endif
+
+#ifdef TARGET_NR_getitimer
+static void
+print_syscall_ret_getitimer(void *cpu_env, const struct syscallname *name,
+                            abi_long ret, abi_long arg0, abi_long arg1,
+                            abi_long arg2, abi_long arg3, abi_long arg4,
+                            abi_long arg5)
+{
+    if (!print_syscall_err(ret)) {
+        qemu_log(TARGET_ABI_FMT_ld, ret);
+        qemu_log(" (");
+        print_itimerval(arg1, 1);
+        qemu_log(")");
+    }
+
+    qemu_log("\n");
+}
+#endif
+
+
+#ifdef TARGET_NR_getitimer
+static void
+print_syscall_ret_setitimer(void *cpu_env, const struct syscallname *name,
+                            abi_long ret, abi_long arg0, abi_long arg1,
+                            abi_long arg2, abi_long arg3, abi_long arg4,
+                            abi_long arg5)
+{
+    if (!print_syscall_err(ret)) {
+        qemu_log(TARGET_ABI_FMT_ld, ret);
+        qemu_log(" (old_value = ");
+        print_itimerval(arg2, 1);
+        qemu_log(")");
+    }
+
+    qemu_log("\n");
+}
+#endif
+
 #if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr) \
  || defined(TARGGET_NR_flistxattr)
 static void
@@ -1217,6 +1231,43 @@ UNUSED static struct flags mlockall_flags[] = {
     FLAG_END,
 };
 
+/* IDs of the various system clocks */
+#define TARGET_CLOCK_REALTIME              0
+#define TARGET_CLOCK_MONOTONIC             1
+#define TARGET_CLOCK_PROCESS_CPUTIME_ID    2
+#define TARGET_CLOCK_THREAD_CPUTIME_ID     3
+#define TARGET_CLOCK_MONOTONIC_RAW         4
+#define TARGET_CLOCK_REALTIME_COARSE       5
+#define TARGET_CLOCK_MONOTONIC_COARSE      6
+#define TARGET_CLOCK_BOOTTIME              7
+#define TARGET_CLOCK_REALTIME_ALARM        8
+#define TARGET_CLOCK_BOOTTIME_ALARM        9
+#define TARGET_CLOCK_SGI_CYCLE             10
+#define TARGET_CLOCK_TAI                   11
+
+UNUSED static struct enums clockids[] = {
+    ENUM_TARGET(CLOCK_REALTIME),
+    ENUM_TARGET(CLOCK_MONOTONIC),
+    ENUM_TARGET(CLOCK_PROCESS_CPUTIME_ID),
+    ENUM_TARGET(CLOCK_THREAD_CPUTIME_ID),
+    ENUM_TARGET(CLOCK_MONOTONIC_RAW),
+    ENUM_TARGET(CLOCK_REALTIME_COARSE),
+    ENUM_TARGET(CLOCK_MONOTONIC_COARSE),
+    ENUM_TARGET(CLOCK_BOOTTIME),
+    ENUM_TARGET(CLOCK_REALTIME_ALARM),
+    ENUM_TARGET(CLOCK_BOOTTIME_ALARM),
+    ENUM_TARGET(CLOCK_SGI_CYCLE),
+    ENUM_TARGET(CLOCK_TAI),
+    ENUM_END,
+};
+
+UNUSED static struct enums itimer_types[] = {
+    ENUM_GENERIC(ITIMER_REAL),
+    ENUM_GENERIC(ITIMER_VIRTUAL),
+    ENUM_GENERIC(ITIMER_PROF),
+    ENUM_END,
+};
+
 /*
  * print_xxx utility functions.  These are used to print syscall
  * parameters in certain format.  All of these have parameter
@@ -1435,13 +1486,34 @@ print_timeval(abi_ulong tv_addr, int last)
             print_pointer(tv_addr, last);
             return;
         }
-        qemu_log("{" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "}%s",
-            tswapal(tv->tv_sec), tswapal(tv->tv_usec), get_comma(last));
+        qemu_log("{tv_sec = " TARGET_ABI_FMT_ld
+                 ",tv_usec = " TARGET_ABI_FMT_ld "}%s",
+                 tswapal(tv->tv_sec), tswapal(tv->tv_usec), get_comma(last));
         unlock_user(tv, tv_addr, 0);
     } else
         qemu_log("NULL%s", get_comma(last));
 }
 
+static void
+print_timespec(abi_ulong ts_addr, int last)
+{
+    if (ts_addr) {
+        struct target_timespec *ts;
+
+        ts = lock_user(VERIFY_READ, ts_addr, sizeof(*ts), 1);
+        if (!ts) {
+            print_pointer(ts_addr, last);
+            return;
+        }
+        qemu_log("{tv_sec = " TARGET_ABI_FMT_ld
+                 ",tv_nsec = " TARGET_ABI_FMT_ld "}%s",
+                 tswapal(ts->tv_sec), tswapal(ts->tv_nsec), get_comma(last));
+        unlock_user(ts, ts_addr, 0);
+    } else {
+        qemu_log("NULL%s", get_comma(last));
+    }
+}
+
 static void
 print_timezone(abi_ulong tz_addr, int last)
 {
@@ -1461,6 +1533,20 @@ print_timezone(abi_ulong tz_addr, int last)
     }
 }
 
+static void
+print_itimerval(abi_ulong it_addr, int last)
+{
+    if (it_addr) {
+        qemu_log("{it_interval=");
+        print_timeval(it_addr, 0);
+        qemu_log("it_value=");
+        print_timeval(it_addr + sizeof(struct target_timeval), 1);
+        qemu_log("}%s", get_comma(last));
+    } else {
+        qemu_log("NULL%s", get_comma(last));
+    }
+}
+
 #undef UNUSED
 
 #ifdef TARGET_NR_accept
@@ -1573,7 +1659,7 @@ print_clock_adjtime(void *cpu_env, const struct syscallname *name,
                     abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
-    print_clockid(arg0, 0);
+    print_enums(clockids, arg0, 0);
     print_pointer(arg1, 1);
     print_syscall_epilogue(name);
 }
@@ -1903,6 +1989,19 @@ print_futimesat(void *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_gettimeofday
+static void
+print_gettimeofday(void *cpu_env, const struct syscallname *name,
+                   abi_long arg0, abi_long arg1, abi_long arg2,
+                   abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_pointer(arg0, 0);
+    print_pointer(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_settimeofday
 static void
 print_settimeofday(void *cpu_env, const struct syscallname *name,
@@ -1916,6 +2015,60 @@ print_settimeofday(void *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_clock_gettime) || defined(TARGET_NR_clock_getres)
+static void
+print_clock_gettime(void *cpu_env, const struct syscallname *name,
+                    abi_long arg0, abi_long arg1, abi_long arg2,
+                    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_enums(clockids, arg0, 0);
+    print_pointer(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#define print_clock_getres     print_clock_gettime
+#endif
+
+#ifdef TARGET_NR_clock_settime
+static void
+print_clock_settime(void *cpu_env, const struct syscallname *name,
+                    abi_long arg0, abi_long arg1, abi_long arg2,
+                    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_enums(clockids, arg0, 0);
+    print_timespec(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_getitimer
+static void
+print_getitimer(void *cpu_env, const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_enums(itimer_types, arg0, 0);
+    print_pointer(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_setitimer
+static void
+print_setitimer(void *cpu_env, const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_enums(itimer_types, arg0, 0);
+    print_itimerval(arg1, 0);
+    print_pointer(arg2, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_link
 static void
 print_link(void *cpu_env, const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index d0ea7f3464..084048ab96 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -83,16 +83,18 @@
 { TARGET_NR_clock_adjtime, "clock_adjtime" , NULL, print_clock_adjtime, NULL },
 #endif
 #ifdef TARGET_NR_clock_getres
-{ TARGET_NR_clock_getres, "clock_getres" , NULL, NULL, NULL },
+{ TARGET_NR_clock_getres, "clock_getres" , NULL, print_clock_getres,
+                          print_syscall_ret_clock_getres },
 #endif
 #ifdef TARGET_NR_clock_gettime
-{ TARGET_NR_clock_gettime, "clock_gettime" , NULL, NULL, NULL },
+{ TARGET_NR_clock_gettime, "clock_gettime" , NULL, print_clock_gettime,
+                           print_syscall_ret_clock_gettime },
 #endif
 #ifdef TARGET_NR_clock_nanosleep
 { TARGET_NR_clock_nanosleep, "clock_nanosleep" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_clock_settime
-{ TARGET_NR_clock_settime, "clock_settime" , NULL, NULL, NULL },
+{ TARGET_NR_clock_settime, "clock_settime" , NULL, print_clock_settime, NULL },
 #endif
 #ifdef TARGET_NR_clone
 { TARGET_NR_clone, "clone" , NULL, print_clone, NULL },
@@ -315,7 +317,8 @@
 { TARGET_NR_gethostname, "gethostname" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getitimer
-{ TARGET_NR_getitimer, "getitimer" , NULL, NULL, NULL },
+{ TARGET_NR_getitimer, "getitimer" , NULL, print_getitimer,
+                       print_syscall_ret_getitimer },
 #endif
 #ifdef TARGET_NR_get_kernel_syms
 { TARGET_NR_get_kernel_syms, "get_kernel_syms" , NULL, NULL, NULL },
@@ -388,7 +391,8 @@
 { TARGET_NR_gettid, "gettid" , "%s()", NULL, NULL },
 #endif
 #ifdef TARGET_NR_gettimeofday
-{ TARGET_NR_gettimeofday, "gettimeofday" , NULL, NULL, NULL },
+{ TARGET_NR_gettimeofday, "gettimeofday" , NULL, print_gettimeofday,
+                          print_syscall_ret_gettimeofday },
 #endif
 #ifdef TARGET_NR_getuid
 { TARGET_NR_getuid, "getuid" , "%s()", NULL, NULL },
@@ -1291,7 +1295,8 @@
 { TARGET_NR_sethostname, "sethostname" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_setitimer
-{ TARGET_NR_setitimer, "setitimer" , NULL, NULL, NULL },
+{ TARGET_NR_setitimer, "setitimer" , NULL, print_setitimer,
+                       print_syscall_ret_setitimer },
 #endif
 #ifdef TARGET_NR_set_mempolicy
 { TARGET_NR_set_mempolicy, "set_mempolicy" , NULL, NULL, NULL },
-- 
2.25.1


