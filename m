Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD2BC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0169D2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0169D2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJmJ-0007re-3k
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFJWM-0006ua-LN
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFJWL-00005e-7s
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:14 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50647)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jFJWK-0008VM-VB
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:13 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mo73N-1jeC9d1i0J-00pcOn; Fri, 20 Mar 2020 16:25:02 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v4 30/32] linux-user,
 aarch64: sync syscall numbers with kernel v5.5
Date: Fri, 20 Mar 2020 16:24:06 +0100
Message-Id: <20200320152408.182899-31-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320152408.182899-1-laurent@vivier.eu>
References: <20200320152408.182899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZlHhap4iMVRxw7J2qaHqzFVVUaD8cEiEpmCXqIQXI3dIPBJi281
 Si5SI4e/Zf5ag3zYaE7zDdXNuFElqhHVLbguhWOXEWLkJ/zEXoAmnnV+X1KzL4uKO743jSh
 1/OxdBD67LJc/fmREOLlzvTedhHEaw7Yl1mndc7UrcMiU4RkvtdddOaXrHwKFULPyaJAs5X
 BKcjNPcO6KNiIn6uDUJpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IECLQbH+M+0=:bT0lMysktn7ZLGX/eDDj7R
 zrd/vctCp4aXtfc0T9G5M3SxQf4EW4LwxGhqWWCjHqZBW5cr4zKLSLVpTJzRLY50JNmEGLRVB
 uOcPFoBr65WK1ZU42g3k3Oz92SKgmxg07PrGajdrtPPchiQLMq2yC95vqlLEXJWlUH7hUTd07
 bnMhQAM/iFZJ93pWEu2CZXI2wY63PaXvbdhLaOhIf3e6laNergKXqOKmgr0rq/FUSZJPLSvai
 Kx3Zt6u3qg50GxUlBb9L2DRxNW79VKBM5s0Tfpt879oAq2M27WOj6RBoWKR1Bouuxk8Rf2mWi
 yz/K+K3rM0GN5crHkF9HsB4qSp+fZ36+ZR+BJP4dveydZ87t5qfRctRzw2nOo30ydNuGkW2yU
 VLxLDPrGrbk6/Qes+dF9rFMQpHyNgEvm4yLED7LwhjEX3+PAWwUq9dW7kg2WCC4i92lX5tHys
 evORYd4VMyo/acSk4SgOQT9odrU/s9QjLCUMse5gH/0N5bwYhwRjskw2vPSe0NTzZvory2Zl+
 2QUBgseHJmDS6C562WgVTqpzyIXZDqfmadwmweAECzcedLKcNRMU8Ro5Z/O/GBAeOwkFITQlJ
 aRQK87V94+y1vnGs6Oj7TnIUa9i/p9Gv28LpjxzbcP6yLp9799TGLwdtxEjF6B3HttkZhJ92W
 ISx1iuqJTCHkb9LEsZUVD2hyVEF3AuhZPIeEq6uz4DrktLN/G4luHuqny1XsJVNdxlOrhymDC
 Of4/kANlGEoZ+yUqhy8nVIFuBEb+W0f3/ZC7AzGILeWFVlqob/5v+IouwaFa0x7BYhYXfwylH
 Z7lnU08thVJOJlkghwvw+/wtf4vwXTTs9dK/XesfDbXx7VM0csYD43XhL48bUFvpqgzKkAW
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
 Riku Voipio <riku.voipio@iki.fi>, Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use helper script scripts/gensyscalls.sh to generate the file.

This change TARGET_NR_fstatat64 by TARGET_NR_newfstatat that is correct
because definitions from linux are:

arch/arm64/include/uapi/asm/unistd.h

  #define __ARCH_WANT_NEW_STAT

include/uapi/asm-generic/unistd.h

  #if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
  #define __NR3264_fstatat 79
  __SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
  #define __NR3264_fstat 80
  __SC_3264(__NR3264_fstat, sys_fstat64, sys_newfstat)
  #endif
  ...
  #if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
  ...
  #if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
  #define __NR_newfstatat __NR3264_fstatat
  #define __NR_fstat __NR3264_fstat
  #endif
  ...

Add syscalls 286 (preadv2) to 435 (clone3).

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200316085620.309769-3-laurent@vivier.eu>
---
 linux-user/aarch64/syscall_nr.h | 34 ++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/linux-user/aarch64/syscall_nr.h b/linux-user/aarch64/syscall_nr.h
index f00ffd7fb82f..85de000b2490 100644
--- a/linux-user/aarch64/syscall_nr.h
+++ b/linux-user/aarch64/syscall_nr.h
@@ -1,7 +1,8 @@
 /*
  * This file contains the system call numbers.
+ * Do not modify.
+ * This file is generated by scripts/gensyscalls.sh
  */
-
 #ifndef LINUX_USER_AARCH64_SYSCALL_NR_H
 #define LINUX_USER_AARCH64_SYSCALL_NR_H
 
@@ -84,7 +85,7 @@
 #define TARGET_NR_splice 76
 #define TARGET_NR_tee 77
 #define TARGET_NR_readlinkat 78
-#define TARGET_NR_fstatat64 79
+#define TARGET_NR_newfstatat 79
 #define TARGET_NR_fstat 80
 #define TARGET_NR_sync 81
 #define TARGET_NR_fsync 82
@@ -254,8 +255,8 @@
 #define TARGET_NR_prlimit64 261
 #define TARGET_NR_fanotify_init 262
 #define TARGET_NR_fanotify_mark 263
-#define TARGET_NR_name_to_handle_at         264
-#define TARGET_NR_open_by_handle_at         265
+#define TARGET_NR_name_to_handle_at 264
+#define TARGET_NR_open_by_handle_at 265
 #define TARGET_NR_clock_adjtime 266
 #define TARGET_NR_syncfs 267
 #define TARGET_NR_setns 268
@@ -276,5 +277,28 @@
 #define TARGET_NR_membarrier 283
 #define TARGET_NR_mlock2 284
 #define TARGET_NR_copy_file_range 285
+#define TARGET_NR_preadv2 286
+#define TARGET_NR_pwritev2 287
+#define TARGET_NR_pkey_mprotect 288
+#define TARGET_NR_pkey_alloc 289
+#define TARGET_NR_pkey_free 290
+#define TARGET_NR_statx 291
+#define TARGET_NR_io_pgetevents 292
+#define TARGET_NR_rseq 293
+#define TARGET_NR_kexec_file_load 294
+#define TARGET_NR_pidfd_send_signal 424
+#define TARGET_NR_io_uring_setup 425
+#define TARGET_NR_io_uring_enter 426
+#define TARGET_NR_io_uring_register 427
+#define TARGET_NR_open_tree 428
+#define TARGET_NR_move_mount 429
+#define TARGET_NR_fsopen 430
+#define TARGET_NR_fsconfig 431
+#define TARGET_NR_fsmount 432
+#define TARGET_NR_fspick 433
+#define TARGET_NR_pidfd_open 434
+#define TARGET_NR_clone3 435
+#define TARGET_NR_syscalls 436
+
+#endif /* LINUX_USER_AARCH64_SYSCALL_NR_H */
 
-#endif
-- 
2.25.1


