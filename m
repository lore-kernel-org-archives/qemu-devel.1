Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFCCC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B8120716
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B8120716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIrhD-00005L-MK
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 06:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jIrg9-0007YF-IB
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jIrg7-00021x-UM
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:30:01 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37325)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jIrg7-000218-L7
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:29:59 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mgvan-1iqy6T0mej-00hNRY; Mon, 30 Mar 2020 12:29:48 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] linux-user: Support futex_time64
Date: Mon, 30 Mar 2020 12:29:45 +0200
Message-Id: <20200330102945.2388294-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330102945.2388294-1-laurent@vivier.eu>
References: <20200330102945.2388294-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UaIG6g2yjCRkS+zUFhgGf0RbzEn1/gGyWCga2Ujeg3tGkIN0tHW
 lCuxLISA1iPU2o5Vpb48+0nffy6qCY/ypYLw9TKPDkGAeIRA8sHKe/sQ9RfGwiBjJG2jl5A
 LdipuNanGP4vBJ4TfLJBEUd9PNQTzosIF3nF3VageB9wQWEVFw1KYCgSZj+eIaHSKH83p9s
 d+BzY0EjM1U1BMcfL4/Tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mdBvq7fXke0=:mH7fyBTfz4HocpLnoxkASR
 JFQwpdrMTrX/LUIUqJ28iYnMQuaR6NWYMy6LMGgX+bFluegC6i0KPJbFKU/7jhjxwMV/Bsrv5
 WlJTy183iTOQhAHfwXv6nZveZtjLaE1L4a8MKT3c96MF1lgMo9blihC+yTd0mUaco42CQtext
 tyF4s7kxUZvCyqFd/ef3WIQtEv+XVCvnJTHvvynK6X+1WagQfve6NDcdWecJ+3e3cbmwTStLD
 ROtbfxuMW023qkOq769iOmfK5cD8rlpDn64NxzPniIJl+A8mAAIgbmhttn0RH54ttM1xmgKlQ
 inZ/m+pa0QpD2Lx+rq1IezDkK+LgBGO7qrjtu/Fe8IlTI9EfkpWxZMy4zFjKshWP8vhWxTJaI
 kpSaZkuM+bxRx7WAVSEdRQCt9KmKCiVP662MFwPBjghKKYpFm/NQb0Mv6MeeSs3TZDis/Bgla
 f45bMetrH1Ny0b1WHtLDugLhNL4iqZOgYAAbAloPDEqGOgArTUF4mgBsK24BL/Z7886nzsdo0
 ujvZpTFQ5WFfkE2bZHNUuXATSeVp9ONn+wsISL2Pqh5GWYxM1Kq08HzG6fDLQWMReeHCC+UIO
 ZMwA21RqdZEncIVH1cKiUz16I8lAYPnLp3m4jGsGrIS2qNIFI5btQirjaT3sCGhLpKOESifyf
 8lPNwKRF0kK/qWmkDIaPalbI1845UbPjxapmxIvR7KECEmOEhJICuoVRaGrnglduLDMzCO0cP
 0QzORlKks+I2K9N+Lcmf0gflF7+ShCHbHNnY6zMxvNo/zIZeY1Yh1waesj55zieo+ZfR0u0Nt
 rUT48qV1fBBuAFV7830pId+eAW99Vu9Mxgkuv0Zcnx7rNCss4NozecFOqPtJ+PJyrMEMAw7
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Add support for host and target futex_time64. If futex_time64 exists on
the host we try that first before falling back to the standard futex
syscall.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <d9390e368a9a1fd32d52aa771815e6e3d40cb1d4.1584571250.git.alistair.francis@wdc.com>
[lv: define sys_futex() if __NR_futex is defined (fix bug on 32bit host),
     remove duplicate get_errno()]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 140 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 126 insertions(+), 14 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 49395dcea978..5af55fca7811 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -245,7 +245,12 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define __NR_sys_rt_sigqueueinfo __NR_rt_sigqueueinfo
 #define __NR_sys_rt_tgsigqueueinfo __NR_rt_tgsigqueueinfo
 #define __NR_sys_syslog __NR_syslog
