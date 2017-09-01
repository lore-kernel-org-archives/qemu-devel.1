Received: from eggs.gnu.org ([2001:4830:134:3::10]:50186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnja5-0004wi-Fr
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dnja0-0008CR-O1
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:53:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dnja0-0008CJ-HU
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:53:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81E34404333
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 10:53:39 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  1 Sep 2017 12:53:31 +0200
Message-Id: <20170901105331.11783-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] docs: add firmware.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Document how guest firmware is handled in qemu today.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/firmware.txt | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 docs/firmware.txt

diff --git a/docs/firmware.txt b/docs/firmware.txt
new file mode 100644
index 0000000000..e242413344
--- /dev/null
+++ b/docs/firmware.txt
@@ -0,0 +1,49 @@
+
+prebuilt firmware in qemu
+=========================
+
+The process of building firmware isn't as easy as building qemu
+itself, for example because you must have cross compilers installed
+when building firmware for other architectures.  So qemu ships
+prebuilt firmware binaries for convenience reasons.
+
+
+directories
+-----------
+
+pc-bios/
+    Firmware binaries.
+    Also other files like keymaps and logos which are copied to
+    $prefix/share/qemu by "make install".
+
+pc-bios/optionrom/
+    Firmware sources, part of the qemu project.
+
+roms/
+    Firmware sources, third-party projects, as git submodules.
+
+
+third-party git repos
+---------------------
+
+For third party firmware sources it is recommended to have a git
+mirror on git.qemu.org.  In case the firmware license is GPL the git
+mirror is mandatory for GPL compilance reasons:  We ship binaries, so
+we must provide sources too.
+
+
+building the firmware
+---------------------
+
+Firmware builds should be done using rules in roms/Makefile.  That
+serves as documentation how the firmware is built, and it also makes
+firmware updates easier for the maintainer.
+
+"make -C roms" prints a list of firmware build targets.
+"make -C roms $target" kicks a build.
+
+
+notes for specific firmwares
+----------------------------
+
+ipxe: see https://wiki.qemu.org/IpxeDownstreamForQemu
-- 
2.9.3
