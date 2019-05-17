Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D9DC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801982082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801982082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48764 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRd2A-0001B2-Kd
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:36:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hRcy3-0007Aw-9o
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hRcy2-0000XA-Bw
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:32:11 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:39407)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hRcy2-0000VP-2x
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:32:10 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1Mr8zO-1guz3B4Bi2-00oDg1; Fri, 17 May 2019 15:32:00 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 15:31:48 +0200
Message-Id: <20190517133149.19593-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517133149.19593-1-laurent@vivier.eu>
References: <20190517133149.19593-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Nnc41dw8F/dFUZKrbCJ9ZgA3Q2Glc6oel3h6CJGGMhh1WLawAZq
	PQONU5xstz6jGsaaSReiLi7sTfH/liz8d9Gd2PIq4vbFg0Pjj3T+3woaZuJ4ZciTxdrhefl
	3DyKIQhnuD+lhFwp5H6+TaUuQYF0K29Yw0P/1qBJYinOVeJpd6i6y/+ULr0kJijEiHPavTQ
	wCsdUQMBqz2kKigr3DkjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QwPFyUSlt2c=:3pn9pxOKH7gZdOIuDKnKlG
	xT3UAFOdAzd2H5GfkZp/QugTXqvJa75c9R4mUgTJGTwkrM9j363XODsvGvcH52GcNE5aJqbj/
	eXlHB0MtoT/YY29VDJRuyvcq0S6/1hQG842oPguO281iU2r7xS2mvHJJZ9GVhr8gPQHLI8Jnd
	ZMAIOtQ38UpCSgrhY7VsSyO/25PUmpl44UimuIUbteOeU2zIyeHyuSiBvZDUxSdYOzrgh4v8u
	FVVv6cwLTOnFGTCUFs6jOLwwWUqkGAtOMr5IXJJ7PRwn7ja2BhBsBSgU4boksN9ry8dKVI6I5
	CXwaFP5mleQdW8jTWfSo//gjgMsDPDkq+w0QyGfYbG2qUised8vPvOzpHO+/iis82uktOw6GZ
	pgTpE4r/p3eg79KaW5FUbYcFt0Nx74Uz7l9bO/lxSdaC/uLiC7c9q5DIB6oo1+cd7dCvdopho
	0nqGabVsKrDFQcH9QHRuaRTtxHZJYAx04S1n4V8kmtEdXVEB00EgGS796F+Ac1ohCeZ91sH/E
	MoQKRrdK+S+F9E93I62+hs/YQ+7U35pnA71yUr3uUfCPK/u/r36nXSrsmTk61WDr5p2+EmyFO
	amXyqqoYyBk6ixzgwyP38MKhvF6XzAY+R8gpRmW81Aw4kG4ol4ao9AFKOSiwQ/3/iWcOMMiVT
	AB+HQvxb+owt0zTgTk7HrcOhUe6OUeqrg1oV9ilT/g1pbF148ufpDY+Z334lYlZSlWzzB39pB
	dhAVgkRgr9Ba8J2nF8CMmYzdvSNtRvec5Fl7AQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: [Qemu-devel] [PATCH v2 1/2] linux-user: add pseudo /proc/cpuinfo
 for sparc
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
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
---
 linux-user/syscall.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f5ff6f5dc8a8..43b1b106765c 100644
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