-#define __NR_sys_futex __NR_futex
+#if defined(__NR_futex)
+# define __NR_sys_futex __NR_futex
+#endif
+#if defined(__NR_futex_time64)
+# define __NR_sys_futex_time64 __NR_futex_time64
+#endif
 #define __NR_sys_inotify_init __NR_inotify_init
 #define __NR_sys_inotify_add_watch __NR_inotify_add_watch
 #define __NR_sys_inotify_rm_watch __NR_inotify_rm_watch
@@ -295,10 +300,14 @@ _syscall1(int,exit_group,int,error_code)
 #if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
 _syscall1(int,set_tid_address,int *,tidptr)
 #endif
-#if (defined(TARGET_NR_futex) || defined(TARGET_NR_exit)) && defined(__NR_futex)
+#if defined(__NR_futex)
 _syscall6(int,sys_futex,int *,uaddr,int,op,int,val,
           const struct timespec *,timeout,int *,uaddr2,int,val3)
 #endif
+#if defined(__NR_futex_time64)
+_syscall6(int,sys_futex_time64,int *,uaddr,int,op,int,val,
+          const struct timespec *,timeout,int *,uaddr2,int,val3)
+#endif
 #define __NR_sys_sched_getaffinity __NR_sched_getaffinity
 _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
           unsigned long *, user_mask_ptr);
@@ -762,10 +771,14 @@ safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
 safe_syscall6(int, epoll_pwait, int, epfd, struct epoll_event *, events,
               int, maxevents, int, timeout, const sigset_t *, sigmask,
               size_t, sigsetsize)
-#ifdef TARGET_NR_futex
+#if defined(__NR_futex)
 safe_syscall6(int,futex,int *,uaddr,int,op,int,val, \
               const struct timespec *,timeout,int *,uaddr2,int,val3)
 #endif
+#if defined(__NR_futex_time64)
+safe_syscall6(int,futex_time64,int *,uaddr,int,op,int,val, \
+              const struct timespec *,timeout,int *,uaddr2,int,val3)
+#endif
 safe_syscall2(int, rt_sigsuspend, sigset_t *, newset, size_t, sigsetsize)
 safe_syscall2(int, kill, pid_t, pid, int, sig)
 safe_syscall2(int, tkill, int, tid, int, sig)
@@ -1229,7 +1242,7 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
 }
 #endif
 
-#if defined(TARGET_NR_clock_settime64)
+#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64)
 static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
                                                  abi_ulong target_addr)
 {
@@ -6916,6 +6929,55 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
 }
 #endif
 
+static int do_sys_futex(int *uaddr, int op, int val,
+                         const struct timespec *timeout, int *uaddr2,
+                         int val3)
+{
+#if HOST_LONG_BITS == 64
+#if defined(__NR_futex)
+    /* always a 64-bit time_t, it doesn't define _time64 version  */
+    return sys_futex(uaddr, op, val, timeout, uaddr2, val3);
+
+#endif
+#else /* HOST_LONG_BITS == 64 */
+#if defined(__NR_futex_time64)
+    if (sizeof(timeout->tv_sec) == 8) {
+        /* _time64 function on 32bit arch */
+        return sys_futex_time64(uaddr, op, val, timeout, uaddr2, val3);
+    }
+#endif
+#if defined(__NR_futex)
+    /* old function on 32bit arch */
+    return sys_futex(uaddr, op, val, timeout, uaddr2, val3);
+#endif
+#endif /* HOST_LONG_BITS == 64 */
+    g_assert_not_reached();
+}
+
+static int do_safe_futex(int *uaddr, int op, int val,
+                         const struct timespec *timeout, int *uaddr2,
+                         int val3)
+{
+#if HOST_LONG_BITS == 64
+#if defined(__NR_futex)
+    /* always a 64-bit time_t, it doesn't define _time64 version  */
+    return get_errno(safe_futex(uaddr, op, val, timeout, uaddr2, val3));
+#endif
+#else /* HOST_LONG_BITS == 64 */
+#if defined(__NR_futex_time64)
+    if (sizeof(timeout->tv_sec) == 8) {
+        /* _time64 function on 32bit arch */
+        return get_errno(safe_futex_time64(uaddr, op, val, timeout, uaddr2,
+                                           val3));
+    }
+#endif
+#if defined(__NR_futex)
+    /* old function on 32bit arch */
+    return get_errno(safe_futex(uaddr, op, val, timeout, uaddr2, val3));
+#endif
+#endif /* HOST_LONG_BITS == 64 */
+    return -TARGET_ENOSYS;
+}
 
 /* ??? Using host futex calls even when target atomic operations
    are not really atomic probably breaks things.  However implementing
@@ -6945,12 +7007,11 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
         } else {
             pts = NULL;
         }
-        return get_errno(safe_futex(g2h(uaddr), op, tswap32(val),
-                         pts, NULL, val3));
+        return do_safe_futex(g2h(uaddr), op, tswap32(val), pts, NULL, val3);
     case FUTEX_WAKE:
-        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+        return do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0);
     case FUTEX_FD:
-        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+        return do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0);
     case FUTEX_REQUEUE:
     case FUTEX_CMP_REQUEUE:
     case FUTEX_WAKE_OP:
@@ -6960,16 +7021,63 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
            to satisfy the compiler.  We do not need to tswap TIMEOUT
            since it's not compared to guest memory.  */
         pts = (struct timespec *)(uintptr_t) timeout;
