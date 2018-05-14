Received: from eggs.gnu.org ([2001:4830:134:3::10]:54732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fII4a-0005E4-ID
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fII4W-0005EX-Bc
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:19:48 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:47607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fII4W-0005Cs-2K
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:19:44 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 14 May 2018 20:19:27 +0200
Message-Id: <20180514181928.18034-7-laurent@vivier.eu>
In-Reply-To: <20180514181928.18034-1-laurent@vivier.eu>
References: <20180514181928.18034-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 6/7] linux-user: fix UNAME_MACHINE for
 sparc/sparc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

"sun4" is not recognized by config.guess.
linux defines sparc and sparc64 in arch/sparc/Makefile.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Message-Id: <20180509231123.20864-7-laurent@vivier.eu>
---
 linux-user/sparc/target_syscall.h   | 2 +-
 linux-user/sparc64/target_syscall.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/sparc/target_syscall.h b/linux-user/sparc/target_syscall.h
index 3725875fcf..b9160a771b 100644
--- a/linux-user/sparc/target_syscall.h
+++ b/linux-user/sparc/target_syscall.h
@@ -11,7 +11,7 @@ struct target_pt_regs {
 	abi_ulong u_regs[16];
 };
 
-#define UNAME_MACHINE "sun4"
+#define UNAME_MACHINE "sparc"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
 /* SPARC kernels don't define this in their Kconfig, but they have the
diff --git a/linux-user/sparc64/target_syscall.h b/linux-user/sparc64/target_syscall.h
index 34f49df4a1..3073a23e03 100644
--- a/linux-user/sparc64/target_syscall.h
+++ b/linux-user/sparc64/target_syscall.h
@@ -12,7 +12,7 @@ struct target_pt_regs {
 	abi_ulong fprs;
 };
 
-#define UNAME_MACHINE "sun4u"
+#define UNAME_MACHINE "sparc64"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
 /* SPARC kernels don't define this in their Kconfig, but they have the
-- 
2.14.3
