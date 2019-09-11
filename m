Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796E2C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C7A206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C7A206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84wv-0004ZS-R9
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i84uP-0002Jo-Rg
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i84uM-00038p-F9
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:51:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46284)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i84uD-00034Y-Gj; Wed, 11 Sep 2019 11:51:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9430681F0E;
 Wed, 11 Sep 2019 15:51:38 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C524B60852;
 Wed, 11 Sep 2019 15:51:35 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Wed, 11 Sep 2019 17:51:23 +0200
Message-Id: <20190911155125.11932-2-eric.auger@redhat.com>
In-Reply-To: <20190911155125.11932-1-eric.auger@redhat.com>
References: <20190911155125.11932-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 11 Sep 2019 15:51:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v2 1/3] linux headers: update for
 KVM_CAP_ARM_IRQ_LINE_LAYOUT_2
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
Cc: yuzenghui@huawei.com, maz@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Temporary header update against 5.3-rc5 + Marc's patch:
"[PATCH] KVM: arm/arm64: vgic: Allow more than 256 vcpus for
KVM_IRQ_LINE"

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/standard-headers/asm-x86/bootparam.h |  2 ++
 include/standard-headers/asm-x86/kvm_para.h  |  1 +
 include/standard-headers/linux/ethtool.h     |  2 ++
 include/standard-headers/linux/pci_regs.h    |  4 +++
 include/standard-headers/linux/virtio_ids.h  |  1 +
 include/standard-headers/linux/virtio_pmem.h |  6 ++---
 linux-headers/asm-arm/kvm.h                  | 16 ++++++++++-
 linux-headers/asm-arm/unistd-common.h        |  2 ++
 linux-headers/asm-arm64/kvm.h                | 21 ++++++++++++++-
 linux-headers/asm-generic/mman-common.h      | 15 ++++++-----
 linux-headers/asm-generic/mman.h             | 10 +++----
 linux-headers/asm-generic/unistd.h           |  8 +++++-
 linux-headers/asm-mips/unistd_n32.h          |  1 +
 linux-headers/asm-mips/unistd_n64.h          |  1 +
 linux-headers/asm-mips/unistd_o32.h          |  1 +
 linux-headers/asm-powerpc/mman.h             |  6 +----
 linux-headers/asm-powerpc/unistd_32.h        |  2 ++
 linux-headers/asm-powerpc/unistd_64.h        |  2 ++
 linux-headers/asm-s390/unistd_32.h           |  2 ++
 linux-headers/asm-s390/unistd_64.h           |  2 ++
 linux-headers/asm-x86/kvm.h                  | 28 +++++++++++++++-----
 linux-headers/asm-x86/unistd_32.h            |  2 ++
 linux-headers/asm-x86/unistd_64.h            |  2 ++
 linux-headers/asm-x86/unistd_x32.h           |  2 ++
 linux-headers/linux/kvm.h                    | 12 ++++++---
 linux-headers/linux/psp-sev.h                |  5 +---
 26 files changed, 119 insertions(+), 37 deletions(-)

diff --git a/include/standard-headers/asm-x86/bootparam.h b/include/stand=
ard-headers/asm-x86/bootparam.h
index 67d4f0119f..a6f7cf535e 100644
--- a/include/standard-headers/asm-x86/bootparam.h
+++ b/include/standard-headers/asm-x86/bootparam.h
@@ -29,6 +29,8 @@
 #define XLF_EFI_HANDOVER_32		(1<<2)
 #define XLF_EFI_HANDOVER_64		(1<<3)
 #define XLF_EFI_KEXEC			(1<<4)
+#define XLF_5LEVEL			(1<<5)
+#define XLF_5LEVEL_ENABLED		(1<<6)
=20
=20
 #endif /* _ASM_X86_BOOTPARAM_H */
diff --git a/include/standard-headers/asm-x86/kvm_para.h b/include/standa=
rd-headers/asm-x86/kvm_para.h
index e1715143fd..90604a8fb7 100644
--- a/include/standard-headers/asm-x86/kvm_para.h
+++ b/include/standard-headers/asm-x86/kvm_para.h
@@ -30,6 +30,7 @@
 #define KVM_FEATURE_ASYNC_PF_VMEXIT	10
 #define KVM_FEATURE_PV_SEND_IPI	11
 #define KVM_FEATURE_POLL_CONTROL	12
