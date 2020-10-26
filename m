Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49AEC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B85520874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B85520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXAfS-0002Ps-6w
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 18:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kXAak-0005fb-Rm
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:03:51 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kXAai-0005Fq-Ka
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:03:50 -0400
Received: from localhost.localdomain ([82.252.139.38]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MrQ2R-1k0cye0Ncd-00oYja; Mon, 26 Oct 2020 23:03:43 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] linux-user: update syscall_nr.h to Linux 5.9-rc7
Date: Mon, 26 Oct 2020 23:03:34 +0100
Message-Id: <20201026220339.195790-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026220339.195790-1-laurent@vivier.eu>
References: <20201026220339.195790-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Re4Nz3e6YcUkR6hCst04ANZ72i8YrvsVOrFQJnv6QGZzKHxZ1r8
 hTe7EUMBsmvJfM2UXKdpGgFIbDXeDro0q+oaXp7FRryxTKDVH3NN7ypDxx1a71l4Y9sFDy2
 u3XHFgTUdE2N/+hDw7BE8EckMsZnRT0CVgEXa+w5d9HUIj9B29WMCmRUQeZ40kww4pO80w8
 TFdGr14wBRT+GAfghYYXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JZ5NMj+GE8Q=:MnOUKPrV1d5icNzeI+5Y0V
 KsfJU1o67BTMwAGv7JUjd8tuo6e2PIEKefaeVxUpJXonh4Suk2DYhUvW6aVywdTZD0Yl7v8Sq
 BDD8a3ih5x172ZLAextN94rfXBHb9bgtHWHlxRFz3OPgHfXbEfXd3sAEK6BPP+zZDzOSBbt+q
 vZSbjyKMqk/TOC5on+O2y6ffjsrC5G77eqfiRuD6utKbYfCXtuSSv3hDL5118iULPxsM3HD9Q
 3kCXE3t58kHv5YFL8Ikty2vflh/+E9O+atrtKsFMwMxptozL0ywV5xzpsyiit5yoWjfuzNVnT
 uu/JfYW2yAYn8rarj+em0aI3UIa1Ntfvmysmjc1tHMtmw3ihAdOKYhHAufbgj2L0wn7/KXcXN
 3BI3xuhxoWn6aToKbWafxWfx/I3Vw5Lbj97UEZQQ5YCVTrpskgnEuzeHVTi7U
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 18:03:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update gensyscalls.sh not to generate an empty line at the end of the file

And then automatically update syscall_nr.h running scripts/gensyscalls.sh

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200930003033.554124-2-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/aarch64/syscall_nr.h  | 7 +++++--
 linux-user/nios2/syscall_nr.h    | 7 +++++--
 linux-user/openrisc/syscall_nr.h | 8 ++++++--
 linux-user/riscv/syscall32_nr.h  | 8 +++++++-
 linux-user/riscv/syscall64_nr.h  | 8 +++++++-
 scripts/gensyscalls.sh           | 3 +--
 6 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/linux-user/aarch64/syscall_nr.h b/linux-user/aarch64/syscall_nr.h
index 85de000b2490..6fd5b331e780 100644
--- a/linux-user/aarch64/syscall_nr.h
+++ b/linux-user/aarch64/syscall_nr.h
@@ -298,7 +298,10 @@
 #define TARGET_NR_fspick 433
 #define TARGET_NR_pidfd_open 434
 #define TARGET_NR_clone3 435
-#define TARGET_NR_syscalls 436
+#define TARGET_NR_close_range 436
+#define TARGET_NR_openat2 437
+#define TARGET_NR_pidfd_getfd 438
+#define TARGET_NR_faccessat2 439
+#define TARGET_NR_syscalls 440
 
 #endif /* LINUX_USER_AARCH64_SYSCALL_NR_H */
-
diff --git a/linux-user/nios2/syscall_nr.h b/linux-user/nios2/syscall_nr.h
index 32d485dc9ae8..e37f40179bf3 100644
--- a/linux-user/nios2/syscall_nr.h
+++ b/linux-user/nios2/syscall_nr.h
@@ -318,7 +318,10 @@
 #define TARGET_NR_fsmount 432
 #define TARGET_NR_fspick 433
 #define TARGET_NR_pidfd_open 434
