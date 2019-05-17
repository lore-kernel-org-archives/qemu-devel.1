Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2D9C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA062082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA062082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRczk-0007vf-2b
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:33:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hRcxw-00077a-NP
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hRcxv-0000PA-MG
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:32:04 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:38211)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hRcxv-0000O5-Db
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:32:03 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1N0Fh1-1gUxhX1kwR-00xKLY; Fri, 17 May 2019 15:32:00 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 15:31:49 +0200
Message-Id: <20190517133149.19593-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517133149.19593-1-laurent@vivier.eu>
References: <20190517133149.19593-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MUxknIyAlww1SwVDciJLAafvYWAlnxkCPoZ4BNt5hBF/41lAK2r
	XoPVt9xO//K/COuscd/K0Eu4EZmKIjEMinhEWSm6TDgq/ewMDnhzWcR8Yt54u1x8WWHYSYG
	JbLqCmR1SXXB5Br1UGLOihFrXbgVH7bXlh1wraeO0Agnqp/MkCA8IIAhVsymdeg3xCdK44i
	AXiU3qtbBcJXSjEzw8Lqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Olv0kgpc8FQ=:6O/i3MAHrd/SA0VErQnKW5
	DdJbSW8ge2AwaDFzF1UM8dBC1b6FMR+QQntnRnFUXpJ6//Fumc7MpCFCdLTdYLtaZhxcix1Hd
	8W6YFldkHA7WfCwp8ONOYkPNLXLOB+nLT1Wj4c2QcmyR4MxWWi3gVUws7cSo3DaAg87bBeAID
	UGoO09eF4Jt1ISxgpKKOym8hux9FC4sARINxCfQh1k2v6XH5Stowj/qmFHCNUxWQJ1A8Wyqyg
	uDAc6LF34Qw3EDXinWn8HMGqqWEKozGUb6geZ917ITG9MbkUNz22HDG3cXrpwfDIQ7ZcPuWXj
	EHxI2tyW1HEiSk0GZJZq2tQnmMKU4FMbrt+RTXEOpGtHMWb9WZFlNzLVa7JyOzoIK3Zkpi4wf
	HVvwJCXmvJu3RP/r1/BV/HQMGj2m9U20dtoAT9ccnukghhK6UQpp0u8QAphj/C/xGi2Edk+4t
	eNhu41K3Bw/29AlXvIJV3tIwN/R44zxvqnV6aY7YQMG6i397E5GexQkUEYuvrppzu+7LdvLDr
	8Gxhi3YSZZsok1mDUQQEy419gmk0MlhQbayXzBH/4LgikeSLZ1F2yzH+Gh/f3TOkrJ1lRnhOi
	EXAiEYVzFbMbJ7Xc4eCcT0XAb9SJPuQVr0ZzbGckpkVkBVHc8thrERC/099m7AIVVUqxaOiyk
	UZ78phwOGDZIf1p/trCMiw8g6EmP/tF0O26r+rObIoKiqEJX5/tmsPXUKxZRugrqbdGOPvI0j
	0BTyipO5gKnjkqn1gCYPw4Xcrwbq0OqvjHWeCg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PATCH v2 2/2] linux-user: add pseudo /proc/hardware
 for m68k
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

Debian console-setup uses /proc/hardware to guess the keyboard layout.
If the file /proc/hardware cannot be opened, the installation fails.

This patch adds a pseudo /proc/hardware file to report the model of
the machine. Instead of reporting a known and fake model, it
reports "qemu-m68k", which is true, and avoids to set the configuration
for an Amiga/Apple/Atari and let the user to chose the good one.

Bug: https://github.com/vivier/qemu-m68k/issues/34
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 43b1b106765c..544fcd02be9a 100644
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


