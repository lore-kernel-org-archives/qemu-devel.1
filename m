Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D42C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F240621479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F240621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7lQc-00041g-1L
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 15:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i7lLv-0008Uy-VK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i7lLr-0006FN-MS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:58:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i7lLp-0006CL-92
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:58:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C615D3082B67;
 Tue, 10 Sep 2019 18:58:50 +0000 (UTC)
Received: from thuth.com (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53F27196AE;
 Tue, 10 Sep 2019 18:58:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 20:58:35 +0200
Message-Id: <20190910185839.19682-4-thuth@redhat.com>
In-Reply-To: <20190910185839.19682-1-thuth@redhat.com>
References: <20190910185839.19682-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 10 Sep 2019 18:58:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/7] tests/Makefile: Remove 'tests/' and
 '$(EXESUF)' from the check-qtest variables
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

It's much easier if we simply add the folder prefix and the exe suffix
later via a substitution instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 252 ++++++++++++++++++++---------------------
 1 file changed, 126 insertions(+), 126 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 50891b8a37..2b2fec59c9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -147,150 +147,150 @@ check-block-$(call land,$(CONFIG_POSIX),$(CONFIG_SOFTMMU)) += tests/check-block.
 # All QTests for now are POSIX-only, but the dependencies are
 # really in libqtest, not in the testcases themselves.
 
-check-qtest-generic-y += tests/qmp-test$(EXESUF)
-check-qtest-generic-y += tests/qmp-cmd-test$(EXESUF)
-check-qtest-generic-$(CONFIG_MODULES) += tests/modules-test$(EXESUF)
-
-check-qtest-generic-y += tests/device-introspect-test$(EXESUF)
-check-qtest-generic-y += tests/cdrom-test$(EXESUF)
-
-check-qtest-pci-$(CONFIG_RTL8139_PCI) += tests/rtl8139-test$(EXESUF)
-check-qtest-pci-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
-check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
-check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
-
-check-qtest-i386-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
-check-qtest-i386-y += tests/fdc-test$(EXESUF)
-check-qtest-i386-y += tests/ide-test$(EXESUF)
-check-qtest-i386-y += tests/ahci-test$(EXESUF)
-check-qtest-i386-y += tests/hd-geo-test$(EXESUF)
-check-qtest-i386-y += tests/boot-order-test$(EXESUF)
-check-qtest-i386-y += tests/bios-tables-test$(EXESUF)
-check-qtest-i386-$(CONFIG_SGA) += tests/boot-serial-test$(EXESUF)
-check-qtest-i386-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
-check-qtest-i386-y += tests/rtc-test$(EXESUF)
-check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) += tests/ipmi-kcs-test$(EXESUF)
+check-qtest-generic-y += qmp-test
+check-qtest-generic-y += qmp-cmd-test
+check-qtest-generic-$(CONFIG_MODULES) += modules-test
+
+check-qtest-generic-y += device-introspect-test
+check-qtest-generic-y += cdrom-test
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
 # Disabled temporarily as it fails intermittently especially under NetBSD VM
-# check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += tests/ipmi-bt-test$(EXESUF)
-check-qtest-i386-y += tests/i440fx-test$(EXESUF)
-check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
-check-qtest-i386-y += tests/device-plug-test$(EXESUF)
-check-qtest-i386-y += tests/drive_del-test$(EXESUF)
-check-qtest-i386-$(CONFIG_WDT_IB700) += tests/wdt_ib700-test$(EXESUF)
-check-qtest-i386-y += tests/tco-test$(EXESUF)
+# check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += ipmi-bt-test
+check-qtest-i386-y += i440fx-test
+check-qtest-i386-y += fw_cfg-test
+check-qtest-i386-y += device-plug-test
+check-qtest-i386-y += drive_del-test
+check-qtest-i386-$(CONFIG_WDT_IB700) += wdt_ib700-test
+check-qtest-i386-y += tco-test
 check-qtest-i386-y += $(check-qtest-pci-y)
-check-qtest-i386-$(CONFIG_PVPANIC) += tests/pvpanic-test$(EXESUF)
-check-qtest-i386-$(CONFIG_I82801B11) += tests/i82801b11-test$(EXESUF)
-check-qtest-i386-$(CONFIG_IOH3420) += tests/ioh3420-test$(EXESUF)
-check-qtest-i386-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
+check-qtest-i386-$(CONFIG_PVPANIC) += pvpanic-test
+check-qtest-i386-$(CONFIG_I82801B11) += i82801b11-test
+check-qtest-i386-$(CONFIG_IOH3420) += ioh3420-test
+check-qtest-i386-$(CONFIG_USB_UHCI) += usb-hcd-uhci-test
 ifeq ($(CONFIG_USB_ECHI)$(CONFIG_USB_UHCI),yy)
