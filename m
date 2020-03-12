Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE97C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671AB206CD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bBndJ6Ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671AB206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCWDq-0000nu-JH
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 18:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=33364f698=alistair.francis@wdc.com>)
 id 1jCWCj-0006ni-Q8
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=33364f698=alistair.francis@wdc.com>)
 id 1jCWCi-00073h-5V
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:21:25 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:20412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=33364f698=alistair.francis@wdc.com>)
 id 1jCWCh-00070r-Qn; Thu, 12 Mar 2020 18:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584051741; x=1615587741;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Wuj7w3hMadEVKit9116wRvZuP7tvU5gp7OeKHl4O7I8=;
 b=bBndJ6EpRny3D7Dv2TfZ8A2EGDOHCv6lDVJbQvoIjv8Jg0bJL0oZIhsM
 1M/9HRYvsTA3RBbBUkJODTe9yUS7ZGuq58vA3jr54IEYQZl4EE0ZPFQIz
 RGcjqwfwCGiLAddoySTPiOm6U4gdA8belrQZJDgWCZdO6cev/occkxEVH
 1F2sKNHI6Zndcb3l8c9wzAl+op0Gh1Nstplw/7ThR/kyyZDlAtllaHATH
 ndzuEuP7c5jwJ02HUWJJTbs3YMaAtZiPmBzvb6W84k1riEkr+ylBYmq1o
 l/2GnBi8PiIM28WwkKVjkxbIvIVw4piSIPgK19ETJ6XsT8j6E9NXRQAW6 w==;
IronPort-SDR: xBfgnR7jl9zX5RIMyLxNJknuENrYdpgBhVcjJumXtV49zuvBE8QdMhEDGlw0sh0WInBky2RVuU
 opVaFmO5zhf88VnNMMQdEIsCFVTJFdsccJ30NbU4hbfqgzWEHAj6r7GxHebSjicCfjPgubor6M
 R8RTerlIK9unoluZwYTHGbpV03LAdlKpyypo8bjBDBaNr08XytQZA61aAH93q4gQ81ZhJ8CfoA
 ApLlLu9+L3TDTO1sRelrrzmty9PrBQMrVVyI5AKc7jhcTOENRXdnBYtInGuUojnDj0m3AFxeZv
 hrM=
X-IronPort-AV: E=Sophos;i="5.70,546,1574092800"; d="scan'208";a="234384939"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2020 06:22:18 +0800
IronPort-SDR: QNnhKLABtj7asXwOllb4NgDb/y8uTa55nirPj+LxKJM6rOvMkfws29InoXzyFOanFWE6lu9v1h
 XC+qSL1uiDEiWV3t6+M8I7zgNajSotcwiMrK3AtjQYDongJJ8LsBwbszos0N5/NuwApxu+2Cge
 I37EVl9THGYrFpprqSiywkgfrNY8YJQhiKrGdWICZ7pW7unmiOpNChfnRST5K3j7/qQpH8Nye9
 RP10+1p5S/GBtZWovRpM4pLWKQ6rahpbvo7PIdzeWyK4Sn25wNaM5BqGKWjjy+faXx2OmGvDCN
 pRa6yCKEg5v4gxiK6G/4LBhE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 15:13:21 -0700
IronPort-SDR: 0X8+zeumkXVoj0Ui1RNi1CiiSSoLd5plP9Srq/0kALxGpGB38Qpr1JBFwf0AZOGSN2A/newRrV
 5YuyDBuwrxnzQVjH9uqbOo/b5Aj8SkZuzxtUdxX/5uo93AP3n07K04H4/SYJ2jbcWp/LVv2h+Z
 UjTaRhk+RMnW4AuRtstT0DEJOmbNjFR+I5KKWSbWmUJimywm8RF4EwG60XzvZHFNHsfwo265lU
 UQvjBvHGjuiyISZsNPw7h1NXpIgfifk1xaw+T855wT4oPYsfleDz+eGUzN/J3Ib1Gm8tUWBqz5
 smM=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Mar 2020 15:21:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Subject: [PATCH v7 3/4] linux-user: Support futex_time64
Date: Thu, 12 Mar 2020 15:13:56 -0700
Message-Id: <ce73e32d4b399581b25d2323fad1d817d66dd11f.1584051142.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584051142.git.alistair.francis@wdc.com>
References: <cover.1584051142.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for host and target futex_time64. If futex_time64 exists on
the host we try that first before falling back to the standard futux
syscall.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/syscall.c | 144 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 131 insertions(+), 13 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 60fd775d9c..9ae7a05e38 100644
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
@@ -295,10 +300,16 @@ _syscall1(int,exit_group,int,error_code)
 #if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
 _syscall1(int,set_tid_address,int *,tidptr)
 #endif
