Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8198CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E4A20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E4A20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDlwt-0006Ob-2B
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 05:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDlY8-0005nW-VK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDlY7-0004cQ-MZ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:56:40 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:41191)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDlY7-0004SL-CO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:56:39 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MS3vJ-1ikMiY3G9L-00TXGn; Mon, 16 Mar 2020 09:56:25 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] linux-user,
 aarch64: sync syscall numbers with kernel v5.5
Date: Mon, 16 Mar 2020 09:56:18 +0100
Message-Id: <20200316085620.309769-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316085620.309769-1-laurent@vivier.eu>
References: <20200316085620.309769-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fq8Ef0xauVqfqQeyegWBw/PMGk4+zDalPyNr7tAeVZj/Z17vXkR
 xtNFl2deeOAFDoSy4QubY2Nfh4Rs6LtHFRxwGJSS30DOeiLhYsTg40XdYoy/3+LsFLnT9Hn
 aQB2gkXWM3rkZCGeA1tvmDUB6TcEpaF9Nt7znJJT1EY73FCmM2NmWYadlyftsKNfT2yRVMI
 v1EVvpe9r/yDRJhadGwsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U4xcXrBGfXA=:GerIyre5C0DMM1+95waKJ5
 6/DOEawAep8iT8wFH8P7VxLwOe0boqoAUN/axNdrjOwKePHD4Rao4jZ5xr4hLnYpR4vO+ZGkn
 XsQtfIni2d2SHcc3p0+lijknZIpYUo1a+zR5Q4aSIkGmK0+NxLynU6ZqDI/FurIU/bxCLNAfH
 PafOFBHa5cd8XllpQnjgi6WifBh47RlxXAGzZrs1JzOW9b1G/BcaRQyrl6kn6TtaW9TA87F3F
 D2zdzzfcdD+e30u3IUGyySu6WpC8L2S8cVAWk3le7616r0va7F1bfHzL0iLvdkEvbRfY3xgZJ
 RevQe9gH0NlU7PUma/bs4aSUGE0HPQcKBRvNKetuodbSu9usnEBivgju7Fox/Tk+vJEpP+A8/
 VUxtjESGV1HPEWqhhUyIABZEFEvGJlnQOCmDuRJmZucUi29tvZzIp4NOWAzX4fw5QefYNXsNN
 Fv4G12aa5FkzVGlSvPXq8Mb3hyHaR6AHzmWwt7QO4uaoAmYRB/Gb8br1cCeBDCKQvyoPwnjHT
 UWequSg+tALC4+q+3NwlzJzo7MoPM0FYQ7EaP9yMXL9PNgso3nFWSXL4/Uk69xevPzRXPUfrn
 8tyqDfYswYUqK7+jtjq0/ADZHzl2huolGN830+BKOpeC3InRyELTsqxTPHCJZCS7seuRl2nIw
 qSPoX09xDGjll0WG7ZXyc0jjsgwOcH2knJD25uVuChK/+Cnu7GDwwsEkZ2bxeXQRHY6IFby+T
 /PdPyG8darPJMgX8wuB0P76yjQIsbD8gRB2VXWuwJMUYBTzHRpGyIQzmxcXQn2ZywpcBJHMoL
 2ZgEXD1hZFXI+7aM2i8ZvvAEeMosYC75oZMQ5RDl+oVE0tN7yO4nSkUarZJhWX9K1W2AWVD
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
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
---

Notes:
    v2: add comments suggested by Taylor

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
2.24.1


