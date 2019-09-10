Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88778C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF2321479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF2321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44167 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7lTr-0007qq-Fa
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 15:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i7lM0-00007Q-Na
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i7lLv-0006Hg-Ug
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:59:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52854)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i7lLt-0006G7-RB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:58:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D251859FE;
 Tue, 10 Sep 2019 18:58:56 +0000 (UTC)
Received: from thuth.com (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B21419C58;
 Tue, 10 Sep 2019 18:58:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 20:58:38 +0200
Message-Id: <20190910185839.19682-7-thuth@redhat.com>
In-Reply-To: <20190910185839.19682-1-thuth@redhat.com>
References: <20190910185839.19682-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 10 Sep 2019 18:58:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 6/7] tests/Makefile: Move qtest-related
 settings to a separate Makefile.include
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

tests/Makefile.include is pretty much overcrowded. Now that we have a
dedicated folder for the qtests, let's move the related settings
to a Makefile.include file in that directory instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include       | 306 +----------------------------------
 tests/qtest/Makefile.include | 305 ++++++++++++++++++++++++++++++++++
 2 files changed, 306 insertions(+), 305 deletions(-)
 create mode 100644 tests/qtest/Makefile.include

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3de768ab5d..d68b2d68a8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -144,154 +144,6 @@ check-unit-y += tests/test-qapi-util$(EXESUF)
 
 check-block-$(call land,$(CONFIG_POSIX),$(CONFIG_SOFTMMU)) += tests/check-block.sh
 
-# All QTests for now are POSIX-only, but the dependencies are
-# really in libqtest, not in the testcases themselves.
-
-check-qtest-generic-y += qmp-test
-check-qtest-generic-y += qmp-cmd-test
-check-qtest-generic-$(CONFIG_MODULES) += modules-test
-
-check-qtest-generic-y += device-introspect-test
-check-qtest-generic-y += cdrom-test
-
-check-qtest-pci-$(CONFIG_RTL8139_PCI) += rtl8139-test
-check-qtest-pci-$(CONFIG_VGA) += display-vga-test
-check-qtest-pci-$(CONFIG_HDA) += intel-hda-test
-check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += ivshmem-test
-
-check-qtest-i386-$(CONFIG_ISA_TESTDEV) = endianness-test
-check-qtest-i386-y += fdc-test
-check-qtest-i386-y += ide-test
-check-qtest-i386-y += ahci-test
-check-qtest-i386-y += hd-geo-test
-check-qtest-i386-y += boot-order-test
-check-qtest-i386-y += bios-tables-test
-check-qtest-i386-$(CONFIG_SGA) += boot-serial-test
-check-qtest-i386-$(CONFIG_SLIRP) += pxe-test
-check-qtest-i386-y += rtc-test
-check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) += ipmi-kcs-test
-# Disabled temporarily as it fails intermittently especially under NetBSD VM
-# check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += ipmi-bt-test
-check-qtest-i386-y += i440fx-test
-check-qtest-i386-y += fw_cfg-test
-check-qtest-i386-y += device-plug-test
-check-qtest-i386-y += drive_del-test
-check-qtest-i386-$(CONFIG_WDT_IB700) += wdt_ib700-test
-check-qtest-i386-y += tco-test
-check-qtest-i386-y += $(check-qtest-pci-y)
-check-qtest-i386-$(CONFIG_PVPANIC) += pvpanic-test
-check-qtest-i386-$(CONFIG_I82801B11) += i82801b11-test
-check-qtest-i386-$(CONFIG_IOH3420) += ioh3420-test
-check-qtest-i386-$(CONFIG_USB_UHCI) += usb-hcd-uhci-test
-ifeq ($(CONFIG_USB_ECHI)$(CONFIG_USB_UHCI),yy)
-check-qtest-i386-y += usb-hcd-ehci-test
-endif
-check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += usb-hcd-xhci-test
-check-qtest-i386-y += cpu-plug-test
-check-qtest-i386-y += q35-test
-check-qtest-i386-y += vmgenid-test
-check-qtest-i386-$(CONFIG_TPM_CRB) += tpm-crb-swtpm-test
-check-qtest-i386-$(CONFIG_TPM_CRB) += tpm-crb-test
-check-qtest-i386-$(CONFIG_TPM_TIS) += tpm-tis-swtpm-test
-check-qtest-i386-$(CONFIG_TPM_TIS) += tpm-tis-test
-check-qtest-i386-$(CONFIG_SLIRP) += test-netfilter
-check-qtest-i386-$(CONFIG_POSIX) += test-filter-mirror
-check-qtest-i386-$(CONFIG_RTL8139_PCI) += test-filter-redirector
-check-qtest-i386-y += migration-test
-check-qtest-i386-y += test-x86-cpuid-compat
-check-qtest-i386-y += numa-test
-check-qtest-x86_64-y += $(check-qtest-i386-y)
-
-check-qtest-alpha-y += boot-serial-test
-check-qtest-alpha-$(CONFIG_VGA) += display-vga-test
-
-check-qtest-hppa-y += boot-serial-test
-check-qtest-hppa-$(CONFIG_VGA) += display-vga-test
-
-check-qtest-m68k-y = boot-serial-test
-
-check-qtest-microblaze-y += boot-serial-test
-
-check-qtest-mips-$(CONFIG_ISA_TESTDEV) = endianness-test
-check-qtest-mips-$(CONFIG_VGA) += display-vga-test
-
-check-qtest-mips64-$(CONFIG_ISA_TESTDEV) = endianness-test
-check-qtest-mips64-$(CONFIG_VGA) += display-vga-test
-
-check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) = endianness-test
-check-qtest-mips64el-$(CONFIG_VGA) += display-vga-test
-
-check-qtest-moxie-y += boot-serial-test
-
-check-qtest-ppc-$(CONFIG_ISA_TESTDEV) = endianness-test
-check-qtest-ppc-y += boot-order-test
-check-qtest-ppc-y += prom-env-test
-check-qtest-ppc-y += drive_del-test
-check-qtest-ppc-y += boot-serial-test
-check-qtest-ppc-$(CONFIG_M48T59) += m48t59-test
-
-check-qtest-ppc64-y += $(check-qtest-ppc-y)
-check-qtest-ppc64-$(CONFIG_PSERIES) += device-plug-test
-check-qtest-ppc64-$(CONFIG_POWERNV) += pnv-xscom-test
-check-qtest-ppc64-y += migration-test
-check-qtest-ppc64-$(CONFIG_PSERIES) += rtas-test
-check-qtest-ppc64-$(CONFIG_SLIRP) += pxe-test
-check-qtest-ppc64-$(CONFIG_USB_UHCI) += usb-hcd-uhci-test
-check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += usb-hcd-xhci-test
-check-qtest-ppc64-$(CONFIG_SLIRP) += test-netfilter
-check-qtest-ppc64-$(CONFIG_POSIX) += test-filter-mirror
-check-qtest-ppc64-$(CONFIG_RTL8139_PCI) += test-filter-redirector
-check-qtest-ppc64-$(CONFIG_VGA) += display-vga-test
-check-qtest-ppc64-y += numa-test
-check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) += ivshmem-test
-check-qtest-ppc64-y += cpu-plug-test
-
-check-qtest-sh4-$(CONFIG_ISA_TESTDEV) = endianness-test
-
-check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) = endianness-test
-
-check-qtest-sparc-y += prom-env-test
-check-qtest-sparc-y += m48t59-test
-check-qtest-sparc-y += boot-serial-test
-
-check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = endianness-test
-check-qtest-sparc64-y += prom-env-test
-check-qtest-sparc64-y += boot-serial-test
-
-check-qtest-arm-y += microbit-test
-check-qtest-arm-y += m25p80-test
-check-qtest-arm-y += test-arm-mptimer
-check-qtest-arm-y += boot-serial-test
-check-qtest-arm-y += hexloader-test
-check-qtest-arm-$(CONFIG_PFLASH_CFI02) += pflash-cfi02-test
-
-check-qtest-aarch64-y = numa-test
-check-qtest-aarch64-y += boot-serial-test
-check-qtest-aarch64-y += migration-test
-# TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditional
-ifneq ($(ARCH),arm)
-check-qtest-aarch64-y += bios-tables-test
-endif
-
-check-qtest-microblazeel-y += $(check-qtest-microblaze-y)
-
-check-qtest-xtensaeb-y += $(check-qtest-xtensa-y)
-
-check-qtest-s390x-y = boot-serial-test
-check-qtest-s390x-$(CONFIG_SLIRP) += pxe-test
-check-qtest-s390x-$(CONFIG_SLIRP) += test-netfilter
-check-qtest-s390x-$(CONFIG_POSIX) += test-filter-mirror
-check-qtest-s390x-$(CONFIG_POSIX) += test-filter-redirector
-check-qtest-s390x-y += drive_del-test
-check-qtest-s390x-y += device-plug-test
-check-qtest-s390x-y += virtio-ccw-test
-check-qtest-s390x-y += cpu-plug-test
-check-qtest-s390x-y += migration-test
-
-check-qtest-generic-y += machine-none-test
-check-qtest-generic-y += qom-test
-check-qtest-generic-y += test-hmp
-
 qapi-schema += alternate-any.json
 qapi-schema += alternate-array.json
 qapi-schema += alternate-base.json