-#define TARGET_NR_syscalls 436
+#define TARGET_NR_close_range 436
+#define TARGET_NR_openat2 437
+#define TARGET_NR_pidfd_getfd 438
+#define TARGET_NR_faccessat2 439
+#define TARGET_NR_syscalls 440
 
 #endif /* LINUX_USER_NIOS2_SYSCALL_NR_H */
-
diff --git a/linux-user/openrisc/syscall_nr.h b/linux-user/openrisc/syscall_nr.h
index 340383beb2c6..a8fc0295109a 100644
--- a/linux-user/openrisc/syscall_nr.h
+++ b/linux-user/openrisc/syscall_nr.h
@@ -318,7 +318,11 @@
 #define TARGET_NR_fsmount 432
 #define TARGET_NR_fspick 433
 #define TARGET_NR_pidfd_open 434
-#define TARGET_NR_syscalls 436
+#define TARGET_NR_clone3 435
+#define TARGET_NR_close_range 436
+#define TARGET_NR_openat2 437
+#define TARGET_NR_pidfd_getfd 438
+#define TARGET_NR_faccessat2 439
+#define TARGET_NR_syscalls 440
 
 #endif /* LINUX_USER_OPENRISC_SYSCALL_NR_H */
-
diff --git a/linux-user/riscv/syscall32_nr.h b/linux-user/riscv/syscall32_nr.h
index 4fef73e954da..079b804daef5 100644
--- a/linux-user/riscv/syscall32_nr.h
+++ b/linux-user/riscv/syscall32_nr.h
@@ -1,5 +1,7 @@
 /*
  * This file contains the system call numbers.
+ * Do not modify.
+ * This file is generated by scripts/gensyscalls.sh
  */
 #ifndef LINUX_USER_RISCV_SYSCALL32_NR_H
 #define LINUX_USER_RISCV_SYSCALL32_NR_H
@@ -290,6 +292,10 @@
 #define TARGET_NR_fspick 433
 #define TARGET_NR_pidfd_open 434
 #define TARGET_NR_clone3 435
-#define TARGET_NR_syscalls 436
+#define TARGET_NR_close_range 436
+#define TARGET_NR_openat2 437
+#define TARGET_NR_pidfd_getfd 438
+#define TARGET_NR_faccessat2 439
+#define TARGET_NR_syscalls 440
 
 #endif /* LINUX_USER_RISCV_SYSCALL32_NR_H */
diff --git a/linux-user/riscv/syscall64_nr.h b/linux-user/riscv/syscall64_nr.h
index cc82f3244f55..d54224ccec64 100644
--- a/linux-user/riscv/syscall64_nr.h
+++ b/linux-user/riscv/syscall64_nr.h
@@ -1,5 +1,7 @@
 /*
  * This file contains the system call numbers.
+ * Do not modify.
+ * This file is generated by scripts/gensyscalls.sh
  */
 #ifndef LINUX_USER_RISCV_SYSCALL64_NR_H
 #define LINUX_USER_RISCV_SYSCALL64_NR_H
@@ -296,6 +298,10 @@
 #define TARGET_NR_fspick 433
 #define TARGET_NR_pidfd_open 434
 #define TARGET_NR_clone3 435
-#define TARGET_NR_syscalls 436
+#define TARGET_NR_close_range 436
+#define TARGET_NR_openat2 437
+#define TARGET_NR_pidfd_getfd 438
+#define TARGET_NR_faccessat2 439
+#define TARGET_NR_syscalls 440
 
 #endif /* LINUX_USER_RISCV_SYSCALL64_NR_H */
diff --git a/scripts/gensyscalls.sh b/scripts/gensyscalls.sh
index b7b8456f6312..bba9fb052c47 100755
--- a/scripts/gensyscalls.sh
+++ b/scripts/gensyscalls.sh
@@ -86,8 +86,7 @@ generate_syscall_nr()
     read_includes $arch $bits | filter_defines | rename_defines | \
                                 evaluate_values | sort -n -k 3
     echo
-    echo "#endif /* ${guard} */"
-    echo) > "$file"
+    echo "#endif /* ${guard} */") > "$file"
 }
 
 mkdir "$TMP/asm"
-- 
2.26.2


