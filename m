Received: from eggs.gnu.org ([2001:4830:134:3::10]:59913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6NG-0001bv-U5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6NG-0000ML-1V
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:01:54 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 30 Aug 2017 13:01:40 -0400
Message-Id: <d4c0b362206c19934110cc24a3e506018ac4421c.1504112256.git.jcody@redhat.com>
In-Reply-To: <cover.1504112256.git.jcody@redhat.com>
References: <cover.1504112256.git.jcody@redhat.com>
In-Reply-To: <cover.1504112256.git.jcody@redhat.com>
References: <cover.1504112256.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] configure: Add option in configure to
 disable live block ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, dgilbert@redhat.com, mrezanin@redhat.com, ehabkost@redhat.com, peterx@redhat.com, jsnow@redhat.com

From: Jeffrey Cody <jcody@redhat.com>

This adds in the option to disable the live block operations.  The
resultant config option is not checked until subsequent patches.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 configure | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configure b/configure
index dd73cce..24bde07 100755
--- a/configure
+++ b/configure
@@ -400,6 +400,7 @@ virglrenderer=""
 tpm="yes"
 libssh2=""
 live_block_migration="yes"
+live_block_ops="yes"
 numa=""
 tcmalloc="no"
 jemalloc="no"
@@ -1263,6 +1264,10 @@ for opt do
   ;;
   --enable-live-block-migration) live_block_migration="yes"
   ;;
+  --disable-live-block-ops) live_block_ops="no"
+  ;;
+  --enable-live-block-ops) live_block_ops="yes"
+  ;;
   --disable-numa) numa="no"
   ;;
   --enable-numa) numa="yes"
@@ -1513,6 +1518,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   smartcard       smartcard support (libcacard)
   libusb          libusb (for usb passthrough)
   live-block-migration   Block migration in the main migration stream
+  live-block-ops  live block operations support
   usb-redir       usb network redirection support
   lzo             support of lzo compression library
   snappy          support of snappy compression library
@@ -5398,6 +5404,7 @@ echo "libssh2 support   $libssh2"
 echo "TPM passthrough   $tpm_passthrough"
 echo "QOM debugging     $qom_cast_debug"
 echo "Live block migration $live_block_migration"
+echo "Live block ops    $live_block_ops"
 echo "lzo support       $lzo"
 echo "snappy support    $snappy"
 echo "bzip2 support     $bzip2"
@@ -5976,6 +5983,10 @@ if test "$live_block_migration" = "yes" ; then
   echo "CONFIG_LIVE_BLOCK_MIGRATION=y" >> $config_host_mak
 fi
 
+if test "$live_block_ops" = "yes" ; then
+  echo "CONFIG_LIVE_BLOCK_OPS=y" >> $config_host_mak
+fi
+
 # USB host support
 if test "$libusb" = "yes"; then
   echo "HOST_USB=libusb legacy" >> $config_host_mak
-- 
2.9.5
