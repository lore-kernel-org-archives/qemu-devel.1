Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886ACC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6627920663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6627920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39613 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6vZ-0005D5-JR
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50005)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hg6mo-00061D-VZ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hg6mn-0001Vs-2e
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:26 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:47701)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hg6ml-0001R0-Ef
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:24 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M3UhQ-1hfYoL3bZC-000YeE; Wed, 26 Jun 2019 14:11:48 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 14:11:35 +0200
Message-Id: <20190626121139.19114-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626121139.19114-1-laurent@vivier.eu>
References: <20190626121139.19114-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FOwiOG93lZxN3jZq8PqE1FTpHQMpEYZGlvzo+TTxjuB6C3iXL3S
 Ole3VcfL9p6XjEndwziC8GoQsbZPaI95U3Mvv4MVrKH8oFoj04mEfcq1xYjtFWTqpAsuRrH
 2ZItz5FMh0Z+ZLkJlqOmyNva/FuMvaCUE9uAXBZC2WXqk+qDAI/m0TIz4pHnk+pbptl+t4Z
 KTIz++fIZhLXm3GeFgtow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YhjZtYQ93Zg=:gRqpnlKAfjKsGei51/+KjF
 YWfjf+gndprJb7N2S8smsYOII4VHa7o6mNSTOGn3WsRGxuvzm3t+INmUsLy0K0bTAPb+3AN37
 A/+oqPrk5MmbQjdGGORGbJKdgnIQykAw1r0Oq8BCxsqYwM1BL4HvAxeW1oDd5PNVz2W1uHG6M
 jCfcyTiVPTbjERe67mx6ds02JS+O7xCO38DdJf1X/+rtEaSFHtUEf+cSVIgCYehBHqo/Ud02g
 wsuO42WlVPjPdZX015WlQfN0Dxg4VFtQxjSYZvwZXM3iMkD3BYe7t6gXFPPhI5sllV6kJTA5j
 N46+ZIFXVUemIR4fJPc0c1hGP7/lnc+gFOY4CEfmjIpyeYxCgjuWUluiU4O/nzo5wZnFCmpdw
 B2h2CXsgx1g2nv+VA/++3lFkgXGiq2EjQ+sRITedKoqzsD36TZCKw6/KxgFXCv8mJMSEmL9V4
 42kVNCoT4ebCm8urz+prsVQXTUWCszmSCZGRXjNfiTCYzH9027UtY24ajk9r3Fx369/I/BiEn
 azP/eF+cukT8PnYGaXr5/tClvJwu4eTfkR1pg9vdGOKuDM8IhhSxVaq+ZN7rVu5UYr9Mm0MeV
 qltnBJs6b+BwKkjzgZSo44vYyeebT6MKusYDJu35s1TRayHH664K39eqLNN7hlxh0ofgMxTXE
 joMTYXVfepicAAdNio9B4Em5LKmdc2BkiaYNlBsZE39mLH2h1flM0+xOp1DkDpzFcppA/4O4D
 pqDVmHlhWWPoFM/bOJdasTcAuBrZs6XN+XKZyA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 2/6] linux-user: emulate msgsnd(),
 msgrcv() and semtimedop()
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
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we have updated kernel headers to 5.2-rc1 we have introduced
new syscall numbers that can be not supported by older kernels
and fail with ENOSYS while the guest emulation succeeded before
because the syscalls were emulated with ipc().

This patch fixes the problem by using ipc() if the new syscall
returns ENOSYS.

Fixes: 86e636951ddc ("linux-user: fix __NR_semtimedop undeclared error")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190529084804.25950-1-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c      | 61 +++++++++++++++++++--------------------
 linux-user/syscall_defs.h |  1 +
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b187c1281dce..e942049cb0da 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -762,50 +762,21 @@ safe_syscall2(int, nanosleep, const struct timespec *, req,
 safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
               const struct timespec *, req, struct timespec *, rem)
 #endif
-#if !defined(__NR_msgsnd) || !defined(__NR_msgrcv) || !defined(__NR_semtimedop)
-/* This host kernel architecture uses a single ipc syscall; fake up
- * wrappers for the sub-operations to hide this implementation detail.
- * Annoyingly we can't include linux/ipc.h to get the constant definitions
- * for the call parameter because some structs in there conflict with the
- * sys/ipc.h ones. So we just define them here, and rely on them being
- * the same for all host architectures.
- */
-#define Q_SEMTIMEDOP 4
-#define Q_MSGSND 11
-#define Q_MSGRCV 12
-#define Q_IPCCALL(VERSION, OP) ((VERSION) << 16 | (OP))
-
+#ifdef __NR_ipc
 safe_syscall6(int, ipc, int, call, long, first, long, second, long, third,
               void *, ptr, long, fifth)
 #endif
 #ifdef __NR_msgsnd
 safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
               int, flags)
