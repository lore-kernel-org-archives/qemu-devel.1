Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F8BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A77120771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A77120771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k67AF-00089m-Ge
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 02:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673T-0006TV-UX
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:40 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673M-0004cC-Cm
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:39 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mrggc-1kQrSt3nGe-00nlbS; Thu, 13 Aug 2020 08:49:28 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/14] linux-user: Add support for a group of 2038 safe syscalls
Date: Thu, 13 Aug 2020 08:49:14 +0200
Message-Id: <20200813064923.263565-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200813064923.263565-1-laurent@vivier.eu>
References: <20200813064923.263565-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dCqji8x8mJP+mxBL/CkPObTVzMKVc4hoXe0pSziuwVvevVaOgi2
 cKXXQM0JwJZ+Wva5eZFuwpDTjfSi/VIkTTIUtYyrcjJbLR7OuPgs6fFVYtQ8lsBrWtcV9d2
 PrLc+ZnYenh/IkZLFni5pFVpi5mo+0qGpkygl4hOrkeBgZ5bDr6eQORLVWpwliUoccims/o
 AVlAt6zSjLQ+yv2Wkltew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KDuER9gwmHs=:8xKKPkQ8X/toify7RglusK
 stm+cR7tiWn14lfjH/JE/DBMiQh6n9DZpeGaOZdJ1m8VW/3EWfGNp+FtK2PwVSNquh44aQ3VZ
 zixEpj4hfH2yIqRjE/BWN5Ex0TnL6KmLmR2Rv3Mc8Gx1WKEbE9U29iL/hvyXNLFEQXyH3gN9Z
 OrBNNyKANijV9gtL6yK6ibsdbB1Q7HGRLCNRmsJvRNSF+1s0uOndA53/qLLucaA+dnPz6cYTF
 ke/95D2nVbAImR/hk6lJFeXbbpGkcSshOO/WFHI4DoAT4qRnO90y1KEYP2wvAAG9og+VTWOJa
 4y/cxEroUoUeQVuIgSuFsduvw+iXBoftaO0m+sYPPX5Xhn38edC63LVlsoBmf0uHRpWrZTZsm
 JY52cFneRwFE4ThecO1poLZiY4cDpHNdv2AyqCFh3HRP7GIjy5N96q0bB1HErgY9q5zM9z1iF
 x+C96duw0m2C5Mut6pR22/J0GPoA4IcyibuYwbR8c+B8Slrelo27aL1JwpC8jOycGn2r1bCqP
 HJ4rALbXLQSrW/C0tez1l/+hzf3NAwy1rsG+DheYcx9K0hLvzKZkUttyk7IsltIAAgrTjmj4H
 Ziwf4UB9PkUZxPpnRA1nsjVS+O0ebO7NKXHqjKuB0QlgdNoutcAC1TMzZlfWxICA+C5wyvZCE
 KB3gJyCGmFJNe1XyP4ZlfZC+/8swM//xLZD1drQwJH5jduJA516hkRm5WRdXRo2k7I+vEnB49
 8mDfBrBouTePWVmeLRHC265FSXw1K1/EOSEv/ATWgPfq31xH8A3gbiZQ8huXcpvZDoQZsw8zK
 14j2kcn/C6eyC2IwKX4Z2esT2HkxUUElTl4FmZVx+okFiasGifOiyF65IvgG8vWvyYjP6rI
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:49:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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


