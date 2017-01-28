Received: from eggs.gnu.org ([2001:4830:134:3::10]:37275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cXRj1-0006lg-5t
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 07:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cXRiw-0000Dy-9Z
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 07:03:23 -0500
Received: from mout.gmx.net ([212.227.15.15]:49233)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1cXRiv-0000De-Vx
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 07:03:18 -0500
Date: Sat, 28 Jan 2017 13:03:07 +0100
From: Helge Deller <deller@gmx.de>
Message-ID: <20170128120307.GA17532@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] linux-user: Add FICLONE and FICLONERANGE ioctls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Add missing FICLONE and FICLONERANGE ioctls.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 2f6e85b..eb1421d 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -112,6 +112,11 @@
 #ifdef FIBMAP
      IOCTL(FIBMAP, IOC_W | IOC_R, MK_PTR(TYPE_LONG))
 #endif
+#ifdef FICLONE
+     IOCTL(FICLONE, IOC_W, TYPE_INT)
+     IOCTL(FICLONERANGE, IOC_W, MK_PTR(MK_ARRAY(TYPE_ULONGLONG, 4)))
+#endif
+
 #ifdef FIGETBSZ
      IOCTL(FIGETBSZ, IOC_R, MK_PTR(TYPE_LONG))
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 4442c22..72ca5b1 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1086,6 +1086,10 @@ struct target_pollfd {
 
 #define TARGET_FIBMAP     TARGET_IO(0x00,1)  /* bmap access */
 #define TARGET_FIGETBSZ   TARGET_IO(0x00,2)  /* get the block size used for bmap */
+
+#define TARGET_FICLONE    TARGET_IOW(0x94, 9, int)
+#define TARGET_FICLONERANGE TARGET_IOW(0x94, 13, struct file_clone_range)
+
 /* Note that the ioctl numbers claim type "long" but the actual type
  * used by the kernel is "int".
  */