+#define KVM_FEATURE_PV_SCHED_YIELD	13
=20
 #define KVM_HINTS_REALTIME      0
=20
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-=
headers/linux/ethtool.h
index 9b9919a8f6..16d0eeea86 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -1483,6 +1483,8 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT =3D 64,
 	ETHTOOL_LINK_MODE_200000baseDR4_Full_BIT	 =3D 65,
 	ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT	 =3D 66,
+	ETHTOOL_LINK_MODE_100baseT1_Full_BIT		 =3D 67,
+	ETHTOOL_LINK_MODE_1000baseT1_Full_BIT		 =3D 68,
=20
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard=
-headers/linux/pci_regs.h
index 27164769d1..f28e562d7c 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -528,6 +528,7 @@
 #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1=
 */
 #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2=
 */
 #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit =
3 */
+#define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit =
4 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
 #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
@@ -556,6 +557,7 @@
 #define  PCI_EXP_LNKSTA_CLS_5_0GB 0x0002 /* Current Link Speed 5.0GT/s *=
/
 #define  PCI_EXP_LNKSTA_CLS_8_0GB 0x0003 /* Current Link Speed 8.0GT/s *=
/
 #define  PCI_EXP_LNKSTA_CLS_16_0GB 0x0004 /* Current Link Speed 16.0GT/s=
 */
+#define  PCI_EXP_LNKSTA_CLS_32_0GB 0x0005 /* Current Link Speed 32.0GT/s=
 */
 #define  PCI_EXP_LNKSTA_NLW	0x03f0	/* Negotiated Link Width */
 #define  PCI_EXP_LNKSTA_NLW_X1	0x0010	/* Current Link Width x1 */
 #define  PCI_EXP_LNKSTA_NLW_X2	0x0020	/* Current Link Width x2 */
@@ -661,6 +663,7 @@
 #define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s *=
/
 #define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s *=
/
 #define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s=
 */
+#define  PCI_EXP_LNKCAP2_SLS_32_0GB	0x00000020 /* Supported Speed 32GT/s=
 */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
 #define  PCI_EXP_LNKCTL2_TLS		0x000f
@@ -668,6 +671,7 @@
 #define  PCI_EXP_LNKCTL2_TLS_5_0GT	0x0002 /* Supported Speed 5GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end =
here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standa=
rd-headers/linux/virtio_ids.h
index 32b2f94d1f..348fd0176f 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -43,6 +43,7 @@
 #define VIRTIO_ID_INPUT        18 /* virtio input */
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
+#define VIRTIO_ID_IOMMU        23 /* virtio IOMMU */
 #define VIRTIO_ID_PMEM         27 /* virtio pmem */
=20
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/include/standard-headers/linux/virtio_pmem.h b/include/stand=
ard-headers/linux/virtio_pmem.h
index 7e3d43b121..fc029de798 100644
--- a/include/standard-headers/linux/virtio_pmem.h
+++ b/include/standard-headers/linux/virtio_pmem.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-C=
lause */
 /*
  * Definitions for virtio-pmem devices.
  *
@@ -7,8 +7,8 @@
  * Author(s): Pankaj Gupta <pagupta@redhat.com>
  */
=20
-#ifndef _UAPI_LINUX_VIRTIO_PMEM_H
-#define _UAPI_LINUX_VIRTIO_PMEM_H
+#ifndef _LINUX_VIRTIO_PMEM_H
+#define _LINUX_VIRTIO_PMEM_H
=20
 #include "standard-headers/linux/types.h"
 #include "standard-headers/linux/virtio_ids.h"
diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
index e1f8b74558..9d379d3372 100644
--- a/linux-headers/asm-arm/kvm.h
+++ b/linux-headers/asm-arm/kvm.h
@@ -214,6 +214,18 @@ struct kvm_vcpu_events {
 #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM | KVM_REG_SIZE_U64 | \
 					 KVM_REG_ARM_FW | ((r) & 0xffff))
 #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
