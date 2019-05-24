Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCC8C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65EE217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65EE217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52734 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU8OI-00005j-V0
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 07:29:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8Ke-0005GI-VF
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8Kd-000120-Ts
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:52 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38207)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hU8Kd-00011U-Ke
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:51 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1N1Oft-1gVkfU03n1-012nSm; Fri, 24 May 2019 13:25:27 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 13:25:12 +0200
Message-Id: <20190524112520.17684-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524112520.17684-1-laurent@vivier.eu>
References: <20190524112520.17684-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZVJYp+Pllff+VmZhbOP76AzxDzdoZoTwwGTC5KpDvz8SNllhHJ+
	dvaiBIkjt5RqKtjHVsBf1qZIzcfbJ/dYDiumlEJ8t2A/zG3E0X2+Dsewg5nRWfbmbGkNiO4
	XNXzGfJkhWDlXR7i5rFCwpjLFKPYI5KzHpzWN83EV67EQGWbS2w+E54nrUvqEifrHxnuKzP
	VIIYq2FVw/zBRMfyUULBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UJA3Ia/IE0E=:adhDTI+EvNq2snAh8G9tye
	SoBvaT0zh94DeLvNExBmHG0W7KGEdsh1uNjUgbx5LPSAkFvqLXMT9Gf42SOfkRI7UZORWNivz
	5f/A7h/82NTVQbsfCDJP2UPf6242GNuFDlVM7HXNXIbJcbkLf+cuz2tlRXg6s+ZLEaORH/rfe
	X0Zo1Ld+AgwYXdir12fMaj3qe+EgrDeYR3Em6kec/CZNF1LfSVk4SBExBaFLe0sqzCCcjOu+N
	wffU804vhKb/nUr7NxMvt7NUBRXDP9KwrXV4sOSF+OMCbvKanFR/udVlif7Ar4RH5jxeOsGLW
	d3hMoMOjSXVqpi0lZrCpBVLQj7dONzsTd6S9gd6Lsb37WeUHcsBEIw9gWA237jtTx8Uhns0zX
	5mu8ym27lXZ156pwD99UrzZRZNconjdiJczfbsD1h3jDymXYHoXmObCpitgXAiGEOhJ5QUm+r
	5pS2MnZ5eE094hl2t41z/7ZDhdebPBXpsqyEFGDbytuoifHHYeihmRRIb5LMAWJBFkHgj/2vz
	2Eae5I179F6aL/vt2sRvldODPdYcasYYCasvcHY4cm2dLF2ngbdPD6J2zuZX0uFNXccsfX0q2
	iLqilur46Am6U/BrbT0FhsTPdx/Hh4fe6rQveVdqHf9VvClJ/vi5CzgjbcmSG/Wu3w8q3KhiX
	gGCVTUR4vtZnoVLq7AZj2Jgr5PkkHgZ4nv2yBOJRtq2jHUxfb/XOQKSfJhb0i0Yo8Lc1WYYCX
	7ZPSwqB3SFBApn27s1svouAu4/5rrM0crJwsWg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL v2 1/9] linux-user: add pseudo /proc/cpuinfo for
 sparc
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
	Richard Henderson <richard.henderson@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SPARC libc6 debian package wants to check the cpu level to be
installed or not:

  WARNING: This machine has a SPARC V8 or earlier class processor.
  Debian lenny and later does not support such old hardware
  any longer.

To avoid this, it only needs to know if the machine type is sun4u or sun4v,
for that it reads the information from /proc/cpuinfo.

Fixes: 9a93c152fcdb4ab2cd85094487b33578fd693915
       ("linux-user: fix UNAME_MACHINE for sparc/sparc64")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190517133149.19593-2-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index efa3ec283706..68484a83e69e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6786,12 +6786,15 @@ static int is_proc_myself(const char *filename, const char *entry)
     return 0;
 }
 
-#if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
+#if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN) || \
+    defined(TARGET_SPARC)
 static int is_proc(const char *filename, const char *entry)
 {
     return strcmp(filename, entry) == 0;
 }
+#endif
 
+#if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
 static int open_net_route(void *cpu_env, int fd)
 {
     FILE *fp;
@@ -6836,6 +6839,14 @@ static int open_net_route(void *cpu_env, int fd)
 }
 #endif
 
+#if defined(TARGET_SPARC)
+static int open_cpuinfo(void *cpu_env, int fd)
+{
+    dprintf(fd, "type\t\t: sun4u\n");
+    return 0;
+}
+#endif
+
 static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags, mode_t mode)
 {
     struct fake_open {
@@ -6851,6 +6862,9 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
         { "cmdline", open_self_cmdline, is_proc_myself },
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
         { "/proc/net/route", open_net_route, is_proc },
+#endif
+#if defined(TARGET_SPARC)
+        { "/proc/cpuinfo", open_cpuinfo, is_proc },
 #endif
         { NULL, NULL, NULL }
     };
-- 
2.20.1