-#else
-static int safe_msgsnd(int msgid, const void *msgp, size_t sz, int flags)
-{
-    return safe_ipc(Q_IPCCALL(0, Q_MSGSND), msgid, sz, flags, (void *)msgp, 0);
-}
 #endif
 #ifdef __NR_msgrcv
 safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
               long, msgtype, int, flags)
-#else
-static int safe_msgrcv(int msgid, void *msgp, size_t sz, long type, int flags)
-{
-    return safe_ipc(Q_IPCCALL(1, Q_MSGRCV), msgid, sz, flags, msgp, type);
-}
 #endif
 #ifdef __NR_semtimedop
 safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
               unsigned, nsops, const struct timespec *, timeout)
-#else
-static int safe_semtimedop(int semid, struct sembuf *tsops, unsigned nsops,
-                           const struct timespec *timeout)
-{
-    return safe_ipc(Q_IPCCALL(0, Q_SEMTIMEDOP), semid, nsops, 0, tsops,
-                    (long)timeout);
-}
 #endif
 #if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
 safe_syscall5(int, mq_timedsend, int, mqdes, const char *, msg_ptr,
@@ -3529,11 +3500,21 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
 static inline abi_long do_semop(int semid, abi_long ptr, unsigned nsops)
 {
     struct sembuf sops[nsops];
+    abi_long ret;
 
     if (target_to_host_sembuf(sops, ptr, nsops))
         return -TARGET_EFAULT;
 
-    return get_errno(safe_semtimedop(semid, sops, nsops, NULL));
+    ret = -TARGET_ENOSYS;
+#ifdef __NR_semtimedop
+    ret = get_errno(safe_semtimedop(semid, sops, nsops, NULL));
+#endif
+#ifdef __NR_ipc
+    if (ret == -TARGET_ENOSYS) {
+        ret = get_errno(safe_ipc(IPCOP_semtimedop, semid, nsops, 0, sops, 0));
+    }
+#endif
+    return ret;
 }
 
 struct target_msqid_ds
@@ -3688,7 +3669,16 @@ static inline abi_long do_msgsnd(int msqid, abi_long msgp,
     }
     host_mb->mtype = (abi_long) tswapal(target_mb->mtype);
     memcpy(host_mb->mtext, target_mb->mtext, msgsz);
+    ret = -TARGET_ENOSYS;
+#ifdef __NR_msgsnd
     ret = get_errno(safe_msgsnd(msqid, host_mb, msgsz, msgflg));
+#endif
+#ifdef __NR_ipc
+    if (ret == -TARGET_ENOSYS) {
+        ret = get_errno(safe_ipc(IPCOP_msgsnd, msqid, msgsz, msgflg,
+                                 host_mb, 0));
+    }
+#endif
     g_free(host_mb);
     unlock_user_struct(target_mb, msgp, 0);
 
@@ -3716,7 +3706,16 @@ static inline abi_long do_msgrcv(int msqid, abi_long msgp,
         ret = -TARGET_ENOMEM;
         goto end;
     }
+    ret = -TARGET_ENOSYS;
+#ifdef __NR_msgrcv
     ret = get_errno(safe_msgrcv(msqid, host_mb, msgsz, msgtyp, msgflg));
+#endif
+#ifdef __NR_ipc
+    if (ret == -TARGET_ENOSYS) {
+        ret = get_errno(safe_ipc(IPCOP_CALL(1, IPCOP_msgrcv), msqid, msgsz,
+                        msgflg, host_mb, msgtyp));
+    }
+#endif
 
     if (ret > 0) {
         abi_ulong target_mtext_addr = msgp + sizeof(abi_ulong);
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 7f141f699c1a..3175440e9dd9 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -32,6 +32,7 @@
 #define TARGET_SYS_RECVMMSG     19        /* recvmmsg()            */
 #define TARGET_SYS_SENDMMSG     20        /* sendmmsg()            */
 
+#define IPCOP_CALL(VERSION, OP) ((VERSION) << 16 | (OP))
 #define IPCOP_semop		1
 #define IPCOP_semget		2
 #define IPCOP_semctl		3
-- 
2.21.0


