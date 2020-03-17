Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D70C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6597F20724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6597F20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEElz-0000vh-Be
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEEW8-00063c-IZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEEW7-0001Rj-76
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:32 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:43329)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEEW6-0001LI-Ub
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:31 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MORMu-1iw0de0MCU-00PtUY; Tue, 17 Mar 2020 16:52:20 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 35/37] linux-user,
 aarch64: sync syscall numbers with kernel v5.5
Date: Tue, 17 Mar 2020 16:51:14 +0100
Message-Id: <20200317155116.1227513-36-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317155116.1227513-1-laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EoUwVet/r0v1yY+TfmePdob1DMYtM1BOPAkk0qXK7ASK5avdZGd
 ZAN/P1oVsuBFdnhtAQXpeyIcRWkMr5RTAw9wrgZqYjcOknPxg0kZVI21fSqme5Fhg6cNEjk
 kahjmaWjiclRizVTTAqDfpvu2F1MKl5ThsKhCFVfV/DbXisRMQVMULjzHzWR8np46Ww1dU1
 /wJ0p2LlCWv0MY0Qw8fyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/MhX7v4kX7A=:vLv44oa4MWfeWN4JSK0Hi8
 5Rvcz7zBHbkRn7fd0FUPtcHSlPM+56vaF1R4PI0gwc15p+SK7wxTcpt7YRN24/RxRNklbfkKt
 9BKUYLOcx9Mq5JsqXX7BL6RVY5WeX2LTN3slpT32R7tcZbyRArlqinKKxOI4IwT4C5qgbcQZH
 3NrSBXIjc4+0QcZp2sXIIQC0zAYRwz5jID5jlHzZjabc0HKcB0wdoKhXiqSWlRfTIa9D1OwqH
 4vBJE4iVdxGQZUdVs6lgxBOBHBaWCUC9dyxwKmGVP9I51VRPXbkcWiRwmDeJGqhKRa1HKQKmJ
 YCwbwku+i5GWbK6fUHdBYL9QnifbtHL4z4iPBB6XjDdRn93I7CN6lwa3qWbI4x+Z0hOOUzIlA
 pIPODmiJsj3//zlvkzX6rQAD62GPiGPKxO8bDkL5ookCprD3E0O0bWWkDUDmleqewkmtX9HcL
 pcg2zwSbF2R1/5ruA5OJ9QleCJhYbQ8r4FhZOGnbyZtiWf3w+hL/53fty6+U0t/vp46sf6rkJ
 L27XJhfAtw2IK5azLq4galTcZ+Hf1GnpBp5vBH8f5WX9SAef/bL15ebvzIDNMkV3Ma+Hpki6c
 Z3aGTYyYXW1/0DQHeQtkiIjGwBIG+zPxFtSnNSwIiocwK6aECBCLojr+/8RgtU02eiCCi31/T
 jiIgaZ8mvewgFWod4HGsvIiSzPB8jhQWqSkXf2goIjpIJZb/XcE2dRAWSXoWVNaAwt6o/ISUV
 bgl4DRg+js8WHYmOYFO9H4clgEX8jNhl6WRJqcgEkciG89X/qevltcZ2TuAjQGCQ26WGozyUe
 9NrPHy0pG63Cw8isiJR485D3r3Dro1VPjsV5PSUhBsB8z456ePDys3ckpT4cMnKnSRI7Hp2
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
2.24.1


