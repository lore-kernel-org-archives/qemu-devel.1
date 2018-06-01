Received: from eggs.gnu.org ([2001:4830:134:3::10]:50211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOlba-0000Kc-1m
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOlbZ-0006sJ-4m
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:04:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fOlbZ-0006rt-0J
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:04:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  1 Jun 2018 16:04:28 +0100
Message-Id: <20180601150428.30896-2-stefanha@redhat.com>
In-Reply-To: <20180601150428.30896-1-stefanha@redhat.com>
References: <20180601150428.30896-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] trace: Sort trace-events-subdirs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Having these entries sorted helps to add new ones.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180528054055.21153-1-f4bug@amsat.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile.objs | 82 +++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index c6c3554203..2c8cb72407 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -196,66 +196,66 @@ vhost-user-blk-obj-y =3D contrib/vhost-user-blk/
=20
 ######################################################################
 trace-events-subdirs =3D
-trace-events-subdirs +=3D util
-trace-events-subdirs +=3D crypto
-trace-events-subdirs +=3D io
-trace-events-subdirs +=3D migration
+trace-events-subdirs +=3D accel/kvm
+trace-events-subdirs +=3D accel/tcg
+trace-events-subdirs +=3D audio
 trace-events-subdirs +=3D block
 trace-events-subdirs +=3D chardev
+trace-events-subdirs +=3D crypto
+trace-events-subdirs +=3D hw/9pfs
+trace-events-subdirs +=3D hw/acpi
+trace-events-subdirs +=3D hw/alpha
+trace-events-subdirs +=3D hw/arm
+trace-events-subdirs +=3D hw/audio
 trace-events-subdirs +=3D hw/block
 trace-events-subdirs +=3D hw/block/dataplane
 trace-events-subdirs +=3D hw/char
-trace-events-subdirs +=3D hw/intc
-trace-events-subdirs +=3D hw/net
-trace-events-subdirs +=3D hw/rdma
-trace-events-subdirs +=3D hw/rdma/vmw
-trace-events-subdirs +=3D hw/virtio
-trace-events-subdirs +=3D hw/audio
-trace-events-subdirs +=3D hw/misc
-trace-events-subdirs +=3D hw/misc/macio
-trace-events-subdirs +=3D hw/usb
-trace-events-subdirs +=3D hw/scsi
-trace-events-subdirs +=3D hw/nvram
 trace-events-subdirs +=3D hw/display
-trace-events-subdirs +=3D hw/input
-trace-events-subdirs +=3D hw/timer
 trace-events-subdirs +=3D hw/dma
-trace-events-subdirs +=3D hw/sparc
-trace-events-subdirs +=3D hw/sparc64
-trace-events-subdirs +=3D hw/sd
-trace-events-subdirs +=3D hw/isa
-trace-events-subdirs +=3D hw/mem
+trace-events-subdirs +=3D hw/hppa
 trace-events-subdirs +=3D hw/i386
 trace-events-subdirs +=3D hw/i386/xen
-trace-events-subdirs +=3D hw/9pfs
-trace-events-subdirs +=3D hw/ppc
+trace-events-subdirs +=3D hw/ide
+trace-events-subdirs +=3D hw/input
+trace-events-subdirs +=3D hw/intc
+trace-events-subdirs +=3D hw/isa
+trace-events-subdirs +=3D hw/mem
+trace-events-subdirs +=3D hw/misc
+trace-events-subdirs +=3D hw/misc/macio
+trace-events-subdirs +=3D hw/net
+trace-events-subdirs +=3D hw/nvram
 trace-events-subdirs +=3D hw/pci
 trace-events-subdirs +=3D hw/pci-host
+trace-events-subdirs +=3D hw/ppc
+trace-events-subdirs +=3D hw/rdma
+trace-events-subdirs +=3D hw/rdma/vmw
 trace-events-subdirs +=3D hw/s390x
+trace-events-subdirs +=3D hw/scsi
+trace-events-subdirs +=3D hw/sd
+trace-events-subdirs +=3D hw/sparc
+trace-events-subdirs +=3D hw/sparc64
+trace-events-subdirs +=3D hw/timer
+trace-events-subdirs +=3D hw/tpm
+trace-events-subdirs +=3D hw/usb
 trace-events-subdirs +=3D hw/vfio
-trace-events-subdirs +=3D hw/acpi
-trace-events-subdirs +=3D hw/arm
-trace-events-subdirs +=3D hw/alpha
-trace-events-subdirs +=3D hw/hppa
+trace-events-subdirs +=3D hw/virtio
 trace-events-subdirs +=3D hw/xen
-trace-events-subdirs +=3D hw/ide
-trace-events-subdirs +=3D hw/tpm
-trace-events-subdirs +=3D ui
-trace-events-subdirs +=3D audio
+trace-events-subdirs +=3D io
+trace-events-subdirs +=3D linux-user
+trace-events-subdirs +=3D migration
+trace-events-subdirs +=3D nbd
 trace-events-subdirs +=3D net
+trace-events-subdirs +=3D qapi
+trace-events-subdirs +=3D qom
+trace-events-subdirs +=3D scsi
 trace-events-subdirs +=3D target/arm
 trace-events-subdirs +=3D target/i386
 trace-events-subdirs +=3D target/mips
-trace-events-subdirs +=3D target/sparc
-trace-events-subdirs +=3D target/s390x
 trace-events-subdirs +=3D target/ppc
-trace-events-subdirs +=3D qom
-trace-events-subdirs +=3D linux-user
-trace-events-subdirs +=3D qapi
-trace-events-subdirs +=3D accel/tcg
-trace-events-subdirs +=3D accel/kvm
-trace-events-subdirs +=3D nbd
-trace-events-subdirs +=3D scsi
+trace-events-subdirs +=3D target/s390x
+trace-events-subdirs +=3D target/sparc
+trace-events-subdirs +=3D ui
+trace-events-subdirs +=3D util
=20
 trace-events-files =3D $(SRC_PATH)/trace-events $(trace-events-subdirs:%=
=3D$(SRC_PATH)/%/trace-events)
=20
--=20
2.17.0
