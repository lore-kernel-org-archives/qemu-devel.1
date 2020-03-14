Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23553C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 11:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50B92076E
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 11:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50B92076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD5AJ-0005nQ-1M
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 07:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jD58r-00043c-E2
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jD58p-00057A-Sn
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:39:45 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53005)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jD58o-00051m-VL
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:39:43 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M3DBd-1jA4Sg15fJ-003cO3; Sat, 14 Mar 2020 12:39:27 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] linux-user,
 aarch64: sync syscall numbers with kernel v5.5
Date: Sat, 14 Mar 2020 12:39:20 +0100
Message-Id: <20200314113922.233353-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200314113922.233353-1-laurent@vivier.eu>
References: <20200314113922.233353-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BXBHUtld0RJHkQ/o+4ybuxJbqzHc/RIwGUkOPmIkXCDQnGXM3iO
 nvqRi7scKAgC0h/+yDDv8smCAutPeyYdGVf1FonUhpjDvo0Q3PDb4jn4RoOZW21vPOoFix3
 9d9NucwlEyGyP+v7mHqkQ1gwMo2mGM87nuX5dto2peqt4WxQtiM6ZtuJxmqr12MU6Y7cFsl
 NKDTuaHLcwhl9NOaZRz1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GG0EIYea4H8=:2JlBAe/showUO/Yye9fNJN
 rfQCqtTmgWF/BsQ7yxEFCj6rr2Zu5VJFKLmWpKFGnUp0dLEtrs9AYJRHzsgnBEJpkXaAmogvT
 ROjByJJFoYmvULgfn8eFN4YUEt99iFqnngetiMFg5mQl1CK5pe4ypGye6rokTcSi7FfXMaD+S
 TYWFXZyQhP3D9Vuo0TbJoVMLkxjKXmGU9a3I9mW5710YBjEeY1aDUGOntDiX3tC3CvFDGVoD6
 f3ImbrfvCCH0MbZkNkwRbGv1Ndizw7Zgk5AHGj5+a2ESi4veePM1TOLgXz1zpQ5KIhA6H6jjT
 8mXG+nt0q/PgU2KnXfpND/xt3PkcQetJGJRfOxIFBBczZ/kclDzGa+nIzB8MXCq3hC2SgZU8d
 0JYBJrqr+TO955Y2o4YroXvhWLuQpYasMkMz0Q8g+A1bR9UPOZoLYs/p4KYtVFicADTvB+HJR
 yV99906eIqtfMq/pWZjSEbbHinDVYqQK/SiQyxW4eTmMp/D76/A7aom8Z22bna9IcSpcS46s+
 4aB8byjqLihYCmzK8hrhyY+oxdisDaT0uDZZJRCcqDYb6BMtmGRVg7MNv7zfeNMAm/J1fhApD
 /x8b1975SMbxH/NX8fJ5pBn+wfCFu+SIQzPf4f40Tv57jHTjggfgewG2ZhhWICq787N1WM+/+
 X3OPU0fDlg2H2unjuqQLe17fhMjghZmtt2ap4d+t+hXKyFViZ1hA6697EceWDvuaiyV/TO5Yd
 m6bbKOkqVa2EGUIiWyGvAoqZXuEgEDNKnes3gD72jxMQJlQKUHRFs4cBZcTkrERFcUyDSWEpw
 wETSs66BXUPgYljyFes+7YAfc7FoJnItJrDQGQmJtTv+EjfR59IWm9KnA21Qm82toTinzKD
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Alistair Francis <alistair.francis@wdc.com>,
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


