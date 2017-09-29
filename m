Received: from eggs.gnu.org ([2001:4830:134:3::10]:53420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF7-0005ws-8d
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF6-0007lf-8d
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:05 -0400
Received: from mifritscher.de ([188.40.170.105]:32956
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtF6-0007kv-1P
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:04 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:10 +0200
Message-Id: <20170929111323.6308-6-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 05/18] Add definitions for 9p.c.
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
Cc: Michael Fritscher <michael@fritscher.net>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Michael Fritscher <michael@fritscher.net>
---
 include/sysemu/os-win32.h | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index 15cc94513b..d344516987 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -222,4 +222,50 @@ struct statfs {
     __fsword_t f_frsize;
     __fsword_t f_flags;
 };
+
+/* from http://octave.org/doxygen/3.4/fcntl_8h.html */
+#define O_NOCTTY 0
+#define O_NDELAY 0
+#define O_NONBLOCK O_NDELAY
+#define O_DSYNC 0
+#define O_DIRECT 0
+#define O_DIRECTORY 0
+#define O_NOFOLLOW 0
+#define O_NOATIME 0
+#define O_SYNC 0
+#define O_ASYNC 0
+
+#define FASYNC 0
+
+#define AT_REMOVEDIR 1
+
+#define NAME_MAX 260
+
+/* from linux/limits.h */
+#define XATTR_SIZE_MAX 65536
+
+/* from linux/kdev_t.h */
+#define MINORBITS 20
+#define MINORMASK ((1U << MINORBITS) - 1)
+
+#define major(dev) ((unsigned int) ((dev) >> MINORBITS))
+#define minor(dev) ((unsigned int) ((dev) & MINORMASK))
+#define makedev(ma, mi) (((ma) << MINORBITS) | (mi))
+
+/* from linux/include/linux/stat.h */
+#define UTIME_NOW ((1l << 30) - 1l)
+#define UTIME_OMIT ((1l << 30) - 2l)
+
+/* from uapi/linux/stat.h */
+#define S_IFSOCK 0140000
+#define S_IFLNK  0120000
+#define S_ISUID  0004000
+#define S_ISGID  0002000
+#define S_ISVTX  0001000
+
+#define S_ISLNK(m)  (((m) & S_IFMT) == S_IFLNK)
+#define S_ISSOCK(m) (((m) & S_IFMT) == S_IFSOCK)
+
+/* from glibc/dirent/dirent.h */
+#define DT_UNKNOWN 0
 #endif
-- 
2.13.2.windows.1
