Received: from eggs.gnu.org ([2001:4830:134:3::10]:56099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKiIz-0005cD-9F
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:17:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKiIw-00088X-BX
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:16:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gKiIv-00087q-Uw
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:16:54 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  8 Nov 2018 11:15:26 +0000
Message-Id: <20181108111531.30671-4-stefanha@redhat.com>
In-Reply-To: <20181108111531.30671-1-stefanha@redhat.com>
References: <20181108111531.30671-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 3/8] MAINTAINERS: use 'https://' instead of
 'git://' for GitHub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Berrange <berrange@redhat.com>, eblake@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, cohuck@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

When you clone the repository without previous commit history, 'git://'
doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
since the client verifies the server certificate.

Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 74 ++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0499e11593..391c8460b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -74,7 +74,7 @@ S: Maintained
 L: qemu-trivial@nongnu.org
 K: ^Subject:.*(?i)trivial
 T: git git://git.corpit.ru/qemu.git trivial-patches
-T: git git://github.com/vivier/qemu.git trivial-patches
+T: git https://github.com/vivier/qemu.git trivial-patches
=20
 Architecture support
 --------------------
@@ -98,7 +98,7 @@ F: pc-bios/s390-ccw.img
 F: target/s390x/
 F: docs/vfio-ap.txt
 K: ^Subject:.*(?i)s390x?
-T: git git://github.com/cohuck/qemu.git s390-next
+T: git https://github.com/cohuck/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
 Guest CPU cores (TCG):
@@ -296,7 +296,7 @@ F: tests/tcg/x86_64/
 F: hw/i386/
 F: disas/i386.c
 F: docs/qemu-cpu-models.texi
-T: git git://github.com/ehabkost/qemu.git x86-next
+T: git https://github.com/ehabkost/qemu.git x86-next
=20
 Xtensa
 M: Max Filippov <jcmvbkbc@gmail.com>
@@ -359,8 +359,8 @@ F: hw/intc/s390_flic.c
 F: hw/intc/s390_flic_kvm.c
 F: include/hw/s390x/s390_flic.h
 F: gdb-xml/s390*.xml
-T: git git://github.com/cohuck/qemu.git s390-next
-T: git git://github.com/borntraeger/qemu.git s390-next
+T: git https://github.com/cohuck/qemu.git s390-next
+T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
 X86
@@ -940,8 +940,8 @@ F: include/hw/s390x/
 F: hw/watchdog/wdt_diag288.c
 F: include/hw/watchdog/wdt_diag288.h
 F: default-configs/s390x-softmmu.mak
-T: git git://github.com/cohuck/qemu.git s390-next
-T: git git://github.com/borntraeger/qemu.git s390-next
+T: git https://github.com/cohuck/qemu.git s390-next
+T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
 S390-ccw boot
@@ -951,7 +951,7 @@ S: Supported
 F: hw/s390x/ipl.*
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
-T: git git://github.com/borntraeger/qemu.git s390-next
+T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
 S390 PCI
@@ -1027,7 +1027,7 @@ S: Supported
 F: hw/core/machine.c
 F: hw/core/null-machine.c
 F: include/hw/boards.h
-T: git git://github.com/ehabkost/qemu.git machine-next
+T: git https://github.com/ehabkost/qemu.git machine-next
=20
 Xtensa Machines
 ---------------
@@ -1063,7 +1063,7 @@ F: tests/ide-test.c
 F: tests/ahci-test.c
 F: tests/cdrom-test.c
 F: tests/libqos/ahci*
-T: git git://github.com/jnsnow/qemu.git ide
+T: git https://github.com/jnsnow/qemu.git ide
=20
 IPMI
 M: Corey Minyard <minyard@acm.org>
