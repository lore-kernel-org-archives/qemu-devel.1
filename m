Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FC0C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606262468D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606262468D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcn6-000352-Ip
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBckD-0007FG-A1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBckC-0002Ht-1T
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:08:17 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46439)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jBckB-0002D1-Ou
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:08:15 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MYvPq-1ipVOF0an2-00UvJJ; Tue, 10 Mar 2020 12:08:03 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] linux-user, aarch64: sync syscall numbers with kernel v5.5
Date: Tue, 10 Mar 2020 12:07:57 +0100
Message-Id: <20200310110759.3331020-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310110759.3331020-1-laurent@vivier.eu>
References: <20200310110759.3331020-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7dMSyY/Ysl0MhN3DDKMhBmJEAVLrhXqHKXBMYoTLjdELylaQHaD
 kvTY4sUctRFqpoCxa+UXPYZGgKatJv8z5fS1cnQy8VUg/UGT01LMP/83sCqS4ccoS8kyMrF
 LlVgKyqkdmW3jzbvXxcSW6NCyIJm/UOtgbvzK61FYdyG1rA05AuU+ihQs3Dm0Qyk6Xg5Qkb
 pV/ad0dxpg92k1jvO0lEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0mJcKmA8sQA=:8Iptil1TFsEVamTs+R7GZL
 9hHiy1TED9kz4TUV5ibu5U3lfsA1sLlELfhqLWAa0ils5QK2dqxC874aowLSNg73WCR4K1zHa
 piTirzoDd1luGy/T/ONie2IdbLrYHhFZdm+hUiGGU+nlItpsms2hg9+jq9V96T+KhfGV6K71V
 zM8uXhgTbdFNftq83cNrkXIZR78WicBrx8niNtkb1paxLAIv09mFrRAX1kl/6WS457Fl3DXVZ
 iiGZK9ZcC5v7KwEb7Pxpk5LMzvLRH2cJmB2goY4ztc8UgCEwhdagxqgYi7qHlWVXzVc2sA4i6
 +rgQY+zbA29ib58YfS5r0sIaWxiVjk0vqkFEBKhN58xW9zxFw2O7SwDVr6VAP4pMk+T4H4Ug5
 w6FY2Bx6TH4494wgGc3kRjN08Sg6HO4OGjzYnrURMQkCvFXdbqm4/f9Kb2ARZ6kbJ6Ip2cM9s
 FnJ3qCcfbKu3AMySxoDvNDrEiMNfhCZ7pRRSEn8CHs09X59/UOjqGOA6UEdOP4OC/C5rJ/T2E
 +SWI7bKnncj38dWnZ2dm2mC/ovzNFElCL++j1JwjfuiEyiINipKbqAhqn9Im3UDodw5HBsTze
 4oxQ1PmU7JLuNa1I60rp9R6/ay9lwLgsCmFMLzNqWmQubp9JwRWyAYBYgs6Hl1+vOY6qyJxtV
 3zWqX47OC8uj8IzG2rS6mlJ2kWDrEnzfRSFScfhVQdt3znVizbp+Xnna80EWsfGjLSE92g3Hs
 5H9I/HMmtLBFwu1+N3sxjoERjuyp1PuiRXiuPOEbNLgaXudiHy7cFZsgM/aZlPT7j6nW/R0kx
 rG4yTuFKKeyOR6BvHZb6hh7QmDqV6LCYSPRiAzxXRRllxLiW3VUOX/0504tEeG4OemObNYJ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Jia Liu <proljc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>
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
---
 linux-user/aarch64/syscall_nr.h | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/linux-user/aarch64/syscall_nr.h b/linux-user/aarch64/syscall_nr.h
index f00ffd7fb82f..eb5287bf6c98 100644
--- a/linux-user/aarch64/syscall_nr.h
+++ b/linux-user/aarch64/syscall_nr.h
@@ -1,7 +1,6 @@
 /*
  * This file contains the system call numbers.
  */
-
 #ifndef LINUX_USER_AARCH64_SYSCALL_NR_H
 #define LINUX_USER_AARCH64_SYSCALL_NR_H
 
@@ -84,7 +83,7 @@
 #define TARGET_NR_splice 76
 #define TARGET_NR_tee 77
 #define TARGET_NR_readlinkat 78
-#define TARGET_NR_fstatat64 79
+#define TARGET_NR_newfstatat 79
 #define TARGET_NR_fstat 80
 #define TARGET_NR_sync 81
 #define TARGET_NR_fsync 82
@@ -254,8 +253,8 @@
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
@@ -276,5 +275,28 @@
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
2.24.1


