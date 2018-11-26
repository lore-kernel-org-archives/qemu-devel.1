Received: from eggs.gnu.org ([2001:4830:134:3::10]:49515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gRIqW-00007e-25
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gRIqR-0005z1-28
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:30:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1gRIqQ-0005wD-TK
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:30:43 -0500
From: Frediano Ziglio <fziglio@redhat.com>
Date: Mon, 26 Nov 2018 15:30:36 +0000
Message-Id: <20181126153036.22414-1-fziglio@redhat.com>
Subject: [Qemu-devel] [PATCH] spice: Use new SpiceImageCompression definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: spice-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Frediano Ziglio <fziglio@redhat.com>

Definitions were updated by spice-server in patch de66161 included
in 0.12.6 released on 12th June 2015.

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
---
 ui/spice-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index ebaae24643..2e6a255a35 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -331,12 +331,12 @@ static const char *stream_video_names[] = {
                stream_video_names, ARRAY_SIZE(stream_video_names))
 
 static const char *compression_names[] = {
-    [ SPICE_IMAGE_COMPRESS_OFF ]      = "off",
-    [ SPICE_IMAGE_COMPRESS_AUTO_GLZ ] = "auto_glz",
-    [ SPICE_IMAGE_COMPRESS_AUTO_LZ ]  = "auto_lz",
-    [ SPICE_IMAGE_COMPRESS_QUIC ]     = "quic",
-    [ SPICE_IMAGE_COMPRESS_GLZ ]      = "glz",
-    [ SPICE_IMAGE_COMPRESS_LZ ]       = "lz",
+    [ SPICE_IMAGE_COMPRESSION_OFF ]      = "off",
+    [ SPICE_IMAGE_COMPRESSION_AUTO_GLZ ] = "auto_glz",
+    [ SPICE_IMAGE_COMPRESSION_AUTO_LZ ]  = "auto_lz",
+    [ SPICE_IMAGE_COMPRESSION_QUIC ]     = "quic",
+    [ SPICE_IMAGE_COMPRESSION_GLZ ]      = "glz",
+    [ SPICE_IMAGE_COMPRESSION_LZ ]       = "lz",
 };
 #define parse_compression(_name)                                        \
     parse_name(_name, "image compression",                              \
@@ -643,7 +643,7 @@ void qemu_spice_init(void)
         *x509_cert_file = NULL,
         *x509_cacert_file = NULL;
     int port, tls_port, addr_flags;
-    spice_image_compression_t compression;
+    SpiceImageCompression compression;
     spice_wan_compression_t wan_compr;
     bool seamless_migration;
 
@@ -754,7 +754,7 @@ void qemu_spice_init(void)
 #endif
     }
 
-    compression = SPICE_IMAGE_COMPRESS_AUTO_GLZ;
+    compression = SPICE_IMAGE_COMPRESSION_AUTO_GLZ;
     str = qemu_opt_get(opts, "image-compression");
     if (str) {
         compression = parse_compression(str);
-- 
2.17.2
