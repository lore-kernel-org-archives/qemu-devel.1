Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79D1C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F6D20409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F6D20409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtOQ-0003P3-MU
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsQn-0008He-Va
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsQm-0007by-Fu
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:33 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52441)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsQm-0007S6-3E
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:32 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MWhxY-1ipjoy0PP6-00X6bn; Mon, 16 Mar 2020 17:16:44 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 32/38] linux-user: update syscall.tbl from linux 0bf999f9c5e7
Date: Mon, 16 Mar 2020 17:15:44 +0100
Message-Id: <20200316161550.336150-33-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qpKFjCfu/ANu6GTHf6lsIIaT3xqIrbaFkSa8kG+X1r6kVzaduQz
 EJ68ixQx6c2GGlcu7Vdhoru+N+iPRWIuGci26pBNoXA4Ncq0XfyscEV4Gw/F6GiyB5qiM39
 6IPZioQKMf8KFqvGC3NBUZqJG4C+8mV8xVYis72BL1Sa5TVjt/OXz6V6Eb3piUmteY/aS/M
 6iweskXvBFnASwBAp5NfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2QGYO98mlU8=:L+6qFf2R2bU229KxBHasGx
 NzC16yxGUZNoLFQiuLU6iSrCOnCJh5NbiJFX/uYQbSI7VUTot77rr/MOaiULJiqubfj1wY+jq
 XdxD4cEqU5hNKlEbA29wE8jXFm2zpAg4BSP/2BEj1b6u4l6AxjbcE6TIL3xso/cBhBcFnT7Zp
 YbfVd+alSO4sD9LU6uZ0aUA1BLYgZ9T74v/EnSfZL6bBouynJxZIjez/Sm+S4D035ygv6q6Ur
 2NPMB2g+YA8rneJM3cxAXCN02dJ7L3Qg5DdK5vGWX9xvX5gh+9XbKFI8gsZYLUePXg7jRkt44
 eOnhddqu8XHiKimz+BshPDDNqTE9GdbRG1PeMHOzZY2G5n/2Ffz1h15Wi/SOb+JXi0ZGG/pb2
 XI+tjE7ZFLIVUp8wBnpKnidM1yGK4JDhhNzL7y9owrwdkQh2IJOig5OVdkXKbCPE3GP5U3oMc
 /gvQUD1kpck0EYTXzO0vxtStTjSBySMQrJhxpNc3DDNltDB8EULiTY5+QhF3kWq68AQ9RVBIu
 L0aZrexyFNOjwxy+cSUlgJIJXtwMbI5xww/IGYFpy9zowCtCxuvbjnFWRbpQBN4EItm0Wur+8
 6FVVul9jPdMquLfFmyj+1I0duHzMSKvXY2h+Fpqoqw029883JWgCJyaha1ZQC6avgTah7HPZY
 iZxq0tSRB/fItJR+lscEykJwDxI7jGgqZu39bHdPAP3Qoz/4W2c0JltRgpTMPRwTmg+JNlLQU
 bx7lnmgqEn46HRgcX8tRlwHbFRf+F9jOnjW44Fr9xcyvtd29+BQPLP7mhiXrNbXveqZRJV0L3
 pJshLr6PoufIPDGg5EA6hvih8vjNqGcXeNXM27pJq/fNLn3c5WWlsVJKf2uVSTwbzNghAvo
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Run scripts/update-syscalltbl.sh with linux commit 0bf999f9c5e7

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200310103403.3284090-20-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/arm/syscall.tbl        | 2 ++
 linux-user/hppa/syscall.tbl       | 2 ++
 linux-user/i386/syscall_32.tbl    | 2 ++
 linux-user/m68k/syscall.tbl       | 4 +++-
 linux-user/microblaze/syscall.tbl | 2 ++
 linux-user/mips/syscall_o32.tbl   | 2 ++
 linux-user/mips64/syscall_n32.tbl | 2 ++
 linux-user/mips64/syscall_n64.tbl | 2 ++
 linux-user/ppc/syscall.tbl        | 2 ++
 linux-user/s390x/syscall.tbl      | 2 ++
 linux-user/sh4/syscall.tbl        | 2 ++
 linux-user/sparc/syscall.tbl      | 2 ++
 linux-user/sparc64/syscall.tbl    | 2 ++
 linux-user/x86_64/syscall_64.tbl  | 2 ++
 linux-user/xtensa/syscall.tbl     | 2 ++
 15 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/linux-user/arm/syscall.tbl b/linux-user/arm/syscall.tbl
index 6da7dc4d79cc..4d1cf74a2caa 100644
--- a/linux-user/arm/syscall.tbl
+++ b/linux-user/arm/syscall.tbl
@@ -449,3 +449,5 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/linux-user/hppa/syscall.tbl b/linux-user/hppa/syscall.tbl
index 285ff516150c..52a15f5cd130 100644
--- a/linux-user/hppa/syscall.tbl
+++ b/linux-user/hppa/syscall.tbl
@@ -433,3 +433,5 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3_wrapper
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/linux-user/i386/syscall_32.tbl b/linux-user/i386/syscall_32.tbl
index 15908eb9b17e..c17cb77eb150 100644
--- a/linux-user/i386/syscall_32.tbl
+++ b/linux-user/i386/syscall_32.tbl
@@ -440,3 +440,5 @@
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
 434	i386	pidfd_open		sys_pidfd_open			__ia32_sys_pidfd_open
 435	i386	clone3			sys_clone3			__ia32_sys_clone3
