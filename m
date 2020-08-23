Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFABC433E3
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B622067C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B622067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9rVI-00019q-Ev
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 11:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9rSs-0004re-5g
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 10:59:22 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9rSp-0006dy-Oo
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 10:59:21 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MBV6n-1kLjAo0vkd-00D24x; Sun, 23 Aug 2020 16:59:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 5/6] linux-user: Add support for a group of 2038 safe syscalls
Date: Sun, 23 Aug 2020 16:59:11 +0200
Message-Id: <20200823145912.1171738-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200823145912.1171738-1-laurent@vivier.eu>
References: <20200823145912.1171738-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:v/JmIcn/3gVAHzsA1rNfUefu5YhhsxT8oo0s52LsPvme60BSJxl
 W4tKmN3tSlrZj4bdLxt1X9g6Pb0arUJiFb/X9sSU5TlkxiR6N1zVAcb1+tegRgYSQ+0qfAv
 7LPvt6Ecntzdm7I8uBGFExthaNHCC3XqavvTPz2Wf/pMbOBGfy4qpt0COXi1Imt3zuAoxLf
 64jtSGS1ooICij8nM/iCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t7GN+OD/ZlQ=:vpH4QomBu6+qsKavJRGm4w
 ghvkmbHIo9Fuyv0JbUYCm/PHZXapCf+TGXxPUHCDIs21m8RAkZ/dk5Pk2m5v08U+xbdqyzi4v
 4CBnX+aGSO1JwfIvJLopqG7yr0ZyQtOCJyg3FfOJKCYWOY/FAyRwQUh5+zejnRacR/g6/5w6y
 a5CXoiVyHjJwu01SZv0DfmaEd1gOcb9l6B/MDpCozOL/DJGCa7upj4H+xP/T7sba4HmZrhHP0
 A0M5zUwPInfLCaqDfXvHp/vAdxvlbVuj47/YMg03KYUqvuP3CEZngLCkO3zJg4IxdRTTqna3/
 BPqLs+mmZO2dDfNnLinfrB7RBPXMIDyi1siTaPmQzRoxmrH3oqAJePzDbNM6p37zP+AW5Z+VT
 ceZfAe1Vx8ZWOSJsx/58HipbNzaSL7nQ9qw/pc/2ScZA3cUXxCNb6ubnfZHyPFKxRV4L/PkRM
 guvcXVdOX+pv9eXkRJ7E4zHPfVnRA50v2tacLQ7WgDWqV29/bj1hCHxkAt1W7WrnIU1G+U8dc
 Zjw/pY5i5yW+rmIyCPwOuSTIijMQX0G8c6r3xRQ2ek28HkTIx/KXUgLPwXwG5ISalrPibvvD3
 qqASYlNgm4Dff/PvGt32zN984F5/rKCP5uT6kiUFpDqn/QwRNuQgbRrd6PEOUavsFplngLmjh
 eibsmVpk45kXhqPEWyRQZ6pqmu/W3PHYRPBgPJJCM5BN3VySmoFNJ7mRwEPI0+i3UvuaLEYzV
 TMNOETjqzksVEySXrM/oZ793Yi52jyTWYWefrYY3QL4Ip2qOb3HnUqV9ZqhIFqVZOahybJnAZ
 TMgXJTEVj/oFDsxIfXx9F1wtJrbNfJR5VqYPHoJz0ej9TViqlLf89YcNGNMYAZtXBIZiNlF
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 10:59:18
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements functionality for following time64 syscalls:

*clock_getres_time64

     This a year 2038 safe variant of syscall:

     int clock_getres(clockid_t clockid, struct timespec *res)
     --finding the resoultion of a specified clock--
     man page: https://man7.org/linux/man-pages/man2/clock_getres.2.html

*timer_gettime64
*timer_settime64

     These are year 2038 safe variants of syscalls:

     int timer_settime(timer_t timerid, int flags,
                       const struct itimerspec *new_value,
                       struct itimerspec *old_value)
     int timer_gettime(timer_t timerid, struct itimerspec *curr_value)
     --arming/dissarming and fetching state of POSIX per-process timer--
     man page: https://man7.org/linux/man-pages/man2/timer_settime.2.html

