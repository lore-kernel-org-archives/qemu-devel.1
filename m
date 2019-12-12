Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E416C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5059E21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dzt334ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5059E21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifP3N-0004ya-W6
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNzA-0004mH-PW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz9-0008Fc-38
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:28 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNz8-0008EW-SF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:27 -0500
Received: by mail-wr1-x444.google.com with SMTP id t2so2647209wrr.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yvhzPXCU/CtE3qvXs+MVaNi1CSZGrYTGkfoEQFgKHMM=;
 b=Dzt334haj4r1KsBiaLkcAscYkAbtBeUwx1EX7UmAH54Dvbq5M7s6Y7fC2cjNjn1FsL
 WB5sbGy/kxxJmerZr5YdkLHNPl83FZTyqoz0rgYkyqN3Wc0RHAs/1yw2q67QHduaZaYD
 Q/EBZiNeQpeFQdRNXxRp7bnQUBSw393NBKLnSi1n8O26GamhWISYkp/Vm4K440m6KqmO
 W1mMOXwFGXHUX+gpC5y0UXbI97I9bJA/vFQvYcNZ6SIffOgcuKVssjWl7BF7BPSBMU61
 QNjLnMVjwlMWqVgwDgoieXVE1HZKylmDSbEeTURFHC+wSlSn8/7I98qfJ1uewFMT/9nK
 fDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yvhzPXCU/CtE3qvXs+MVaNi1CSZGrYTGkfoEQFgKHMM=;
 b=H00mvrSFdeQw7rQltOVBRwIbHDpM0QwztJjxIWqiy8Ygo/+YzD91G7MHeXnalGCu+p
 HLqluV0/OmxIuyAGRE1t+vWqNst9I2OFfPPRfXT+gL1ToT3aINvb6Q1Jc/pgUN1P+r8k
 8ZA30HKZ/zXdhA44u+JjZsYvbCDVxoHD523H0EhYUPftSvQT8/1goMXMsldSdobQUfNt
 6mjjOSkP44i1mISz5wEgV1HbQnQkkUMy+H6blc+XrC0O4IQ51Qqbpsl/DLLA7psi2mS0
 tOhT2dp82omRj1umDyb+WrLSF28sLbjLkzs1u/EBkMw+23BzUaQCve+/gO0PSew7DMF5
 imzA==
X-Gm-Message-State: APjAAAU6Tm2GVxyUyOR0BhzfVHtEZ8NwBI2BJk1HDVVa785HkRemd+AD
 zZbhmRJyg0F0lYX9IIRV9YAIZYT/
X-Google-Smtp-Source: APXvYqwqXIvt+ezk0EX/JonqEnY45tTi95rZlOVziYhZvXt/izlucg8J74HwhE+jFsiNMjUCb9NBEw==
X-Received: by 2002:a5d:514a:: with SMTP id u10mr6036315wrt.169.1576155265590; 
 Thu, 12 Dec 2019 04:54:25 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 088/132] meson: convert hw/intc
Date: Thu, 12 Dec 2019 13:52:12 +0100
Message-Id: <1576155176-2464-89-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs      |  1 -
 hw/intc/Makefile.objs | 51 --------------------------------------------------
 hw/intc/meson.build   | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/meson.build        |  1 +
 4 files changed, 53 insertions(+), 52 deletions(-)
 delete mode 100644 hw/intc/Makefile.objs
 create mode 100644 hw/intc/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 8697b42..c89ca8d 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -14,7 +14,6 @@ devices-dirs-$(CONFIG_HYPERV) += hyperv/
 devices-dirs-$(CONFIG_I2C) += i2c/
 devices-dirs-y += ide/
 devices-dirs-y += input/
