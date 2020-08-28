Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6856C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F18207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F18207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBeg8-0000Qc-Oh
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBeaA-000438-6x
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:18 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:57583)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBea4-0007Gn-5i
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:17 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MfL5v-1knTVi2CAF-00gtWz; Fri, 28 Aug 2020 15:38:10 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 16/18] linux-user: Add support for 'clock_nanosleep_time64()'
 and 'clock_adjtime64()'
Date: Fri, 28 Aug 2020 15:37:51 +0200
Message-Id: <20200828133753.2622286-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828133753.2622286-1-laurent@vivier.eu>
References: <20200828133753.2622286-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZTvxMMF6HYm5sSFMS4zNbaPrJTpHJ7aTsgTjtoMEEhZIwy+tkxN
 4jdlIBBeauj32t9gHtoFODbtb8izKucfHACBEq7XBOKUvrJMQ8sN+5nkB9qSilONBqBB3f6
 cqdw2S/CXDiyAU506x06yxDhGSDh7AEsYueXK5Nk2A8ZQ6NMe8ZbfH1lFanXdq72iGhNy62
 5Y2jmjgoTf48AZbBDeHhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FIYYG54jq5U=:/CHiEjA2P9kFhOopxO8BT0
 XuRQydrrQ7uQK6b2f64DHSPvx7KzQxuMLbkdwuBhFtekRB0KVx1EjBfAKlMz9nGSLd85u1kQR
 hMG2HFU9j8t76g6v8SUbnA7RaLapSyXWesOebmABeu3t1AQ6F4BqKwBU/WojR7TzD1enjap19
 3CL4hXugcUIbc8uagHBcl5eIsxyxdWspuFw5zIb/kDUX7NCV5P+ZsmwNxjWt2+YNfKm9RFOcM
 L5ItyZM4SlzTQ01f2jSpg2KG2iKV1F6A2v8krkUsQDB2EVwlXVr56yItecCqJTeuKpfpcaNO9
 JEn5oetefQYzJ4g0cquTEoWM3i9bGoWCzH2N2sTbUyE70liUNCF0vZ/ywP3cAsspeHPKd/lhG
 Za6TjBSZtxc/EtbXygfw5BqZgd20jGEMdoyn6SE/e9WCRUE8XgS6oxwQ78VHiFC0fMHUtTk1C
 gAWP5AG0cvOav04bSLO+Zb5UH2buJQWt0KXiZ//XWDeN9bJpuIoU2HHW6OBACyMv8Q/sAcpop
 9RxacIoDdKQdoMxlWtgR9FTISL0Qo8tj8MW5p/8AfIWod8Oo4msPUdLCItuuKBKXr093bEugD
 iGvHQuy/SQfk3sJ1WslQChFgFs0SAwrLb2ocVSkrYd9M03QyFODYizW6dCprmgN4rIs8tCnlQ
 962ROrmaLG26vORZ6vqMK66SVNdNldFISypap3jdvUMs9k/nsMvdIZxSXL5W957LMUB8ZgHvv
 F9nd8T//TIwn3O8k/Q1BW1Vhw4o/RhLU1by8xkJT+2Ox33SS2hj5w/xliOwkY4YlJRCXvCy/q
 bwDkLBFwpfLBKZhQ4q9C3dRpwillynvElBm3qk/w5oH5iwpe42epNOlvBDTTbMAE+MgkQG0
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 09:38:08
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

This patch implements functionality for following time64 syscall:

*clock_nanosleep_time64()

    This is a year 2038 safe vairant of syscall:
    int clock_nanosleep(clockid_t clockid, int flags,
                        const struct timespec *request,
                        struct timespec *remain)
    --high-resolution sleep with specifiable clock--
    man page: https://man7.org/linux/man-pages/man2/clock_nanosleep.2.html

*clock_adjtime64()

    This is a year 2038 safe variant of syscall:
    int clock_adjtime(clockid_t clk_id, struct timex *buf)
    --tune kernel clock--
    man page: https://man7.org/linux/man-pages/man2/clock_adjtime.2.html

Implementation notes:

    Syscall 'clock_nanosleep_time64()' was implemented similarly
    to syscall 'clock_nanosleep()' except that 'host_to_target_timespec64()'
    and 'target_to_host_timespec64()' were used instead of the regular
    'host_to_target_timespec()' and 'target_to_host_timespec()'.

    For 'clock_adjtime64()' a 64-bit target kernel version of 'struct timex'
    was defined in 'syscall_defs.h': 'struct target__kernel_timex'.
    This type was used to convert the values of 64-bit timex type between
    host and target. For this purpose a 64-bit timex converting functions
    'target_to_host_timex64()' and 'host_to_target_timex64()'. An existing
    function 'copy_to_user_timeval64()' was used to convert the field
    'time' which if of type 'struct timeval' from host to target.
    Function 'copy_from_user_timveal64()' was added in this patch and
    used to convert the 'time' field from target to host.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200824192116.65562-2-Filip.Bozuta@syrmia.com>
