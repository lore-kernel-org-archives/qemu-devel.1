Received: from eggs.gnu.org ([209.51.188.92]:35918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6Z-0000HI-OR
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6X-0004il-Kc
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6V-0004eh-Gz
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 47F9D301E141
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 163D2600CD
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:43 +0100
Message-Id: <20190311220843.4026-28-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 27/27] docs/interop/firmware.json: Prefer
 -machine to if=pflash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The previous commit added a way to configure firmware with -blockdev
rather than -drive if=pflash.  Document it as the preferred way.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190308131445.17502-13-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 docs/interop/firmware.json | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 28f9bc1591..ff8c2ce5f2 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -212,9 +212,13 @@
 #
 # @executable: Identifies the firmware executable. The firmware
 #              executable may be shared by multiple virtual machine
-#              definitions. The corresponding QEMU command line option
-#              is "-drive
-#              if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format".
+#              definitions. The preferred corresponding QEMU command
+#              line options are
+#                  -drive if=none,id=pflash0,readonly=on,file=@executable.@filename,format=@executable.@format
+#                  -machine pflash0=pflash0
+#              or equivalent -blockdev instead of -drive.
+#              With QEMU versions older than 4.0, you have to use
+#                  -drive if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format
 #
 # @nvram-template: Identifies the NVRAM template compatible with
 #                  @executable. Management software instantiates an
@@ -225,9 +229,13 @@
 #                  individual copies of it are. An NVRAM file is
 #                  typically used for persistently storing the
 #                  non-volatile UEFI variables of a virtual machine
-#                  definition. The corresponding QEMU command line
-#                  option is "-drive
-#                  if=pflash,unit=1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format".
+#                  definition. The preferred corresponding QEMU
+#                  command line options are
+#                      -drive if=none,id=pflash1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format
+#                      -machine pflash1=pflash1
+#                  or equivalent -blockdev instead of -drive.
+#                  With QEMU versions older than 4.0, you have to use
+#                      -drive if=pflash,unit=1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format
 #
 # Since: 3.0
 ##
-- 
2.17.2