*timerfd_gettime64
*timerfd_settime64

     These are year 2038 safe variants of syscalls:

     int timerfd_settime(int fd, int flags,
                         const struct itimerspec *new_value,
                         struct itimerspec *old_value)
     int timerfd_gettime(int fd, struct itimerspec *curr_value)
     --timers that notify via file descriptor--
     man page: https://man7.org/linux/man-pages/man2/timerfd_settime.2.html

Implementation notes:

     Syscall 'clock_getres_time64' was implemented similarly to 'clock_getres()'.
     The only difference was that for the conversion of 'struct timespec' from
     host to target, function 'host_to_target_timespec64()' was used instead of
     'host_to_target_timespec()'.

     For other syscalls, new functions 'host_to_target_itimerspec64()' and
     'target_to_host_itimerspec64()' were added to convert the value of the
     'struct itimerspec' from host to target and vice versa. A new type
     'struct target__kernel_itimerspec' was added in 'syscall_defs.h'. This
     type was defined with fields which are of the already defined type
     'struct target_timespec'. This new 'struct target__kernel_itimerspec'
     type is used in these new converting functions. These new functions were
     defined similarly to 'host_to_target_itimerspec()' and 'target_to_host_itimerspec()'
     the only difference being that 'target_to_host_timespec64()' and
     'host_to_target_timespec64()' were used.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200722153421.295411-3-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c      | 139 +++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |   5 ++
 2 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index aea1160804a2..bbb61a59c72f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1247,7 +1247,9 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
 }
 #endif
 
-#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64)
+#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64) || \
+    defined(TARGET_NR_timer_settime64) || \
+    (defined(TARGET_NR_timerfd_settime64) && defined(CONFIG_TIMERFD))
 static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
                                                  abi_ulong target_addr)
 {
@@ -6801,6 +6803,24 @@ static inline abi_long target_to_host_itimerspec(struct itimerspec *host_its,
 }
 #endif
 
+#if defined(TARGET_NR_timer_settime64) || \
+    (defined(TARGET_NR_timerfd_settime64) && defined(CONFIG_TIMERFD))
+static inline abi_long target_to_host_itimerspec64(struct itimerspec *host_its,
+                                                   abi_ulong target_addr)
+{
+    if (target_to_host_timespec64(&host_its->it_interval, target_addr +
+                                  offsetof(struct target__kernel_itimerspec,
+                                           it_interval)) ||
+        target_to_host_timespec64(&host_its->it_value, target_addr +
+                                  offsetof(struct target__kernel_itimerspec,
+                                           it_value))) {
+        return -TARGET_EFAULT;
+    }
+
+    return 0;
+}
+#endif
+
 #if ((defined(TARGET_NR_timerfd_gettime) || \
       defined(TARGET_NR_timerfd_settime)) && defined(CONFIG_TIMERFD)) || \
       defined(TARGET_NR_timer_gettime) || defined(TARGET_NR_timer_settime)
@@ -6819,6 +6839,26 @@ static inline abi_long host_to_target_itimerspec(abi_ulong target_addr,
 }
 #endif
 
