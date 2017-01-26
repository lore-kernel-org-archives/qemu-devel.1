Received: from eggs.gnu.org ([2001:4830:134:3::10]:47394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWf3T-0005k4-N0
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWf3P-0003f0-0k
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:15 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:65219)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cWf3O-0003eF-Ms
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:10 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 26 Jan 2017 09:04:49 +0100
Message-Id: <20170126080449.28255-4-laurent@vivier.eu>
In-Reply-To: <20170126080449.28255-1-laurent@vivier.eu>
References: <20170126080449.28255-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v3 3/3] linux-user: define correct UTS machine
 name for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

the correct UTS machine name (as expected by systemd) is "parisc",
not "hppa".

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/hppa/target_syscall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/hppa/target_syscall.h b/linux-user/hppa/target_syscall.h
index ac18a9c..e2f3668 100644
--- a/linux-user/hppa/target_syscall.h
+++ b/linux-user/hppa/target_syscall.h
@@ -19,7 +19,7 @@ struct target_pt_regs {
     target_ulong ipsw;
 };
 
-#define UNAME_MACHINE "hppa"
+#define UNAME_MACHINE "parisc"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 #define TARGET_CLONE_BACKWARDS
 #define TARGET_MINSIGSTKSZ       2048
-- 
2.9.3
