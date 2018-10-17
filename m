Received: from eggs.gnu.org ([2001:4830:134:3::10]:53308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCii0-0005r2-Hh
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCihk-0001Ij-DC
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCiha-0000zD-DU
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:19 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 Oct 2018 12:04:56 +0200
Message-Id: <1539770707-7289-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1539770707-7289-1-git-send-email-thuth@redhat.com>
References: <1539770707-7289-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/15] tests: remove gcov-files- variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

Commit 31d2dda ("build-system: remove per-test GCOV reporting", 2018-06-2=
0)
removed users of the variables, since those uses can be replaced by a sim=
ple
overall report produced by gcovr.  However, the variables were never remo=
ved.
Do it now.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
[thuth: Fixed up contextual conflicts with the patch from Eric]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing.rst |   4 +-
 tests/Makefile.include | 118 -------------------------------------------=
------
 2 files changed, 1 insertion(+), 121 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 727c401..fcfad87 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -43,15 +43,13 @@ add a new unit test:
=20
 3. Add the test to ``tests/Makefile.include``. First, name the unit test
    program and add it to ``$(check-unit-y)``; then add a rule to build t=
he
-   executable. Optionally, you can add a magical variable to support ``g=
cov``.
-   For example:
+   executable.  For example:
=20
 .. code::
=20
   check-unit-y +=3D tests/foo-test$(EXESUF)
   tests/foo-test$(EXESUF): tests/foo-test.o $(test-util-obj-y)
   ...
-  gcov-files-foo-test-y =3D util/foo.c
=20
 Since unit tests don't require environment variables, the simplest way t=
o debug
 a unit test failure is often directly invoking it or even running it und=