[lv: add missing ifdef's]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c      | 142 +++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |  31 +++++++++
 2 files changed, 170 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b28c8edb421e..6fd3099cd687 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -774,7 +774,8 @@ safe_syscall4(int, accept4, int, fd, struct sockaddr *, addr, socklen_t *, len,
 safe_syscall2(int, nanosleep, const struct timespec *, req,
               struct timespec *, rem)
 #endif
-#ifdef TARGET_NR_clock_nanosleep
+#if defined(TARGET_NR_clock_nanosleep) || \
+    defined(TARGET_NR_clock_nanosleep_time64)
 safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
               const struct timespec *, req, struct timespec *, rem)
 #endif
@@ -1177,8 +1178,27 @@ static inline abi_long copy_to_user_timeval(abi_ulong target_tv_addr,
     return 0;
 }
 
+#if defined(TARGET_NR_clock_adjtime64) && defined(CONFIG_CLOCK_ADJTIME)
+static inline abi_long copy_from_user_timeval64(struct timeval *tv,
+                                                abi_ulong target_tv_addr)
+{
+    struct target__kernel_sock_timeval *target_tv;
+
+    if (!lock_user_struct(VERIFY_READ, target_tv, target_tv_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    __get_user(tv->tv_sec, &target_tv->tv_sec);
+    __get_user(tv->tv_usec, &target_tv->tv_usec);
+
+    unlock_user_struct(target_tv, target_tv_addr, 0);
+
+    return 0;
+}
+#endif
+
 static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
-                                             const struct timeval *tv)
+                                              const struct timeval *tv)
 {
     struct target__kernel_sock_timeval *target_tv;
 
@@ -1222,7 +1242,8 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
     defined(TARGET_NR_timer_settime64) || \
     defined(TARGET_NR_mq_timedsend_time64) || \
     defined(TARGET_NR_mq_timedreceive_time64) || \
-    (defined(TARGET_NR_timerfd_settime64) && defined(CONFIG_TIMERFD))
+    (defined(TARGET_NR_timerfd_settime64) && defined(CONFIG_TIMERFD)) || \
+    defined(TARGET_NR_clock_nanosleep_time64)
 static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
                                                  abi_ulong target_addr)
 {
@@ -6953,6 +6974,87 @@ static inline abi_long host_to_target_timex(abi_long target_addr,
 }
 #endif
 
+
+#if defined(TARGET_NR_clock_adjtime64) && defined(CONFIG_CLOCK_ADJTIME)
+static inline abi_long target_to_host_timex64(struct timex *host_tx,
+                                              abi_long target_addr)
+{
+    struct target__kernel_timex *target_tx;
+
+    if (copy_from_user_timeval64(&host_tx->time, target_addr +
+                                 offsetof(struct target__kernel_timex,
+                                          time))) {
+        return -TARGET_EFAULT;
+    }
+
+    if (!lock_user_struct(VERIFY_READ, target_tx, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    __get_user(host_tx->modes, &target_tx->modes);
+    __get_user(host_tx->offset, &target_tx->offset);
+    __get_user(host_tx->freq, &target_tx->freq);
+    __get_user(host_tx->maxerror, &target_tx->maxerror);
+    __get_user(host_tx->esterror, &target_tx->esterror);
+    __get_user(host_tx->status, &target_tx->status);
+    __get_user(host_tx->constant, &target_tx->constant);
+    __get_user(host_tx->precision, &target_tx->precision);
+    __get_user(host_tx->tolerance, &target_tx->tolerance);
+    __get_user(host_tx->tick, &target_tx->tick);
+    __get_user(host_tx->ppsfreq, &target_tx->ppsfreq);
+    __get_user(host_tx->jitter, &target_tx->jitter);
+    __get_user(host_tx->shift, &target_tx->shift);
+    __get_user(host_tx->stabil, &target_tx->stabil);
+    __get_user(host_tx->jitcnt, &target_tx->jitcnt);
+    __get_user(host_tx->calcnt, &target_tx->calcnt);
+    __get_user(host_tx->errcnt, &target_tx->errcnt);
+    __get_user(host_tx->stbcnt, &target_tx->stbcnt);
+    __get_user(host_tx->tai, &target_tx->tai);
+
+    unlock_user_struct(target_tx, target_addr, 0);
+    return 0;
+}
+
+static inline abi_long host_to_target_timex64(abi_long target_addr,
+                                              struct timex *host_tx)
+{
+    struct target__kernel_timex *target_tx;
+
+   if (copy_to_user_timeval64(target_addr +
+                              offsetof(struct target__kernel_timex, time),
+                              &host_tx->time)) {
+        return -TARGET_EFAULT;
+    }
+
+    if (!lock_user_struct(VERIFY_WRITE, target_tx, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    __put_user(host_tx->modes, &target_tx->modes);
+    __put_user(host_tx->offset, &target_tx->offset);
+    __put_user(host_tx->freq, &target_tx->freq);
+    __put_user(host_tx->maxerror, &target_tx->maxerror);
+    __put_user(host_tx->esterror, &target_tx->esterror);
+    __put_user(host_tx->status, &target_tx->status);
+    __put_user(host_tx->constant, &target_tx->constant);
+    __put_user(host_tx->precision, &target_tx->precision);
+    __put_user(host_tx->tolerance, &target_tx->tolerance);
+    __put_user(host_tx->tick, &target_tx->tick);
+    __put_user(host_tx->ppsfreq, &target_tx->ppsfreq);
+    __put_user(host_tx->jitter, &target_tx->jitter);
+    __put_user(host_tx->shift, &target_tx->shift);
+    __put_user(host_tx->stabil, &target_tx->stabil);
+    __put_user(host_tx->jitcnt, &target_tx->jitcnt);
+    __put_user(host_tx->calcnt, &target_tx->calcnt);
+    __put_user(host_tx->errcnt, &target_tx->errcnt);
+    __put_user(host_tx->stbcnt, &target_tx->stbcnt);
+    __put_user(host_tx->tai, &target_tx->tai);
+
+    unlock_user_struct(target_tx, target_addr, 1);
+    return 0;
+}
+#endif
+
 static inline abi_long target_to_host_sigevent(struct sigevent *host_sevp,
                                                abi_ulong target_addr)
 {
@@ -9940,6 +10042,21 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
+#if defined(TARGET_NR_clock_adjtime64) && defined(CONFIG_CLOCK_ADJTIME)
+    case TARGET_NR_clock_adjtime64:
+        {
+            struct timex htx;
+
+            if (target_to_host_timex64(&htx, arg2) != 0) {
+                return -TARGET_EFAULT;
+            }
+            ret = get_errno(clock_adjtime(arg1, &htx));
+            if (!is_error(ret) && host_to_target_timex64(arg2, &htx)) {
+                    return -TARGET_EFAULT;
+            }
+        }
+        return ret;
 #endif
     case TARGET_NR_getpgid:
         return get_errno(getpgid(arg1));
@@ -11911,6 +12028,25 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
+#ifdef TARGET_NR_clock_nanosleep_time64
+    case TARGET_NR_clock_nanosleep_time64:
+    {
+        struct timespec ts;
+
+        if (target_to_host_timespec64(&ts, arg3)) {
+            return -TARGET_EFAULT;
+        }
+
+        ret = get_errno(safe_clock_nanosleep(arg1, arg2,
+                                             &ts, arg4 ? &ts : NULL));
+
+        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME &&
+            host_to_target_timespec64(arg4, &ts)) {
+            return -TARGET_EFAULT;
+        }
+        return ret;
+    }
+#endif
 
 #if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
     case TARGET_NR_set_tid_address:
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index a6abc7e70be8..9d07991176b8 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -294,6 +294,37 @@ struct target_timex {
     abi_int:32; abi_int:32; abi_int:32;
 };
 
+struct target__kernel_timex {
+    abi_uint modes;               /* Mode selector */
+    abi_int: 32;                  /* pad */
+    abi_llong offset;             /* Time offset */
+    abi_llong freq;               /* Frequency offset */
+    abi_llong maxerror;           /* Maximum error (microseconds) */
+    abi_llong esterror;           /* Estimated error (microseconds) */
+    abi_int status;               /* Clock command/status */
+    abi_int: 32;                  /* pad */
+    abi_llong constant;           /* PLL (phase-locked loop) time constant */
+    abi_llong precision;          /* Clock precision (microseconds, ro) */
+    abi_llong tolerance;          /* Clock freq. tolerance (ppm, ro) */
+    struct target__kernel_sock_timeval time;  /* Current time */
+    abi_llong tick;               /* Microseconds between clock ticks */
+    abi_llong ppsfreq;            /* PPS (pulse per second) frequency */
+    abi_llong jitter;             /* PPS jitter (ro); nanoseconds */
+    abi_int shift;                /* PPS interval duration (seconds) */
+    abi_int: 32;                  /* pad */
+    abi_llong stabil;             /* PPS stability */
+    abi_llong jitcnt;             /* PPS jitter limit exceeded (ro) */
+    abi_llong calcnt;             /* PPS calibration intervals */
+    abi_llong errcnt;             /* PPS calibration errors */
+    abi_llong stbcnt;             /* PPS stability limit exceeded */
+    abi_int tai;                  /* TAI offset */
+
+    /* Further padding bytes to allow for future expansion */
+    abi_int:32; abi_int:32; abi_int:32; abi_int:32;
+    abi_int:32; abi_int:32; abi_int:32; abi_int:32;
+    abi_int:32; abi_int:32; abi_int:32;
+};
+
 typedef abi_long target_clock_t;
 
 #define TARGET_HZ 100
-- 
2.26.2