@@ -1072,7 +1072,7 @@ F: include/hw/ipmi/*
 F: hw/ipmi/*
 F: hw/smbios/smbios_type_38.c
 F: tests/ipmi*
-T: git git://github.com/cminyard/qemu.git master-ipmi-rebase
+T: git https://github.com/cminyard/qemu.git master-ipmi-rebase
=20
 Floppy
 M: John Snow <jsnow@redhat.com>
@@ -1081,7 +1081,7 @@ S: Supported
 F: hw/block/fdc.c
 F: include/hw/block/fdc.h
 F: tests/fdc-test.c
-T: git git://github.com/jnsnow/qemu.git ide
+T: git https://github.com/jnsnow/qemu.git ide
=20
 OMAP
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -1151,7 +1151,7 @@ S: Odd Fixes
 F: hw/net/
 F: include/hw/net/
 F: tests/virtio-net-test.c
-T: git git://github.com/jasowang/qemu.git net
+T: git https://github.com/jasowang/qemu.git net
=20
 SCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
@@ -1160,7 +1160,7 @@ S: Supported
 F: include/hw/scsi/*
 F: hw/scsi/*
 F: tests/virtio-scsi-test.c
-T: git git://github.com/bonzini/qemu.git scsi-next
+T: git https://github.com/bonzini/qemu.git scsi-next
=20
 SSI
 M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
@@ -1217,7 +1217,7 @@ S: Supported
 F: hw/vfio/ccw.c
 F: hw/s390x/s390-ccw.c
 F: include/hw/s390x/s390-ccw.h
-T: git git://github.com/cohuck/qemu.git s390-next
+T: git https://github.com/cohuck/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
 vfio-ap
@@ -1256,7 +1256,7 @@ S: Supported
 F: hw/9pfs/
 F: fsdev/
 F: tests/virtio-9p-test.c
-T: git git://github.com/gkurz/qemu.git 9p-next
+T: git https://github.com/gkurz/qemu.git 9p-next
=20
 virtio-blk
 M: Stefan Hajnoczi <stefanha@redhat.com>
@@ -1265,7 +1265,7 @@ S: Supported
 F: hw/block/virtio-blk.c
 F: hw/block/dataplane/*
 F: tests/virtio-blk-test.c
-T: git git://github.com/stefanha/qemu.git block
+T: git https://github.com/stefanha/qemu.git block
=20
 virtio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
@@ -1273,8 +1273,8 @@ M: Halil Pasic <pasic@linux.ibm.com>
 S: Supported
 F: hw/s390x/virtio-ccw*.[hc]
 F: hw/s390x/vhost-vsock-ccw.c
-T: git git://github.com/cohuck/qemu.git s390-next
-T: git git://github.com/borntraeger/qemu.git s390-next
+T: git https://github.com/cohuck/qemu.git s390-next
+T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
 virtio-input
@@ -1478,7 +1478,7 @@ F: migration/block*
 F: include/block/aio.h
 F: include/block/aio-wait.h
 F: scripts/qemugdb/aio.py
-T: git git://github.com/stefanha/qemu.git block
+T: git https://github.com/stefanha/qemu.git block
=20
 Block SCSI subsystem
 M: Paolo Bonzini <pbonzini@redhat.com>
@@ -1502,7 +1502,7 @@ F: block/commit.c
 F: block/stream.c
 F: block/mirror.c
 F: qapi/job.json
-T: git git://github.com/codyprime/qemu-kvm-jtc.git block
+T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 Block QAPI, monitor, command line
 M: Markus Armbruster <armbru@redhat.com>
@@ -1524,8 +1524,8 @@ F: include/qemu/hbitmap.h
 F: include/block/dirty-bitmap.h
 F: tests/test-hbitmap.c
 F: docs/interop/bitmaps.rst
-T: git git://github.com/famz/qemu.git bitmaps
-T: git git://github.com/jnsnow/qemu.git bitmaps
+T: git https://github.com/famz/qemu.git bitmaps
+T: git https://github.com/jnsnow/qemu.git bitmaps
=20
 Character device backends
 M: Paolo Bonzini <pbonzini@redhat.com>
@@ -1649,7 +1649,7 @@ M: Jason Wang <jasowang@redhat.com>
 S: Maintained
 F: net/
 F: include/net/
-T: git git://github.com/jasowang/qemu.git net
+T: git https://github.com/jasowang/qemu.git net
 F: qapi/net.json
=20
 Netmap network backend
@@ -1665,7 +1665,7 @@ M: Eduardo Habkost <ehabkost@redhat.com>
 S: Maintained
 F: numa.c
 F: include/sysemu/numa.h
-T: git git://github.com/ehabkost/qemu.git machine-next
+T: git https://github.com/ehabkost/qemu.git machine-next
=20
 Host Memory Backends
 M: Eduardo Habkost <ehabkost@redhat.com>
@@ -1673,7 +1673,7 @@ M: Igor Mammedov <imammedo@redhat.com>
 S: Maintained
 F: backends/hostmem*.c
 F: include/sysemu/hostmem.h
-T: git git://github.com/ehabkost/qemu.git machine-next
+T: git https://github.com/ehabkost/qemu.git machine-next
=20
 Cryptodev Backends
 M: Gonglei <arei.gonglei@huawei.com>
@@ -1737,12 +1737,12 @@ F: qemu-ga.texi
 F: scripts/qemu-guest-agent/
 F: tests/test-qga.c
 F: docs/interop/qemu-ga-ref.texi
-T: git git://github.com/mdroth/qemu.git qga
+T: git https://github.com/mdroth/qemu.git qga
=20
 QOM
 M: Andreas F=C3=A4rber <afaerber@suse.de>
 S: Supported
-T: git git://github.com/afaerber/qemu-cpu.git qom-next
+T: git https://github.com/afaerber/qemu-cpu.git qom-next
 F: include/qom/
 X: include/qom/cpu.h
 F: qom/
@@ -1802,7 +1802,7 @@ F: qemu-option-trace.texi
 F: scripts/tracetool.py
 F: scripts/tracetool/
 F: docs/devel/tracing.txt
-T: git git://github.com/stefanha/qemu.git tracing
+T: git https://github.com/stefanha/qemu.git tracing
=20
 TPM
 M: Stefan Berger <stefanb@linux.ibm.com>
@@ -1815,7 +1815,7 @@ F: include/sysemu/tpm*
 F: qapi/tpm.json
 F: backends/tpm.c
 F: tests/*tpm*
-T: git git://github.com/stefanberger/qemu-tpm.git tpm-next
+T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
=20
 Checkpatch
 S: Odd Fixes
@@ -2030,7 +2030,7 @@ M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/rbd.c
-T: git git://github.com/codyprime/qemu-kvm-jtc.git block
+T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 Sheepdog
 M: Liu Yuan <namei.unix@gmail.com>
@@ -2038,14 +2038,14 @@ M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/sheepdog.c
-T: git git://github.com/codyprime/qemu-kvm-jtc.git block
+T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 VHDX
 M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/vhdx*
-T: git git://github.com/codyprime/qemu-kvm-jtc.git block
+T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 VDI
 M: Stefan Weil <sw@weilnetz.de>
@@ -2081,7 +2081,7 @@ M: Peter Lieven <pl@kamp.de>
 L: qemu-block@nongnu.org
 S: Maintained
 F: block/nfs.c
-T: git git://github.com/codyprime/qemu-kvm-jtc.git block
+T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 SSH
 M: Richard W.M. Jones <rjones@redhat.com>
@@ -2089,21 +2089,21 @@ M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/ssh.c
-T: git git://github.com/codyprime/qemu-kvm-jtc.git block
+T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 CURL
 M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/curl.c
-T: git git://github.com/codyprime/qemu-kvm-jtc.git block
+T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 GLUSTER
 M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/gluster.c
-T: git git://github.com/codyprime/qemu-kvm-jtc.git block
+T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 Null Block Driver
 M: Fam Zheng <famz@redhat.com>
--=20
2.19.1
