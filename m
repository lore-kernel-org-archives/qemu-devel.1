Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3357C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977FF20724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977FF20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEk6-0005vM-Kj
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEEVw-0005lW-EG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEEVu-0000hj-Bi
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:20 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:51091)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEEVu-0000cf-0C
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:18 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MRTEp-1itWrw3ZvJ-00NPJh; Tue, 17 Mar 2020 16:52:14 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 31/37] linux-user: update syscall.tbl from linux 0bf999f9c5e7
Date: Tue, 17 Mar 2020 16:51:10 +0100
Message-Id: <20200317155116.1227513-32-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317155116.1227513-1-laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sBn0pR1KsolyGfnr/oXRyeDCe0nfyGgtQlu1rvjvZIn8SPQKzbE
 T9UWmwDh6e2jSxjiJZ6+FnarODeHH8SWF9XZEaSO0svMOxYFlpZoI2wOsCjJurJU0uHQHXj
 vPQt/QfIe+zPaRXAPzOuEyLAW2lPZRxWtXc7cDCvRYXj7RqNK4zRNHR/SPoWmlQI1SaI7Au
 Cpj365ZF2a4E2uErW6oIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3KHggnMdhGA=:v3oGqivbHDH19/Mc9nFvg/
 6AlAW7qLfjQjBO7XaT47fKcnHuRWcdXBwATok+quOWp6LtCvc4tW1Ddlt46/MeckpgGKcYQKB
 ZC36E2K7J/b+UVZsI5GNttPoAKbtdN0TAOKcY3i25RhmKbUBy77krKhV6BqQSceRm2oEgDCWi
 +ZqUwm2UKQcVn3+voWiTbonAOC+jR60haKHOXhrnyaNk8VNBhugcnzybeAkHLFC13vl4PZC/o
 32ezVuiots3/o1PtwiOb5GnKK8KMOq8jlCYJDcuDdaARVEVCQI2S4AGiog8kURmYCXcDB9f2e
 YtgWH1B/12HX4B4+4+7B8q9Gvpu/HFhbkukcaplITkZS/6lpYm07englJ7aibkVnDOqZbDpa2
 WAS7cbYLCG0A2sFR+40L5l0APSV5BYvpbmBYGStiJk6sJK/prhLIFr56IkVuidUOt06cp5ept
 5NRA46IL0eMY2cgFdFVidmN58FIJH47dKh1L0SAfOoIGPy+YX5fCSkOWXI3JyPZ+cHzD+BdQB
 +gzGDwvPO0LVyHhAskyoWAvhQqqrdnLwazac7Owew0uhRlc6JNaUexjwxQGizXkwFKoZdxz4a
 fKgsrX9qCTroP15qj7fuN2d5cboVDwtBI9p7Vzx9NNwJ71ilXJ+fMTWUU6KxmBqtIlvXc7z1W
 1FY3W+pka3i77u+Is7r2UbsrPFP6bzBjv7ZdZMFag+hpSwTr6K0Vx5RXMhmT/j1htgQ50Hyvt
 1iNFwBYxVVRT+Yo8HSOxS9jELCpSLtHO/C6DfR5nniHYE7EUJT3KQMCgRs2ke82FmZKiQTpI4
 M5SgRiBO/Rq7ya1f2hqPwoWqoRS+MBYFYlOMsobt+3nIQWa6UotSZ5RnMXKiQUI4V/TcYic
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


