Received: from eggs.gnu.org ([2001:4830:134:3::10]:58809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVykY-0004px-NH
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVykU-0006Sp-Eb
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:54:54 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:08 +0300
Message-Id: <425d343b84d90455510ac7786703f93d0a786293.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 04/31] Fix documentation and some comments
 (article, grammar)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 arch_init.c     | 2 +-
 qemu-doc.texi   | 2 +-
 qemu-options.hx | 2 +-
 util/uri.c      | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch_init.c b/arch_init.c
index 6c4e287..13d6c56 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -85,7 +85,7 @@ const uint32_t arch_type = QEMU_ARCH;
 
 static struct defconfig_file {
     const char *filename;
-    /* Indicates it is an user config file (disabled by -no-user-config) */
+    /* Indicates it is a user config file (disabled by -no-user-config) */
     bool userconfig;
 } default_config_files[] = {
     { CONFIG_QEMU_CONFDIR "/qemu.conf",                   true },
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 0b2746f..3840585 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1037,7 +1037,7 @@ qemu-system-i386 -iscsi initiator-name=iqn.qemu.test:my-initiator \
 @node disk_images_gluster
 @subsection GlusterFS disk images
 
-GlusterFS is an user space distributed file system.
+GlusterFS is a user space distributed file system.
 
 You can boot from the GlusterFS disk image with the command:
 @example
diff --git a/qemu-options.hx b/qemu-options.hx
index 232f737..82b9991 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2589,7 +2589,7 @@ qemu-system-i386 --drive file=sheepdog://192.0.2.1:30000/MyVirtualMachine
 See also @url{http://http://www.osrg.net/sheepdog/}.
 
 @item GlusterFS
-GlusterFS is an user space distributed file system.
+GlusterFS is a user space distributed file system.
 QEMU supports the use of GlusterFS volumes for hosting VM disk images using
 TCP, Unix Domain Sockets and RDMA transport protocols.
 
diff --git a/util/uri.c b/util/uri.c
index 70a9cbc..21b1828 100644
--- a/util/uri.c
+++ b/util/uri.c
@@ -342,7 +342,7 @@ rfc3986_parse_port(URI *uri, const char **str)
  * @uri:  pointer to an URI structure
  * @str:  the string to analyze
  *
- * Parse an user informations part and fills in the appropriate fields
+ * Parse a user information part and fill in the appropriate fields
  * of the @uri structure
  *
  * userinfo      = *( unreserved / pct-encoded / sub-delims / ":" )
@@ -508,7 +508,7 @@ rfc3986_parse_authority(URI *uri, const char **str)
 
     cur = *str;
     /*
-     * try to parse an userinfo and check for the trailing @
+     * try to parse a userinfo and check for the trailing @
      */
     ret = rfc3986_parse_user_info(uri, &cur);
     if ((ret != 0) || (*cur != '@'))
-- 
2.1.4
