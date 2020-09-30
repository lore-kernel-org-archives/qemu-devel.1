Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBFDC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:35:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF0220754
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF0220754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNQ5d-0002MU-G0
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 20:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kNQ1L-0006Om-M3
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 20:30:59 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kNQ1J-00089B-ND
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 20:30:59 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mg6i8-1kupIA1vFW-00hdCi; Wed, 30 Sep 2020 02:30:36 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] linux-user: update syscall_nr.h to Linux 5.9-rc7
Date: Wed, 30 Sep 2020 02:30:30 +0200
Message-Id: <20200930003033.554124-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930003033.554124-1-laurent@vivier.eu>
References: <20200930003033.554124-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LN9U56u3ggGdA/1rJ/bIvGZouklUwfsm2VfYViKYv5EST5tmlsb
 /j6lbYpxyKpuELHQLm5bFngDNrXRwXboPCaomrjHvNCQCHptt5F2rVXvO7ZkpRXHh7SOwRw
 lZ54ng4Q95MMv0GDy4b5nZyNSCqXX0KJ5V/kCKPIwAepkpNcxvbX8uVCRSpKc5n2O6DmfV3
 I6Q4reaub+qOxHMzllZFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DbOsiY1cUL0=:+FkB1p5y8FT71zM1FICy26
 z0grHeVgV7bnX3hLIZdqU6zSq0NPXR0A5yVhVKfeddo8ozkOGmuIJ0oDhIOdaqvD+55bR16VV
 hNeeLNZPEao5viWK/UXaJXrdOWA1bmVI+y4JDX2lAA3Ow8uaQCM1dXE1VOuSXl3YG/flp715c
 H3niZqsxxN63p/F5IQClfG6JL7+53mZX+gX9nu/Vul+4w6CLtUn5fadq1b8i5xv5otnYfBi9/
 dQtwRGJ9gy0/toiAMqu9DvCepuPBMeijiLTJSqRVTidmMg4hVICk+BR2xNt9pCNyQ9FGxxgRM
 TBRxZr3lo1G3UbSfl43lOKTYJ+B9TNOOGqTCJXKvy7cDMKT2p42+CqZiF8Xpi8me7oSFA586A
 1hNGAwUO7ha1Kj98qsjNgMnbJtXvDMTqjsfB4uMTwmUTokjzVAoukVY9qTM2LhlqotGwik7wM
 oQfpAUlQmXdj1lusDHnDeKkOfNL1Lsr/yOhxqkxrhXhe+ogx8h/ZRBi81+DrHBMUvO+FGPfIb
 AOtbiCgRQxaAzFUzKj6P59uMq2i4yKpMP77Td2YkX8QSoQgoPQgIFUE7adjkauLBgRR5v9KIT
 msSfSO3HoPBDhWa2JqYASRYRYhO0cZ2QueHsA5HF2S47nA0nakQtfv0M+Ptst7to2lNSChJwc
 H6nZmPjnSM67pSRJ0B0+OGBrLiPF/9yJgm+b1JkWDYgxE6GQHKq0ZelsTGAmKd6xoMY0RzVtW
 mN1dJkz8MQqkCgPDdFMpiHsG09xV+isW/fPD7j3ZHDpydbNP2zc8tDZNElZa52M2mac3rCIwG
 WsbAEXqR8YaWvBZSYlHcJpgKnm9apFuanpORTARaHKdyRwDSUNmm0x4GVfAdSINI6RRFmks
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 20:30:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_NONE=0.001,
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update gensyscalls.sh not to generate an empty line at the end of the file

And then automatically update syscall_nr.h running scripts/gensyscalls.sh

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