+437	i386	openat2			sys_openat2			__ia32_sys_openat2
+438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
diff --git a/linux-user/m68k/syscall.tbl b/linux-user/m68k/syscall.tbl
index a88a285a0e5f..f4f49fcb76d0 100644
--- a/linux-user/m68k/syscall.tbl
+++ b/linux-user/m68k/syscall.tbl
@@ -434,4 +434,6 @@
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
-# 435 reserved for clone3
+435	common	clone3				__sys_clone3
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/linux-user/microblaze/syscall.tbl b/linux-user/microblaze/syscall.tbl
index 09b0cd7dab0a..4c67b11f9c9e 100644
--- a/linux-user/microblaze/syscall.tbl
+++ b/linux-user/microblaze/syscall.tbl
@@ -441,3 +441,5 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/linux-user/mips/syscall_o32.tbl b/linux-user/mips/syscall_o32.tbl
index 353539ea4140..ac586774c980 100644
--- a/linux-user/mips/syscall_o32.tbl
+++ b/linux-user/mips/syscall_o32.tbl
@@ -423,3 +423,5 @@
 433	o32	fspick				sys_fspick
 434	o32	pidfd_open			sys_pidfd_open
 435	o32	clone3				__sys_clone3
+437	o32	openat2				sys_openat2
+438	o32	pidfd_getfd			sys_pidfd_getfd
diff --git a/linux-user/mips64/syscall_n32.tbl b/linux-user/mips64/syscall_n32.tbl
index e7c5ab38e403..1f9e8ad636cc 100644
--- a/linux-user/mips64/syscall_n32.tbl
+++ b/linux-user/mips64/syscall_n32.tbl
@@ -374,3 +374,5 @@
 433	n32	fspick				sys_fspick
 434	n32	pidfd_open			sys_pidfd_open
 435	n32	clone3				__sys_clone3
+437	n32	openat2				sys_openat2
+438	n32	pidfd_getfd			sys_pidfd_getfd
diff --git a/linux-user/mips64/syscall_n64.tbl b/linux-user/mips64/syscall_n64.tbl
index 13cd66581f3b..c0b9d802dbf6 100644
--- a/linux-user/mips64/syscall_n64.tbl
+++ b/linux-user/mips64/syscall_n64.tbl
@@ -350,3 +350,5 @@
 433	n64	fspick				sys_fspick
 434	n64	pidfd_open			sys_pidfd_open
 435	n64	clone3				__sys_clone3
+437	n64	openat2				sys_openat2
+438	n64	pidfd_getfd			sys_pidfd_getfd
diff --git a/linux-user/ppc/syscall.tbl b/linux-user/ppc/syscall.tbl
index 43f736ed47f2..35b61bfc1b1a 100644
--- a/linux-user/ppc/syscall.tbl
+++ b/linux-user/ppc/syscall.tbl
@@ -517,3 +517,5 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	nospu	clone3				ppc_clone3
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/linux-user/s390x/syscall.tbl b/linux-user/s390x/syscall.tbl
index 3054e9c035a3..bd7bd3581a0f 100644
--- a/linux-user/s390x/syscall.tbl
+++ b/linux-user/s390x/syscall.tbl
@@ -438,3 +438,5 @@
 433  common	fspick			sys_fspick			sys_fspick
 434  common	pidfd_open		sys_pidfd_open			sys_pidfd_open
 435  common	clone3			sys_clone3			sys_clone3
+437  common	openat2			sys_openat2			sys_openat2
+438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
diff --git a/linux-user/sh4/syscall.tbl b/linux-user/sh4/syscall.tbl
index b5ed26c4c005..c7a30fcd135f 100644
--- a/linux-user/sh4/syscall.tbl
+++ b/linux-user/sh4/syscall.tbl
@@ -438,3 +438,5 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/linux-user/sparc/syscall.tbl b/linux-user/sparc/syscall.tbl
index 8c8cc7537fb2..f13615ecdecc 100644
--- a/linux-user/sparc/syscall.tbl
+++ b/linux-user/sparc/syscall.tbl
@@ -481,3 +481,5 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+437	common	openat2			sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/linux-user/sparc64/syscall.tbl b/linux-user/sparc64/syscall.tbl
index 8c8cc7537fb2..f13615ecdecc 100644
--- a/linux-user/sparc64/syscall.tbl
+++ b/linux-user/sparc64/syscall.tbl
@@ -481,3 +481,5 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+437	common	openat2			sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/linux-user/x86_64/syscall_64.tbl b/linux-user/x86_64/syscall_64.tbl
index c29976eca4a8..44d510bc9b78 100644
--- a/linux-user/x86_64/syscall_64.tbl
+++ b/linux-user/x86_64/syscall_64.tbl
@@ -357,6 +357,8 @@
 433	common	fspick			__x64_sys_fspick
 434	common	pidfd_open		__x64_sys_pidfd_open
 435	common	clone3			__x64_sys_clone3/ptregs
+437	common	openat2			__x64_sys_openat2
+438	common	pidfd_getfd		__x64_sys_pidfd_getfd
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/linux-user/xtensa/syscall.tbl b/linux-user/xtensa/syscall.tbl
index 25f4de729a6d..85a9ab1bc04d 100644
--- a/linux-user/xtensa/syscall.tbl
+++ b/linux-user/xtensa/syscall.tbl
@@ -406,3 +406,5 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
-- 
2.24.1