-check-qtest-i386-y += tests/usb-hcd-ehci-test$(EXESUF)
+check-qtest-i386-y += usb-hcd-ehci-test
 endif
-check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
-check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
-check-qtest-i386-y += tests/q35-test$(EXESUF)
-check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
-check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-swtpm-test$(EXESUF)
-check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-test$(EXESUF)
-check-qtest-i386-$(CONFIG_TPM_TIS) += tests/tpm-tis-swtpm-test$(EXESUF)
-check-qtest-i386-$(CONFIG_TPM_TIS) += tests/tpm-tis-test$(EXESUF)
-check-qtest-i386-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
-check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
-check-qtest-i386-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
-check-qtest-i386-y += tests/migration-test$(EXESUF)
-check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
-check-qtest-i386-y += tests/numa-test$(EXESUF)
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
 check-qtest-x86_64-y += $(check-qtest-i386-y)
 
-check-qtest-alpha-y += tests/boot-serial-test$(EXESUF)
-check-qtest-alpha-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
+check-qtest-alpha-y += boot-serial-test
+check-qtest-alpha-$(CONFIG_VGA) += display-vga-test
 
-check-qtest-hppa-y += tests/boot-serial-test$(EXESUF)
-check-qtest-hppa-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
+check-qtest-hppa-y += boot-serial-test
+check-qtest-hppa-$(CONFIG_VGA) += display-vga-test
 
-check-qtest-m68k-y = tests/boot-serial-test$(EXESUF)
+check-qtest-m68k-y = boot-serial-test
 
-check-qtest-microblaze-y += tests/boot-serial-test$(EXESUF)
+check-qtest-microblaze-y += boot-serial-test
 
-check-qtest-mips-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
-check-qtest-mips-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
+check-qtest-mips-$(CONFIG_ISA_TESTDEV) = endianness-test
+check-qtest-mips-$(CONFIG_VGA) += display-vga-test
 
-check-qtest-mips64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
-check-qtest-mips64-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
+check-qtest-mips64-$(CONFIG_ISA_TESTDEV) = endianness-test
+check-qtest-mips64-$(CONFIG_VGA) += display-vga-test
 
-check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
-check-qtest-mips64el-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
+check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) = endianness-test
+check-qtest-mips64el-$(CONFIG_VGA) += display-vga-test
 
-check-qtest-moxie-y += tests/boot-serial-test$(EXESUF)
+check-qtest-moxie-y += boot-serial-test
 
-check-qtest-ppc-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
-check-qtest-ppc-y += tests/boot-order-test$(EXESUF)
-check-qtest-ppc-y += tests/prom-env-test$(EXESUF)
-check-qtest-ppc-y += tests/drive_del-test$(EXESUF)
-check-qtest-ppc-y += tests/boot-serial-test$(EXESUF)
-check-qtest-ppc-$(CONFIG_M48T59) += tests/m48t59-test$(EXESUF)
+check-qtest-ppc-$(CONFIG_ISA_TESTDEV) = endianness-test
+check-qtest-ppc-y += boot-order-test
+check-qtest-ppc-y += prom-env-test
+check-qtest-ppc-y += drive_del-test
+check-qtest-ppc-y += boot-serial-test
+check-qtest-ppc-$(CONFIG_M48T59) += m48t59-test
 
 check-qtest-ppc64-y += $(check-qtest-ppc-y)
-check-qtest-ppc64-$(CONFIG_PSERIES) += tests/device-plug-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_POWERNV) += tests/pnv-xscom-test$(EXESUF)
-check-qtest-ppc64-y += tests/migration-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_PSERIES) += tests/rtas-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_USB_UHCI) += tests/usb-hcd-uhci-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
-check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
-check-qtest-ppc64-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
-check-qtest-ppc64-$(CONFIG_VGA) += tests/display-vga-test$(EXESUF)
-check-qtest-ppc64-y += tests/numa-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) += tests/ivshmem-test$(EXESUF)
-check-qtest-ppc64-y += tests/cpu-plug-test$(EXESUF)
-
-check-qtest-sh4-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
-
-check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
-
-check-qtest-sparc-y += tests/prom-env-test$(EXESUF)
-check-qtest-sparc-y += tests/m48t59-test$(EXESUF)
-check-qtest-sparc-y += tests/boot-serial-test$(EXESUF)
-
-check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
-check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
-check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
-
-check-qtest-arm-y += tests/microbit-test$(EXESUF)
-check-qtest-arm-y += tests/m25p80-test$(EXESUF)
-check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
-check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
-check-qtest-arm-y += tests/hexloader-test$(EXESUF)
-check-qtest-arm-$(CONFIG_PFLASH_CFI02) += tests/pflash-cfi02-test$(EXESUF)
-
-check-qtest-aarch64-y = tests/numa-test$(EXESUF)
-check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
-check-qtest-aarch64-y += tests/migration-test$(EXESUF)
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
 # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditional
 ifneq ($(ARCH),arm)