@@ -671,12 +523,6 @@ tests/test-authz-pam$(EXESUF): tests/test-authz-pam.o $(test-authz-obj-y)
 tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
 tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
         tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-y)
-tests/qtest/tpm-crb-swtpm-test$(EXESUF): tests/qtest/tpm-crb-swtpm-test.o tests/tpm-emu.o \
-	tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
-tests/qtest/tpm-crb-test$(EXESUF): tests/qtest/tpm-crb-test.o tests/tpm-emu.o $(test-io-obj-y)
-tests/qtest/tpm-tis-swtpm-test$(EXESUF): tests/qtest/tpm-tis-swtpm-test.o tests/tpm-emu.o \
-	tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
-tests/qtest/tpm-tis-test$(EXESUF): tests/qtest/tpm-tis-test.o tests/tpm-emu.o $(test-io-obj-y)
 tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
         tests/io-channel-helpers.o $(test-io-obj-y)
 tests/test-io-channel-tls$(EXESUF): tests/test-io-channel-tls.o \
@@ -691,144 +537,6 @@ tests/test-crypto-ivgen$(EXESUF): tests/test-crypto-ivgen.o $(test-crypto-obj-y)
 tests/test-crypto-afsplit$(EXESUF): tests/test-crypto-afsplit.o $(test-crypto-obj-y)
 tests/test-crypto-block$(EXESUF): tests/test-crypto-block.o $(test-crypto-obj-y)
 
