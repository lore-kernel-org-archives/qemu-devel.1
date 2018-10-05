Received: from eggs.gnu.org ([2001:4830:134:3::10]:46279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8T6e-00053i-6s
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8T6Y-0001i1-TG
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:37:36 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:51329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8T6V-0001VQ-0L
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:37:28 -0400
Received: by mail-wm1-f50.google.com with SMTP id 143-v6so2430286wmf.1
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 09:37:20 -0700 (PDT)
References: <1538756242-54922-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dc7a5027-e3fb-c7dd-6f99-b0f05c0dc124@redhat.com>
Date: Fri, 5 Oct 2018 18:37:17 +0200
MIME-Version: 1.0
In-Reply-To: <1538756242-54922-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests: remove gcov-files- variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/10/2018 18:17, Paolo Bonzini wrote:
> Commit 31d2dda ("build-system: remove per-test GCOV reporting", 2018-06-20)
> removed users of the variables, since those uses can be replaced by a simple
> overall report produced by gcovr.  However, the variables were never removed.
> Do it now.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/testing.rst |   4 +-
>  tests/Makefile.include | 118 -------------------------------------------------

Nice :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  2 files changed, 1 insertion(+), 121 deletions(-)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 727c401..fcfad87 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -43,15 +43,13 @@ add a new unit test:
>  
>  3. Add the test to ``tests/Makefile.include``. First, name the unit test
>     program and add it to ``$(check-unit-y)``; then add a rule to build the
> -   executable. Optionally, you can add a magical variable to support ``gcov``.
> -   For example:
> +   executable.  For example:
>  
>  .. code::
>  
>    check-unit-y += tests/foo-test$(EXESUF)
>    tests/foo-test$(EXESUF): tests/foo-test.o $(test-util-obj-y)
>    ...
> -  gcov-files-foo-test-y = util/foo.c
>  
>  Since unit tests don't require environment variables, the simplest way to debug
>  a unit test failure is often directly invoking it or even running it under
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 175d013..993823a 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -39,106 +39,61 @@ SYSEMU_TARGET_LIST := $(subst -softmmu.mak,,$(notdir \
>     $(wildcard $(SRC_PATH)/default-configs/*-softmmu.mak)))
>  
>  check-unit-y = tests/check-qdict$(EXESUF)
> -gcov-files-check-qdict-y = qobject/qdict.c
>  check-unit-y = tests/check-block-qdict$(EXESUF)
> -gcov-files-check-block-qdict-y = qobject/block-qdict.c
>  check-unit-y += tests/test-char$(EXESUF)
> -gcov-files-check-qdict-y = chardev/char.c
>  check-unit-y += tests/check-qnum$(EXESUF)
> -gcov-files-check-qnum-y = qobject/qnum.c
>  check-unit-y += tests/check-qstring$(EXESUF)
> -gcov-files-check-qstring-y = qobject/qstring.c
>  check-unit-y += tests/check-qlist$(EXESUF)
> -gcov-files-check-qlist-y = qobject/qlist.c
>  check-unit-y += tests/check-qnull$(EXESUF)
> -gcov-files-check-qnull-y = qobject/qnull.c
>  check-unit-y += tests/check-qobject$(EXESUF)
>  check-unit-y += tests/check-qjson$(EXESUF)
> -gcov-files-check-qjson-y = qobject/qjson.c
>  check-unit-y += tests/check-qlit$(EXESUF)
> -gcov-files-check-qlit-y = qobject/qlit.c
>  check-unit-y += tests/test-qobject-output-visitor$(EXESUF)
> -gcov-files-test-qobject-output-visitor-y = qapi/qobject-output-visitor.c
>  check-unit-y += tests/test-clone-visitor$(EXESUF)
> -gcov-files-test-clone-visitor-y = qapi/qapi-clone-visitor.c
>  check-unit-y += tests/test-qobject-input-visitor$(EXESUF)
> -gcov-files-test-qobject-input-visitor-y = qapi/qobject-input-visitor.c
>  check-unit-y += tests/test-qmp-cmds$(EXESUF)
> -gcov-files-test-qmp-cmds-y = qapi/qmp-dispatch.c
>  check-unit-y += tests/test-string-input-visitor$(EXESUF)
> -gcov-files-test-string-input-visitor-y = qapi/string-input-visitor.c
>  check-unit-y += tests/test-string-output-visitor$(EXESUF)
> -gcov-files-test-string-output-visitor-y = qapi/string-output-visitor.c
>  check-unit-y += tests/test-qmp-event$(EXESUF)
> -gcov-files-test-qmp-event-y += qapi/qmp-event.c
>  check-unit-y += tests/test-opts-visitor$(EXESUF)
> -gcov-files-test-opts-visitor-y = qapi/opts-visitor.c
>  check-unit-y += tests/test-coroutine$(EXESUF)
> -gcov-files-test-coroutine-y = coroutine-$(CONFIG_COROUTINE_BACKEND).c
>  check-unit-y += tests/test-visitor-serialization$(EXESUF)
>  check-unit-y += tests/test-iov$(EXESUF)
> -gcov-files-test-iov-y = util/iov.c
>  check-unit-y += tests/test-aio$(EXESUF)
> -gcov-files-test-aio-y = util/async.c util/qemu-timer.o
> -gcov-files-test-aio-$(CONFIG_WIN32) += util/aio-win32.c
> -gcov-files-test-aio-$(CONFIG_POSIX) += util/aio-posix.c
>  check-unit-y += tests/test-aio-multithread$(EXESUF)
> -gcov-files-test-aio-multithread-y = $(gcov-files-test-aio-y)
> -gcov-files-test-aio-multithread-y += util/qemu-coroutine.c tests/iothread.c
>  check-unit-y += tests/test-throttle$(EXESUF)
>  check-unit-y += tests/test-thread-pool$(EXESUF)
> -gcov-files-test-thread-pool-y = thread-pool.c
> -gcov-files-test-hbitmap-y = util/hbitmap.c
>  check-unit-y += tests/test-hbitmap$(EXESUF)
> -gcov-files-test-hbitmap-y = blockjob.c
>  check-unit-y += tests/test-bdrv-drain$(EXESUF)
>  check-unit-y += tests/test-blockjob$(EXESUF)
>  check-unit-y += tests/test-blockjob-txn$(EXESUF)
>  check-unit-y += tests/test-block-backend$(EXESUF)
>  check-unit-y += tests/test-x86-cpuid$(EXESUF)
>  # all code tested by test-x86-cpuid is inside topology.h
> -gcov-files-test-x86-cpuid-y =
>  ifeq ($(CONFIG_SOFTMMU),y)
>  check-unit-y += tests/test-xbzrle$(EXESUF)
> -gcov-files-test-xbzrle-y = migration/xbzrle.c
>  check-unit-$(CONFIG_POSIX) += tests/test-vmstate$(EXESUF)
>  endif
>  check-unit-y += tests/test-cutils$(EXESUF)
> -gcov-files-test-cutils-y += util/cutils.c
>  check-unit-y += tests/test-shift128$(EXESUF)
> -gcov-files-test-shift128-y = util/host-utils.c
>  check-unit-y += tests/test-mul64$(EXESUF)
> -gcov-files-test-mul64-y = util/host-utils.c
>  check-unit-y += tests/test-int128$(EXESUF)
>  # all code tested by test-int128 is inside int128.h
> -gcov-files-test-int128-y =
>  check-unit-y += tests/rcutorture$(EXESUF)
> -gcov-files-rcutorture-y = util/rcu.c
>  check-unit-y += tests/test-rcu-list$(EXESUF)
> -gcov-files-test-rcu-list-y = util/rcu.c
>  check-unit-y += tests/test-rcu-simpleq$(EXESUF)
> -gcov-files-test-rcu-simpleq-y = util/rcu.c
>  check-unit-y += tests/test-rcu-tailq$(EXESUF)
> -gcov-files-test-rcu-tailq-y = util/rcu.c
>  check-unit-y += tests/test-qdist$(EXESUF)
> -gcov-files-test-qdist-y = util/qdist.c
>  check-unit-y += tests/test-qht$(EXESUF)
> -gcov-files-test-qht-y = util/qht.c
>  check-unit-y += tests/test-qht-par$(EXESUF)
> -gcov-files-test-qht-par-y = util/qht.c
>  check-unit-y += tests/test-bitops$(EXESUF)
>  check-unit-y += tests/test-bitcnt$(EXESUF)
>  check-unit-y += tests/test-qdev-global-props$(EXESUF)
>  check-unit-y += tests/check-qom-interface$(EXESUF)
> -gcov-files-check-qom-interface-y = qom/object.c
>  check-unit-y += tests/check-qom-proplist$(EXESUF)
> -gcov-files-check-qom-proplist-y = qom/object.c
>  check-unit-y += tests/test-qemu-opts$(EXESUF)
> -gcov-files-test-qemu-opts-y = util/qemu-option.c
>  check-unit-y += tests/test-keyval$(EXESUF)
> -gcov-files-test-keyval-y = util/keyval.c
>  check-unit-y += tests/test-write-threshold$(EXESUF)
> -gcov-files-test-write-threshold-y = block/write-threshold.c
>  check-unit-y += tests/test-crypto-hash$(EXESUF)
>  check-speed-y += tests/benchmark-crypto-hash$(EXESUF)
>  check-unit-y += tests/test-crypto-hmac$(EXESUF)
> @@ -166,15 +121,11 @@ check-unit-y += tests/test-crypto-afsplit$(EXESUF)
>  check-unit-y += tests/test-crypto-xts$(EXESUF)
>  check-unit-y += tests/test-crypto-block$(EXESUF)
>  check-unit-y += tests/test-logging$(EXESUF)
> -gcov-files-test-logging-y = util/log.c
>  check-unit-$(CONFIG_REPLICATION) += tests/test-replication$(EXESUF)
>  check-unit-y += tests/test-bufferiszero$(EXESUF)
> -gcov-files-check-bufferiszero-y = util/bufferiszero.c
>  check-unit-y += tests/test-uuid$(EXESUF)
>  check-unit-y += tests/ptimer-test$(EXESUF)
> -gcov-files-ptimer-test-y = hw/core/ptimer.c
>  check-unit-y += tests/test-qapi-util$(EXESUF)
> -gcov-files-test-qapi-util-y = qapi/qapi-util.c
>  
>  check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
>  
> @@ -182,87 +133,48 @@ check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
>  # really in libqtest, not in the testcases themselves.
>  
>  check-qtest-generic-y = tests/qmp-test$(EXESUF)
> -gcov-files-generic-y = monitor.c qapi/qmp-dispatch.c
>  check-qtest-generic-y += tests/qmp-cmd-test$(EXESUF)
>  
>  check-qtest-generic-y += tests/device-introspect-test$(EXESUF)
> -gcov-files-generic-y = qdev-monitor.c qmp.c
>  check-qtest-generic-y += tests/cdrom-test$(EXESUF)
>  
> -gcov-files-ipack-y += hw/ipack/ipack.c
>  check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
> -gcov-files-ipack-y += hw/char/ipoctal232.c
>  
>  check-qtest-virtioserial-y += tests/virtio-console-test$(EXESUF)
> -gcov-files-virtioserial-y += hw/char/virtio-console.c
>  
> -gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio.c
>  check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
> -gcov-files-virtio-y += i386-softmmu/hw/net/virtio-net.c
>  check-qtest-virtio-y += tests/virtio-balloon-test$(EXESUF)
> -gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio-balloon.c
>  check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
> -gcov-files-virtio-y += i386-softmmu/hw/block/virtio-blk.c
>  check-qtest-virtio-y += tests/virtio-rng-test$(EXESUF)
> -gcov-files-virtio-y += hw/virtio/virtio-rng.c
>  check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
> -gcov-files-virtio-y += i386-softmmu/hw/scsi/virtio-scsi.c
>  ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
>  check-qtest-virtio-y += tests/virtio-9p-test$(EXESUF)
> -gcov-files-virtio-y += hw/9pfs/virtio-9p.c
> -gcov-files-virtio-y += i386-softmmu/hw/9pfs/virtio-9p-device.c
>  endif
>  check-qtest-virtio-y += tests/virtio-serial-test$(EXESUF)
> -gcov-files-virtio-y += i386-softmmu/hw/char/virtio-serial-bus.c
>  check-qtest-virtio-y += $(check-qtest-virtioserial-y)
> -gcov-files-virtio-y += $(gcov-files-virtioserial-y)
>  
>  check-qtest-pci-y += tests/e1000-test$(EXESUF)
> -gcov-files-pci-y += hw/net/e1000.c
>  check-qtest-pci-y += tests/e1000e-test$(EXESUF)
> -gcov-files-pci-y += hw/net/e1000e.c hw/net/e1000e_core.c
>  check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
> -gcov-files-pci-$(CONFIG_RTL8139_PCI) += hw/net/rtl8139.c
>  check-qtest-pci-$(CONFIG_PCNET_PCI) += tests/pcnet-test$(EXESUF)
> -gcov-files-pci-$(CONFIG_PCNET_PCI) += hw/net/pcnet.c
> -gcov-files-pci-$(CONFIG_PCNET_PCI) += hw/net/pcnet-pci.c
>  check-qtest-pci-$(CONFIG_EEPRO100_PCI) += tests/eepro100-test$(EXESUF)
> -gcov-files-pci-$(CONFIG_EEPRO100_PCI) += hw/net/eepro100.c
>  check-qtest-pci-$(CONFIG_NE2000_PCI) += tests/ne2000-test$(EXESUF)
> -gcov-files-pci-$(CONFIG_NE2000_PCI) += hw/net/ne2000.c
>  check-qtest-pci-$(CONFIG_NVME_PCI) += tests/nvme-test$(EXESUF)
> -gcov-files-pci-$(CONFIG_NVME_PCI) += hw/block/nvme.c
>  check-qtest-pci-$(CONFIG_AC97) += tests/ac97-test$(EXESUF)
> -gcov-files-pci-$(CONFIG_AC97) += hw/audio/ac97.c
>  check-qtest-pci-$(CONFIG_ES1370) += tests/es1370-test$(EXESUF)
> -gcov-files-pci-$(CONFIG_ES1370) += hw/audio/es1370.c
>  check-qtest-pci-y += $(check-qtest-virtio-y)
> -gcov-files-pci-y += $(gcov-files-virtio-y) hw/virtio/virtio-pci.c
>  check-qtest-pci-$(CONFIG_IPACK) += tests/tpci200-test$(EXESUF)
> -gcov-files-pci-$(CONFIG_IPACK) += hw/ipack/tpci200.c
>  check-qtest-pci-$(CONFIG_IPACK) += $(check-qtest-ipack-y)
> -gcov-files-pci-$(CONFIG_IPACK) += $(gcov-files-ipack-y)
>  check-qtest-pci-y += tests/display-vga-test$(EXESUF)
> -gcov-files-pci-y += hw/display/vga.c
> -gcov-files-pci-y += hw/display/cirrus_vga.c
> -gcov-files-pci-y += hw/display/vga-pci.c
> -gcov-files-pci-y += hw/display/virtio-gpu.c
> -gcov-files-pci-y += hw/display/virtio-gpu-pci.c
> -gcov-files-pci-$(CONFIG_VIRTIO_VGA) += hw/display/virtio-vga.c
>  check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
> -gcov-files-pci-$(CONFIG_HDA) += hw/audio/intel-hda.c hw/audio/hda-codec.c
>  check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
> -gcov-files-pci-$(CONFIG_IVSHMEM_DEVICE) += hw/misc/ivshmem.c
>  check-qtest-pci-y += tests/megasas-test$(EXESUF)
> -gcov-files-pci-y += hw/scsi/megasas.c
>  
>  check-qtest-i386-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  check-qtest-i386-y += tests/fdc-test$(EXESUF)
> -gcov-files-i386-y = hw/block/fdc.c
>  check-qtest-i386-y += tests/ide-test$(EXESUF)
>  check-qtest-i386-y += tests/ahci-test$(EXESUF)
>  check-qtest-i386-y += tests/hd-geo-test$(EXESUF)
> -gcov-files-i386-y += hw/block/hd-geometry.c
>  check-qtest-i386-y += tests/boot-order-test$(EXESUF)
>  check-qtest-i386-y += tests/bios-tables-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_SGA) += tests/boot-serial-test$(EXESUF)
> @@ -274,37 +186,21 @@ check-qtest-i386-y += tests/i440fx-test$(EXESUF)
>  check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
>  check-qtest-i386-y += tests/drive_del-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_WDT_IB700) += tests/wdt_ib700-test$(EXESUF)
> -gcov-files-i386-$(CONFIG_WDT_IB700) += hw/watchdog/watchdog.c hw/watchdog/wdt_ib700.c
>  check-qtest-i386-y += tests/tco-test$(EXESUF)
>  check-qtest-i386-y += $(check-qtest-pci-y)
> -gcov-files-i386-y += $(gcov-files-pci-y)
>  check-qtest-i386-$(CONFIG_VMXNET3_PCI) += tests/vmxnet3-test$(EXESUF)
> -gcov-files-i386-$(CONFIG_VMXNET3_PCI) += hw/net/vmxnet3.c
> -gcov-files-i386-y += hw/net/net_rx_pkt.c
> -gcov-files-i386-y += hw/net/net_tx_pkt.c
>  check-qtest-i386-$(CONFIG_PVPANIC) += tests/pvpanic-test$(EXESUF)
> -gcov-files-i386-$(CONFIG_PVPANIC) += i386-softmmu/hw/misc/pvpanic.c
>  check-qtest-i386-$(CONFIG_I82801B11) += tests/i82801b11-test$(EXESUF)
> -gcov-files-i386-$(CONFIG_I82801B11) += hw/pci-bridge/i82801b11.c
>  check-qtest-i386-$(CONFIG_IOH3420) += tests/ioh3420-test$(EXESUF)
> -gcov-files-i386-$(CONFIG_IOH3420) += hw/pci-bridge/ioh3420.c
>  check-qtest-i386-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
> -gcov-files-i386-$(CONFIG_USB_OHCI) += hw/usb/hcd-ohci.c
>  check-qtest-i386-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
> -gcov-files-i386-$(CONFIG_USB_UHCI) += hw/usb/hcd-uhci.c
>  ifeq ($(CONFIG_USB_ECHI)$(CONFIG_USB_UHCI),yy)
>  check-qtest-i386-y += tests/usb-hcd-ehci-test$(EXESUF)
>  endif
> -gcov-files-i386-$(CONFIG_USB_EHCI) += hw/usb/hcd-ehci.c
> -gcov-files-i386-y += hw/usb/dev-hid.c
> -gcov-files-i386-y += hw/usb/dev-storage.c
>  check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
> -gcov-files-i386-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci.c
> -gcov-files-i386-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci-nec.c
>  check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
>  check-qtest-i386-y += tests/q35-test$(EXESUF)
>  check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
> -gcov-files-i386-y += hw/pci-host/q35.c
>  check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
>  ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
>  check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
> @@ -321,8 +217,6 @@ check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
>  check-qtest-i386-y += tests/numa-test$(EXESUF)
>  check-qtest-x86_64-y += $(check-qtest-i386-y)
>  check-qtest-x86_64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
> -gcov-files-i386-y += i386-softmmu/hw/timer/mc146818rtc.c
> -gcov-files-x86_64-y = $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-files-i386-y))
>  
>  check-qtest-alpha-y = tests/boot-serial-test$(EXESUF)
>  
> @@ -346,23 +240,16 @@ check-qtest-ppc-y += tests/prom-env-test$(EXESUF)
>  check-qtest-ppc-y += tests/drive_del-test$(EXESUF)
>  check-qtest-ppc-y += tests/boot-serial-test$(EXESUF)
>  check-qtest-ppc-y += tests/m48t59-test$(EXESUF)
> -gcov-files-ppc-y += hw/timer/m48t59.c
>  
>  check-qtest-ppc64-y = $(check-qtest-ppc-y)
> -gcov-files-ppc64-y = $(subst ppc-softmmu/,ppc64-softmmu/,$(gcov-files-ppc-y))
>  check-qtest-ppc64-y += tests/spapr-phb-test$(EXESUF)
> -gcov-files-ppc64-y += ppc64-softmmu/hw/ppc/spapr_pci.c
>  check-qtest-ppc64-y += tests/pnv-xscom-test$(EXESUF)
>  check-qtest-ppc64-y += tests/migration-test$(EXESUF)
>  check-qtest-ppc64-y += tests/rtas-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
> -gcov-files-ppc64-$(CONFIG_USB_OHCI) += hw/usb/hcd-ohci.c
>  check-qtest-ppc64-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
> -gcov-files-ppc64-$(CONFIG_USB_UHCI) += hw/usb/hcd-uhci.c
>  check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
> -gcov-files-ppc64-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci.c
> -gcov-files-ppc64-$(CONFIG_USB_XHCI) += hw/usb/hcd-xhci-nec.c
>  check-qtest-ppc64-y += $(check-qtest-virtio-y)
>  check-qtest-ppc64-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
> @@ -370,7 +257,6 @@ check-qtest-ppc64-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
>  check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
>  check-qtest-ppc64-y += tests/numa-test$(EXESUF)
>  check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
> -gcov-files-ppc64-$(CONFIG_IVSHMEM_DEVICE) += hw/misc/ivshmem.c
>  check-qtest-ppc64-y += tests/cpu-plug-test$(EXESUF)
>  
>  check-qtest-sh4-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> @@ -379,7 +265,6 @@ check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  
>  check-qtest-sparc-y = tests/prom-env-test$(EXESUF)
>  check-qtest-sparc-y += tests/m48t59-test$(EXESUF)
> -gcov-files-sparc-y = hw/timer/m48t59.c
>  check-qtest-sparc-y += tests/boot-serial-test$(EXESUF)
>  
>  check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> @@ -390,11 +275,8 @@ check-qtest-arm-y = tests/tmp105-test$(EXESUF)
>  check-qtest-arm-y += tests/pca9552-test$(EXESUF)
>  check-qtest-arm-y += tests/ds1338-test$(EXESUF)
>  check-qtest-arm-y += tests/m25p80-test$(EXESUF)
> -gcov-files-arm-y += hw/misc/tmp105.c
>  check-qtest-arm-y += tests/virtio-blk-test$(EXESUF)
> -gcov-files-arm-y += arm-softmmu/hw/block/virtio-blk.c
>  check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
> -gcov-files-arm-y += hw/timer/arm_mptimer.c
>  check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
>  check-qtest-arm-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
>  check-qtest-arm-y += tests/hexloader-test$(EXESUF)
> 
