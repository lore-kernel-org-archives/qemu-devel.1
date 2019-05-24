Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF58DC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B481E217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B481E217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52785 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU8Qu-0002OM-Ta
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 07:32:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8Kl-0005VY-M4
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8Kk-00016n-CO
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:59 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:56361)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hU8Kk-00015t-2k
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:58 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MIxBc-1hE7uX2oIs-00KLxV; Fri, 24 May 2019 13:25:27 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 13:25:13 +0200
Message-Id: <20190524112520.17684-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524112520.17684-1-laurent@vivier.eu>
References: <20190524112520.17684-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xh6Sa+2nA5IJIw6duJjLbQWWY83kKZ7wbiyhA1zFQk+M7MZ2sSi
	q/3g1sa8zGf4oq+nBDmzXxAzml1R2gQ0mgrffuspRfx6TQYYBE5DKrDZbeN58uWnph+7v21
	Ho5DXeLUSUiw8Lw/4zSY+zEQeqO9aUD2yiRZbL3jeQtpVeRQC+Dpkh1M5zVb8M8hBJoQwWb
	wgisxbKJu7fqzhRAcwQhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vTBt5pFikrA=:ctiZ5RRbmbZHDB9++HuYjP
	38dYVcw9zTuaqrz+9D53PUkM1ecF0uBXmNJbdp3HBvdnyWcttTCyIEBn/yqeCrMvh/nY4DFjb
	NRLY4VsNnJXQWqe1sxfBJvHQFUPmc4opspipPZtowg9otqBMG3obtQQ/HVD3v7wQRfbuoLjhJ
	bvMnhpjNq6RPpQM9au1pwm6Qefo5m7iprvuGSUl9q50vJvObR/o/DlIlmqhhAn+HZcZ2TjtXI
	T/kcKxqApH4Fo0dcG50vb7xXqzbFKTHMgf1MwK3KwMnvy4fA4KYanaZC0vrad7qge+i2v2UG3
	KoWExqzFFJY61+/Is3CMJaBxhhi9L/W5c7oBlvpskCDKTBtpJ5xVRRp/SXqaez3SfOBw3dQml
	3PW0MgmWveJYs7xu+qDGnCFP9pqmMgoWcv2h8yZkzUleepMgI7CSXBnOAeHwUPVbYi/kmuGvK
	aX6V7scP7VrWoPSbQtcgJ5sJwI6/gosf3Tx4KOmpca3luYmASfME46G+q7h0VEZk+i86xzTkm
	/LsJoKqHEEZeirX05Du0ko5aflwiqc54CVJVZJKOKOII/T0FM8FSdfQRVXYHNZJgh9KVVuHyC
	PoH3aWHqLCX2c8DZn14KlvK1jxvuqFKpKSCBgo9Yt7kg0aLkiDUR5xG9ywxqPXEdTaXgKPtFR
	3OeX6m1iiwetDdQggdfdL7JgK16WDu2NJvZuuPDWVX/4vfZjJEqmheJSy/M4gsdK0xW/StC0h
	AhYL+hSISxWX/L/E8sUaPsZ0vikNtwOixJNWfQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: [Qemu-devel] [PULL v2 2/9] linux-user: add pseudo /proc/hardware
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


