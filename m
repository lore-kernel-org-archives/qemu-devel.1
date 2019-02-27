Received: from eggs.gnu.org ([209.51.188.92]:49686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1gz4c1-0005am-7k
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 14:11:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1gz4c0-0007ZV-Ir
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 14:11:25 -0500
Received: from mout.gmx.net ([212.227.15.19]:52511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1gz4bz-0007WB-36
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 14:11:24 -0500
Date: Wed, 27 Feb 2019 20:11:15 +0100
From: Helge Deller <deller@gmx.de>
Message-ID: <20190227191115.GA20163@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] linux-user: Nicer strace output of chroot()
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
Cc: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 7318392e57..6f72a74c09 100644
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
index ff8bb19f5f..db21ce4177 100644
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
