Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97034C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F7A5205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7A5205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52787 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU8RP-0002sS-HE
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 07:32:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8Kq-0005fF-55
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8Ko-00018h-Jt
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:26:04 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:48539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hU8Ko-00018N-Au
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:26:02 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MfHIb-1h0ZCn3K1b-00gqke; Fri, 24 May 2019 13:25:35 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 13:25:20 +0200
Message-Id: <20190524112520.17684-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524112520.17684-1-laurent@vivier.eu>
References: <20190524112520.17684-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4j1ecWKpqLKYUxdxC0tcLTys1b+Lw2sDx0SnmC/BtVKQhKpXT/+
	NHc2FBWZ6DsKM4IM/wrybN/d+6Dgn3MdHxBWXDTQ/1bi71wwaHR5z+ABciRj/3Nvs21uszL
	vC7VZOz1CNRmW7R6RqKc6HTyvHCzMkCe93dDS6pdeZ/r6gpZGUASRPh/Q8sIqD6Sgl7QwgE
	PptcDBAO5Luk1GPY2ZpVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:enTuKS2fygo=:mqUUFl2tnsBdr/n6zU+L4I
	mt6BAnDm0ZB+rUQMmH5SuSG3Q7Sa4x+4IZSaeJuLFfdcE8DDgSeEPhjPwmUPqlD3LPAPifnv7
	At5XagS28yNxBYLnFf5ylISRxipzSjx3J30/eAmkFFpGx8cFTk/b2rZrDJzJTX0In9mAfJdXp
	z30wU00GtQis2B1R54NBaO8IVDRpp93m55sSoXlFHc4Xfqz0a8B2cOaMb6CcvYCD+iikqQHmn
	N8ZzHc6r2awa4lzCb73qtVvp2vrv6BPdaFAK571s09/Vl4vkvn+RINoaFCPbc3OphGGlauR2F
	rVLoYQJn5jIAL39wuM9fSViShlL9J7MysIA0V+Zm+xbu0Nw5Htt/MeEcmEsGsHrl5t348Bp6Z
	GjhKHQ7eoORmS30TR/1n70CPJ9zKPpigGcIB2XhS+RYjkqwZ7gzEzvbdx4vlxjmCn6lXAUbuq
	aQv+uwX4K9enU4oCK7k88MC2Hmo5bpcolXvauCqWOxzPSuZqtnEUEu9WzjqCVQkPZlJKcp0VR
	v7Mxa6zhO/aYiYc1F9n7ZMr+xQplCOk3h0AWqpeO975qH2KkZRphumVI1qCKOn/FA86HY7l8Q
	F23d42kxX9H/kzv2wh/Z4dScu9Mngrpf08D815Z+I1RN/3BtAx1L7eyb/Rb27fVy1HXwpwtv/
	9xuFL/Pw17IqFG3GCHeJkx3/MId0e1oSK5b+PG+kIZuilbGVgFRi+9S4nn2adcecBQY+axzSm
	4G398umrlebckzX0iWniSsrTvyUD8CwMqmk2XQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL v2 9/9] linux-user: Pass through nanosecond
 timestamp components for stat syscalls
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>, Chen-Yu Tsai <wens@csie.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen-Yu Tsai <wens@csie.org>

Since Linux 2.6 the stat syscalls have mostly supported nanosecond
components for each of the file-related timestamps.

QEMU user mode emulation currently does not pass through the nanosecond
portion of the timestamp, even when the host system fills in the value.
This results in a mismatch when run on subsecond resolution filesystems
such as ext4 or XFS.

An example of this leading to inconsistency is cross-debootstraping a
full desktop root filesystem of Debian Buster. Recent versions of
fontconfig store the full timestamp (instead of just the second portion)
of the directory in its per-directory cache file, and checks this against
the directory to see if the cache is up-to-date. With QEMU user mode
emulation, the timestamp stored is incorrect, and upon booting the rootfs
natively, fontconfig discovers the mismatch, and proceeds to rebuild the
cache on the comparatively slow machine (low-power ARM vs x86). This
stalls the first attempt to open whatever application that incorporates
fontconfig.

This patch renames the "unused" padding trailing each timestamp element
to its nanosecond counterpart name if such an element exists in the
kernel sources for the given platform. Not all do. Then have the syscall
wrapper fill in the nanosecond portion if the host supports it, as
specified by the _POSIX_C_SOURCE and _XOPEN_SOURCE feature macros.