er
diff --git a/tests/Makefile.include b/tests/Makefile.include
index b68cbb3..7fe8578 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -39,106 +39,61 @@ SYSEMU_TARGET_LIST :=3D $(subst -softmmu.mak,,$(notd=
ir \
    $(wildcard $(SRC_PATH)/default-configs/*-softmmu.mak)))
=20
 check-unit-y +=3D tests/check-qdict$(EXESUF)
-gcov-files-check-qdict-y =3D qobject/qdict.c
 check-unit-y +=3D tests/check-block-qdict$(EXESUF)
-gcov-files-check-block-qdict-y =3D qobject/block-qdict.c
 check-unit-y +=3D tests/test-char$(EXESUF)
-gcov-files-check-qdict-y =3D chardev/char.c
 check-unit-y +=3D tests/check-qnum$(EXESUF)
-gcov-files-check-qnum-y =3D qobject/qnum.c
 check-unit-y +=3D tests/check-qstring$(EXESUF)
-gcov-files-check-qstring-y =3D qobject/qstring.c
 check-unit-y +=3D tests/check-qlist$(EXESUF)
-gcov-files-check-qlist-y =3D qobject/qlist.c
 check-unit-y +=3D tests/check-qnull$(EXESUF)
-gcov-files-check-qnull-y =3D qobject/qnull.c
 check-unit-y +=3D tests/check-qobject$(EXESUF)
 check-unit-y +=3D tests/check-qjson$(EXESUF)
-gcov-files-check-qjson-y =3D qobject/qjson.c
 check-unit-y +=3D tests/check-qlit$(EXESUF)
-gcov-files-check-qlit-y =3D qobject/qlit.c
 check-unit-y +=3D tests/test-qobject-output-visitor$(EXESUF)
-gcov-files-test-qobject-output-visitor-y =3D qapi/qobject-output-visitor=
.c
 check-unit-y +=3D tests/test-clone-visitor$(EXESUF)
-gcov-files-test-clone-visitor-y =3D qapi/qapi-clone-visitor.c
 check-unit-y +=3D tests/test-qobject-input-visitor$(EXESUF)
-gcov-files-test-qobject-input-visitor-y =3D qapi/qobject-input-visitor.c
 check-unit-y +=3D tests/test-qmp-cmds$(EXESUF)
-gcov-files-test-qmp-cmds-y =3D qapi/qmp-dispatch.c
 check-unit-y +=3D tests/test-string-input-visitor$(EXESUF)
-gcov-files-test-string-input-visitor-y =3D qapi/string-input-visitor.c
 check-unit-y +=3D tests/test-string-output-visitor$(EXESUF)
-gcov-files-test-string-output-visitor-y =3D qapi/string-output-visitor.c
 check-unit-y +=3D tests/test-qmp-event$(EXESUF)
-gcov-files-test-qmp-event-y +=3D qapi/qmp-event.c
 check-unit-y +=3D tests/test-opts-visitor$(EXESUF)
-gcov-files-test-opts-visitor-y =3D qapi/opts-visitor.c
 check-unit-y +=3D tests/test-coroutine$(EXESUF)
-gcov-files-test-coroutine-y =3D coroutine-$(CONFIG_COROUTINE_BACKEND).c
 check-unit-y +=3D tests/test-visitor-serialization$(EXESUF)
 check-unit-y +=3D tests/test-iov$(EXESUF)
-gcov-files-test-iov-y =3D util/iov.c
 check-unit-y +=3D tests/test-aio$(EXESUF)
-gcov-files-test-aio-y =3D util/async.c util/qemu-timer.o
-gcov-files-test-aio-$(CONFIG_WIN32) +=3D util/aio-win32.c
-gcov-files-test-aio-$(CONFIG_POSIX) +=3D util/aio-posix.c
 check-unit-y +=3D tests/test-aio-multithread$(EXESUF)
-gcov-files-test-aio-multithread-y =3D $(gcov-files-test-aio-y)
-gcov-files-test-aio-multithread-y +=3D util/qemu-coroutine.c tests/iothr=
ead.c
 check-unit-y +=3D tests/test-throttle$(EXESUF)
 check-unit-y +=3D tests/test-thread-pool$(EXESUF)
-gcov-files-test-thread-pool-y =3D thread-pool.c
-gcov-files-test-hbitmap-y =3D util/hbitmap.c
 check-unit-y +=3D tests/test-hbitmap$(EXESUF)
-gcov-files-test-hbitmap-y =3D blockjob.c
 check-unit-y +=3D tests/test-bdrv-drain$(EXESUF)
 check-unit-y +=3D tests/test-blockjob$(EXESUF)
 check-unit-y +=3D tests/test-blockjob-txn$(EXESUF)
 check-unit-y +=3D tests/test-block-backend$(EXESUF)
 check-unit-y +=3D tests/test-x86-cpuid$(EXESUF)
 # all code tested by test-x86-cpuid is inside topology.h
-gcov-files-test-x86-cpuid-y =3D
 ifeq ($(CONFIG_SOFTMMU),y)
 check-unit-y +=3D tests/test-xbzrle$(EXESUF)
-gcov-files-test-xbzrle-y =3D migration/xbzrle.c
 check-unit-$(CONFIG_POSIX) +=3D tests/test-vmstate$(EXESUF)
 endif
 check-unit-y +=3D tests/test-cutils$(EXESUF)
-gcov-files-test-cutils-y +=3D util/cutils.c
 check-unit-y +=3D tests/test-shift128$(EXESUF)
-gcov-files-test-shift128-y =3D util/host-utils.c
 check-unit-y +=3D tests/test-mul64$(EXESUF)
-gcov-files-test-mul64-y =3D util/host-utils.c
 check-unit-y +=3D tests/test-int128$(EXESUF)
 # all code tested by test-int128 is inside int128.h
-gcov-files-test-int128-y =3D
 check-unit-y +=3D tests/rcutorture$(EXESUF)
-gcov-files-rcutorture-y =3D util/rcu.c
 check-unit-y +=3D tests/test-rcu-list$(EXESUF)
-gcov-files-test-rcu-list-y =3D util/rcu.c
 check-unit-y +=3D tests/test-rcu-simpleq$(EXESUF)
-gcov-files-test-rcu-simpleq-y =3D util/rcu.c
 check-unit-y +=3D tests/test-rcu-tailq$(EXESUF)
-gcov-files-test-rcu-tailq-y =3D util/rcu.c
 check-unit-y +=3D tests/test-qdist$(EXESUF)
-gcov-files-test-qdist-y =3D util/qdist.c
 check-unit-y +=3D tests/test-qht$(EXESUF)
-gcov-files-test-qht-y =3D util/qht.c
 check-unit-y +=3D tests/test-qht-par$(EXESUF)
-gcov-files-test-qht-par-y =3D util/qht.c
 check-unit-y +=3D tests/test-bitops$(EXESUF)
 check-unit-y +=3D tests/test-bitcnt$(EXESUF)
 check-unit-y +=3D tests/test-qdev-global-props$(EXESUF)
 check-unit-y +=3D tests/check-qom-interface$(EXESUF)
-gcov-files-check-qom-interface-y =3D qom/object.c
 check-unit-y +=3D tests/check-qom-proplist$(EXESUF)
-gcov-files-check-qom-proplist-y =3D qom/object.c
 check-unit-y +=3D tests/test-qemu-opts$(EXESUF)
-gcov-files-test-qemu-opts-y =3D util/qemu-option.c
 check-unit-y +=3D tests/test-keyval$(EXESUF)
-gcov-files-test-keyval-y =3D util/keyval.c
 check-unit-y +=3D tests/test-write-threshold$(EXESUF)
-gcov-files-test-write-threshold-y =3D block/write-threshold.c
 check-unit-y +=3D tests/test-crypto-hash$(EXESUF)
 check-speed-y +=3D tests/benchmark-crypto-hash$(EXESUF)
 check-unit-y +=3D tests/test-crypto-hmac$(EXESUF)
@@ -166,15 +121,11 @@ check-unit-y +=3D tests/test-crypto-afsplit$(EXESUF=
)
 check-unit-y +=3D tests/test-crypto-xts$(EXESUF)
 check-unit-y +=3D tests/test-crypto-block$(EXESUF)
 check-unit-y +=3D tests/test-logging$(EXESUF)
-gcov-files-test-logging-y =3D util/log.c
 check-unit-$(CONFIG_REPLICATION) +=3D tests/test-replication$(EXESUF)
 check-unit-y +=3D tests/test-bufferiszero$(EXESUF)
-gcov-files-check-bufferiszero-y =3D util/bufferiszero.c
 check-unit-y +=3D tests/test-uuid$(EXESUF)
 check-unit-y +=3D tests/ptimer-test$(EXESUF)
-gcov-files-ptimer-test-y =3D hw/core/ptimer.c
 check-unit-y +=3D tests/test-qapi-util$(EXESUF)
-gcov-files-test-qapi-util-y =3D qapi/qapi-util.c
=20
 check-block-$(CONFIG_POSIX) +=3D tests/qemu-iotests-quick.sh
=20
@@ -182,87 +133,48 @@ check-block-$(CONFIG_POSIX) +=3D tests/qemu-iotests=
-quick.sh
 # really in libqtest, not in the testcases themselves.
=20
 check-qtest-generic-y +=3D tests/qmp-test$(EXESUF)
-gcov-files-generic-y =3D monitor.c qapi/qmp-dispatch.c
 check-qtest-generic-y +=3D tests/qmp-cmd-test$(EXESUF)
=20
 check-qtest-generic-y +=3D tests/device-introspect-test$(EXESUF)
-gcov-files-generic-y =3D qdev-monitor.c qmp.c
 check-qtest-generic-y +=3D tests/cdrom-test$(EXESUF)
=20
-gcov-files-ipack-y +=3D hw/ipack/ipack.c
 check-qtest-ipack-y +=3D tests/ipoctal232-test$(EXESUF)
-gcov-files-ipack-y +=3D hw/char/ipoctal232.c
=20
 check-qtest-virtioserial-y +=3D tests/virtio-console-test$(EXESUF)
-gcov-files-virtioserial-y +=3D hw/char/virtio-console.c
=20
-gcov-files-virtio-y +=3D i386-softmmu/hw/virtio/virtio.c
 check-qtest-virtio-y +=3D tests/virtio-net-test$(EXESUF)
-gcov-files-virtio-y +=3D i386-softmmu/hw/net/virtio-net.c
 check-qtest-virtio-y +=3D tests/virtio-balloon-test$(EXESUF)
-gcov-files-virtio-y +=3D i386-softmmu/hw/virtio/virtio-balloon.c
 check-qtest-virtio-y +=3D tests/virtio-blk-test$(EXESUF)
-gcov-files-virtio-y +=3D i386-softmmu/hw/block/virtio-blk.c
 check-qtest-virtio-y +=3D tests/virtio-rng-test$(EXESUF)
-gcov-files-virtio-y +=3D hw/virtio/virtio-rng.c
 check-qtest-virtio-y +=3D tests/virtio-scsi-test$(EXESUF)
-gcov-files-virtio-y +=3D i386-softmmu/hw/scsi/virtio-scsi.c
 ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
 check-qtest-virtio-y +=3D tests/virtio-9p-test$(EXESUF)
-gcov-files-virtio-y +=3D hw/9pfs/virtio-9p.c
-gcov-files-virtio-y +=3D i386-softmmu/hw/9pfs/virtio-9p-device.c
 endif
 check-qtest-virtio-y +=3D tests/virtio-serial-test$(EXESUF)
-gcov-files-virtio-y +=3D i386-softmmu/hw/char/virtio-serial-bus.c
 check-qtest-virtio-y +=3D $(check-qtest-virtioserial-y)
-gcov-files-virtio-y +=3D $(gcov-files-virtioserial-y)
=20
 check-qtest-pci-y +=3D tests/e1000-test$(EXESUF)
-gcov-files-pci-y +=3D hw/net/e1000.c
 check-qtest-pci-y +=3D tests/e1000e-test$(EXESUF)
-gcov-files-pci-y +=3D hw/net/e1000e.c hw/net/e1000e_core.c
 check-qtest-pci-$(CONFIG_RTL8139_PCI) +=3D tests/rtl8139-test$(EXESUF)
-gcov-files-pci-$(CONFIG_RTL8139_PCI) +=3D hw/net/rtl8139.c
 check-qtest-pci-$(CONFIG_PCNET_PCI) +=3D tests/pcnet-test$(EXESUF)
-gcov-files-pci-$(CONFIG_PCNET_PCI) +=3D hw/net/pcnet.c
-gcov-files-pci-$(CONFIG_PCNET_PCI) +=3D hw/net/pcnet-pci.c
 check-qtest-pci-$(CONFIG_EEPRO100_PCI) +=3D tests/eepro100-test$(EXESUF)
-gcov-files-pci-$(CONFIG_EEPRO100_PCI) +=3D hw/net/eepro100.c
 check-qtest-pci-$(CONFIG_NE2000_PCI) +=3D tests/ne2000-test$(EXESUF)
-gcov-files-pci-$(CONFIG_NE2000_PCI) +=3D hw/net/ne2000.c
 check-qtest-pci-$(CONFIG_NVME_PCI) +=3D tests/nvme-test$(EXESUF)
-gcov-files-pci-$(CONFIG_NVME_PCI) +=3D hw/block/nvme.c
 check-qtest-pci-$(CONFIG_AC97) +=3D tests/ac97-test$(EXESUF)
-gcov-files-pci-$(CONFIG_AC97) +=3D hw/audio/ac97.c
 check-qtest-pci-$(CONFIG_ES1370) +=3D tests/es1370-test$(EXESUF)
-gcov-files-pci-$(CONFIG_ES1370) +=3D hw/audio/es1370.c
 check-qtest-pci-y +=3D $(check-qtest-virtio-y)
-gcov-files-pci-y +=3D $(gcov-files-virtio-y) hw/virtio/virtio-pci.c
 check-qtest-pci-$(CONFIG_IPACK) +=3D tests/tpci200-test$(EXESUF)
-gcov-files-pci-$(CONFIG_IPACK) +=3D hw/ipack/tpci200.c
 check-qtest-pci-$(CONFIG_IPACK) +=3D $(check-qtest-ipack-y)
-gcov-files-pci-$(CONFIG_IPACK) +=3D $(gcov-files-ipack-y)
 check-qtest-pci-y +=3D tests/display-vga-test$(EXESUF)
-gcov-files-pci-y +=3D hw/display/vga.c
-gcov-files-pci-y +=3D hw/display/cirrus_vga.c
-gcov-files-pci-y +=3D hw/display/vga-pci.c
-gcov-files-pci-y +=3D hw/display/virtio-gpu.c
-gcov-files-pci-y +=3D hw/display/virtio-gpu-pci.c
-gcov-files-pci-$(CONFIG_VIRTIO_VGA) +=3D hw/display/virtio-vga.c
 check-qtest-pci-$(CONFIG_HDA) +=3D tests/intel-hda-test$(EXESUF)
-gcov-files-pci-$(CONFIG_HDA) +=3D hw/audio/intel-hda.c hw/audio/hda-code=
c.c
 check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) +=3D tests/ivshmem-test$(EXESUF=
)
-gcov-files-pci-$(CONFIG_IVSHMEM_DEVICE) +=3D hw/misc/ivshmem.c
 check-qtest-pci-y +=3D tests/megasas-test$(EXESUF)
-gcov-files-pci-y +=3D hw/scsi/megasas.c
=20
 check-qtest-i386-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF=
)
 check-qtest-i386-y +=3D tests/fdc-test$(EXESUF)
-gcov-files-i386-y =3D hw/block/fdc.c
 check-qtest-i386-y +=3D tests/ide-test$(EXESUF)
 check-qtest-i386-y +=3D tests/ahci-test$(EXESUF)
 check-qtest-i386-y +=3D tests/hd-geo-test$(EXESUF)
-gcov-files-i386-y +=3D hw/block/hd-geometry.c
 check-qtest-i386-y +=3D tests/boot-order-test$(EXESUF)
 check-qtest-i386-y +=3D tests/bios-tables-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SGA) +=3D tests/boot-serial-test$(EXESUF)
@@ -274,37 +186,21 @@ check-qtest-i386-y +=3D tests/i440fx-test$(EXESUF)
 check-qtest-i386-y +=3D tests/fw_cfg-test$(EXESUF)
 check-qtest-i386-y +=3D tests/drive_del-test$(EXESUF)
 check-qtest-i386-$(CONFIG_WDT_IB700) +=3D tests/wdt_ib700-test$(EXESUF)
-gcov-files-i386-$(CONFIG_WDT_IB700) +=3D hw/watchdog/watchdog.c hw/watch=
dog/wdt_ib700.c
 check-qtest-i386-y +=3D tests/tco-test$(EXESUF)
 check-qtest-i386-y +=3D $(check-qtest-pci-y)
-gcov-files-i386-y +=3D $(gcov-files-pci-y)
 check-qtest-i386-$(CONFIG_VMXNET3_PCI) +=3D tests/vmxnet3-test$(EXESUF)
-gcov-files-i386-$(CONFIG_VMXNET3_PCI) +=3D hw/net/vmxnet3.c
-gcov-files-i386-y +=3D hw/net/net_rx_pkt.c
-gcov-files-i386-y +=3D hw/net/net_tx_pkt.c
 check-qtest-i386-$(CONFIG_PVPANIC) +=3D tests/pvpanic-test$(EXESUF)
-gcov-files-i386-$(CONFIG_PVPANIC) +=3D i386-softmmu/hw/misc/pvpanic.c
 check-qtest-i386-$(CONFIG_I82801B11) +=3D tests/i82801b11-test$(EXESUF)
-gcov-files-i386-$(CONFIG_I82801B11) +=3D hw/pci-bridge/i82801b11.c
 check-qtest-i386-$(CONFIG_IOH3420) +=3D tests/ioh3420-test$(EXESUF)
-gcov-files-i386-$(CONFIG_IOH3420) +=3D hw/pci-bridge/ioh3420.c
 check-qtest-i386-$(CONFIG_USB_OHCI) +=3D tests/usb-hcd-ohci-test$(EXESUF=
)
-gcov-files-i386-$(CONFIG_USB_OHCI) +=3D hw/usb/hcd-ohci.c
 check-qtest-i386-$(CONFIG_USB_UHCI) +=3D tests/usb-hcd-uhci-test$(EXESUF=
)
-gcov-files-i386-$(CONFIG_USB_UHCI) +=3D hw/usb/hcd-uhci.c
 ifeq ($(CONFIG_USB_ECHI)$(CONFIG_USB_UHCI),yy)
 check-qtest-i386-y +=3D tests/usb-hcd-ehci-test$(EXESUF)
 endif
-gcov-files-i386-$(CONFIG_USB_EHCI) +=3D hw/usb/hcd-ehci.c
-gcov-files-i386-y +=3D hw/usb/dev-hid.c
-gcov-files-i386-y +=3D hw/usb/dev-storage.c
 check-qtest-i386-$(CONFIG_USB_XHCI_NEC) +=3D tests/usb-hcd-xhci-test$(EX=
ESUF)
-gcov-files-i386-$(CONFIG_USB_XHCI) +=3D hw/usb/hcd-xhci.c
-gcov-files-i386-$(CONFIG_USB_XHCI) +=3D hw/usb/hcd-xhci-nec.c
 check-qtest-i386-y +=3D tests/cpu-plug-test$(EXESUF)
 check-qtest-i386-y +=3D tests/q35-test$(EXESUF)
 check-qtest-i386-y +=3D tests/vmgenid-test$(EXESUF)
-gcov-files-i386-y +=3D hw/pci-host/q35.c
 check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) +=3D tests/vhost-use=
r-test$(EXESUF)
 ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
 check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) +=3D tests/vhost=
-user-test$(EXESUF)
@@ -321,8 +217,6 @@ check-qtest-i386-y +=3D tests/test-x86-cpuid-compat$(=
EXESUF)
 check-qtest-i386-y +=3D tests/numa-test$(EXESUF)
 check-qtest-x86_64-y +=3D $(check-qtest-i386-y)
 check-qtest-x86_64-$(CONFIG_SDHCI) +=3D tests/sdhci-test$(EXESUF)
-gcov-files-i386-y +=3D i386-softmmu/hw/timer/mc146818rtc.c
-gcov-files-x86_64-y =3D $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-fil=
es-i386-y))
=20
 check-qtest-alpha-y +=3D tests/boot-serial-test$(EXESUF)
=20
@@ -346,23 +240,16 @@ check-qtest-ppc-y +=3D tests/prom-env-test$(EXESUF)
 check-qtest-ppc-y +=3D tests/drive_del-test$(EXESUF)
 check-qtest-ppc-y +=3D tests/boot-serial-test$(EXESUF)
 check-qtest-ppc-y +=3D tests/m48t59-test$(EXESUF)
-gcov-files-ppc-y +=3D hw/timer/m48t59.c
=20
 check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)
-gcov-files-ppc64-y =3D $(subst ppc-softmmu/,ppc64-softmmu/,$(gcov-files-=
ppc-y))
 check-qtest-ppc64-y +=3D tests/spapr-phb-test$(EXESUF)
-gcov-files-ppc64-y +=3D ppc64-softmmu/hw/ppc/spapr_pci.c
 check-qtest-ppc64-y +=3D tests/pnv-xscom-test$(EXESUF)
 check-qtest-ppc64-y +=3D tests/migration-test$(EXESUF)
 check-qtest-ppc64-y +=3D tests/rtas-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_SLIRP) +=3D tests/pxe-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_USB_OHCI) +=3D tests/usb-hcd-ohci-test$(EXESU=
F)
-gcov-files-ppc64-$(CONFIG_USB_OHCI) +=3D hw/usb/hcd-ohci.c
 check-qtest-ppc64-$(CONFIG_USB_UHCI) +=3D tests/usb-hcd-uhci-test$(EXESU=
F)
-gcov-files-ppc64-$(CONFIG_USB_UHCI) +=3D hw/usb/hcd-uhci.c
 check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) +=3D tests/usb-hcd-xhci-test$(E=
XESUF)
-gcov-files-ppc64-$(CONFIG_USB_XHCI) +=3D hw/usb/hcd-xhci.c
-gcov-files-ppc64-$(CONFIG_USB_XHCI) +=3D hw/usb/hcd-xhci-nec.c
 check-qtest-ppc64-y +=3D $(check-qtest-virtio-y)
 check-qtest-ppc64-$(CONFIG_SLIRP) +=3D tests/test-netfilter$(EXESUF)
 check-qtest-ppc64-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESUF)
@@ -370,7 +257,6 @@ check-qtest-ppc64-$(CONFIG_RTL8139_PCI) +=3D tests/te=
st-filter-redirector$(EXESUF)
 check-qtest-ppc64-y +=3D tests/display-vga-test$(EXESUF)
 check-qtest-ppc64-y +=3D tests/numa-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) +=3D tests/ivshmem-test$(EXES=
UF)
-gcov-files-ppc64-$(CONFIG_IVSHMEM_DEVICE) +=3D hw/misc/ivshmem.c
 check-qtest-ppc64-y +=3D tests/cpu-plug-test$(EXESUF)
=20
 check-qtest-sh4-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF)
@@ -379,7 +265,6 @@ check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D tests/end=
ianness-test$(EXESUF)
=20
 check-qtest-sparc-y +=3D tests/prom-env-test$(EXESUF)
 check-qtest-sparc-y +=3D tests/m48t59-test$(EXESUF)
-gcov-files-sparc-y =3D hw/timer/m48t59.c
 check-qtest-sparc-y +=3D tests/boot-serial-test$(EXESUF)
=20
 check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXE=
SUF)
@@ -390,11 +275,8 @@ check-qtest-arm-y +=3D tests/tmp105-test$(EXESUF)
 check-qtest-arm-y +=3D tests/pca9552-test$(EXESUF)
 check-qtest-arm-y +=3D tests/ds1338-test$(EXESUF)
 check-qtest-arm-y +=3D tests/m25p80-test$(EXESUF)
-gcov-files-arm-y +=3D hw/misc/tmp105.c
 check-qtest-arm-y +=3D tests/virtio-blk-test$(EXESUF)
-gcov-files-arm-y +=3D arm-softmmu/hw/block/virtio-blk.c
 check-qtest-arm-y +=3D tests/test-arm-mptimer$(EXESUF)
-gcov-files-arm-y +=3D hw/timer/arm_mptimer.c
 check-qtest-arm-y +=3D tests/boot-serial-test$(EXESUF)
 check-qtest-arm-$(CONFIG_SDHCI) +=3D tests/sdhci-test$(EXESUF)
 check-qtest-arm-y +=3D tests/hexloader-test$(EXESUF)
--=20
1.8.3.1
