Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AE5C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34D820714
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34D820714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBehr-0003oi-VU
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBea7-0003wk-RX
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:15 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:53833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBea3-0007Gb-4Z
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:15 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MSqbe-1k2PBR1iNq-00UG8y; Fri, 28 Aug 2020 15:37:59 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/18] linux-user: Add strace support for printing arguments of
 truncate()/ftruncate() and getsid()
Date: Fri, 28 Aug 2020 15:37:40 +0200
Message-Id: <20200828133753.2622286-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828133753.2622286-1-laurent@vivier.eu>
References: <20200828133753.2622286-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XoUGNhqitSlAnIumASTrVsKcrEFe2ULZcSgk+ubu6U2eaxkkehC
 4zU/o0WmVVIZmwUGLNnu9xx71mIFQ5XVHhzXqax3oMLzPAyB8yYwpfRwra/pcaePJlylsGw
 SNw3DeHc6fmfdmamUlWB1bLwu+YABHsTVFOOSbLoMBiDidBKnZS+X8vSr16kNZ/FKYj9Zd1
 57OM1ZxWUSpxsJn03j0dA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nD8pNaNgyKU=:Zv4RUjPEfJGTdZXbZFtLKy
 Geh0aP0S249zwDyZJm04c9KdGftsT/HrCTwHFOvn7G184JGuKKPyxwncU9i97wEgylJOIrlrj
 lhfY+NzeFZpXRbO1Yt3kMpYYOUEHdlwiTDacb7nqSkbJepKbUOcUsX8YkD8YDt1y18ZOSIwst
 MNFLZCVoyo+BAoIGAAqPu2ErmkDch3UVwIYTcsqW7T4eYhpcnYeYjDB6saO8oVEMlg7xVdsAO
 R/+3oCuLfamdb134gSzuSc2YGEnSCijapM8V7ZkxO/oAanftDetbxO7ebSbqtvvSO+ElGye3+
 2xAvCWSuVe36iIe+/O8aXHlhE6RMC+Ne1A0P8l6u+VbEHw4sZ3fa30HS3S+e44U76QrELySV9
 c3ruSxe4ycnMTccjlCmxHwaxr/yGMTOfYPplgynKGqUSabPWZsOesrFFaQ9QoS1txqsJwmKw1
 73vmYGQQT+8veqVnC8oZ/zHk6V8GtV+7mDk/vI3898eU1eaHDLOfpYTxWN2HSVj3m1TEhY272
 DMCK4okoEhZWU9AkKrD2UqvpQL6oee61ZYAtdM6WO3vhGBr+9oFwJfpTvHbw/6Rv3jexWhc2v
 itDzt+cFf+6l8KddmBRhlIT7thiQ9g8zIK5zKsY1n0CAakkUxtIX9GOsfue4M2lkZOCJqVBSe
 7xmL5oXSdmPLLHDCkNmFAX8ePQ2w5n7ah8UR+MDssrVWNw3SYNzhQNYRXCvUrgJI+omdeQYFQ
 fC/LNZtTlvJi5WiA7dfkJc9pZ3Oa6PqIyDgM6mWdCqc+cHfivr8LwlB2a532d9y3iA8a9mnS5
 3YqmXGyg+riYwNyD5g+c8m92nsqlcXILd8qGZOcu5b++zXU/+38vFX/BVG8mXWvbENOGVMW
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

This patch implements strace argument printing functionality for following syscalls:

    * truncate, ftruncate - truncate a file to a specified length

        int truncate/truncate64(const char *path, off_t length)
        int ftruncate/ftruncate64(int fd, off_t length)
        man page: https://man7.org/linux/man-pages/man2/truncate.2.html

    * getsid - get session ID

        pid_t getsid(pid_t pid)
        man page: https://man7.org/linux/man-pages/man2/getsid.2.html

Implementation notes:

    Syscalls truncate/truncate64 take string argument types and thus a
    separate print function "print_truncate/print_truncate64" is stated in
    file "strace.list". This function is defined and implemented in "strace.c"
    by using an existing function used to print string arguments: "print_string()".
    For syscall ftruncate64, a separate printing function was also stated in
    "strace.c" as it requires a special kind of handling.
    The other syscalls have only primitive argument types, so the rest of the
    implementation was handled by stating an appropriate printing format in file
    "strace.list".
    Function "regpairs_aligned()" was cut & pasted from "syscall.c" to "qemu.h"
    as it is used by functions "print_truncate64()" and "print_ftruncate64()"
    to print the offset arguments of "truncate64()" and "ftruncate64()".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200811164553.27713-3-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/qemu.h      | 35 +++++++++++++++++++++++++++++++
 linux-user/strace.c    | 47 ++++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list | 10 ++++-----
 linux-user/syscall.c   | 32 ----------------------------
 4 files changed, 87 insertions(+), 37 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 63ddfe86fd8b..f431805e573f 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -706,6 +706,41 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
 }
 #endif /* TARGET_ABI_BITS != 32 */
 
