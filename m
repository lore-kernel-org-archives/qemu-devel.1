Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50192C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FAB20714
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FAB20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBehP-0002vm-EQ
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBeaF-0004GV-3C
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:23 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBeaC-0007Ij-Om
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:22 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MVJZv-1k4L6y1WnH-00SKCT; Fri, 28 Aug 2020 15:38:11 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 18/18] linux-user: Add support for utimensat_time64() and
 semtimedop_time64()
Date: Fri, 28 Aug 2020 15:37:53 +0200
Message-Id: <20200828133753.2622286-19-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828133753.2622286-1-laurent@vivier.eu>
References: <20200828133753.2622286-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IHYNE50jJVD2+4o2efEd3AX88jGMiT2uZDUMWMHNiDyHYVJrNgi
 0F1d+XliTPSa5kesSpEQmIw6O0yQdjRWcsZBg95r+j9vJoj/hVLiietBx8iHYgjfPCrq4dI
 LePnLdzcpngHIwpDC2RqvATdLpxwsd6AeEKgSJ+x+xzKnXJQEec+kfS7uZ6L34ccHwuDEDO
 3Fhi9Ydo9syTO2MhGGUDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bHjCcwmtcsQ=:7N62bwomPOthgyjT0KxbJf
 KKQPItGVFlnzJ6eK4LbcxJDvZ+JoZ7dNRMoqqqas2w7sW9ItvDx/Vcs8zH47MR7ZXELw8ggLd
 l/DNez6UESD0UM0uSAF/QwIIqgtJUQxWH0BzjUf/AxQwajutkEDZm9nSBZ1zavwvDiKDOKBeO
 YySgimZkOYJKBc+boQNo6BC78qQfnclF2XCMTJwi4bMxZz0BTcl8covcEioaVBO9+YM340cGP
 hQ2RxJNN0bZ46eWqEG8rWCUmfcIESiJoBPW3QIg29zS+gsCQD7YTxxVee7JIK+twE92GW86K8
 Gw6WPOhOyQciLDUyv0OJgI2dZaxJ4N0hDyXsJA/ZOCbIEPa+RZ1Dd8zRcxS3//3nWiJTmaH0a
 sKjXMfrxCPGp/LeqIdGZCf5ZoMYE1XeNKmCr9K34KHJCUKujB8/61V2j7oTdV7giiJmqT2gDP
 fNN4XxZfQrhMVuQjnEDaI3j6USlaa627y96eFQje0cepFFlXhlQOhQIXMF/tB+piGUu4zTjHL
 D4Qt5hG1z1Dlu1pM4WT+SLqQi0EXKn/fgwJAryOsWjfsgQKItC5KLmCJ5Noh55urt1fU0HN0q
 +BTEtTiV60cjPOrBfNwvyFWmxiq4SeyyG3jQbaEi44pmrpbIvol+2AmeTO8WAq7tBzcSkGxrY
 RFc4VbAsJV9be7FT5YNs4/XxCZPnC4y76VFwU1h+MCDsvJdMmeEhmk8hLR0VFTw9bdJOelHZs
 kDWErXo1hudKcqvelLlOZ9IBXvGFxfjTkn2NttBr5GKr+egNA0mIZ1NndnRK/q9WPr+DQM0Ra
 fNSgE+kRT4Wo3IymuG/1fDslUqFpQcyTQQ5On3pYxurCYY+9wpZ0acynoAfvGmxzVBiXOfo
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 09:38:06
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

This patch introduces functionality for following time64 syscalls:

*utimensat_time64()

    int utimensat(int dirfd, const char *pathname,
                  const struct timespec times[2], int flags);
    -- change file timestamps with nanosecond precision --
    man page: https://man7.org/linux/man-pages/man2/utimensat.2.html

*semtimedop_time64()

    int semtimedop(int semid, struct sembuf *sops, size_t nsops,
                   const struct timespec *timeout);
    -- System V semaphore operations --
    man page: https://www.man7.org/linux/man-pages/man2/semtimedop.2.html

