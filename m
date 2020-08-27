Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0378BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D027D207DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D027D207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNTA-0005wV-1b
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNS5-0004GS-Tf
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:50 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNS3-0000Ha-Rl
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:49 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MSKq6-1k0URY1rZY-00Sdf4; Thu, 27 Aug 2020 21:20:44 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 17/18] linux-user: Add support for 'rt_sigtimedwait_time64()'
 and 'sched_rr_get_interval_time64()'
Date: Thu, 27 Aug 2020 21:20:17 +0200
Message-Id: <20200827192018.2442099-18-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827192018.2442099-1-laurent@vivier.eu>
References: <20200827192018.2442099-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iArs7WzgFORGfjjIRmUkgldGfCrWfC86/ThQOMf+7Bj7ZMDRUNH
 Sdq1SOQejV0kKhqu84TktQ/E87oBVzeIinADgn25Vl7sDjvynQbpbyEgNs86s0EnyJ0GtYl
 x0o/ff1GIKkWHnLMnj6/FIk6VEnheHbKHaXhHYAsKF/UN5h+jfcS3t228+kOEwE5CVX0bqh
 nVLeYIfoHqz5VxAjSJLXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VpHd2xuhM5w=:QTvbdPdu2GJWtZ766OjsBj
 QqCPv+gscSeTJ4f3a1mnlXpCcMPAzZsIL8AuPjptd7egZmPlIYEQ4oYyj7d6xJxzO1IA+9N7O
 UaQh1eJRsf3oSRgY3PRYpS2AodoMpKexjfUPsrCF1uto7RWCFASGGrPdXGBPRS5zmh1hZiKrE
 uIXtmrpBdijTOR3dcHtS8n2xqiPT/fk9HNxgS7Ayy4HdSVprlEj2Jz13jKrLoOwFqkR9CN7jD
 whFDIQujEnBYdtSk0WflXB1pzot/h+472/0Qd6+k8DIsVnfs95HCi1buJJ1qsi+I9kt9ja6ZM
 KZmgRmASejhULw0f92+lrTswGANZnix5xvDwKPjSSf/Zt6LZ+AXqp1ypP3hZv1o9WZW/0lgUT
 NA1nTiyS8XQFaTwCorfQjZwFUVP6XXoiSoyjTdPTIZj/DWxpqwuFWUC5IGz+R+B5rORpHO8KT
 s9fVfUPJgSA3kpvmrxee/hbp8w79Q1btq6rBHnafdrZWkoDZSGCWsMYrIKOorKRKeMPGHDxQt
 19qybkViFqEmvkuEtT7s9CaZY0CowUfHrs5HE635oBi7wYMx23i4+1Ol3GsH057xyH0nWTRqA
 GH0Oy0buaVzvzNzcySLDJJe3K3LPq7Ey2KG+WvZM7GuySE952YPciwIGVG/88OHyyu/CS+WKY
 WqG2EutLS1X2yocILgQuIQvFVGxqaWLf0DRltSxjzJM7G4WNY5PPhVTKPxvTNbqUXdnkY6bFt
 iMOh7IrGWZHm7/7M7zvqKGhsG/KXITvw5GqaWNj5B3R5GvZpaiAB78e84EQ3XybVU/5zZyIfB
 gWCguT2vGjm0uv52VCoE+SKvGeDRSI3+bZQqVT3zy5RssAeu4UVByG+ZgYA/WQJr/6Ib/3t
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

This patch implements functionality for following time64 syscalls:

*rt_sigtimedwait_time64()

    This is a year 2038 safe variant of syscall:

    int rt_sigtimedwait(const sigset_t *set, siginfo_t *info,
                        const struct timespec *timeout, size_t sigsetsize)
    --synchronously wait for queued signals--
    man page: https://man7.org/linux/man-pages/man2/rt_sigtimedwait.2.html

*sched_rr_get_interval_time64()

    This is a year 2038 safe variant of syscall:

    int sched_rr_get_interval(pid_t pid, struct timespec *tp)
    --get  the  SCHED_RR  interval  for the named process--
    man page: https://man7.org/linux/man-pages/man2/sched_rr_get_interval.2.html

