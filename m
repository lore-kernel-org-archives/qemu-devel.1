Received: from eggs.gnu.org ([2001:4830:134:3::10]:50521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gHmlN-0003i7-OF
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gHmlC-0005sQ-PW
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gHmlB-0005jP-Tl
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:25:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 31 Oct 2018 08:43:08 +0000
Message-Id: <20181031084309.9227-4-stefanha@redhat.com>
In-Reply-To: <20181031084309.9227-1-stefanha@redhat.com>
References: <20181031084309.9227-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] MAINTAINERS: use 'https://' instead of
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
Cc: Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

When you clone the repository without previous commit history, 'git://'
doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
since the client verifies the server certificate.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 74 ++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d794bd7a66..464f7f9338 100644
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
@@ -295,7 +295,7 @@ F: tests/tcg/x86_64/
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
@@ -942,8 +942,8 @@ F: include/hw/s390x/
 F: hw/watchdog/wdt_diag288.c
 F: include/hw/watchdog/wdt_diag288.h
 F: default-configs/s390x-softmmu.mak
-T: git git://github.com/cohuck/qemu.git s390-next
-T: git git://github.com/borntraeger/qemu.git s390-next
+T: git https://github.com/cohuck/qemu.git s390-next
+T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
 S390-ccw Bios
@@ -952,7 +952,7 @@ M: Thomas Huth <thuth@redhat.com>
 S: Supported
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
-T: git git://github.com/borntraeger/qemu.git s390-next
+T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
 UniCore32 Machines
@@ -1022,7 +1022,7 @@ S: Supported
 F: hw/core/machine.c
 F: hw/core/null-machine.c
 F: include/hw/boards.h
-T: git git://github.com/ehabkost/qemu.git machine-next
+T: git https://github.com/ehabkost/qemu.git machine-next
=20
 Xtensa Machines
 ---------------
@@ -1058,7 +1058,7 @@ F: tests/ide-test.c
 F: tests/ahci-test.c
 F: tests/cdrom-test.c
 F: tests/libqos/ahci*
-T: git git://github.com/jnsnow/qemu.git ide
+T: git https://github.com/jnsnow/qemu.git ide
=20
 IPMI
 M: Corey Minyard <minyard@acm.org>
