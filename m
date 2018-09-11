Received: from eggs.gnu.org ([2001:4830:134:3::10]:55780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzjJP-0008Qo-LU
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzjJN-0007Xf-2h
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:06:39 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fzjJM-0007WC-O7
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:06:36 -0400
Received: by mail-wm0-x242.google.com with SMTP id n11-v6so1147332wmc.2
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 07:06:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Sep 2018 15:06:30 +0100
Message-Id: <20180911140631.18481-4-alex.bennee@linaro.org>
In-Reply-To: <20180911140631.18481-1-alex.bennee@linaro.org>
References: <20180911140631.18481-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 3/4] linux-user/nios2: bump min uname to
 4.16.0 [!HACK]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: 1791796@bugs.launchpad.net, thuth@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

This is to work around the limitations of the buildroot
qemu_nios2_10m50_defconfig which sets the base kernel version for
glibc.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/nios2/target_syscall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/nios2/target_syscall.h b/linux-user/nios2/target_syscall.h
index ca6b7e69f6..905b80d112 100644
--- a/linux-user/nios2/target_syscall.h
+++ b/linux-user/nios2/target_syscall.h
@@ -2,7 +2,7 @@
 #define TARGET_SYSCALL_H
 
 #define UNAME_MACHINE "nios2"
-#define UNAME_MINIMUM_RELEASE "3.19.0"
+#define UNAME_MINIMUM_RELEASE "4.16.0"
 
 struct target_pt_regs {
     unsigned long  r8;    /* r8-r15 Caller-saved GP registers */
-- 
2.17.1
