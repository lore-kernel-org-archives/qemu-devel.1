Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CB1C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F46820883
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F46820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41946 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hViCr-0004Uo-43
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:56:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hViBN-0003YF-Ir
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hViBL-0004Wa-LN
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:54:49 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:44721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hViBK-0004VQ-2J
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:54:46 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1Mk0FS-1glQ482nvc-00kSkU; Tue, 28 May 2019 21:54:00 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 28 May 2019 21:53:55 +0200
Message-Id: <20190528195355.26793-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o4SQOWi1b9RQsrIyZR6AdvxgmHubJpH3XxmRESv7XtCHRHTosGu
	9nRs3g3bJKoBOIh6wEeysf+cvh0xCVwCwcy/KqkqtfK4yIXOTy5pSmzz2rOGxQ9/jgCk2iO
	sQbMT3zVKhYp4COuzxiz7CXpa4aJPinrPzAuiu8aL+79EhuMIPoDwC9buqc/nm4znX+7dlo
	DbZXOrNIpmGUnEYYOFMKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eZG5FjUu64I=:Efqak5Ye9w763o/pJIBpio
	SQ1jENpjKC/8LnGKOIjHxydkxRutXWi2PzTimeIgK2a+PPGZgfaRlCYbU/qpvj7BgKKgqs+Mv
	ZSoch90IYKbwYWm9vKZhwc6f4HgYgavzvEjw2388wwrSOYSecXY6j4gWVHM2X034FaZj3zU2s
	x5LC4KMjaPecsU1P0LT4NrdFTfl9BPo2R9hG1tEc2bGwWAS0QGNE7o/dnASO8IB7IDPI6nIuC
	bOH+Svby6Ia6NEGHZ/KL3PKLgElG/ziFP7U2n5n5CbyWBUtmvtQfcdaWxF7lXJLooKqfclHtD
	YkcXTHUJR4vQn/3KC9TwVCqhUEbE4QGzBknvxhSKPnIrtz0dzAujjshySInalbUnn2QciW4+s
	bQNhseEE9raTex/jL550yjs9IL8kNTSUQFaDm2EmPMFBC2jxXif+PxPMoUw//5IYcx7QknkRt
	LupiZrIVVyLple8Fqbc5TwDaUKcwMjndHja8Lfp8gT9P9ELBwvhHNY1yUYqhANWDMmx3vpcvH
	KKLwVxdTQQpOm+jNhFAoL7AS0qefyBFuKOqBn8BXmizNlZfLplpQ/r/VfS/a2Nllj7WxFJTGe
	4/HaYBiPbSm49G9uhZacpOOk2u7n0TJQeR/qPd2IxsjkxdaVtN7FT5dML9C7DqO5nQKLmeyzv
	9n/YP4TS7mCq+1vrSaiKQgb/Jgc3IZ6dUZGd9UlXb2XEgXm4oWPv/HnSVweSDZBk1xw/4RDBI
	fQ4svwsQYEyn385NHBITwsi1R6XnaZkPIQDVuw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PATCH] linux-user: emulate msgsnd(),
 msgrcv() and semtimedop()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
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
---
 linux-user/syscall.c      | 61 +++++++++++++++++++--------------------
 linux-user/syscall_defs.h |  1 +
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5e29e675e9cf..bbd185bbff74 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -763,50 +763,21 @@ safe_syscall2(int, nanosleep, const struct timespec *, req,
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
@@ -3530,11 +3501,21 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
 static inline abi_long do_semop(int semid, abi_long ptr, unsigned nsops)
 {
     struct sembuf sops[nsops];
+    abi_long ret;
 
     if (target_to_host_sembuf(sops, ptr, nsops))
         return -TARGET_EFAULT;
 
-    return get_errno(safe_semtimedop(semid, sops, nsops, NULL));
+    ret = -ENOSYS;
+#ifdef __NR_semtimedop
+    ret = get_errno(safe_semtimedop(semid, sops, nsops, NULL));
+#endif
+#ifdef __NR_ipc
+    if (ret == -ENOSYS) {
+        ret = get_errno(safe_ipc(IPCOP_semtimedop, semid, nsops, 0, sops, 0));
+    }
+#endif
+    return ret;
 }
 
 struct target_msqid_ds
@@ -3689,7 +3670,16 @@ static inline abi_long do_msgsnd(int msqid, abi_long msgp,
     }
     host_mb->mtype = (abi_long) tswapal(target_mb->mtype);
     memcpy(host_mb->mtext, target_mb->mtext, msgsz);
+    ret = -ENOSYS;
+#ifdef __NR_msgsnd
     ret = get_errno(safe_msgsnd(msqid, host_mb, msgsz, msgflg));
+#endif
+#ifdef __NR_ipc
+    if (ret == -ENOSYS) {
+        ret = get_errno(safe_ipc(IPCOP_msgsnd, msqid, msgsz, msgflg,
+                                 host_mb, 0));
+    }
+#endif
     g_free(host_mb);
     unlock_user_struct(target_mb, msgp, 0);
 
@@ -3717,7 +3707,16 @@ static inline abi_long do_msgrcv(int msqid, abi_long msgp,
         ret = -TARGET_ENOMEM;
         goto end;
     }
+    ret = -ENOSYS;
+#ifdef __NR_msgrcv
     ret = get_errno(safe_msgrcv(msqid, host_mb, msgsz, msgtyp, msgflg));
+#endif
+#ifdef __NR_ipc
+    if (ret == -ENOSYS) {
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
2.20.1