Implementation notes:

   Syscall 'utimensat_time64()' is implemented in similar way as its
   regular variants only difference being that time64 converting function
   is used to convert values of 'struct timespec' between host and target
   ('target_to_host_timespec64()').

   For syscall 'semtimedop_time64()' and additional argument is added
   in function 'do_semtimedop()' through which the aproppriate 'struct timespec'
   converting function is called (false for regular target_to_host_timespec()
   and true for target_to_host_timespec64()). For 'do_ipc()' a
   check was added as that additional argument: 'TARGET_ABI_BITS == 64'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200824223050.92032-3-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 64 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 188363f72e74..d14d849a720c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -391,7 +391,7 @@ static bitmask_transtbl fcntl_flags_tbl[] = {
 
 _syscall2(int, sys_getcwd1, char *, buf, size_t, size)
 
-#ifdef TARGET_NR_utimensat
+#if defined(TARGET_NR_utimensat) || defined(TARGET_NR_utimensat_time64)
 #if defined(__NR_utimensat)
 #define __NR_sys_utimensat __NR_utimensat
 _syscall4(int,sys_utimensat,int,dirfd,const char *,pathname,
@@ -1244,7 +1244,10 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
     defined(TARGET_NR_mq_timedreceive_time64) || \
     (defined(TARGET_NR_timerfd_settime64) && defined(CONFIG_TIMERFD)) || \
     defined(TARGET_NR_clock_nanosleep_time64) || \
-    defined(TARGET_NR_rt_sigtimedwait_time64)
+    defined(TARGET_NR_rt_sigtimedwait_time64) || \
+    defined(TARGET_NR_utimensat) || \
+    defined(TARGET_NR_utimensat_time64) || \
+    defined(TARGET_NR_semtimedop_time64)
 static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
                                                  abi_ulong target_addr)
 {
@@ -3879,7 +3882,7 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
 }
 
 #if defined(TARGET_NR_ipc) || defined(TARGET_NR_semop) || \
-    defined(TARGET_NR_semtimedop)
+    defined(TARGET_NR_semtimedop) || defined(TARGET_NR_semtimedop_time64)
 
 /*
  * This macro is required to handle the s390 variants, which passes the
@@ -3896,7 +3899,7 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
 static inline abi_long do_semtimedop(int semid,
                                      abi_long ptr,
                                      unsigned nsops,
-                                     abi_long timeout)
+                                     abi_long timeout, bool time64)
 {
     struct sembuf *sops;
     struct timespec ts, *pts = NULL;
@@ -3904,8 +3907,14 @@ static inline abi_long do_semtimedop(int semid,
 
     if (timeout) {
         pts = &ts;
-        if (target_to_host_timespec(pts, timeout)) {
-            return -TARGET_EFAULT;
+        if (time64) {
+            if (target_to_host_timespec64(pts, timeout)) {
+                return -TARGET_EFAULT;
+            }
+        } else {
+            if (target_to_host_timespec(pts, timeout)) {
+                return -TARGET_EFAULT;
+            }
         }
     }
 
@@ -4428,7 +4437,7 @@ static abi_long do_ipc(CPUArchState *cpu_env,
 
     switch (call) {
     case IPCOP_semop:
-        ret = do_semtimedop(first, ptr, second, 0);
+        ret = do_semtimedop(first, ptr, second, 0, false);
         break;
     case IPCOP_semtimedop:
     /*
@@ -4438,9 +4447,9 @@ static abi_long do_ipc(CPUArchState *cpu_env,
      * to a struct timespec where the generic variant uses fifth parameter.
      */
 #if defined(TARGET_S390X)
-        ret = do_semtimedop(first, ptr, second, third);
+        ret = do_semtimedop(first, ptr, second, third, TARGET_ABI_BITS == 64);
 #else
-        ret = do_semtimedop(first, ptr, second, fifth);
+        ret = do_semtimedop(first, ptr, second, fifth, TARGET_ABI_BITS == 64);
 #endif
         break;
 
@@ -9949,11 +9958,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_semop
     case TARGET_NR_semop:
-        return do_semtimedop(arg1, arg2, arg3, 0);
+        return do_semtimedop(arg1, arg2, arg3, 0, false);
 #endif
 #ifdef TARGET_NR_semtimedop
     case TARGET_NR_semtimedop:
-        return do_semtimedop(arg1, arg2, arg3, arg4);
+        return do_semtimedop(arg1, arg2, arg3, arg4, false);
+#endif
+#ifdef TARGET_NR_semtimedop_time64
+    case TARGET_NR_semtimedop_time64:
+        return do_semtimedop(arg1, arg2, arg3, arg4, true);
 #endif
 #ifdef TARGET_NR_semctl
     case TARGET_NR_semctl:
@@ -12160,6 +12173,35 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
+#ifdef TARGET_NR_utimensat_time64
+    case TARGET_NR_utimensat_time64:
+        {
+            struct timespec *tsp, ts[2];
+            if (!arg3) {
+                tsp = NULL;
+            } else {
+                if (target_to_host_timespec64(ts, arg3)) {
+                    return -TARGET_EFAULT;
+                }
+                if (target_to_host_timespec64(ts + 1, arg3 +
+                                     sizeof(struct target__kernel_timespec))) {
+                    return -TARGET_EFAULT;
+                }
+                tsp = ts;
+            }
+            if (!arg2)
+                ret = get_errno(sys_utimensat(arg1, NULL, tsp, arg4));
+            else {
+                p = lock_user_string(arg2);
+                if (!p) {
+                    return -TARGET_EFAULT;
+                }
+                ret = get_errno(sys_utimensat(arg1, path(p), tsp, arg4));
+                unlock_user(p, arg2, 0);
+            }
+        }
+        return ret;
+#endif
 #ifdef TARGET_NR_futex
     case TARGET_NR_futex:
         return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
-- 
2.26.2