Recent versions of glibc only use stat64 and newfstatat syscalls on
32-bit and 64-bit platforms respectively. The changes in this patch
were tested by directly calling the stat, stat64 and newfstatat syscalls
directly, in addition to the glibc wrapper, on arm and aarch64 little
endian targets.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Message-Id: <20190522162147.26303-1-wens@kernel.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c      | 19 +++++++++++++++
 linux-user/syscall_defs.h | 49 +++++++++++++++++++++++++--------------
 2 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 51cc049e064f..0d6c764502c3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6409,6 +6409,11 @@ static inline abi_long host_to_target_stat64(void *cpu_env,
         __put_user(host_st->st_atime, &target_st->target_st_atime);
         __put_user(host_st->st_mtime, &target_st->target_st_mtime);
         __put_user(host_st->st_ctime, &target_st->target_st_ctime);
+#if _POSIX_C_SOURCE >= 200809L || _XOPEN_SOURCE >= 700
+        __put_user(host_st->st_atim.tv_nsec, &target_st->target_st_atime_nsec);
+        __put_user(host_st->st_mtim.tv_nsec, &target_st->target_st_mtime_nsec);
+        __put_user(host_st->st_ctim.tv_nsec, &target_st->target_st_ctime_nsec);
+#endif
         unlock_user_struct(target_st, target_addr, 1);
     } else
 #endif
@@ -6439,6 +6444,11 @@ static inline abi_long host_to_target_stat64(void *cpu_env,
         __put_user(host_st->st_atime, &target_st->target_st_atime);
         __put_user(host_st->st_mtime, &target_st->target_st_mtime);
         __put_user(host_st->st_ctime, &target_st->target_st_ctime);
+#if _POSIX_C_SOURCE >= 200809L || _XOPEN_SOURCE >= 700
+        __put_user(host_st->st_atim.tv_nsec, &target_st->target_st_atime_nsec);
+        __put_user(host_st->st_mtim.tv_nsec, &target_st->target_st_mtime_nsec);
+        __put_user(host_st->st_ctim.tv_nsec, &target_st->target_st_ctime_nsec);
+#endif
         unlock_user_struct(target_st, target_addr, 1);
     }
 
@@ -8892,6 +8902,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 __put_user(st.st_atime, &target_st->target_st_atime);
                 __put_user(st.st_mtime, &target_st->target_st_mtime);
                 __put_user(st.st_ctime, &target_st->target_st_ctime);