-devices-dirs-y += intc/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
deleted file mode 100644
index f726d87..0000000
--- a/hw/intc/Makefile.objs
+++ /dev/null
@@ -1,51 +0,0 @@
-common-obj-$(CONFIG_HEATHROW_PIC) += heathrow_pic.o
-common-obj-$(CONFIG_I8259) += i8259_common.o i8259.o
-common-obj-$(CONFIG_PL190) += pl190.o
-common-obj-$(CONFIG_PUV3) += puv3_intc.o
-common-obj-$(CONFIG_XILINX) += xilinx_intc.o
-common-obj-$(CONFIG_XLNX_ZYNQMP_PMU) += xlnx-pmu-iomod-intc.o
-common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-ipi.o
-common-obj-$(CONFIG_ETRAXFS) += etraxfs_pic.o
-common-obj-$(CONFIG_IMX) += imx_avic.o imx_gpcv2.o
-common-obj-$(CONFIG_LM32) += lm32_pic.o
-common-obj-$(CONFIG_REALVIEW) += realview_gic.o
-common-obj-$(CONFIG_SLAVIO) += slavio_intctl.o
-common-obj-$(CONFIG_IOAPIC) += ioapic_common.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gic_common.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gic.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gicv2m.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_common.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gicv3.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_dist.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_redist.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_its_common.o
-common-obj-$(CONFIG_OPENPIC) += openpic.o
-common-obj-y += intc.o
-
-obj-$(CONFIG_APIC) += apic.o apic_common.o
-obj-$(CONFIG_ARM_GIC_KVM) += arm_gic_kvm.o
-obj-$(call land,$(CONFIG_ARM_GIC_KVM),$(TARGET_AARCH64)) += arm_gicv3_kvm.o
-obj-$(call land,$(CONFIG_ARM_GIC_KVM),$(TARGET_AARCH64)) += arm_gicv3_its_kvm.o
-obj-$(CONFIG_ARM_V7M) += armv7m_nvic.o
-obj-$(CONFIG_EXYNOS4) += exynos4210_gic.o exynos4210_combiner.o
-obj-$(CONFIG_GRLIB) += grlib_irqmp.o
-obj-$(CONFIG_IOAPIC) += ioapic.o
-obj-$(CONFIG_OMAP) += omap_intc.o
-obj-$(CONFIG_OPENPIC_KVM) += openpic_kvm.o
-obj-$(CONFIG_RASPI) += bcm2835_ic.o bcm2836_control.o
-obj-$(CONFIG_SH4) += sh_intc.o
-obj-$(CONFIG_XICS) += xics.o
-obj-$(CONFIG_XICS_SPAPR) += xics_spapr.o
-obj-$(CONFIG_XICS_KVM) += xics_kvm.o
-obj-$(CONFIG_XIVE) += xive.o
-obj-$(CONFIG_XIVE_SPAPR) += spapr_xive.o
-obj-$(CONFIG_XIVE_KVM) += spapr_xive_kvm.o
-obj-$(CONFIG_POWERNV) += xics_pnv.o pnv_xive.o
-obj-$(CONFIG_ALLWINNER_A10_PIC) += allwinner-a10-pic.o
-obj-$(CONFIG_S390_FLIC) += s390_flic.o
-obj-$(CONFIG_S390_FLIC_KVM) += s390_flic_kvm.o
-obj-$(CONFIG_ASPEED_SOC) += aspeed_vic.o
-obj-$(CONFIG_ARM_GIC) += arm_gicv3_cpuif.o
-obj-$(CONFIG_MIPS_CPS) += mips_gic.o
-obj-$(CONFIG_NIOS2) += nios2_iic.o
-obj-$(CONFIG_OMPIC) += ompic.o
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
new file mode 100644
index 0000000..a2e5314
--- /dev/null
+++ b/hw/intc/meson.build
@@ -0,0 +1,52 @@
+softmmu_ss.add(files('intc.c'))
+softmmu_ss.add(when: 'CONFIG_ARM_GIC', if_true: files(
+  'arm_gic.c',
+  'arm_gic_common.c',
+  'arm_gicv2m.c',
+  'arm_gicv3.c',
+  'arm_gicv3_common.c',
+  'arm_gicv3_dist.c',
+  'arm_gicv3_its_common.c',
+  'arm_gicv3_redist.c',
+))
+softmmu_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_pic.c'))
+softmmu_ss.add(when: 'CONFIG_HEATHROW_PIC', if_true: files('heathrow_pic.c'))
+softmmu_ss.add(when: 'CONFIG_I8259', if_true: files('i8259_common.c', 'i8259.c'))
+softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('imx_avic.c', 'imx_gpcv2.c'))
+softmmu_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic_common.c'))
+softmmu_ss.add(when: 'CONFIG_LM32', if_true: files('lm32_pic.c'))
+softmmu_ss.add(when: 'CONFIG_OPENPIC', if_true: files('openpic.c'))
+softmmu_ss.add(when: 'CONFIG_PL190', if_true: files('pl190.c'))
+softmmu_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3_intc.c'))
+softmmu_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview_gic.c'))
+softmmu_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_intctl.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX', if_true: files('xilinx_intc.c'))
+softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP', if_true: files('xlnx-zynqmp-ipi.c'))
+softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP_PMU', if_true: files('xlnx-pmu-iomod-intc.c'))
+
+specific_ss.add(when: 'CONFIG_ALLWINNER_A10_PIC', if_true: files('allwinner-a10-pic.c'))
+specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
+specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif.c'))
+specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
+specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
+specific_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
+specific_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_vic.c'))
+specific_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_gic.c', 'exynos4210_combiner.c'))
+specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
+specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
+specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gic.c'))
+specific_ss.add(when: 'CONFIG_NIOS2', if_true: files('nios2_iic.c'))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_intc.c'))
+specific_ss.add(when: 'CONFIG_OMPIC', if_true: files('ompic.c'))
+specific_ss.add(when: 'CONFIG_OPENPIC_KVM', if_true: files('openpic_kvm.c'))
+specific_ss.add(when: 'CONFIG_POWERNV', if_true: files('xics_pnv.c', 'pnv_xive.c'))
+specific_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_ic.c', 'bcm2836_control.c'))
+specific_ss.add(when: 'CONFIG_S390_FLIC', if_true: files('s390_flic.c'))
+specific_ss.add(when: 'CONFIG_S390_FLIC_KVM', if_true: files('s390_flic_kvm.c'))
+specific_ss.add(when: 'CONFIG_SH4', if_true: files('sh_intc.c'))
+specific_ss.add(when: 'CONFIG_XICS', if_true: files('xics.c'))
+specific_ss.add(when: 'CONFIG_XICS_KVM', if_true: files('xics_kvm.c'))
+specific_ss.add(when: 'CONFIG_XICS_SPAPR', if_true: files('xics_spapr.c'))
+specific_ss.add(when: 'CONFIG_XIVE', if_true: files('xive.c'))
+specific_ss.add(when: 'CONFIG_XIVE_KVM', if_true: files('spapr_xive_kvm.c'))
+specific_ss.add(when: 'CONFIG_XIVE_SPAPR', if_true: files('spapr_xive.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 3e3f090..a5032d3 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('intc')
 subdir('ipack')
 subdir('ipmi')
 subdir('isa')
-- 
1.8.3.1