+
+/* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
+#ifdef TARGET_ARM
+static inline int regpairs_aligned(void *cpu_env, int num)
+{
+    return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
+}
+#elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+#elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
+/*
+ * SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
+ * of registers which translates to the same as ARM/MIPS, because we start with
+ * r3 as arg1
+ */
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+#elif defined(TARGET_SH4)
+/* SH4 doesn't align register pairs, except for p{read,write}64 */
+static inline int regpairs_aligned(void *cpu_env, int num)
+{
+    switch (num) {
+    case TARGET_NR_pread64:
+    case TARGET_NR_pwrite64:
+        return 1;
+
+    default:
+        return 0;
+    }
+}
+#elif defined(TARGET_XTENSA)
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+#else
+static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
+#endif
+
 /**
  * preexit_cleanup: housekeeping before the guest exits
  *
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 2dcc15496a6a..31c7be24ebfd 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1962,6 +1962,53 @@ print_lseek(void *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_truncate
+static void
+print_truncate(void *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_truncate64
+static void
+print_truncate64(void *cpu_env, const struct syscallname *name,
+                 abi_long arg0, abi_long arg1, abi_long arg2,
+                 abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    if (regpairs_aligned(cpu_env, TARGET_NR_truncate64)) {
+        arg1 = arg2;
+        arg2 = arg3;
+    }
+    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_ftruncate64
+static void
+print_ftruncate64(void *cpu_env, const struct syscallname *name,
+                  abi_long arg0, abi_long arg1, abi_long arg2,
+                  abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    if (regpairs_aligned(cpu_env, TARGET_NR_ftruncate64)) {
+        arg1 = arg2;
+        arg2 = arg3;
+    }
+    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_socket)
 static void
 print_socket(void *cpu_env, const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index a04706a524ae..8e5303d03500 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -258,10 +258,10 @@
 { TARGET_NR_ftime, "ftime" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_ftruncate
-{ TARGET_NR_ftruncate, "ftruncate" , NULL, NULL, NULL },
+{ TARGET_NR_ftruncate, "ftruncate" , "%s(%d," TARGET_ABI_FMT_ld ")", NULL, NULL },
 #endif
 #ifdef TARGET_NR_ftruncate64
-{ TARGET_NR_ftruncate64, "ftruncate64" , NULL, NULL, NULL },
+{ TARGET_NR_ftruncate64, "ftruncate64" , NULL, print_ftruncate64, NULL },
 #endif
 #ifdef TARGET_NR_futex
 { TARGET_NR_futex, "futex" , NULL, print_futex, NULL },
@@ -372,7 +372,7 @@
 { TARGET_NR_getrusage, "getrusage" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getsid
-{ TARGET_NR_getsid, "getsid" , NULL, NULL, NULL },
+{ TARGET_NR_getsid, "getsid" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_getsockname
 { TARGET_NR_getsockname, "getsockname" , NULL, NULL, NULL },
@@ -1535,10 +1535,10 @@
 { TARGET_NR_tkill, "tkill" , NULL, print_tkill, NULL },
 #endif
 #ifdef TARGET_NR_truncate
-{ TARGET_NR_truncate, "truncate" , NULL, NULL, NULL },
+{ TARGET_NR_truncate, "truncate" , NULL, print_truncate, NULL },
 #endif
 #ifdef TARGET_NR_truncate64
-{ TARGET_NR_truncate64, "truncate64" , NULL, NULL, NULL },
+{ TARGET_NR_truncate64, "truncate64" , NULL, print_truncate64, NULL },
 #endif
 #ifdef TARGET_NR_tuxcall
 { TARGET_NR_tuxcall, "tuxcall" , NULL, NULL, NULL },
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 42107f37e397..ec7192112e9d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -495,38 +495,6 @@ static inline int next_free_host_timer(void)
 }
 #endif
 
-/* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
-#ifdef TARGET_ARM
-static inline int regpairs_aligned(void *cpu_env, int num)
-{
-    return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
-}
-#elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
-#elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
-/* SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
- * of registers which translates to the same as ARM/MIPS, because we start with
- * r3 as arg1 */
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
-#elif defined(TARGET_SH4)
-/* SH4 doesn't align register pairs, except for p{read,write}64 */
-static inline int regpairs_aligned(void *cpu_env, int num)
-{
-    switch (num) {
-    case TARGET_NR_pread64:
-    case TARGET_NR_pwrite64:
-        return 1;
-
-    default:
-        return 0;
-    }
-}
-#elif defined(TARGET_XTENSA)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
-#else
-static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
-#endif
-
 #define ERRNO_TABLE_SIZE 1200
 
 /* target_to_host_errno_table[] is initialized from
-- 
2.26.2


