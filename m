Received: from eggs.gnu.org ([209.51.188.92]:43995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvo-00043I-Ie
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvn-0007U0-Co
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:16 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:47513)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h1pvm-0007Sx-TG
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:15 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  7 Mar 2019 11:06:55 +0100
Message-Id: <20190307100656.14044-9-laurent@vivier.eu>
In-Reply-To: <20190307100656.14044-1-laurent@vivier.eu>
References: <20190307100656.14044-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 8/9] linux-user: Nicer strace output of chroot()
 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Helge Deller <deller@gmx.de>

From: Helge Deller <deller@gmx.de>

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Message-Id: <20190227191115.GA20163@ls3530.dellerweb.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 12 ++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 7318392e571c..6f72a74c0918 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1235,6 +1235,18 @@ print_chdir(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_chroot
+static void
+print_chroot(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_chmod
 static void
 print_chmod(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index ff8bb19f5fac..db21ce41779f 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -77,7 +77,7 @@
 { TARGET_NR_chown32, "chown32" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_chroot
-{ TARGET_NR_chroot, "chroot" , NULL, NULL, NULL },
+{ TARGET_NR_chroot, "chroot" , NULL, print_chroot, NULL },
 #endif
 #ifdef TARGET_NR_clock_adjtime
 { TARGET_NR_clock_adjtime, "clock_adjtime" , NULL, print_clock_adjtime, NULL },
-- 
2.20.1