+	/* Higher values mean better protection. */
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL		0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL		1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_REQUIRED	2
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
+	/* Higher values mean better protection. */
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL		0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN		1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL		2
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED	3
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED	(1U << 4)
=20
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
@@ -254,8 +266,10 @@ struct kvm_vcpu_events {
 #define   KVM_DEV_ARM_ITS_CTRL_RESET		4
=20
 /* KVM_IRQ_LINE irq field index values */
+#define KVM_ARM_IRQ_VCPU2_SHIFT		28
+#define KVM_ARM_IRQ_VCPU2_MASK		0xf
 #define KVM_ARM_IRQ_TYPE_SHIFT		24
-#define KVM_ARM_IRQ_TYPE_MASK		0xff
+#define KVM_ARM_IRQ_TYPE_MASK		0xf
 #define KVM_ARM_IRQ_VCPU_SHIFT		16
 #define KVM_ARM_IRQ_VCPU_MASK		0xff
 #define KVM_ARM_IRQ_NUM_SHIFT		0
diff --git a/linux-headers/asm-arm/unistd-common.h b/linux-headers/asm-ar=
m/unistd-common.h
index 27a9b6da27..eb5d361b11 100644
--- a/linux-headers/asm-arm/unistd-common.h
+++ b/linux-headers/asm-arm/unistd-common.h
@@ -388,5 +388,7 @@
 #define __NR_fsconfig (__NR_SYSCALL_BASE + 431)
 #define __NR_fsmount (__NR_SYSCALL_BASE + 432)
 #define __NR_fspick (__NR_SYSCALL_BASE + 433)
+#define __NR_pidfd_open (__NR_SYSCALL_BASE + 434)
+#define __NR_clone3 (__NR_SYSCALL_BASE + 435)
=20
 #endif /* _ASM_ARM_UNISTD_COMMON_H */
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.=
h
index 2431ec35a9..0ce6e49f3a 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -229,6 +229,16 @@ struct kvm_vcpu_events {
 #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
 					 KVM_REG_ARM_FW | ((r) & 0xffff))
 #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL		0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL		1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_REQUIRED	2
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL		0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN		1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL		2
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED	3
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED     	(1U << 4)
=20
 /* SVE registers */
 #define KVM_REG_ARM64_SVE		(0x15 << KVM_REG_ARM_COPROC_SHIFT)
@@ -260,6 +270,13 @@ struct kvm_vcpu_events {
 	 KVM_REG_SIZE_U256 |						\
 	 ((i) & (KVM_ARM64_SVE_MAX_SLICES - 1)))
=20
+/*
+ * Register values for KVM_REG_ARM64_SVE_ZREG(), KVM_REG_ARM64_SVE_PREG(=
) and
+ * KVM_REG_ARM64_SVE_FFR() are represented in memory in an endianness-
+ * invariant layout which differs from the layout used for the FPSIMD
+ * V-registers on big-endian systems: see sigcontext.h for more explanat=
ion.
+ */
+
 #define KVM_ARM64_SVE_VQ_MIN __SVE_VQ_MIN
 #define KVM_ARM64_SVE_VQ_MAX __SVE_VQ_MAX
=20
@@ -308,8 +325,10 @@ struct kvm_vcpu_events {
 #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
=20
 /* KVM_IRQ_LINE irq field index values */
+#define KVM_ARM_IRQ_VCPU2_SHIFT		28
+#define KVM_ARM_IRQ_VCPU2_MASK		0xf
 #define KVM_ARM_IRQ_TYPE_SHIFT		24
-#define KVM_ARM_IRQ_TYPE_MASK		0xff
+#define KVM_ARM_IRQ_TYPE_MASK		0xf
 #define KVM_ARM_IRQ_VCPU_SHIFT		16
 #define KVM_ARM_IRQ_VCPU_MASK		0xff
 #define KVM_ARM_IRQ_NUM_SHIFT		0
diff --git a/linux-headers/asm-generic/mman-common.h b/linux-headers/asm-=
generic/mman-common.h
index abd238d0f7..63b1f506ea 100644
--- a/linux-headers/asm-generic/mman-common.h
+++ b/linux-headers/asm-generic/mman-common.h
@@ -19,15 +19,18 @@
 #define MAP_TYPE	0x0f		/* Mask for type of mapping */
 #define MAP_FIXED	0x10		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
-#ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
-# define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could=
 be uninitialized */
-#else
-# define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
-#endif
=20
-/* 0x0100 - 0x80000 flags are defined in asm-generic/mman.h */
+/* 0x0100 - 0x4000 flags are defined in asm-generic/mman.h */
+#define MAP_POPULATE		0x008000	/* populate (prefault) pagetables */
+#define MAP_NONBLOCK		0x010000	/* do not block on IO */
+#define MAP_STACK		0x020000	/* give out an address that is best suited f=
or process/thread stacks */
+#define MAP_HUGETLB		0x040000	/* create a huge page mapping */
+#define MAP_SYNC		0x080000 /* perform synchronous page faults for the ma=
pping */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap un=
derlying mapping */
=20
+#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could =
be
+					 * uninitialized */
+
 /*
  * Flags for mlock
  */
diff --git a/linux-headers/asm-generic/mman.h b/linux-headers/asm-generic=
/mman.h
index 653687d977..57e8195d0b 100644
--- a/linux-headers/asm-generic/mman.h
+++ b/linux-headers/asm-generic/mman.h
@@ -9,13 +9,11 @@
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited fo=
r process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-#define MAP_SYNC	0x80000		/* perform synchronous page faults for the map=
ping */
=20
-/* Bits [26:31] are reserved, see mman-common.h for MAP_HUGETLB usage */
+/*
+ * Bits [26:31] are reserved, see asm-generic/hugetlb_encode.h
+ * for MAP_HUGETLB usage
+ */
=20
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-gener=
ic/unistd.h
index a87904daf1..1be0e798e3 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -844,9 +844,15 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_pidfd_open 434
+__SYSCALL(__NR_pidfd_open, sys_pidfd_open)
+#ifdef __ARCH_WANT_SYS_CLONE3
+#define __NR_clone3 435
+__SYSCALL(__NR_clone3, sys_clone3)
+#endif
=20
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 436
=20
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips=
/unistd_n32.h
index fb988de900..7dffe8e34e 100644
--- a/linux-headers/asm-mips/unistd_n32.h
+++ b/linux-headers/asm-mips/unistd_n32.h
@@ -363,6 +363,7 @@
 #define __NR_fsconfig	(__NR_Linux + 431)
 #define __NR_fsmount	(__NR_Linux + 432)
 #define __NR_fspick	(__NR_Linux + 433)
+#define __NR_pidfd_open	(__NR_Linux + 434)
=20
=20
 #endif /* _ASM_MIPS_UNISTD_N32_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips=
/unistd_n64.h
index 17359163c9..f4592d6fc5 100644
--- a/linux-headers/asm-mips/unistd_n64.h
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -339,6 +339,7 @@
 #define __NR_fsconfig	(__NR_Linux + 431)
 #define __NR_fsmount	(__NR_Linux + 432)
 #define __NR_fspick	(__NR_Linux + 433)
+#define __NR_pidfd_open	(__NR_Linux + 434)
=20
=20
 #endif /* _ASM_MIPS_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips=
/unistd_o32.h
index 83c8d8fb83..04c6728352 100644
--- a/linux-headers/asm-mips/unistd_o32.h
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -409,6 +409,7 @@
 #define __NR_fsconfig	(__NR_Linux + 431)
 #define __NR_fsmount	(__NR_Linux + 432)
 #define __NR_fspick	(__NR_Linux + 433)
+#define __NR_pidfd_open	(__NR_Linux + 434)
=20
=20
 #endif /* _ASM_MIPS_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/mman.h b/linux-headers/asm-powerpc=
/mman.h
index 1c2b3fca05..8db7c2a3be 100644
--- a/linux-headers/asm-powerpc/mman.h
+++ b/linux-headers/asm-powerpc/mman.h
@@ -21,15 +21,11 @@
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
=20
+
 #define MCL_CURRENT     0x2000          /* lock all currently mapped pag=
es */
 #define MCL_FUTURE      0x4000          /* lock all additions to address=
 space */
 #define MCL_ONFAULT	0x8000		/* lock all pages that are faulted in */
=20
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited fo=
r process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-
 /* Override any generic PKEY permission defines */
 #define PKEY_DISABLE_EXECUTE   0x4
 #undef PKEY_ACCESS_MASK
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-po=
werpc/unistd_32.h
index 04cb2d3e61..5584cc1b4f 100644
--- a/linux-headers/asm-powerpc/unistd_32.h
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -416,6 +416,8 @@
 #define __NR_fsconfig	431
 #define __NR_fsmount	432
 #define __NR_fspick	433
+#define __NR_pidfd_open	434
+#define __NR_clone3	435
=20
=20
 #endif /* _ASM_POWERPC_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-po=
werpc/unistd_64.h
index b1e6921490..251bcff77e 100644
--- a/linux-headers/asm-powerpc/unistd_64.h
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -388,6 +388,8 @@
 #define __NR_fsconfig	431
 #define __NR_fsmount	432
 #define __NR_fspick	433
+#define __NR_pidfd_open	434
+#define __NR_clone3	435
=20
=20
 #endif /* _ASM_POWERPC_UNISTD_64_H */
diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/=
unistd_32.h
index 941853f3e9..7cce3ee296 100644
--- a/linux-headers/asm-s390/unistd_32.h
+++ b/linux-headers/asm-s390/unistd_32.h
@@ -406,5 +406,7 @@
 #define __NR_fsconfig 431
 #define __NR_fsmount 432
 #define __NR_fspick 433
+#define __NR_pidfd_open 434
+#define __NR_clone3 435
=20
 #endif /* _ASM_S390_UNISTD_32_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/=
unistd_64.h
index 90271d7f82..2371ff1e7a 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -354,5 +354,7 @@
 #define __NR_fsconfig 431
 #define __NR_fsmount 432
 #define __NR_fspick 433
+#define __NR_pidfd_open 434
+#define __NR_clone3 435
=20
 #endif /* _ASM_S390_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 6e7dd792e4..503d3f42da 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -378,23 +378,24 @@ struct kvm_sync_regs {
 	struct kvm_vcpu_events events;
 };
=20
-#define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
-#define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
-#define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
-#define KVM_X86_QUIRK_OUT_7E_INC_RIP	(1 << 3)
+#define KVM_X86_QUIRK_LINT0_REENABLED	   (1 << 0)
+#define KVM_X86_QUIRK_CD_NW_CLEARED	   (1 << 1)
+#define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	   (1 << 2)
+#define KVM_X86_QUIRK_OUT_7E_INC_RIP	   (1 << 3)
+#define KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT (1 << 4)
=20
 #define KVM_STATE_NESTED_FORMAT_VMX	0
-#define KVM_STATE_NESTED_FORMAT_SVM	1
+#define KVM_STATE_NESTED_FORMAT_SVM	1	/* unused */
=20
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
 #define KVM_STATE_NESTED_EVMCS		0x00000004
=20
-#define KVM_STATE_NESTED_VMX_VMCS_SIZE	0x1000
-
 #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
=20
+#define KVM_STATE_NESTED_VMX_VMCS_SIZE	0x1000
+
 struct kvm_vmx_nested_state_data {
 	__u8 vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
 	__u8 shadow_vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
@@ -432,4 +433,17 @@ struct kvm_nested_state {
 	} data;
 };
=20
+/* for KVM_CAP_PMU_EVENT_FILTER */
+struct kvm_pmu_event_filter {
+	__u32 action;
+	__u32 nevents;
+	__u32 fixed_counter_bitmap;
+	__u32 flags;
+	__u32 pad[4];
+	__u64 events[0];
+};
+
+#define KVM_PMU_EVENT_ALLOW 0
+#define KVM_PMU_EVENT_DENY 1
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/un=
istd_32.h
index 57bb48854c..e8ebec1cdc 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -424,5 +424,7 @@
 #define __NR_fsconfig 431
 #define __NR_fsmount 432
 #define __NR_fspick 433
+#define __NR_pidfd_open 434
+#define __NR_clone3 435
=20
 #endif /* _ASM_X86_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/un=
istd_64.h
index fe6aa0688a..a2f863d549 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -346,5 +346,7 @@
 #define __NR_fsconfig 431
 #define __NR_fsmount 432
 #define __NR_fspick 433
+#define __NR_pidfd_open 434
+#define __NR_clone3 435
=20
 #endif /* _ASM_X86_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/u=
nistd_x32.h
index 09cca49ba7..4cdc67d848 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -299,6 +299,8 @@
 #define __NR_fsconfig (__X32_SYSCALL_BIT + 431)
 #define __NR_fsmount (__X32_SYSCALL_BIT + 432)
 #define __NR_fspick (__X32_SYSCALL_BIT + 433)
+#define __NR_pidfd_open (__X32_SYSCALL_BIT + 434)
+#define __NR_clone3 (__X32_SYSCALL_BIT + 435)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index c8423e760c..a6a65ace2c 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -116,7 +116,7 @@ struct kvm_irq_level {
 	 * ACPI gsi notion of irq.
 	 * For IA-64 (APIC model) IOAPIC0: irq 0-23; IOAPIC1: irq 24-47..
 	 * For X86 (standard AT mode) PIC0/1: irq 0-15. IOAPIC0: 0-23..
-	 * For ARM: See Documentation/virtual/kvm/api.txt
+	 * For ARM: See Documentation/virt/kvm/api.txt
 	 */
 	union {
 		__u32 irq;
@@ -696,9 +696,11 @@ struct kvm_ioeventfd {
 #define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
 #define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
 #define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
+#define KVM_X86_DISABLE_EXITS_CSTATE         (1 << 3)
 #define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAI=
T | \
                                               KVM_X86_DISABLE_EXITS_HLT =
| \
-                                              KVM_X86_DISABLE_EXITS_PAUS=
E)
+                                              KVM_X86_DISABLE_EXITS_PAUS=
E | \
+                                              KVM_X86_DISABLE_EXITS_CSTA=
TE)
=20
 /* for KVM_ENABLE_CAP */
 struct kvm_enable_cap {
@@ -993,6 +995,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_SVE 170
 #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
 #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
+#define KVM_CAP_PMU_EVENT_FILTER 173
+#define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
=20
 #ifdef KVM_CAP_IRQ_ROUTING
=20
@@ -1083,7 +1087,7 @@ struct kvm_xen_hvm_config {
  *
  * KVM_IRQFD_FLAG_RESAMPLE indicates resamplefd is valid and specifies
  * the irqfd to operate in resampling mode for level triggered interrupt
- * emulation.  See Documentation/virtual/kvm/api.txt.
+ * emulation.  See Documentation/virt/kvm/api.txt.
  */
 #define KVM_IRQFD_FLAG_RESAMPLE (1 << 1)
=20
@@ -1327,6 +1331,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_PPC_GET_RMMU_INFO	  _IOW(KVMIO,  0xb0, struct kvm_ppc_rmmu_i=
nfo)
 /* Available with KVM_CAP_PPC_GET_CPU_CHAR */
 #define KVM_PPC_GET_CPU_CHAR	  _IOR(KVMIO,  0xb1, struct kvm_ppc_cpu_cha=
r)
+/* Available with KVM_CAP_PMU_EVENT_FILTER */
+#define KVM_SET_PMU_EVENT_FILTER  _IOW(KVMIO,  0xb2, struct kvm_pmu_even=
t_filter)
=20
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device=
)
diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.=
h
index 36bbe17d8f..34c39690c0 100644
--- a/linux-headers/linux/psp-sev.h
+++ b/linux-headers/linux/psp-sev.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
  * Userspace interface for AMD Secure Encrypted Virtualization (SEV)
  * platform management commands.
@@ -7,10 +8,6 @@
  * Author: Brijesh Singh <brijesh.singh@amd.com>
  *
  * SEV API specification is available at: https://developer.amd.com/sev/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
=20
 #ifndef __PSP_SEV_USER_H__
--=20
2.20.1


