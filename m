Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AC4C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA052204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA052204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvFS5-0003Du-5B
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 03:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFR9-0001Xy-Dg
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:11 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFR7-00024h-Cx
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:11 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MI4cT-1k7dDy2451-00FFBo; Tue, 14 Jul 2020 09:33:05 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/7] linux-user: refactor ipc syscall and support of semtimedop
 syscall
Date: Tue, 14 Jul 2020 09:32:54 +0200
Message-Id: <20200714073259.1464675-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714073259.1464675-1-laurent@vivier.eu>
References: <20200714073259.1464675-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uQJ81YhjAukFjG6a0Dvb8tSdrCIWf7M9Bg5Wf5qUuBcn/xM+jvI
 R5sLEnTDoMAGTQlVynbCPna+Qy32YjTz5JMpNM02jha32UiS5rSmbKOL4wBWcaFBf3FPU/t
 j6xm0Wyj+YNTaun3+NVjCSoBmSiTnmXSkFzuKuWaaicOszUHwcmI3xoNSAoI+Nia3sogzSX
 Bgc0xt8Ba5B78XTWL1ofA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9eR0s16Qioo=:KaXqzTyng+OHiJVUj88y36
 vlERKUFLJqAOlspWyfpK3ZiEWfR9P522iM5AfE05ht5jBiFhrPHuwgbzzHecn1PEWKlsWwJTg
 i0xtzsedzVHq1sZXR6JaIOM+dpdLSIgJ7ygmedp5OASHfi63iJ8zDPv7LNdry9xD7vXZ1FMCA
 kAGzY/+3q14m62HIMIewmuUtm/DD7QYWMT/VBLF2wEBR8OJrfpNrNwSaG6KW2QTVV2Gz5gz9P
 hLMIDOlN5b66a19ChqLqgZHxxu52qCh8kjK/kMI/aqclT308rp1RhJI144ULmHejdOX8odJSe
 sV3Oq0s+rdwGIkonRiDNy5uC80w7+MOSR3TkhgLFG9Sr0asxuVw9Y4+ERQoMhLsDvkyTD9dT6
 VytMIipG+2oDG6tHCGOhMa/IhkD8O8BoGqGAGKOHp1JkhPuB93b+J54Hi2r2bWXQmVPkzu8iT
 UkYEYB5vF25p/LqSRpbdkPiPCGU95f597MUclArqVMtYfBSw5U3KoOhkWm0KVPmmkQbt4cdVP
 5G8geNc3VaNnCcMvoB0WUlAGyRVcKPE2Fz5nWIpo1I0WBP5r1z47GzSuM/ycfLb3WraExLYuI
 w6MfNgunCEhe81J4c0Fr4sNmj+yMVpTdqtCP+M7K2aWDRk/PQiC9OZS05tZ/wvOdb3xWGaQZu
 bs6qaxU+hNY/yLFVar91cj/fkY1/yZJHoC7f6bouSQ/Iw9QpAfrAzEg81TKt2FzWBhtiEEY82
 7afSEmnSpIERpzBGeTr93bOyChG238G2YBCtxGd3IKt8O/VqSh91eTML3T+74LqQ+vQxWByVp
 SUf5uThs1l94MyveA7B5b3PfUh4uBZ6Ykp5wM5aFtKMwxgFiQCo1/u4od8JFvOXRhPToR5S
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:33:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Matus Kysel <mkysel@tachyum.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Matus Kysel <mkysel@tachyum.com>

Refactoring ipc syscall for s390x and SPARC, so it matches glibc implementation

We should add support of semtimedop syscall as new version of glibc
2.31 uses semop based on semtimedop
(commit: https://gitlab.com/freedesktop-sdk/mirrors/sourceware/glibc/-/commit/765cdd0bffd77960ae852104fc4ea5edcdb8aed3 ).

Signed-off-by: Matus Kysel <mkysel@tachyum.com>
Message-Id: <20200626124612.58593-2-mkysel@tachyum.com>
Message-Id: <20200626124612.58593-3-mkysel@tachyum.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
[lv: merged PATCH 1 & 2 to avoid build break on PATCH 1]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 84 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 77 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e9f53340cd65..1211e759c26c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -817,9 +817,14 @@ safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
               const struct timespec *, req, struct timespec *, rem)
 #endif
 #ifdef __NR_ipc
+#ifdef __s390x__
+safe_syscall5(int, ipc, int, call, long, first, long, second, long, third,
+              void *, ptr)
+#else
 safe_syscall6(int, ipc, int, call, long, first, long, second, long, third,
               void *, ptr, long, fifth)
 #endif
+#endif
 #ifdef __NR_msgsnd
 safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
               int, flags)
@@ -1230,7 +1235,8 @@ static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
     defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6) || \
     defined(TARGET_NR_nanosleep) || defined(TARGET_NR_clock_settime) || \
     defined(TARGET_NR_utimensat) || defined(TARGET_NR_mq_timedsend) || \
-    defined(TARGET_NR_mq_timedreceive)
+    defined(TARGET_NR_mq_timedreceive) || defined(TARGET_NR_ipc) || \
+    defined(TARGET_NR_semop) || defined(TARGET_NR_semtimedop)
 static inline abi_long target_to_host_timespec(struct timespec *host_ts,
                                                abi_ulong target_addr)
 {
@@ -3878,25 +3884,53 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
     return 0;
 }
 