-#if defined(TARGET_NR_futex) && defined(__NR_futex)
+#if (defined(TARGET_NR_futex) && defined(__NR_futex)) || \
+    (defined(TARGET_NR_futex_time64) && \
+        (HOST_LONG_BITS == 64 && defined(__NR_futex)))
 _syscall6(int,sys_futex,int *,uaddr,int,op,int,val,
           const struct timespec *,timeout,int *,uaddr2,int,val3)
 #endif
+#if (defined(TARGET_NR_futex_time64) && defined(__NR_futex_teim64))
+_syscall6(int,sys_futex_time64,int *,uaddr,int,op,int,val,
+          const struct timespec *,timeout,int *,uaddr2,int,val3)
+#endif
 #define __NR_sys_sched_getaffinity __NR_sched_getaffinity
 _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
           unsigned long *, user_mask_ptr);
@@ -762,10 +773,14 @@ safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
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
@@ -1229,7 +1244,7 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
 }
 #endif
 
-#if defined(TARGET_NR_clock_settime64)
+#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64)
 static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
                                                  abi_ulong target_addr)
 {
@@ -6890,6 +6905,55 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
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
+    return -TARGET_ENOSYS;
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
@@ -6919,12 +6983,61 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
         } else {
             pts = NULL;
         }
-        return get_errno(safe_futex(g2h(uaddr), op, tswap32(val),
+        return get_errno(do_safe_futex(g2h(uaddr), op, tswap32(val),
+                         pts, NULL, val3));
+    case FUTEX_WAKE:
+        return get_errno(do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+    case FUTEX_FD:
+        return get_errno(do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+    case FUTEX_REQUEUE:
+    case FUTEX_CMP_REQUEUE:
+    case FUTEX_WAKE_OP:
+        /* For FUTEX_REQUEUE, FUTEX_CMP_REQUEUE, and FUTEX_WAKE_OP, the
+           TIMEOUT parameter is interpreted as a uint32_t by the kernel.
+           But the prototype takes a `struct timespec *'; insert casts
+           to satisfy the compiler.  We do not need to tswap TIMEOUT
+           since it's not compared to guest memory.  */
+        pts = (struct timespec *)(uintptr_t) timeout;
+        return get_errno(do_safe_futex(g2h(uaddr), op, val, pts,
+                                       g2h(uaddr2),
+                                       (base_op == FUTEX_CMP_REQUEUE
+                                        ? tswap32(val3)
+                                        : val3)));
+    default:
+        return -TARGET_ENOSYS;
+    }
+}
+#endif
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
+        return get_errno(do_safe_futex(g2h(uaddr), op, tswap32(val),
                          pts, NULL, val3));
     case FUTEX_WAKE:
-        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+        return get_errno(do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
     case FUTEX_FD:
-        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
+        return get_errno(do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
     case FUTEX_REQUEUE:
     case FUTEX_CMP_REQUEUE:
     case FUTEX_WAKE_OP:
@@ -6934,16 +7047,17 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
            to satisfy the compiler.  We do not need to tswap TIMEOUT
            since it's not compared to guest memory.  */
         pts = (struct timespec *)(uintptr_t) timeout;
-        return get_errno(safe_futex(g2h(uaddr), op, val, pts,
-                                    g2h(uaddr2),
-                                    (base_op == FUTEX_CMP_REQUEUE
-                                     ? tswap32(val3)
-                                     : val3)));
+        return get_errno(do_safe_futex(g2h(uaddr), op, val, pts,
+                                       g2h(uaddr2),
+                                       (base_op == FUTEX_CMP_REQUEUE
+                                        ? tswap32(val3)
+                                        : val3)));
     default:
         return -TARGET_ENOSYS;
     }
 }
 #endif
+
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
 static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
                                      abi_long handle, abi_long mount_id,
@@ -7505,7 +7619,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ts = cpu->opaque;
             if (ts->child_tidptr) {
                 put_user_u32(0, ts->child_tidptr);
-                sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
+                do_sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
                           NULL, NULL, 0);
             }
             thread_cpu = NULL;
@@ -11597,6 +11711,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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