+#if (_POSIX_C_SOURCE >= 200809L || _XOPEN_SOURCE >= 700) && \
+    defined(TARGET_STAT_HAVE_NSEC)
+                __put_user(st.st_atim.tv_nsec,
+                           &target_st->target_st_atime_nsec);
+                __put_user(st.st_mtim.tv_nsec,
+                           &target_st->target_st_mtime_nsec);
+                __put_user(st.st_ctim.tv_nsec,
+                           &target_st->target_st_ctime_nsec);
+#endif
                 unlock_user_struct(target_st, arg2, 1);
             }
         }
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index cb40620114f8..7f141f699c1a 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1185,6 +1185,7 @@ struct target_winsize {
 #if (defined(TARGET_I386) && defined(TARGET_ABI32)) \
     || (defined(TARGET_ARM) && defined(TARGET_ABI32)) \
     || defined(TARGET_CRIS)
+#define TARGET_STAT_HAVE_NSEC
 struct target_stat {
 	unsigned short st_dev;
 	unsigned short __pad1;
@@ -1199,11 +1200,11 @@ struct target_stat {
 	abi_ulong  st_blksize;
 	abi_ulong  st_blocks;
 	abi_ulong  target_st_atime;
-	abi_ulong  __unused1;
+	abi_ulong  target_st_atime_nsec;
 	abi_ulong  target_st_mtime;
-	abi_ulong  __unused2;
+	abi_ulong  target_st_mtime_nsec;
 	abi_ulong  target_st_ctime;
-	abi_ulong  __unused3;
+	abi_ulong  target_st_ctime_nsec;
 	abi_ulong  __unused4;
 	abi_ulong  __unused5;
 };
@@ -1235,13 +1236,13 @@ struct target_stat64 {
 	abi_ulong	__pad4;		/* future possible st_blocks high bits */
 
 	abi_ulong	target_st_atime;
-	abi_ulong	__pad5;
+	abi_ulong	target_st_atime_nsec;
 
 	abi_ulong	target_st_mtime;
-	abi_ulong	__pad6;
+	abi_ulong	target_st_mtime_nsec;
 
 	abi_ulong	target_st_ctime;
-	abi_ulong	__pad7;		/* will be high 32 bits of ctime someday */
+	abi_ulong	target_st_ctime_nsec;
 
 	unsigned long long	st_ino;
 } QEMU_PACKED;
@@ -1320,19 +1321,20 @@ struct target_stat64 {
 	unsigned int	st_blocks;
 
 	abi_ulong	target_st_atime;
-	abi_ulong	__unused1;
+	abi_ulong	target_st_atime_nsec;
 
 	abi_ulong	target_st_mtime;
-	abi_ulong	__unused2;
+	abi_ulong	target_st_mtime_nsec;
 
 	abi_ulong	target_st_ctime;
-	abi_ulong	__unused3;
+	abi_ulong	target_st_ctime_nsec;
 
 	abi_ulong	__unused4[3];
 };
 
 #elif defined(TARGET_SPARC)
 
+#define TARGET_STAT_HAVE_NSEC
 struct target_stat {
 	unsigned short	st_dev;
 	abi_ulong	st_ino;
@@ -1343,14 +1345,14 @@ struct target_stat {
 	unsigned short	st_rdev;
 	abi_long	st_size;
 	abi_long	target_st_atime;
-	abi_ulong	__unused1;
+	abi_ulong	target_st_atime_nsec;
 	abi_long	target_st_mtime;
-	abi_ulong	__unused2;
+	abi_ulong	target_st_mtime_nsec;
 	abi_long	target_st_ctime;
-	abi_ulong	__unused3;
+	abi_ulong	target_st_ctime_nsec;
 	abi_long	st_blksize;
 	abi_long	st_blocks;
-	abi_ulong	__unused4[2];
+	abi_ulong	__unused1[2];
 };
 
 #define TARGET_HAS_STRUCT_STAT64
@@ -1378,20 +1380,21 @@ struct target_stat64 {
 	unsigned int	st_blocks;
 
 	unsigned int	target_st_atime;
-	unsigned int	__unused1;
+	unsigned int	target_st_atime_nsec;
 
 	unsigned int	target_st_mtime;
-	unsigned int	__unused2;
+	unsigned int	target_st_mtime_nsec;
 
 	unsigned int	target_st_ctime;
-	unsigned int	__unused3;
+	unsigned int	target_st_ctime_nsec;
 
-	unsigned int	__unused4;
-	unsigned int	__unused5;
+	unsigned int	__unused1;
+	unsigned int	__unused2;
 };
 
 #elif defined(TARGET_PPC)
 
+#define TARGET_STAT_HAVE_NSEC
 struct target_stat {
 	abi_ulong st_dev;
 	abi_ulong st_ino;
@@ -1449,6 +1452,7 @@ struct QEMU_PACKED target_stat64 {
 
 #elif defined(TARGET_MICROBLAZE)
 
+#define TARGET_STAT_HAVE_NSEC
 struct target_stat {
 	abi_ulong st_dev;
 	abi_ulong st_ino;
@@ -1564,6 +1568,7 @@ struct target_stat64 {
 
 #elif defined(TARGET_ABI_MIPSN64)
 
+#define TARGET_STAT_HAVE_NSEC
 /* The memory layout is the same as of struct stat64 of the 32-bit kernel.  */
 struct target_stat {
 	unsigned int		st_dev;
@@ -1603,6 +1608,7 @@ struct target_stat {
 
 #elif defined(TARGET_ABI_MIPSN32)
 
+#define TARGET_STAT_HAVE_NSEC
 struct target_stat {
         abi_ulong    st_dev;
         abi_ulong    st_pad0[3]; /* Reserved for st_dev expansion */
@@ -1627,6 +1633,7 @@ struct target_stat {
 
 #elif defined(TARGET_ABI_MIPSO32)
 
+#define TARGET_STAT_HAVE_NSEC
 struct target_stat {
 	unsigned	st_dev;
 	abi_long	st_pad1[3];		/* Reserved for network id */
@@ -1743,6 +1750,7 @@ struct target_stat64 {
 
 #elif defined(TARGET_SH4)
 
+#define TARGET_STAT_HAVE_NSEC
 struct target_stat {
 	abi_ulong  st_dev;
 	abi_ulong  st_ino;
@@ -1802,6 +1810,7 @@ struct QEMU_PACKED target_stat64 {
 };
 
 #elif defined(TARGET_I386) && !defined(TARGET_ABI32)
+#define TARGET_STAT_HAVE_NSEC
 struct target_stat {
 	abi_ulong	st_dev;
 	abi_ulong	st_ino;
@@ -1847,6 +1856,7 @@ struct target_stat {
     abi_ulong  __unused[3];
 };
 #elif defined(TARGET_AARCH64)
+#define TARGET_STAT_HAVE_NSEC
 struct target_stat {
     abi_ulong  st_dev;
     abi_ulong  st_ino;
@@ -1869,6 +1879,7 @@ struct target_stat {
     unsigned int __unused[2];
 };
 #elif defined(TARGET_XTENSA)
+#define TARGET_STAT_HAVE_NSEC
 struct target_stat {
     abi_ulong       st_dev;
     abi_ulong       st_ino;
@@ -1918,6 +1929,7 @@ struct target_stat64  {
 
 /* These are the asm-generic versions of the stat and stat64 structures */
 
+#define TARGET_STAT_HAVE_NSEC
 struct target_stat {
     abi_ulong st_dev;
     abi_ulong st_ino;
@@ -1969,6 +1981,7 @@ struct target_stat64 {
 
 #elif defined(TARGET_HPPA)
 
+#define TARGET_STAT_HAVE_NSEC
 struct target_stat {
     abi_uint   st_dev;
     abi_uint   st_ino;
-- 
2.20.1