@@ -1067,7 +1067,7 @@ F: include/hw/ipmi/*
 F: hw/ipmi/*
 F: hw/smbios/smbios_type_38.c
 F: tests/ipmi*
-T: git git://github.com/cminyard/qemu.git master-ipmi-rebase
+T: git https://github.com/cminyard/qemu.git master-ipmi-rebase
=20
 Floppy
 M: John Snow <jsnow@redhat.com>
@@ -1076,7 +1076,7 @@ S: Supported
 F: hw/block/fdc.c
 F: include/hw/block/fdc.h
 F: tests/fdc-test.c
-T: git git://github.com/jnsnow/qemu.git ide
+T: git https://github.com/jnsnow/qemu.git ide
=20
 OMAP
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -1144,7 +1144,7 @@ S: Odd Fixes
 F: hw/net/
 F: include/hw/net/
 F: tests/virtio-net-test.c
-T: git git://github.com/jasowang/qemu.git net
+T: git https://github.com/jasowang/qemu.git net
=20
 SCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
@@ -1153,7 +1153,7 @@ S: Supported
 F: include/hw/scsi/*
 F: hw/scsi/*
 F: tests/virtio-scsi-test.c
-T: git git://github.com/bonzini/qemu.git scsi-next
+T: git https://github.com/bonzini/qemu.git scsi-next
=20
 SSI
 M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
@@ -1208,7 +1208,7 @@ S: Supported
 F: hw/vfio/ccw.c
 F: hw/s390x/s390-ccw.c
 F: include/hw/s390x/s390-ccw.h
-T: git git://github.com/cohuck/qemu.git s390-next
+T: git https://github.com/cohuck/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
 vfio-ap
@@ -1247,7 +1247,7 @@ S: Supported
 F: hw/9pfs/
 F: fsdev/
 F: tests/virtio-9p-test.c
-T: git git://github.com/gkurz/qemu.git 9p-next
+T: git https://github.com/gkurz/qemu.git 9p-next
=20
 virtio-blk
 M: Stefan Hajnoczi <stefanha@redhat.com>
@@ -1256,7 +1256,7 @@ S: Supported
 F: hw/block/virtio-blk.c
 F: hw/block/dataplane/*
 F: tests/virtio-blk-test.c
-T: git git://github.com/stefanha/qemu.git block
+T: git https://github.com/stefanha/qemu.git block
=20
 virtio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
@@ -1264,8 +1264,8 @@ M: Christian Borntraeger <borntraeger@de.ibm.com>
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
@@ -1469,7 +1469,7 @@ F: migration/block*
 F: include/block/aio.h
 F: include/block/aio-wait.h
 F: scripts/qemugdb/aio.py
-T: git git://github.com/stefanha/qemu.git block
+T: git https://github.com/stefanha/qemu.git block
=20
 Block SCSI subsystem
 M: Paolo Bonzini <pbonzini@redhat.com>
@@ -1493,7 +1493,7 @@ F: block/commit.c
 F: block/stream.c
 F: block/mirror.c
 F: qapi/job.json
-T: git git://github.com/codyprime/qemu-kvm-jtc.git block
+T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 Block QAPI, monitor, command line
 M: Markus Armbruster <armbru@redhat.com>
@@ -1515,8 +1515,8 @@ F: include/qemu/hbitmap.h
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
@@ -1640,7 +1640,7 @@ M: Jason Wang <jasowang@redhat.com>
 S: Maintained
 F: net/
 F: include/net/
-T: git git://github.com/jasowang/qemu.git net
+T: git https://github.com/jasowang/qemu.git net
 F: qapi/net.json
=20
 Netmap network backend
@@ -1656,7 +1656,7 @@ M: Eduardo Habkost <ehabkost@redhat.com>
 S: Maintained
 F: numa.c
 F: include/sysemu/numa.h
-T: git git://github.com/ehabkost/qemu.git machine-next
+T: git https://github.com/ehabkost/qemu.git machine-next
=20
 Host Memory Backends
 M: Eduardo Habkost <ehabkost@redhat.com>
@@ -1664,7 +1664,7 @@ M: Igor Mammedov <imammedo@redhat.com>
 S: Maintained
 F: backends/hostmem*.c
 F: include/sysemu/hostmem.h
-T: git git://github.com/ehabkost/qemu.git machine-next
+T: git https://github.com/ehabkost/qemu.git machine-next
=20
 Cryptodev Backends
 M: Gonglei <arei.gonglei@huawei.com>
@@ -1728,12 +1728,12 @@ F: qemu-ga.texi
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
@@ -1793,7 +1793,7 @@ F: qemu-option-trace.texi
 F: scripts/tracetool.py
 F: scripts/tracetool/
 F: docs/devel/tracing.txt
-T: git git://github.com/stefanha/qemu.git tracing
+T: git https://github.com/stefanha/qemu.git tracing
=20
 TPM
 M: Stefan Berger <stefanb@linux.vnet.ibm.com>
@@ -1806,7 +1806,7 @@ F: include/sysemu/tpm*
 F: qapi/tpm.json
 F: backends/tpm.c
 F: tests/*tpm*
-T: git git://github.com/stefanberger/qemu-tpm.git tpm-next
+T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
=20
 Checkpatch
 S: Odd Fixes
@@ -2022,7 +2022,7 @@ M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/rbd.c
-T: git git://github.com/codyprime/qemu-kvm-jtc.git block
+T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 Sheepdog
 M: Liu Yuan <namei.unix@gmail.com>
@@ -2031,14 +2031,14 @@ L: qemu-block@nongnu.org
 L: sheepdog@lists.wpkg.org
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
@@ -2074,7 +2074,7 @@ M: Peter Lieven <pl@kamp.de>
 L: qemu-block@nongnu.org
 S: Maintained
 F: block/nfs.c
-T: git git://github.com/codyprime/qemu-kvm-jtc.git block
+T: git https://github.com/codyprime/qemu-kvm-jtc.git block
=20
 SSH
 M: Richard W.M. Jones <rjones@redhat.com>
@@ -2082,21 +2082,21 @@ M: Jeff Cody <jcody@redhat.com>
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
2.17.2
