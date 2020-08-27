Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF817C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842A9207DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842A9207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNYA-00008d-MT
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNS2-00049B-Ly
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:46 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:49831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNRz-0000EV-5c
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:46 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MWRZt-1k5jFC2c3v-00Xsar; Thu, 27 Aug 2020 21:20:34 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/18] linux-user: Add strace support for printing arguments of
 some clock and time functions
Date: Thu, 27 Aug 2020 21:20:08 +0200
Message-Id: <20200827192018.2442099-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827192018.2442099-1-laurent@vivier.eu>
References: <20200827192018.2442099-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NB9938P+5opmnSzFZMuNXxDKGGhWCw6l5FGZtDqM5ZSbPCAW559
 3FnRcJGlKwt2cZHDrEkTtdsNLw+ZzLbmvI8eRWhe96Mojn+zUOlMWv8vXhSE+I/P7t+G91B
 9y7PWpWOd/p/xV+VQSrkQf77d6J2FXxmmRVNhXlRAXSCfUGGCrJ2IxpNPD2b/qQhW7dd0tA
 A1sqjTjolCreJ6Dtvst7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZQX412ckV8k=:o9DBYbd/avRQ2Cdacs7nug
 /OqYFE5LUbnRbGUOrl+VPakdMc8YVCXG445Or1vO0xWAfLN06qs9j8N/bagy/gUtJBFY/opOD
 Rtpw1wezpEYDbFOGkkDFZc2tlr2GJ/dj+JSDzxH7bZ584eNRX6cAMwT2ejOWfy2w20BnJ4bGv
 w1GWCHRlB/sHAyuWfczTR7oLLTCPdJkWM2xbbal+8bH8kBWb4ichj6SiJ9nDxpghl5khfpV2e
 xYefPb6vTcLMEcb58GXzl6AKL2uz1nWVsk6CxZKcFWmX2CsC1FHkYwnmCoaSkPrWUn4Gcx48s
 akOYR+jqyhq6TwTDrTHD5FRD1UKLyUzgzwiF7ZBWYUvduREcndbtxUuo3j4SWmgiGmqeT/c3C
 KT9KbBhs545gDWYxqv116TRUROJzmON+Q6yKvLcnuCvy5PsuXHIjxlpuveLQw1O3TOB2F1YrH
 5haaxfnFHWfNhJVKFTqLq8IVOAWW6Iq5SJwqZPtebPPOpAxyodN6ML8OBejJ4do8CTEGATLnH
 fADa63VVjv7SGyOP8T9GixCC1k8Z5PaLpC4XU+QzTmP/ZMO/DUoX/E5Tb8S9X2WhGbvXzjhWy
 nSNSl4uybzXNAh+QGUb+PHRBESAn0R77Z3cQtaf0QFo7Ai84mXnbyTMwwbpVFP9KtrEYvPGYI
 Q+GEyHem+g7XHugGNFJQz+bOAmq8BjsY5iDknbn3W6Ehc6FH1A+Q716gvA1GDDED6Usb4YA1r
 tQ7NO5dPOdYUh3VmyfAbL2imvQpv/UUO3wTr7pxOwe76/tDgdvKtqFjkBCcHPglfr9BO32sWi
 ZGVu1pSr1xAffWolRJKD0wMUgMI3E9X7yHBSV+D679zAyAz4xL6xTze6YQotINqhrUopCSJ
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 15:20:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200811164553.27713-6-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 287 +++++++++++++++++++++++++++++++----------
 linux-user/strace.list |  17 ++-
 2 files changed, 232 insertions(+), 72 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index d0731b888d29..c7ef948b9451 100644
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
@@ -582,69 +584,6 @@ print_fdset(int n, abi_ulong target_fds_addr)
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
@@ -843,6 +782,81 @@ print_syscall_ret_adjtimex(void *cpu_env, const struct syscallname *name,
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
@@ -1221,6 +1235,43 @@ UNUSED static struct flags mlockall_flags[] = {
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
@@ -1439,13 +1490,34 @@ print_timeval(abi_ulong tv_addr, int last)
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
@@ -1465,6 +1537,22 @@ print_timezone(abi_ulong tz_addr, int last)
     }
 }
 
+static void
+print_itimerval(abi_ulong it_addr, int last)
+{
+    if (it_addr) {
+        qemu_log("{it_interval=");
+        print_timeval(it_addr +
+                      offsetof(struct target_itimerval, it_interval), 0);
+        qemu_log("it_value=");
+        print_timeval(it_addr +
+                      offsetof(struct target_itimerval, it_value), 0);
+        qemu_log("}%s", get_comma(last));
+    } else {
+        qemu_log("NULL%s", get_comma(last));
+    }
+}
+
 #undef UNUSED
 
 #ifdef TARGET_NR_accept
@@ -1577,7 +1665,7 @@ print_clock_adjtime(void *cpu_env, const struct syscallname *name,
                     abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
-    print_clockid(arg0, 0);
+    print_enums(clockids, arg0, 0);
     print_pointer(arg1, 1);
     print_syscall_epilogue(name);
 }
@@ -1907,6 +1995,19 @@ print_futimesat(void *cpu_env, const struct syscallname *name,
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
@@ -1920,6 +2021,60 @@ print_settimeofday(void *cpu_env, const struct syscallname *name,
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
index d0ea7f3464b8..084048ab96dd 100644
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
2.26.2