-libqgraph-obj-y = tests/libqos/qgraph.o
-
-libqos-obj-y = $(libqgraph-obj-y) tests/libqos/pci.o tests/libqos/fw_cfg.o
-libqos-obj-y += tests/libqos/malloc.o
-libqos-obj-y += tests/libqos/libqos.o
-libqos-spapr-obj-y = $(libqos-obj-y) tests/libqos/malloc-spapr.o
-libqos-spapr-obj-y += tests/libqos/libqos-spapr.o
-libqos-spapr-obj-y += tests/libqos/rtas.o
-libqos-spapr-obj-y += tests/libqos/pci-spapr.o
-libqos-pc-obj-y = $(libqos-obj-y) tests/libqos/pci-pc.o
-libqos-pc-obj-y += tests/libqos/malloc-pc.o tests/libqos/libqos-pc.o
-libqos-pc-obj-y += tests/libqos/ahci.o
-libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
-
-# Devices
-qos-test-obj-y = tests/qtest/qos-test.o $(libqgraph-obj-y)
-qos-test-obj-y += $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
-qos-test-obj-y += tests/libqos/e1000e.o
-qos-test-obj-y += tests/libqos/i2c.o
-qos-test-obj-y += tests/libqos/i2c-imx.o
-qos-test-obj-y += tests/libqos/i2c-omap.o
-qos-test-obj-y += tests/libqos/sdhci.o
-qos-test-obj-y += tests/libqos/tpci200.o
-qos-test-obj-y += tests/libqos/virtio.o
-qos-test-obj-$(CONFIG_VIRTFS) += tests/libqos/virtio-9p.o
-qos-test-obj-y += tests/libqos/virtio-balloon.o
-qos-test-obj-y += tests/libqos/virtio-blk.o
-qos-test-obj-y += tests/libqos/virtio-mmio.o
-qos-test-obj-y += tests/libqos/virtio-net.o
-qos-test-obj-y += tests/libqos/virtio-pci.o
-qos-test-obj-y += tests/libqos/virtio-rng.o
-qos-test-obj-y += tests/libqos/virtio-scsi.o
-qos-test-obj-y += tests/libqos/virtio-serial.o
-
-# Machines
-qos-test-obj-y += tests/libqos/aarch64-xlnx-zcu102-machine.o
-qos-test-obj-y += tests/libqos/arm-imx25-pdk-machine.o
-qos-test-obj-y += tests/libqos/arm-n800-machine.o
-qos-test-obj-y += tests/libqos/arm-raspi2-machine.o
-qos-test-obj-y += tests/libqos/arm-sabrelite-machine.o
-qos-test-obj-y += tests/libqos/arm-smdkc210-machine.o
-qos-test-obj-y += tests/libqos/arm-virt-machine.o
-qos-test-obj-y += tests/libqos/arm-xilinx-zynq-a9-machine.o
-qos-test-obj-y += tests/libqos/ppc64_pseries-machine.o
-qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
-
-# Tests
-qos-test-obj-y += tests/qtest/ac97-test.o
-qos-test-obj-y += tests/qtest/ds1338-test.o
-qos-test-obj-y += tests/qtest/e1000-test.o
-qos-test-obj-y += tests/qtest/e1000e-test.o
-qos-test-obj-y += tests/qtest/eepro100-test.o
-qos-test-obj-y += tests/qtest/es1370-test.o
-qos-test-obj-y += tests/qtest/ipoctal232-test.o
-qos-test-obj-y += tests/qtest/megasas-test.o
-qos-test-obj-y += tests/qtest/ne2000-test.o
-qos-test-obj-y += tests/qtest/nvme-test.o
-qos-test-obj-y += tests/qtest/pca9552-test.o
-qos-test-obj-y += tests/qtest/pci-test.o
-qos-test-obj-y += tests/qtest/pcnet-test.o
-qos-test-obj-y += tests/qtest/sdhci-test.o
-qos-test-obj-y += tests/qtest/spapr-phb-test.o
-qos-test-obj-y += tests/qtest/tmp105-test.o
-qos-test-obj-y += tests/qtest/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
-qos-test-obj-$(CONFIG_VHOST_NET_USER) += tests/qtest/vhost-user-test.o $(chardev-obj-y) $(test-io-obj-y)
-qos-test-obj-y += tests/qtest/virtio-test.o
-qos-test-obj-$(CONFIG_VIRTFS) += tests/qtest/virtio-9p-test.o
-qos-test-obj-y += tests/qtest/virtio-blk-test.o
-qos-test-obj-y += tests/qtest/virtio-net-test.o
-qos-test-obj-y += tests/qtest/virtio-rng-test.o
-qos-test-obj-y += tests/qtest/virtio-scsi-test.o
-qos-test-obj-y += tests/qtest/virtio-serial-test.o
-qos-test-obj-y += tests/qtest/vmxnet3-test.o
-
-check-unit-y += tests/test-qgraph$(EXESUF)
-tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
-
-check-qtest-generic-y += qos-test
-tests/qtest/qos-test$(EXESUF): $(qos-test-obj-y)
-
-tests/qtest/qmp-test$(EXESUF): tests/qtest/qmp-test.o
-tests/qtest/qmp-cmd-test$(EXESUF): tests/qtest/qmp-cmd-test.o
-tests/qtest/device-introspect-test$(EXESUF): tests/qtest/device-introspect-test.o
-tests/qtest/rtc-test$(EXESUF): tests/qtest/rtc-test.o
-tests/qtest/m48t59-test$(EXESUF): tests/qtest/m48t59-test.o
-tests/qtest/hexloader-test$(EXESUF): tests/qtest/hexloader-test.o
-tests/qtest/pflash-cfi02$(EXESUF): tests/qtest/pflash-cfi02-test.o
-tests/qtest/endianness-test$(EXESUF): tests/qtest/endianness-test.o
-tests/qtest/prom-env-test$(EXESUF): tests/qtest/prom-env-test.o $(libqos-obj-y)
-tests/qtest/rtas-test$(EXESUF): tests/qtest/rtas-test.o $(libqos-spapr-obj-y)
-tests/qtest/fdc-test$(EXESUF): tests/qtest/fdc-test.o
-tests/qtest/ide-test$(EXESUF): tests/qtest/ide-test.o $(libqos-pc-obj-y)
-tests/qtest/ahci-test$(EXESUF): tests/qtest/ahci-test.o $(libqos-pc-obj-y) qemu-img$(EXESUF)
-tests/qtest/ipmi-kcs-test$(EXESUF): tests/qtest/ipmi-kcs-test.o
-tests/qtest/ipmi-bt-test$(EXESUF): tests/qtest/ipmi-bt-test.o
-tests/qtest/hd-geo-test$(EXESUF): tests/qtest/hd-geo-test.o
-tests/qtest/boot-order-test$(EXESUF): tests/qtest/boot-order-test.o $(libqos-obj-y)
-tests/qtest/boot-serial-test$(EXESUF): tests/qtest/boot-serial-test.o $(libqos-obj-y)
-tests/qtest/bios-tables-test$(EXESUF): tests/qtest/bios-tables-test.o \
-	tests/qtest/boot-sector.o tests/qtest/acpi-utils.o $(libqos-obj-y)
-tests/qtest/pxe-test$(EXESUF): tests/qtest/pxe-test.o tests/qtest/boot-sector.o $(libqos-obj-y)
-tests/qtest/microbit-test$(EXESUF): tests/qtest/microbit-test.o
-tests/qtest/m25p80-test$(EXESUF): tests/qtest/m25p80-test.o
-tests/qtest/i440fx-test$(EXESUF): tests/qtest/i440fx-test.o $(libqos-pc-obj-y)
-tests/qtest/q35-test$(EXESUF): tests/qtest/q35-test.o $(libqos-pc-obj-y)
-tests/qtest/fw_cfg-test$(EXESUF): tests/qtest/fw_cfg-test.o $(libqos-pc-obj-y)
-tests/qtest/rtl8139-test$(EXESUF): tests/qtest/rtl8139-test.o $(libqos-pc-obj-y)
-tests/qtest/pnv-xscom-test$(EXESUF): tests/qtest/pnv-xscom-test.o
-tests/qtest/wdt_ib700-test$(EXESUF): tests/qtest/wdt_ib700-test.o
-tests/qtest/tco-test$(EXESUF): tests/qtest/tco-test.o $(libqos-pc-obj-y)
-tests/qtest/virtio-ccw-test$(EXESUF): tests/qtest/virtio-ccw-test.o
-tests/qtest/display-vga-test$(EXESUF): tests/qtest/display-vga-test.o
-tests/qtest/qom-test$(EXESUF): tests/qtest/qom-test.o
-tests/qtest/test-hmp$(EXESUF): tests/qtest/test-hmp.o
-tests/qtest/machine-none-test$(EXESUF): tests/qtest/machine-none-test.o
-tests/qtest/device-plug-test$(EXESUF): tests/qtest/device-plug-test.o
-tests/qtest/drive_del-test$(EXESUF): tests/qtest/drive_del-test.o
-tests/qtest/pvpanic-test$(EXESUF): tests/qtest/pvpanic-test.o
-tests/qtest/i82801b11-test$(EXESUF): tests/qtest/i82801b11-test.o
-tests/qtest/intel-hda-test$(EXESUF): tests/qtest/intel-hda-test.o
-tests/qtest/ioh3420-test$(EXESUF): tests/qtest/ioh3420-test.o
-tests/qtest/usb-hcd-uhci-test$(EXESUF): tests/qtest/usb-hcd-uhci-test.o $(libqos-usb-obj-y)
-tests/qtest/usb-hcd-ehci-test$(EXESUF): tests/qtest/usb-hcd-ehci-test.o $(libqos-usb-obj-y)
-tests/qtest/usb-hcd-xhci-test$(EXESUF): tests/qtest/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
-tests/qtest/cpu-plug-test$(EXESUF): tests/qtest/cpu-plug-test.o
-tests/qtest/migration-test$(EXESUF): tests/qtest/migration-test.o
-tests/qtest/qemu-iotests/qtest/socket_scm_helper$(EXESUF): tests/qtest/qemu-iotests/qtest/socket_scm_helper.o
-tests/qtest/test-netfilter$(EXESUF): tests/qtest/test-netfilter.o $(qtest-obj-y)
-tests/qtest/test-filter-mirror$(EXESUF): tests/qtest/test-filter-mirror.o $(qtest-obj-y)
-tests/qtest/test-filter-redirector$(EXESUF): tests/qtest/test-filter-redirector.o $(qtest-obj-y)
-tests/qtest/test-x86-cpuid-compat$(EXESUF): tests/qtest/test-x86-cpuid-compat.o $(qtest-obj-y)
-tests/qtest/ivshmem-test$(EXESUF): tests/qtest/ivshmem-test.o contrib/ivshmem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
-tests/qtest/vhost-user-bridge$(EXESUF): tests/qtest/vhost-user-bridge.o $(test-util-obj-y) libvhost-user.a
-tests/qtest/test-arm-mptimer$(EXESUF): tests/qtest/test-arm-mptimer.o
-tests/qtest/numa-test$(EXESUF): tests/qtest/numa-test.o
-tests/qtest/vmgenid-test$(EXESUF): tests/qtest/vmgenid-test.o tests/qtest/boot-sector.o tests/qtest/acpi-utils.o
-tests/qtest/cdrom-test$(EXESUF): tests/qtest/cdrom-test.o tests/qtest/boot-sector.o $(libqos-obj-y)
-
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
 