-check-qtest-aarch64-y += tests/bios-tables-test$(EXESUF)
+check-qtest-aarch64-y += bios-tables-test
 endif
 
 check-qtest-microblazeel-y += $(check-qtest-microblaze-y)
 
 check-qtest-xtensaeb-y += $(check-qtest-xtensa-y)
 
-check-qtest-s390x-y = tests/boot-serial-test$(EXESUF)
-check-qtest-s390x-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
-check-qtest-s390x-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
-check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
-check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
-check-qtest-s390x-y += tests/drive_del-test$(EXESUF)
-check-qtest-s390x-y += tests/device-plug-test$(EXESUF)
-check-qtest-s390x-y += tests/virtio-ccw-test$(EXESUF)
-check-qtest-s390x-y += tests/cpu-plug-test$(EXESUF)
-check-qtest-s390x-y += tests/migration-test$(EXESUF)
-
-check-qtest-generic-y += tests/machine-none-test$(EXESUF)
-check-qtest-generic-y += tests/qom-test$(EXESUF)
-check-qtest-generic-y += tests/test-hmp$(EXESUF)
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
+check-qtest-generic-y += machine-none-test
+check-qtest-generic-y += qom-test
+check-qtest-generic-y += test-hmp
 
 qapi-schema += alternate-any.json
 qapi-schema += alternate-array.json
@@ -763,7 +763,7 @@ qos-test-obj-y += tests/vmxnet3-test.o
 check-unit-y += tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
 
-check-qtest-generic-y += tests/qos-test$(EXESUF)
+check-qtest-generic-y += qos-test
 tests/qos-test$(EXESUF): $(qos-test-obj-y)
 
 tests/qmp-test$(EXESUF): tests/qmp-test.o
@@ -846,8 +846,8 @@ tests/migration/initrd-stress.img: tests/migration/stress$(EXESUF)
 TARGETS=$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
 ifeq ($(CONFIG_POSIX),y)
 QTEST_TARGETS = $(TARGETS)
-check-qtest-y=$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y))
-check-qtest-y += $(check-qtest-generic-y)
+check-qtest-y=$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y:%=tests/%$(EXESUF)))
+check-qtest-y += $(check-qtest-generic-y:%=tests/%$(EXESUF))
 else
 QTEST_TARGETS =
 endif
@@ -897,7 +897,7 @@ endef
 
 .PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
 $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: %-softmmu/all $(check-qtest-y)
-	$(call do_test_human,$(check-qtest-$*-y) $(check-qtest-generic-y), \
+	$(call do_test_human,$(check-qtest-$*-y:%=tests/%$(EXESUF)) $(check-qtest-generic-y:%=tests/%$(EXESUF)), \
 	  QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
 	  QTEST_QEMU_IMG=qemu-img$(EXESUF))
 
@@ -910,7 +910,7 @@ check-speed: $(check-speed-y)
 # gtester tests with TAP output
 
 $(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-qtest-%.tap: %-softmmu/all $(check-qtest-y)
-	$(call do_test_tap, $(check-qtest-$*-y) $(check-qtest-generic-y), \
+	$(call do_test_tap, $(check-qtest-$*-y:%=tests/%$(EXESUF)) $(check-qtest-generic-y:%=tests/%$(EXESUF)), \
 	  QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
 	  QTEST_QEMU_IMG=qemu-img$(EXESUF))
 
@@ -1173,7 +1173,7 @@ check-block: $(patsubst %,check-%, $(check-block-y))
 check: check-block check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
-	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
+	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y:%=tests/%$(EXESUF))) $(check-qtest-generic-y:%=tests/%$(EXESUF)))
 	rm -f tests/test-qapi-gen-timestamp
 	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
 
-- 
2.18.1