+#if ((defined(TARGET_NR_timerfd_gettime64) || \
+      defined(TARGET_NR_timerfd_settime64)) && defined(CONFIG_TIMERFD)) || \
+      defined(TARGET_NR_timer_gettime64) || defined(TARGET_NR_timer_settime64)
+static inline abi_long host_to_target_itimerspec64(abi_ulong target_addr,
+                                                   struct itimerspec *host_its)
+{
+    if (host_to_target_timespec64(target_addr +
+                                  offsetof(struct target__kernel_itimerspec,
+                                           it_interval),
+                                  &host_its->it_interval) ||
+        host_to_target_timespec64(target_addr +
+                                  offsetof(struct target__kernel_itimerspec,
+                                           it_value),
+                                  &host_its->it_value)) {
+        return -TARGET_EFAULT;
+    }
+    return 0;
+}
+#endif
+
 #if defined(TARGET_NR_adjtimex) || \
     (defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME))
 static inline abi_long target_to_host_timex(struct timex *host_tx,
@@ -11811,6 +11851,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
+#ifdef TARGET_NR_clock_getres_time64
+    case TARGET_NR_clock_getres_time64:
+    {
+        struct timespec ts;
+        ret = get_errno(clock_getres(arg1, &ts));
+        if (!is_error(ret)) {
+            host_to_target_timespec64(arg2, &ts);
+        }
+        return ret;
+    }
+#endif
 #ifdef TARGET_NR_clock_nanosleep
     case TARGET_NR_clock_nanosleep:
     {
@@ -12405,6 +12456,32 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     }
 #endif
 
+#ifdef TARGET_NR_timer_settime64
+    case TARGET_NR_timer_settime64:
+    {
+        target_timer_t timerid = get_timer_id(arg1);
+
+        if (timerid < 0) {
+            ret = timerid;
+        } else if (arg3 == 0) {
+            ret = -TARGET_EINVAL;
+        } else {
+            timer_t htimer = g_posix_timers[timerid];
+            struct itimerspec hspec_new = {{0},}, hspec_old = {{0},};
+
+            if (target_to_host_itimerspec64(&hspec_new, arg3)) {
+                return -TARGET_EFAULT;
+            }
+            ret = get_errno(
+                          timer_settime(htimer, arg2, &hspec_new, &hspec_old));
+            if (arg4 && host_to_target_itimerspec64(arg4, &hspec_old)) {
+                return -TARGET_EFAULT;
+            }
+        }
+        return ret;
+    }
+#endif
+
 #ifdef TARGET_NR_timer_gettime
     case TARGET_NR_timer_gettime:
     {
@@ -12428,6 +12505,29 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     }
 #endif
 
+#ifdef TARGET_NR_timer_gettime64
+    case TARGET_NR_timer_gettime64:
+    {
+        /* args: timer_t timerid, struct itimerspec64 *curr_value */
+        target_timer_t timerid = get_timer_id(arg1);
+
+        if (timerid < 0) {
+            ret = timerid;
+        } else if (!arg2) {
+            ret = -TARGET_EFAULT;
+        } else {
+            timer_t htimer = g_posix_timers[timerid];
+            struct itimerspec hspec;
+            ret = get_errno(timer_gettime(htimer, &hspec));
+
+            if (host_to_target_itimerspec64(arg2, &hspec)) {
+                ret = -TARGET_EFAULT;
+            }
+        }
+        return ret;
+    }
+#endif
+
 #ifdef TARGET_NR_timer_getoverrun
     case TARGET_NR_timer_getoverrun:
     {
@@ -12481,6 +12581,20 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
 #endif
 
+#if defined(TARGET_NR_timerfd_gettime64) && defined(CONFIG_TIMERFD)
+    case TARGET_NR_timerfd_gettime64:
+        {
+            struct itimerspec its_curr;
+
+            ret = get_errno(timerfd_gettime(arg1, &its_curr));
+
+            if (arg2 && host_to_target_itimerspec64(arg2, &its_curr)) {
+                return -TARGET_EFAULT;
+            }
+        }
+        return ret;
+#endif
+
 #if defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD)
     case TARGET_NR_timerfd_settime:
         {
@@ -12504,6 +12618,29 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
 #endif
 
+#if defined(TARGET_NR_timerfd_settime64) && defined(CONFIG_TIMERFD)
+    case TARGET_NR_timerfd_settime64:
+        {
+            struct itimerspec its_new, its_old, *p_new;
+
+            if (arg3) {
+                if (target_to_host_itimerspec64(&its_new, arg3)) {
+                    return -TARGET_EFAULT;
+                }
+                p_new = &its_new;
+            } else {
+                p_new = NULL;
+            }
+
+            ret = get_errno(timerfd_settime(arg1, arg2, p_new, &its_old));
+
+            if (arg4 && host_to_target_itimerspec64(arg4, &its_old)) {
+                return -TARGET_EFAULT;
+            }
+        }
+        return ret;
+#endif
+
 #if defined(TARGET_NR_ioprio_get) && defined(__NR_ioprio_get)
     case TARGET_NR_ioprio_get:
         return get_errno(ioprio_get(arg1, arg2));
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 3c261cff0e5e..427a25f5bce5 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -259,6 +259,11 @@ struct target_itimerspec {
     struct target_timespec it_value;
 };
 
+struct target__kernel_itimerspec {
+    struct target__kernel_timespec it_interval;
+    struct target__kernel_timespec it_value;
+};
+
 struct target_timex {
     abi_uint modes;              /* Mode selector */
     abi_long offset;             /* Time offset */
-- 
2.26.2


