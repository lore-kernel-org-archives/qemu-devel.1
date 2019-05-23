Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3B0C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839AB20863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839AB20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38194 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTp7E-0003zT-KX
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:54:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTowy-0004IG-LD
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTowx-0006L9-J6
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:08 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:38177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTowx-0006I2-A0
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:07 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MBUZr-1hLpGT18L1-00Cz0V; Thu, 23 May 2019 16:43:42 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:43:28 +0200
Message-Id: <20190523144336.13960-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523144336.13960-1-laurent@vivier.eu>
References: <20190523144336.13960-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sFzFbFoTTJSxzKzFxiZe8nYkdCweOxthZPnT7LndP08mK1zExTN
	B4EMM41/Kzw+ea1Ld4wmXebE6O6PkljKXcm0dryf3bzfmZi74YnsaBLdgDxaXOolg+TkL/C
	jet4Dhmkg5EjO/wl0ssC8wSxOdRzzRiMVhnwrhcj6K/7ZupU4UUpPvPcSnFuaUG11BLriV7
	ARsCXmDpHK5mHd7iK4S9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PQAGtdmxa/c=:8Yf0CI+3PSlK+BKRuqol1I
	HbSeR2KWYRWNENp7thVErmnQQ6aIw+W9Sn8loBC7V30Ya3/paIoxVqnPhoPcCjqx3BoNXUiEH
	09r7g18vohLVjLwtS1UfPzRNF1x+72qJHVMZtS1DoBsbM48m1BhKgIf+rCik9qYOBHlVFqkh3
	ugWedr8lVZ/WVUgNYPMho1I47JvBiHW9nk5l7JjbZAh50wKAVRGSX9I0nDjK1+yUwVrNTN0cH
	CJrB23GWfbKr/tWHkQ3gLziSmjIqK0SwL/C3uTZdAtUlYg0aqskjc40VpIGly8WMmRh4/I0Z3
	b/k2Z2LdAgz1ZKekhe0jD9cdwgBQhcE4+pqALDmstfH2XY0z6tbThGL0z6p5JsqyyrcKuApmk
	Ewaso/NUqOLOr2YoWSxwMjIZu9xSrIXZhspdt1PWeQfP/+XDm8UoMuxgyNiV1VNOF17i7BcOi
	M1UbrsF69r0ORxR/XLn4mFhkVQYgz6U5D2N5EHZc9Ya+HwA7UgXhjTSka9LXHM+m0Kg9g6jqN
	q+E2/QQ9vL3yRSUy4jjB9HP46ubLQDL5iKh5f4Rpdf7kxhTdWd4AunKaPD8B2bHWWh9KpdmwY
	5+7ijiW3HGN02lqkpACJrSQHLEY5URY73UiiQOH5EhoEotiyNrTJ+Xt86hUqBJAjuaEDYFe5A
	JMEZms7ooaprh2siSwBHGL6mQknlJBGO8kI5fx3+hiqrizP3drdtGczykA5oy8ne7l3+Trc3q
	SmcSEkO43YlkW6G43QVbve3Xlk5L8h1ZUtyfiw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PULL 02/10] linux-user: add pseudo /proc/hardware for
 m68k
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

Debian console-setup uses /proc/hardware to guess the keyboard layout.
If the file /proc/hardware cannot be opened, the installation fails.

This patch adds a pseudo /proc/hardware file to report the model of
the machine. Instead of reporting a known and fake model, it
reports "qemu-m68k", which is true, and avoids to set the configuration
for an Amiga/Apple/Atari and let the user to chose the good one.

Bug: https://github.com/vivier/qemu-m68k/issues/34
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190517133149.19593-3-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 68484a83e69e..e5545cbafac7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6787,7 +6787,7 @@ static int is_proc_myself(const char *filename, const char *entry)
 }
 
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN) || \
-    defined(TARGET_SPARC)
+    defined(TARGET_SPARC) || defined(TARGET_M68K)
 static int is_proc(const char *filename, const char *entry)
 {
     return strcmp(filename, entry) == 0;
@@ -6847,6 +6847,14 @@ static int open_cpuinfo(void *cpu_env, int fd)
 }
 #endif
 
+#if defined(TARGET_M68K)
+static int open_hardware(void *cpu_env, int fd)
+{
+    dprintf(fd, "Model:\t\tqemu-m68k\n");
+    return 0;
+}
+#endif
+
 static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags, mode_t mode)
 {
     struct fake_open {
@@ -6865,6 +6873,9 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
 #endif
 #if defined(TARGET_SPARC)
         { "/proc/cpuinfo", open_cpuinfo, is_proc },
+#endif
+#if defined(TARGET_M68K)
+        { "/proc/hardware", open_hardware, is_proc },
 #endif
         { NULL, NULL, NULL }
     };
-- 
2.20.1