Implementation notes:

    These syscalls were implemented in similar ways like
    'rt_sigtimedwait()' and 'sched_rr_get_interval()' except
    that functions 'target_to_host_timespec64()' and
    'host_to_target_timespec64()' were used to convert values
    of 'struct timespec' between host and target.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200824192116.65562-3-Filip.Bozuta@syrmia.com>
[lv: add missing defined(TARGET_NR_rt_sigtimedwait_time64)]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 58 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 82414c08d655..9d7376734ad4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -764,7 +764,7 @@ safe_syscall6(ssize_t, recvfrom, int, fd, void *, buf, size_t, len,
 safe_syscall3(ssize_t, sendmsg, int, fd, const struct msghdr *, msg, int, flags)
 safe_syscall3(ssize_t, recvmsg, int, fd, struct msghdr *, msg, int, flags)
 safe_syscall2(int, flock, int, fd, int, operation)
-#ifdef TARGET_NR_rt_sigtimedwait
+#if defined(TARGET_NR_rt_sigtimedwait) || defined(TARGET_NR_rt_sigtimedwait_time64)
 safe_syscall4(int, rt_sigtimedwait, const sigset_t *, these, siginfo_t *, uinfo,
               const struct timespec *, uts, size_t, sigsetsize)
 #endif
@@ -1241,7 +1241,8 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
     defined(TARGET_NR_mq_timedsend_time64) || \
     defined(TARGET_NR_mq_timedreceive_time64) || \
     (defined(TARGET_NR_timerfd_settime64) && defined(CONFIG_TIMERFD)) || \
-    defined(TARGET_NR_clock_nanosleep_time64)
+    defined(TARGET_NR_clock_nanosleep_time64) || \
+    defined(TARGET_NR_rt_sigtimedwait_time64)
 static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
                                                  abi_ulong target_addr)
 {
@@ -9042,6 +9043,48 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
+#ifdef TARGET_NR_rt_sigtimedwait_time64
+    case TARGET_NR_rt_sigtimedwait_time64:
+        {
+            sigset_t set;
+            struct timespec uts, *puts;
+            siginfo_t uinfo;
+
+            if (arg4 != sizeof(target_sigset_t)) {
+                return -TARGET_EINVAL;
+            }
+
+            p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+            if (!p) {
+                return -TARGET_EFAULT;
+            }
+            target_to_host_sigset(&set, p);
+            unlock_user(p, arg1, 0);
+            if (arg3) {
+                puts = &uts;
+                if (target_to_host_timespec64(puts, arg3)) {
+                    return -TARGET_EFAULT;
+                }
+            } else {
+                puts = NULL;
+            }
+            ret = get_errno(safe_rt_sigtimedwait(&set, &uinfo, puts,
+                                                 SIGSET_T_SIZE));
+            if (!is_error(ret)) {
+                if (arg2) {
+                    p = lock_user(VERIFY_WRITE, arg2,
+                                  sizeof(target_siginfo_t), 0);
+                    if (!p) {
+                        return -TARGET_EFAULT;
+                    }
+                    host_to_target_siginfo(p, &uinfo);
+                    unlock_user(p, arg2, sizeof(target_siginfo_t));
+                }
+                ret = host_to_target_signal(ret);
+            }
+        }
+        return ret;
 #endif
     case TARGET_NR_rt_sigqueueinfo:
         {
@@ -10566,6 +10609,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
+#ifdef TARGET_NR_sched_rr_get_interval_time64
+    case TARGET_NR_sched_rr_get_interval_time64:
+        {
+            struct timespec ts;
+            ret = get_errno(sched_rr_get_interval(arg1, &ts));
+            if (!is_error(ret)) {
+                ret = host_to_target_timespec64(arg2, &ts);
+            }
+        }
+        return ret;
+#endif
 #if defined(TARGET_NR_nanosleep)
     case TARGET_NR_nanosleep:
         {
-- 
2.26.2


