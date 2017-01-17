Received: from eggs.gnu.org ([2001:4830:134:3::10]:44164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTYmj-00026v-1y
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTYmh-0002ml-SS
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:47:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTYmh-0002mM-KD
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:47:07 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBB638F02B
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:47:07 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 17 Jan 2017 16:46:38 -0200
Message-Id: <20170117184638.25809-4-ehabkost@redhat.com>
In-Reply-To: <20170117184638.25809-1-ehabkost@redhat.com>
References: <20170117184638.25809-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] audio: Rename hw/audio/audio.h to
 hw/audio/soundhw.h
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

All the functions in hw/audio/audio.h are called "soundhw_*()"
and live in hw/audio/audiohw.c. Rename the header file for
consistency.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/audio/{audio.h => soundhw.h} | 0
 arch_init.c                             | 2 +-
 hw/audio/ac97.c                         | 2 +-
 hw/audio/adlib.c                        | 2 +-
 hw/audio/cs4231a.c                      | 2 +-
 hw/audio/es1370.c                       | 2 +-
 hw/audio/gus.c                          | 2 +-
 hw/audio/intel-hda.c                    | 2 +-
 hw/audio/pcspk.c                        | 2 +-
 hw/audio/sb16.c                         | 2 +-
 hw/audio/soundhw.c                      | 2 +-
 vl.c                                    | 2 +-
 12 files changed, 11 insertions(+), 11 deletions(-)
 rename include/hw/audio/{audio.h => soundhw.h} (100%)

diff --git a/include/hw/audio/audio.h b/include/hw/audio/soundhw.h
similarity index 100%
rename from include/hw/audio/audio.h
rename to include/hw/audio/soundhw.h
diff --git a/arch_init.c b/arch_init.c
index 16465c3f54..da26b40056 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -27,7 +27,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/arch_init.h"
 #include "hw/pci/pci.h"
-#include "hw/audio/audio.h"
+#include "hw/audio/soundhw.h"
 #include "hw/smbios/smbios.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index c30657501c..959c786261 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/audio/audio.h"
+#include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/pci/pci.h"
 #include "sysemu/dma.h"
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 7836446fc8..a9356e83b5 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
-#include "hw/audio/audio.h"
+#include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/isa/isa.h"
 
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 3ecd0582bf..096e8e98d7 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -23,7 +23,7 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/audio/audio.h"
+#include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev.h"
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index fe64c1ac37..dd7c23d185 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -28,7 +28,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/audio/audio.h"
+#include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/pci/pci.h"
 #include "sysemu/dma.h"
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 3d08a6576a..21861be869 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
-#include "hw/audio/audio.h"
+#include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/isa/isa.h"
 #include "gusemu.h"
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 537face94d..8e36147f64 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -22,7 +22,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "qemu/timer.h"
-#include "hw/audio/audio.h"
+#include "hw/audio/soundhw.h"
 #include "intel-hda.h"
 #include "intel-hda-defs.h"
 #include "sysemu/dma.h"
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 798002277b..c815a2b9ca 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -26,7 +26,7 @@
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
-#include "hw/audio/audio.h"
+#include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "qemu/timer.h"
 #include "hw/timer/i8254.h"
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 6b4427f242..6ab2f6f89a 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -23,7 +23,7 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/audio/audio.h"
+#include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev.h"
diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index 2178a5c8ef..710912e715 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -28,7 +28,7 @@
 #include "qom/object.h"
 #include "hw/isa/isa.h"
 #include "hw/pci/pci.h"
-#include "hw/audio/audio.h"
+#include "hw/audio/soundhw.h"
 
 struct soundhw {
     const char *name;
diff --git a/vl.c b/vl.c
index a5bf85ebec..27213fd6af 100644
--- a/vl.c
+++ b/vl.c
@@ -87,7 +87,7 @@ int main(int argc, char **argv)
 #include "migration/block.h"
 #include "sysemu/tpm.h"
 #include "sysemu/dma.h"
-#include "hw/audio/audio.h"
+#include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "migration/migration.h"
 #include "sysemu/cpus.h"
-- 
2.11.0.259.g40922b1
