Received: from eggs.gnu.org ([2001:4830:134:3::10]:50266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNAu2-0004g2-3e
	for qemu-devel@nongnu.org; Mon, 28 May 2018 01:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNAtz-0007e5-1G
	for qemu-devel@nongnu.org; Mon, 28 May 2018 01:41:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 28 May 2018 02:40:55 -0300
Message-Id: <20180528054055.21153-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] trace: Sort trace-events-subdirs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org

Having these entries sorted helps to add new ones.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 Makefile.objs | 82 +++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index c6c3554203..2c8cb72407 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -196,66 +196,66 @@ vhost-user-blk-obj-y = contrib/vhost-user-blk/
 
 ######################################################################
 trace-events-subdirs =
-trace-events-subdirs += util
-trace-events-subdirs += crypto
-trace-events-subdirs += io
-trace-events-subdirs += migration
+trace-events-subdirs += accel/kvm
+trace-events-subdirs += accel/tcg
+trace-events-subdirs += audio
 trace-events-subdirs += block
 trace-events-subdirs += chardev
+trace-events-subdirs += crypto
+trace-events-subdirs += hw/9pfs
+trace-events-subdirs += hw/acpi
+trace-events-subdirs += hw/alpha
+trace-events-subdirs += hw/arm
+trace-events-subdirs += hw/audio
 trace-events-subdirs += hw/block
 trace-events-subdirs += hw/block/dataplane
 trace-events-subdirs += hw/char
-trace-events-subdirs += hw/intc
-trace-events-subdirs += hw/net
-trace-events-subdirs += hw/rdma
-trace-events-subdirs += hw/rdma/vmw
-trace-events-subdirs += hw/virtio
-trace-events-subdirs += hw/audio
-trace-events-subdirs += hw/misc
-trace-events-subdirs += hw/misc/macio
-trace-events-subdirs += hw/usb
-trace-events-subdirs += hw/scsi
-trace-events-subdirs += hw/nvram
 trace-events-subdirs += hw/display
-trace-events-subdirs += hw/input
-trace-events-subdirs += hw/timer
 trace-events-subdirs += hw/dma
-trace-events-subdirs += hw/sparc
-trace-events-subdirs += hw/sparc64
-trace-events-subdirs += hw/sd
-trace-events-subdirs += hw/isa
-trace-events-subdirs += hw/mem
+trace-events-subdirs += hw/hppa
 trace-events-subdirs += hw/i386
 trace-events-subdirs += hw/i386/xen
-trace-events-subdirs += hw/9pfs
-trace-events-subdirs += hw/ppc
+trace-events-subdirs += hw/ide
+trace-events-subdirs += hw/input
+trace-events-subdirs += hw/intc
+trace-events-subdirs += hw/isa
+trace-events-subdirs += hw/mem
+trace-events-subdirs += hw/misc
+trace-events-subdirs += hw/misc/macio
+trace-events-subdirs += hw/net
+trace-events-subdirs += hw/nvram
 trace-events-subdirs += hw/pci
 trace-events-subdirs += hw/pci-host
+trace-events-subdirs += hw/ppc
+trace-events-subdirs += hw/rdma
+trace-events-subdirs += hw/rdma/vmw
 trace-events-subdirs += hw/s390x
+trace-events-subdirs += hw/scsi
+trace-events-subdirs += hw/sd
+trace-events-subdirs += hw/sparc
+trace-events-subdirs += hw/sparc64
+trace-events-subdirs += hw/timer
+trace-events-subdirs += hw/tpm
+trace-events-subdirs += hw/usb
 trace-events-subdirs += hw/vfio
-trace-events-subdirs += hw/acpi
-trace-events-subdirs += hw/arm
-trace-events-subdirs += hw/alpha
-trace-events-subdirs += hw/hppa
+trace-events-subdirs += hw/virtio
 trace-events-subdirs += hw/xen
-trace-events-subdirs += hw/ide
-trace-events-subdirs += hw/tpm
-trace-events-subdirs += ui
-trace-events-subdirs += audio
+trace-events-subdirs += io
+trace-events-subdirs += linux-user
+trace-events-subdirs += migration
+trace-events-subdirs += nbd
 trace-events-subdirs += net
+trace-events-subdirs += qapi
+trace-events-subdirs += qom
+trace-events-subdirs += scsi
 trace-events-subdirs += target/arm
 trace-events-subdirs += target/i386
 trace-events-subdirs += target/mips
-trace-events-subdirs += target/sparc
-trace-events-subdirs += target/s390x
 trace-events-subdirs += target/ppc
-trace-events-subdirs += qom
-trace-events-subdirs += linux-user
-trace-events-subdirs += qapi
-trace-events-subdirs += accel/tcg
-trace-events-subdirs += accel/kvm
-trace-events-subdirs += nbd
-trace-events-subdirs += scsi
+trace-events-subdirs += target/s390x
+trace-events-subdirs += target/sparc
+trace-events-subdirs += ui
+trace-events-subdirs += util
 
 trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PATH)/%/trace-events)
 
-- 
2.17.0