-        return get_errno(safe_futex(g2h(uaddr), op, val, pts,
-                                    g2h(uaddr2),
-                                    (base_op == FUTEX_CMP_REQUEUE
-                                     ? tswap32(val3)
-                                     : val3)));
+        return do_safe_futex(g2h(uaddr), op, val, pts, g2h(uaddr2),
+                             (base_op == FUTEX_CMP_REQUEUE
+                                      ? tswap32(val3)
+                                      : val3));
     default:
         return -TARGET_ENOSYS;
     }
 }
 #endif
+
+#if defined(TARGET_NR_futex_time64)
+static int do_futex_time64(target_ulong uaddr, int op, int val, target_ulong timeout,
+                           target_ulong uaddr2, int val3)
+{
+    struct timespec ts, *pts;
+    int base_op;
+
+    /* ??? We assume FUTEX_* constants are the same on both host
+       and target.  */
+#ifdef FUTEX_CMD_MASK
+    base_op = op & FUTEX_CMD_MASK;
+#else
+    base_op = op;
+#endif
+    switch (base_op) {
+    case FUTEX_WAIT:
+    case FUTEX_WAIT_BITSET:
+        if (timeout) {
+            pts = &ts;
+            target_to_host_timespec64(pts, timeout);
+        } else {
+            pts = NULL;
+        }
+        return do_safe_futex(g2h(uaddr), op, tswap32(val), pts, NULL, val3);
+    case FUTEX_WAKE:
+        return do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0);
+    case FUTEX_FD:
+        return do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0);
+    case FUTEX_REQUEUE:
+    case FUTEX_CMP_REQUEUE:
+    case FUTEX_WAKE_OP:
+        /* For FUTEX_REQUEUE, FUTEX_CMP_REQUEUE, and FUTEX_WAKE_OP, the
+           TIMEOUT parameter is interpreted as a uint32_t by the kernel.
+           But the prototype takes a `struct timespec *'; insert casts
+           to satisfy the compiler.  We do not need to tswap TIMEOUT
+           since it's not compared to guest memory.  */
+        pts = (struct timespec *)(uintptr_t) timeout;
+        return do_safe_futex(g2h(uaddr), op, val, pts, g2h(uaddr2),
+                             (base_op == FUTEX_CMP_REQUEUE
+                                      ? tswap32(val3)
+                                      : val3));
+    default:
+        return -TARGET_ENOSYS;
+    }
+}
+#endif
+
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
 static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
                                      abi_long handle, abi_long mount_id,
@@ -7541,7 +7649,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ts = cpu->opaque;
             if (ts->child_tidptr) {
                 put_user_u32(0, ts->child_tidptr);
-                sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
+                do_sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
                           NULL, NULL, 0);
             }
             thread_cpu = NULL;
@@ -11635,6 +11743,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_futex:
         return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
 #endif
+#ifdef TARGET_NR_futex_time64
+    case TARGET_NR_futex_time64:
+        return do_futex_time64(arg1, arg2, arg3, arg4, arg5, arg6);
+#endif
 #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
     case TARGET_NR_inotify_init:
         ret = get_errno(sys_inotify_init());
-- 
2.25.1


