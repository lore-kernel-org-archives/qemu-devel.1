Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54DCC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49599206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49599206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38073 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTp2F-0000PW-Bs
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:49:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTowu-0004Co-DP
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTowt-0006CJ-Ab
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:04 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTowt-0006AN-0x
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:03 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1M8QiW-1hYCej2X6e-004PLo; Thu, 23 May 2019 16:43:41 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:43:27 +0200
Message-Id: <20190523144336.13960-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523144336.13960-1-laurent@vivier.eu>
References: <20190523144336.13960-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EYyeMyp13uTmvGMZg2AihT1bSicFMtThF1qZgcvqF+R+MAkVtRG
	DKO+yke/QNIOaUjVTWiTJ7HuHl0tFxqQ9yK/1qel8x9HDu5C8PpMfuE8bag+1rXXHjuewDi
	lUIzXjj2vlnLrcBnHQGx8+96ojjTxRr/VzKP55b6lYbps3IIIAmQcAlizYmkoQaTfJWK9xC
	AnOjiTAKbgJtAnput3eSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uYaPZKay5ao=:3rB1mJ2rhCqGcu39c3BwNT
	n2MUHynEd0HPyeP1UkLfJ6RBCaAKoU3QIKFLHq86E5S/Z/LYQN6vMFCNRqJkEH4tKqWsoluHk
	aGoQbkBD/8QQ5xwY4juckJ31haheKBZZnQB69OGhHXj8h6hV6T7ODhtQmNqhkOTEzBFUJjGDj
	3LUzE5YpOp9u7uWeoWA2zBlkphrStYEeCAWRUd1HIBGh0YgEO8hWG92Ur7KpbMRph/oNluF/I
	tMDI7kcB8YjlOnZe9IR4vz0Oq50TpWloIguU7cSPdBGJvwxiO3dbFgX8KF9yHNyxKC96t28tm
	fD1208ttR15BFZE/WO6OaHKgjlz/Otf0mj5WUr5qNcFXQ27e93Tg8Y+M28j48nfXvsFbxpw+T
	7twEovAMrwZDzhiqEVgHk3nI0y7G7f083tfm7WbOYqGTA/nWiNfVi+oHdByoz4fOk751VewsN
	WpfrpLhl9v21jOFf7HgY1HbswMHDgJzDmRBL1IgReMR3MBfpjNtr+o439yHUuMBDTfmlR+6pR
	3T11zOIqfPRtC9ydfTiH2PsEsEiAb6UPAE7wkRP68RXF5u1PjQORqh86tmuGen7msnTCPMN5l
	DF+bLeDew9XJ3toZfCSk9kCt0Z8+QPl2crQFmJR4KR1pob6OMf59KJls+te+0YwAwEqNSkAXg
	sNKVcjzyfdTmfzviYyCGK7KPZ0qgOx3qMWyLN3+uXtIjq8HIG6KYCpPpRnfdzkOXFIEys3JCw
	VqG1elHsS13yCWbmsn6YEILXrfP0mkl9zJk0OA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: [Qemu-devel] [PULL 01/10] linux-user: add pseudo /proc/cpuinfo for
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