-static inline abi_long do_semop(int semid, abi_long ptr, unsigned nsops)
+#if defined(TARGET_NR_ipc) || defined(TARGET_NR_semop) || \
+    defined(TARGET_NR_semtimedop)
+
+/*
+ * This macro is required to handle the s390 variants, which passes the
+ * arguments in a different order than default.
+ */
+#ifdef __s390x__
+#define SEMTIMEDOP_IPC_ARGS(__nsops, __sops, __timeout) \
+  (__nsops), (__timeout), (__sops)
+#else
+#define SEMTIMEDOP_IPC_ARGS(__nsops, __sops, __timeout) \
+  (__nsops), 0, (__sops), (__timeout)
+#endif
+
+static inline abi_long do_semtimedop(int semid,
+                                     abi_long ptr,
+                                     unsigned nsops,
+                                     abi_long timeout)
 {
     struct sembuf sops[nsops];
+    struct timespec ts, *pts = NULL;
     abi_long ret;
 
+    if (timeout) {
+        pts = &ts;
+        if (target_to_host_timespec(pts, timeout)) {
+            return -TARGET_EFAULT;
+        }
+    }
+
     if (target_to_host_sembuf(sops, ptr, nsops))
         return -TARGET_EFAULT;
 
     ret = -TARGET_ENOSYS;
 #ifdef __NR_semtimedop
-    ret = get_errno(safe_semtimedop(semid, sops, nsops, NULL));
+    ret = get_errno(safe_semtimedop(semid, sops, nsops, pts));
 #endif
 #ifdef __NR_ipc
     if (ret == -TARGET_ENOSYS) {
-        ret = get_errno(safe_ipc(IPCOP_semtimedop, semid, nsops, 0, sops, 0));
+        ret = get_errno(safe_ipc(IPCOP_semtimedop, semid,
+                                 SEMTIMEDOP_IPC_ARGS(nsops, sops, (long)pts)));
     }
 #endif
     return ret;
 }
+#endif
 
 struct target_msqid_ds
 {
@@ -4056,8 +4090,13 @@ static inline abi_long do_msgsnd(int msqid, abi_long msgp,
 #endif
 #ifdef __NR_ipc
     if (ret == -TARGET_ENOSYS) {
+#ifdef __s390x__
+        ret = get_errno(safe_ipc(IPCOP_msgsnd, msqid, msgsz, msgflg,
+                                 host_mb));
+#else
         ret = get_errno(safe_ipc(IPCOP_msgsnd, msqid, msgsz, msgflg,
                                  host_mb, 0));
+#endif
     }
 #endif
     g_free(host_mb);
@@ -4066,6 +4105,20 @@ static inline abi_long do_msgsnd(int msqid, abi_long msgp,
     return ret;
 }
 
+#ifdef __NR_ipc
+#if defined(__sparc__)
+/* SPARC for msgrcv it does not use the kludge on final 2 arguments.  */
+#define MSGRCV_ARGS(__msgp, __msgtyp) __msgp, __msgtyp
+#elif defined(__s390x__)
+/* The s390 sys_ipc variant has only five parameters.  */
+#define MSGRCV_ARGS(__msgp, __msgtyp) \
+    ((long int[]){(long int)__msgp, __msgtyp})
+#else
+#define MSGRCV_ARGS(__msgp, __msgtyp) \
+    ((long int[]){(long int)__msgp, __msgtyp}), 0
+#endif
+#endif
+
 static inline abi_long do_msgrcv(int msqid, abi_long msgp,
                                  ssize_t msgsz, abi_long msgtyp,
                                  int msgflg)
@@ -4094,7 +4147,7 @@ static inline abi_long do_msgrcv(int msqid, abi_long msgp,
 #ifdef __NR_ipc
     if (ret == -TARGET_ENOSYS) {
         ret = get_errno(safe_ipc(IPCOP_CALL(1, IPCOP_msgrcv), msqid, msgsz,
-                        msgflg, host_mb, msgtyp));
+                        msgflg, MSGRCV_ARGS(host_mb, msgtyp)));
     }
 #endif
 
@@ -4372,7 +4425,20 @@ static abi_long do_ipc(CPUArchState *cpu_env,
 
     switch (call) {
     case IPCOP_semop:
-        ret = do_semop(first, ptr, second);
+        ret = do_semtimedop(first, ptr, second, 0);
+        break;
+    case IPCOP_semtimedop:
+    /*
+     * The s390 sys_ipc variant has only five parameters instead of six
+     * (as for default variant) and the only difference is the handling of
+     * SEMTIMEDOP where on s390 the third parameter is used as a pointer
+     * to a struct timespec where the generic variant uses fifth parameter.
+     */
+#if defined(TARGET_S390X)
+        ret = do_semtimedop(first, ptr, second, third);
+#else
+        ret = do_semtimedop(first, ptr, second, fifth);
+#endif
         break;
 
     case IPCOP_semget:
@@ -9684,7 +9750,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_semop
     case TARGET_NR_semop:
-        return do_semop(arg1, arg2, arg3);
+        return do_semtimedop(arg1, arg2, arg3, 0);
+#endif
+#ifdef TARGET_NR_semtimedop
+    case TARGET_NR_semtimedop:
+        return do_semtimedop(arg1, arg2, arg3, arg4);
 #endif
 #ifdef TARGET_NR_semctl
     case TARGET_NR_semctl:
-- 
2.26.2