@@ -841,19 +549,7 @@ tests/migration/initrd-stress.img: tests/migration/stress$(EXESUF)
 	rm $(INITRD_WORK_DIR)/init
 	rmdir $(INITRD_WORK_DIR)
 
-# QTest rules
-
-TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
-ifeq ($(CONFIG_POSIX),y)
-QTEST_TARGETS = $(TARGETS)
-check-qtest-y=$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y:%=tests/qtest/%$(EXESUF)))
-check-qtest-y += $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF))
-else
-QTEST_TARGETS =
-endif
-
-qtest-obj-y = tests/qtest/libqtest.o $(test-util-obj-y)
-$(check-qtest-y): $(qtest-obj-y)
+include $(SRC_PATH)/tests/qtest/Makefile.include
 
 tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
 tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
new file mode 100644
index 0000000000..54e1d6fb6c
--- /dev/null
+++ b/tests/qtest/Makefile.include
@@ -0,0 +1,305 @@
+# All QTests for now are POSIX-only, but the dependencies are
+# really in libqtest, not in the testcases themselves.
+
+check-qtest-generic-y += cdrom-test
+check-qtest-generic-y += device-introspect-test
+check-qtest-generic-y += machine-none-test
+check-qtest-generic-$(CONFIG_MODULES) += modules-test
+check-qtest-generic-y += qmp-test
+check-qtest-generic-y += qmp-cmd-test
+check-qtest-generic-y += qom-test
+check-qtest-generic-y += test-hmp
+
+check-qtest-pci-$(CONFIG_RTL8139_PCI) += rtl8139-test
+check-qtest-pci-$(CONFIG_VGA) += display-vga-test
+check-qtest-pci-$(CONFIG_HDA) += intel-hda-test
+check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += ivshmem-test
+
+check-qtest-i386-$(CONFIG_ISA_TESTDEV) = endianness-test
+check-qtest-i386-y += fdc-test
+check-qtest-i386-y += ide-test
+check-qtest-i386-y += ahci-test
+check-qtest-i386-y += hd-geo-test
+check-qtest-i386-y += boot-order-test
+check-qtest-i386-y += bios-tables-test
+check-qtest-i386-$(CONFIG_SGA) += boot-serial-test
+check-qtest-i386-$(CONFIG_SLIRP) += pxe-test
+check-qtest-i386-y += rtc-test
+check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) += ipmi-kcs-test
+# Disabled temporarily as it fails intermittently especially under NetBSD VM
+# check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += ipmi-bt-test
+check-qtest-i386-y += i440fx-test
+check-qtest-i386-y += fw_cfg-test
+check-qtest-i386-y += device-plug-test
+check-qtest-i386-y += drive_del-test
+check-qtest-i386-$(CONFIG_WDT_IB700) += wdt_ib700-test
+check-qtest-i386-y += tco-test
+check-qtest-i386-y += $(check-qtest-pci-y)
+check-qtest-i386-$(CONFIG_PVPANIC) += pvpanic-test
+check-qtest-i386-$(CONFIG_I82801B11) += i82801b11-test
+check-qtest-i386-$(CONFIG_IOH3420) += ioh3420-test
+check-qtest-i386-$(CONFIG_USB_UHCI) += usb-hcd-uhci-test
+ifeq ($(CONFIG_USB_ECHI)$(CONFIG_USB_UHCI),yy)
+check-qtest-i386-y += usb-hcd-ehci-test
+endif
+check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += usb-hcd-xhci-test
+check-qtest-i386-y += cpu-plug-test
+check-qtest-i386-y += q35-test
+check-qtest-i386-y += vmgenid-test
+check-qtest-i386-$(CONFIG_TPM_CRB) += tpm-crb-swtpm-test
+check-qtest-i386-$(CONFIG_TPM_CRB) += tpm-crb-test
+check-qtest-i386-$(CONFIG_TPM_TIS) += tpm-tis-swtpm-test
+check-qtest-i386-$(CONFIG_TPM_TIS) += tpm-tis-test
+check-qtest-i386-$(CONFIG_SLIRP) += test-netfilter
+check-qtest-i386-$(CONFIG_POSIX) += test-filter-mirror
+check-qtest-i386-$(CONFIG_RTL8139_PCI) += test-filter-redirector
+check-qtest-i386-y += migration-test
+check-qtest-i386-y += test-x86-cpuid-compat
+check-qtest-i386-y += numa-test
+check-qtest-x86_64-y += $(check-qtest-i386-y)
+
+check-qtest-alpha-y += boot-serial-test
+check-qtest-alpha-$(CONFIG_VGA) += display-vga-test
+
+check-qtest-hppa-y += boot-serial-test
+check-qtest-hppa-$(CONFIG_VGA) += display-vga-test
+
+check-qtest-m68k-y = boot-serial-test
+
+check-qtest-microblaze-y += boot-serial-test
+
+check-qtest-mips-$(CONFIG_ISA_TESTDEV) = endianness-test
+check-qtest-mips-$(CONFIG_VGA) += display-vga-test
+
+check-qtest-mips64-$(CONFIG_ISA_TESTDEV) = endianness-test
+check-qtest-mips64-$(CONFIG_VGA) += display-vga-test
+
+check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) = endianness-test
+check-qtest-mips64el-$(CONFIG_VGA) += display-vga-test
+
+check-qtest-moxie-y += boot-serial-test
+
+check-qtest-ppc-$(CONFIG_ISA_TESTDEV) = endianness-test
+check-qtest-ppc-y += boot-order-test
+check-qtest-ppc-y += prom-env-test
+check-qtest-ppc-y += drive_del-test
+check-qtest-ppc-y += boot-serial-test
+check-qtest-ppc-$(CONFIG_M48T59) += m48t59-test
+
+check-qtest-ppc64-y += $(check-qtest-ppc-y)
+check-qtest-ppc64-$(CONFIG_PSERIES) += device-plug-test
+check-qtest-ppc64-$(CONFIG_POWERNV) += pnv-xscom-test
+check-qtest-ppc64-y += migration-test
+check-qtest-ppc64-$(CONFIG_PSERIES) += rtas-test
+check-qtest-ppc64-$(CONFIG_SLIRP) += pxe-test
+check-qtest-ppc64-$(CONFIG_USB_UHCI) += usb-hcd-uhci-test
+check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += usb-hcd-xhci-test
+check-qtest-ppc64-$(CONFIG_SLIRP) += test-netfilter
+check-qtest-ppc64-$(CONFIG_POSIX) += test-filter-mirror
+check-qtest-ppc64-$(CONFIG_RTL8139_PCI) += test-filter-redirector
+check-qtest-ppc64-$(CONFIG_VGA) += display-vga-test
+check-qtest-ppc64-y += numa-test
+check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) += ivshmem-test
+check-qtest-ppc64-y += cpu-plug-test
+
+check-qtest-sh4-$(CONFIG_ISA_TESTDEV) = endianness-test
+
+check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) = endianness-test
+
+check-qtest-sparc-y += prom-env-test
+check-qtest-sparc-y += m48t59-test
+check-qtest-sparc-y += boot-serial-test
+
+check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = endianness-test
+check-qtest-sparc64-y += prom-env-test
+check-qtest-sparc64-y += boot-serial-test
+
+check-qtest-arm-y += microbit-test
+check-qtest-arm-y += m25p80-test
+check-qtest-arm-y += test-arm-mptimer
+check-qtest-arm-y += boot-serial-test
+check-qtest-arm-y += hexloader-test
+check-qtest-arm-$(CONFIG_PFLASH_CFI02) += pflash-cfi02-test
+
+check-qtest-aarch64-y = numa-test
+check-qtest-aarch64-y += boot-serial-test
+check-qtest-aarch64-y += migration-test
+# TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditional
+ifneq ($(ARCH),arm)
+check-qtest-aarch64-y += bios-tables-test
+endif
+
+check-qtest-microblazeel-y += $(check-qtest-microblaze-y)
+
+check-qtest-xtensaeb-y += $(check-qtest-xtensa-y)
+
+check-qtest-s390x-y = boot-serial-test
+check-qtest-s390x-$(CONFIG_SLIRP) += pxe-test
+check-qtest-s390x-$(CONFIG_SLIRP) += test-netfilter
+check-qtest-s390x-$(CONFIG_POSIX) += test-filter-mirror
+check-qtest-s390x-$(CONFIG_POSIX) += test-filter-redirector
+check-qtest-s390x-y += drive_del-test
+check-qtest-s390x-y += device-plug-test
+check-qtest-s390x-y += virtio-ccw-test
+check-qtest-s390x-y += cpu-plug-test
+check-qtest-s390x-y += migration-test
+
+# libqos / qgraph :
+libqgraph-obj-y = tests/libqos/qgraph.o
+
+libqos-obj-y = $(libqgraph-obj-y) tests/libqos/pci.o tests/libqos/fw_cfg.o
+libqos-obj-y += tests/libqos/malloc.o
+libqos-obj-y += tests/libqos/libqos.o
+libqos-spapr-obj-y = $(libqos-obj-y) tests/libqos/malloc-spapr.o
+libqos-spapr-obj-y += tests/libqos/libqos-spapr.o
+libqos-spapr-obj-y += tests/libqos/rtas.o
+libqos-spapr-obj-y += tests/libqos/pci-spapr.o
+libqos-pc-obj-y = $(libqos-obj-y) tests/libqos/pci-pc.o
+libqos-pc-obj-y += tests/libqos/malloc-pc.o tests/libqos/libqos-pc.o
+libqos-pc-obj-y += tests/libqos/ahci.o
+libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
+
+# qos devices:
+qos-test-obj-y = tests/qtest/qos-test.o $(libqgraph-obj-y)
+qos-test-obj-y += $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+qos-test-obj-y += tests/libqos/e1000e.o
+qos-test-obj-y += tests/libqos/i2c.o
+qos-test-obj-y += tests/libqos/i2c-imx.o
+qos-test-obj-y += tests/libqos/i2c-omap.o
+qos-test-obj-y += tests/libqos/sdhci.o
+qos-test-obj-y += tests/libqos/tpci200.o
+qos-test-obj-y += tests/libqos/virtio.o
+qos-test-obj-$(CONFIG_VIRTFS) += tests/libqos/virtio-9p.o
+qos-test-obj-y += tests/libqos/virtio-balloon.o
+qos-test-obj-y += tests/libqos/virtio-blk.o
+qos-test-obj-y += tests/libqos/virtio-mmio.o
+qos-test-obj-y += tests/libqos/virtio-net.o
+qos-test-obj-y += tests/libqos/virtio-pci.o
+qos-test-obj-y += tests/libqos/virtio-rng.o
+qos-test-obj-y += tests/libqos/virtio-scsi.o
+qos-test-obj-y += tests/libqos/virtio-serial.o
+
+# qos machines:
+qos-test-obj-y += tests/libqos/aarch64-xlnx-zcu102-machine.o
+qos-test-obj-y += tests/libqos/arm-imx25-pdk-machine.o
+qos-test-obj-y += tests/libqos/arm-n800-machine.o
+qos-test-obj-y += tests/libqos/arm-raspi2-machine.o
+qos-test-obj-y += tests/libqos/arm-sabrelite-machine.o
+qos-test-obj-y += tests/libqos/arm-smdkc210-machine.o
+qos-test-obj-y += tests/libqos/arm-virt-machine.o
+qos-test-obj-y += tests/libqos/arm-xilinx-zynq-a9-machine.o
+qos-test-obj-y += tests/libqos/ppc64_pseries-machine.o
+qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
+
+# qos tests:
+qos-test-obj-y += tests/qtest/ac97-test.o
+qos-test-obj-y += tests/qtest/ds1338-test.o
+qos-test-obj-y += tests/qtest/e1000-test.o
+qos-test-obj-y += tests/qtest/e1000e-test.o
+qos-test-obj-y += tests/qtest/eepro100-test.o
+qos-test-obj-y += tests/qtest/es1370-test.o
+qos-test-obj-y += tests/qtest/ipoctal232-test.o
+qos-test-obj-y += tests/qtest/megasas-test.o
+qos-test-obj-y += tests/qtest/ne2000-test.o
+qos-test-obj-y += tests/qtest/nvme-test.o
+qos-test-obj-y += tests/qtest/pca9552-test.o
+qos-test-obj-y += tests/qtest/pci-test.o
+qos-test-obj-y += tests/qtest/pcnet-test.o
+qos-test-obj-y += tests/qtest/sdhci-test.o
+qos-test-obj-y += tests/qtest/spapr-phb-test.o
+qos-test-obj-y += tests/qtest/tmp105-test.o
+qos-test-obj-y += tests/qtest/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
+qos-test-obj-$(CONFIG_VHOST_NET_USER) += tests/qtest/vhost-user-test.o $(chardev-obj-y) $(test-io-obj-y)
+qos-test-obj-y += tests/qtest/virtio-test.o
+qos-test-obj-$(CONFIG_VIRTFS) += tests/qtest/virtio-9p-test.o
+qos-test-obj-y += tests/qtest/virtio-blk-test.o
+qos-test-obj-y += tests/qtest/virtio-net-test.o
+qos-test-obj-y += tests/qtest/virtio-rng-test.o
+qos-test-obj-y += tests/qtest/virtio-scsi-test.o
+qos-test-obj-y += tests/qtest/virtio-serial-test.o
+qos-test-obj-y += tests/qtest/vmxnet3-test.o
+
+check-unit-y += tests/test-qgraph$(EXESUF)
+tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
+
+check-qtest-generic-y += qos-test
+tests/qtest/qos-test$(EXESUF): $(qos-test-obj-y)
+
+# QTests dependencies:
+tests/qtest/tpm-crb-swtpm-test$(EXESUF): tests/qtest/tpm-crb-swtpm-test.o tests/tpm-emu.o \
+	tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
+tests/qtest/tpm-crb-test$(EXESUF): tests/qtest/tpm-crb-test.o tests/tpm-emu.o $(test-io-obj-y)
+tests/qtest/tpm-tis-swtpm-test$(EXESUF): tests/qtest/tpm-tis-swtpm-test.o tests/tpm-emu.o \
+	tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
+tests/qtest/tpm-tis-test$(EXESUF): tests/qtest/tpm-tis-test.o tests/tpm-emu.o $(test-io-obj-y)
+tests/qtest/qmp-test$(EXESUF): tests/qtest/qmp-test.o
+tests/qtest/qmp-cmd-test$(EXESUF): tests/qtest/qmp-cmd-test.o
+tests/qtest/device-introspect-test$(EXESUF): tests/qtest/device-introspect-test.o
+tests/qtest/rtc-test$(EXESUF): tests/qtest/rtc-test.o
+tests/qtest/m48t59-test$(EXESUF): tests/qtest/m48t59-test.o
+tests/qtest/hexloader-test$(EXESUF): tests/qtest/hexloader-test.o
+tests/qtest/pflash-cfi02$(EXESUF): tests/qtest/pflash-cfi02-test.o
+tests/qtest/endianness-test$(EXESUF): tests/qtest/endianness-test.o
+tests/qtest/prom-env-test$(EXESUF): tests/qtest/prom-env-test.o $(libqos-obj-y)
+tests/qtest/rtas-test$(EXESUF): tests/qtest/rtas-test.o $(libqos-spapr-obj-y)
+tests/qtest/fdc-test$(EXESUF): tests/qtest/fdc-test.o
+tests/qtest/ide-test$(EXESUF): tests/qtest/ide-test.o $(libqos-pc-obj-y)
+tests/qtest/ahci-test$(EXESUF): tests/qtest/ahci-test.o $(libqos-pc-obj-y) qemu-img$(EXESUF)
+tests/qtest/ipmi-kcs-test$(EXESUF): tests/qtest/ipmi-kcs-test.o
+tests/qtest/ipmi-bt-test$(EXESUF): tests/qtest/ipmi-bt-test.o
+tests/qtest/hd-geo-test$(EXESUF): tests/qtest/hd-geo-test.o
+tests/qtest/boot-order-test$(EXESUF): tests/qtest/boot-order-test.o $(libqos-obj-y)
+tests/qtest/boot-serial-test$(EXESUF): tests/qtest/boot-serial-test.o $(libqos-obj-y)
+tests/qtest/bios-tables-test$(EXESUF): tests/qtest/bios-tables-test.o \
+	tests/qtest/boot-sector.o tests/qtest/acpi-utils.o $(libqos-obj-y)
+tests/qtest/pxe-test$(EXESUF): tests/qtest/pxe-test.o tests/qtest/boot-sector.o $(libqos-obj-y)
+tests/qtest/microbit-test$(EXESUF): tests/qtest/microbit-test.o
+tests/qtest/m25p80-test$(EXESUF): tests/qtest/m25p80-test.o
+tests/qtest/i440fx-test$(EXESUF): tests/qtest/i440fx-test.o $(libqos-pc-obj-y)
+tests/qtest/q35-test$(EXESUF): tests/qtest/q35-test.o $(libqos-pc-obj-y)
+tests/qtest/fw_cfg-test$(EXESUF): tests/qtest/fw_cfg-test.o $(libqos-pc-obj-y)
+tests/qtest/rtl8139-test$(EXESUF): tests/qtest/rtl8139-test.o $(libqos-pc-obj-y)
+tests/qtest/pnv-xscom-test$(EXESUF): tests/qtest/pnv-xscom-test.o
+tests/qtest/wdt_ib700-test$(EXESUF): tests/qtest/wdt_ib700-test.o
+tests/qtest/tco-test$(EXESUF): tests/qtest/tco-test.o $(libqos-pc-obj-y)
+tests/qtest/virtio-ccw-test$(EXESUF): tests/qtest/virtio-ccw-test.o
+tests/qtest/display-vga-test$(EXESUF): tests/qtest/display-vga-test.o
+tests/qtest/qom-test$(EXESUF): tests/qtest/qom-test.o
+tests/qtest/test-hmp$(EXESUF): tests/qtest/test-hmp.o
+tests/qtest/machine-none-test$(EXESUF): tests/qtest/machine-none-test.o
+tests/qtest/device-plug-test$(EXESUF): tests/qtest/device-plug-test.o
+tests/qtest/drive_del-test$(EXESUF): tests/qtest/drive_del-test.o
+tests/qtest/pvpanic-test$(EXESUF): tests/qtest/pvpanic-test.o
+tests/qtest/i82801b11-test$(EXESUF): tests/qtest/i82801b11-test.o
+tests/qtest/intel-hda-test$(EXESUF): tests/qtest/intel-hda-test.o
+tests/qtest/ioh3420-test$(EXESUF): tests/qtest/ioh3420-test.o
+tests/qtest/usb-hcd-uhci-test$(EXESUF): tests/qtest/usb-hcd-uhci-test.o $(libqos-usb-obj-y)
+tests/qtest/usb-hcd-ehci-test$(EXESUF): tests/qtest/usb-hcd-ehci-test.o $(libqos-usb-obj-y)
+tests/qtest/usb-hcd-xhci-test$(EXESUF): tests/qtest/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
+tests/qtest/cpu-plug-test$(EXESUF): tests/qtest/cpu-plug-test.o
+tests/qtest/migration-test$(EXESUF): tests/qtest/migration-test.o
+tests/qtest/qemu-iotests/qtest/socket_scm_helper$(EXESUF): tests/qtest/qemu-iotests/qtest/socket_scm_helper.o
+tests/qtest/test-netfilter$(EXESUF): tests/qtest/test-netfilter.o $(qtest-obj-y)
+tests/qtest/test-filter-mirror$(EXESUF): tests/qtest/test-filter-mirror.o $(qtest-obj-y)
+tests/qtest/test-filter-redirector$(EXESUF): tests/qtest/test-filter-redirector.o $(qtest-obj-y)
+tests/qtest/test-x86-cpuid-compat$(EXESUF): tests/qtest/test-x86-cpuid-compat.o $(qtest-obj-y)
+tests/qtest/ivshmem-test$(EXESUF): tests/qtest/ivshmem-test.o contrib/ivshmem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+tests/qtest/vhost-user-bridge$(EXESUF): tests/qtest/vhost-user-bridge.o $(test-util-obj-y) libvhost-user.a
+tests/qtest/test-arm-mptimer$(EXESUF): tests/qtest/test-arm-mptimer.o
+tests/qtest/numa-test$(EXESUF): tests/qtest/numa-test.o
+tests/qtest/vmgenid-test$(EXESUF): tests/qtest/vmgenid-test.o tests/qtest/boot-sector.o tests/qtest/acpi-utils.o
+tests/qtest/cdrom-test$(EXESUF): tests/qtest/cdrom-test.o tests/qtest/boot-sector.o $(libqos-obj-y)
+
+# QTest rules
+
+TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
+ifeq ($(CONFIG_POSIX),y)
+QTEST_TARGETS = $(TARGETS)
+check-qtest-y=$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y:%=tests/qtest/%$(EXESUF)))
+check-qtest-y += $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF))
+else
+QTEST_TARGETS =
+endif
+
+qtest-obj-y = tests/qtest/libqtest.o $(test-util-obj-y)
+$(check-qtest-y): $(qtest-obj-y)
-- 
2.18.1


