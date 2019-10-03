Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9ADC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7838320700
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7838320700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG3Oa-0007YG-8M
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 11:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iG3Jo-0003Kz-A5
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 11:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iG3Jk-0006Oh-0J
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 11:47:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iG3Ja-0006Gv-VJ; Thu, 03 Oct 2019 11:46:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 18BCA2102;
 Thu,  3 Oct 2019 15:46:50 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-64.ams2.redhat.com [10.36.117.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0150B196B2;
 Thu,  3 Oct 2019 15:46:47 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v4 1/3] linux headers: update against v5.4-rc1
Date: Thu,  3 Oct 2019 17:46:38 +0200
Message-Id: <20191003154640.22451-2-eric.auger@redhat.com>
In-Reply-To: <20191003154640.22451-1-eric.auger@redhat.com>
References: <20191003154640.22451-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Thu, 03 Oct 2019 15:46:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

Update the headers against commit:
0f1a7b3fac05 ("timer-of: don't use conditional expression
with mixed 'void' types")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/standard-headers/asm-x86/bootparam.h  |   2 +
 include/standard-headers/asm-x86/kvm_para.h   |   1 +
 include/standard-headers/linux/ethtool.h      |  24 +++
 include/standard-headers/linux/pci_regs.h     |  19 +-
 include/standard-headers/linux/virtio_fs.h    |  19 ++
 include/standard-headers/linux/virtio_ids.h   |   2 +
 include/standard-headers/linux/virtio_iommu.h | 165 ++++++++++++++++++
 include/standard-headers/linux/virtio_pmem.h  |   6 +-
 linux-headers/asm-arm/kvm.h                   |  16 +-
 linux-headers/asm-arm/unistd-common.h         |   2 +
 linux-headers/asm-arm64/kvm.h                 |  21 ++-
 linux-headers/asm-generic/mman-common.h       |  18 +-
 linux-headers/asm-generic/mman.h              |  10 +-
 linux-headers/asm-generic/unistd.h            |  10 +-
 linux-headers/asm-mips/mman.h                 |   3 +
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/mman.h              |   6 +-
 linux-headers/asm-powerpc/unistd_32.h         |   2 +
 linux-headers/asm-powerpc/unistd_64.h         |   2 +
 linux-headers/asm-s390/kvm.h                  |   6 +
 linux-headers/asm-s390/unistd_32.h            |   2 +
 linux-headers/asm-s390/unistd_64.h            |   2 +
 linux-headers/asm-x86/kvm.h                   |  28 ++-
 linux-headers/asm-x86/unistd.h                |   2 +-
 linux-headers/asm-x86/unistd_32.h             |   2 +
 linux-headers/asm-x86/unistd_64.h             |   2 +
 linux-headers/asm-x86/unistd_x32.h            |   2 +
 linux-headers/linux/kvm.h                     |  12 +-
 linux-headers/linux/psp-sev.h                 |   5 +-
 linux-headers/linux/vfio.h                    |  71 +++++---
 32 files changed, 406 insertions(+), 59 deletions(-)
 create mode 100644 include/standard-headers/linux/virtio_fs.h
 create mode 100644 include/standard-headers/linux/virtio_iommu.h

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
index 9b9919a8f6..4ff422b635 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -259,10 +259,32 @@ struct ethtool_tunable {
 #define ETHTOOL_PHY_FAST_LINK_DOWN_ON	0
 #define ETHTOOL_PHY_FAST_LINK_DOWN_OFF	0xff
=20
+/* Energy Detect Power Down (EDPD) is a feature supported by some PHYs, =
where
+ * the PHY's RX & TX blocks are put into a low-power mode when there is =
no
+ * link detected (typically cable is un-plugged). For RX, only a minimal
+ * link-detection is available, and for TX the PHY wakes up to send link=
 pulses
+ * to avoid any lock-ups in case the peer PHY may also be running in EDP=
D mode.
+ *
+ * Some PHYs may support configuration of the wake-up interval for TX pu=
lses,
+ * and some PHYs may support only disabling TX pulses entirely. For the =
latter
+ * a special value is required (ETHTOOL_PHY_EDPD_NO_TX) so that this can=
 be
+ * configured from userspace (should the user want it).
+ *
+ * The interval units for TX wake-up are in milliseconds, since this sho=
uld
+ * cover a reasonable range of intervals:
+ *  - from 1 millisecond, which does not sound like much of a power-save=
r
+ *  - to ~65 seconds which is quite a lot to wait for a link to come up =
when
+ *    plugging a cable
+ */
+#define ETHTOOL_PHY_EDPD_DFLT_TX_MSECS		0xffff
+#define ETHTOOL_PHY_EDPD_NO_TX			0xfffe
+#define ETHTOOL_PHY_EDPD_DISABLE		0
+
 enum phy_tunable_id {
 	ETHTOOL_PHY_ID_UNSPEC,
 	ETHTOOL_PHY_DOWNSHIFT,
 	ETHTOOL_PHY_FAST_LINK_DOWN,
+	ETHTOOL_PHY_EDPD,
 	/*
 	 * Add your fresh new phy tunable attribute above and remember to updat=
e
 	 * phy_tunable_strings[] in net/core/ethtool.c
@@ -1483,6 +1505,8 @@ enum ethtool_link_mode_bit_indices {
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
index 27164769d1..29d6e93fd1 100644
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
@@ -589,6 +591,7 @@
 #define  PCI_EXP_SLTCTL_CCIE	0x0010	/* Command Completed Interrupt Enabl=
e */
 #define  PCI_EXP_SLTCTL_HPIE	0x0020	/* Hot-Plug Interrupt Enable */
 #define  PCI_EXP_SLTCTL_AIC	0x00c0	/* Attention Indicator Control */
+#define  PCI_EXP_SLTCTL_ATTN_IND_SHIFT 6      /* Attention Indicator shi=
ft */
 #define  PCI_EXP_SLTCTL_ATTN_IND_ON    0x0040 /* Attention Indicator on =
*/
 #define  PCI_EXP_SLTCTL_ATTN_IND_BLINK 0x0080 /* Attention Indicator bli=
nking */
 #define  PCI_EXP_SLTCTL_ATTN_IND_OFF   0x00c0 /* Attention Indicator off=
 */
@@ -661,6 +664,7 @@
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
@@ -668,6 +672,7 @@
 #define  PCI_EXP_LNKCTL2_TLS_5_0GT	0x0002 /* Supported Speed 5GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end =
here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
@@ -709,7 +714,9 @@
 #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
 #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
 #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
+#define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
+#define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
=20
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1049,4 +1056,14 @@
 #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /* LTR_L1.2_THRESHOL=
D_Scale */
 #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register */
=20
+/* Data Link Feature */
+#define PCI_DLF_CAP		0x04	/* Capabilities Register */
+#define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link Feature Exchan=
ge Enable */
+
+/* Physical Layer 16.0 GT/s */
+#define PCI_PL_16GT_LE_CTRL	0x20	/* Lane Equalization Control Register *=
/
+#define  PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK		0x0000000F
+#define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
+#define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
+
 #endif /* LINUX_PCI_REGS_H */
diff --git a/include/standard-headers/linux/virtio_fs.h b/include/standar=
d-headers/linux/virtio_fs.h
new file mode 100644
index 0000000000..9d88817a6b
--- /dev/null
+++ b/include/standard-headers/linux/virtio_fs.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-=
Clause) */
+
+#ifndef _LINUX_VIRTIO_FS_H
+#define _LINUX_VIRTIO_FS_H
+
+#include "standard-headers/linux/types.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_config.h"
+#include "standard-headers/linux/virtio_types.h"
+
+struct virtio_fs_config {
+	/* Filesystem name (UTF-8, not NUL-terminated, padded with NULs) */
+	uint8_t tag[36];
+
+	/* Number of request queues */
+	uint32_t num_request_queues;
+} QEMU_PACKED;
+
+#endif /* _LINUX_VIRTIO_FS_H */
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standa=
rd-headers/linux/virtio_ids.h
index 32b2f94d1f..585e07b273 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -43,6 +43,8 @@
 #define VIRTIO_ID_INPUT        18 /* virtio input */
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
+#define VIRTIO_ID_IOMMU        23 /* virtio IOMMU */
+#define VIRTIO_ID_FS           26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM         27 /* virtio pmem */
=20
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/include/standard-headers/linux/virtio_iommu.h b/include/stan=
dard-headers/linux/virtio_iommu.h
new file mode 100644
index 0000000000..b9443b83a1
--- /dev/null
+++ b/include/standard-headers/linux/virtio_iommu.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Virtio-iommu definition v0.12
+ *
+ * Copyright (C) 2019 Arm Ltd.
+ */
+#ifndef _LINUX_VIRTIO_IOMMU_H
+#define _LINUX_VIRTIO_IOMMU_H
+
+#include "standard-headers/linux/types.h"
+
+/* Feature bits */
+#define VIRTIO_IOMMU_F_INPUT_RANGE		0
+#define VIRTIO_IOMMU_F_DOMAIN_RANGE		1
+#define VIRTIO_IOMMU_F_MAP_UNMAP		2
+#define VIRTIO_IOMMU_F_BYPASS			3
+#define VIRTIO_IOMMU_F_PROBE			4
+#define VIRTIO_IOMMU_F_MMIO			5
+
+struct virtio_iommu_range_64 {
+	uint64_t					start;
+	uint64_t					end;
+};
+
+struct virtio_iommu_range_32 {
+	uint32_t					start;
+	uint32_t					end;
+};
+
+struct virtio_iommu_config {
+	/* Supported page sizes */
+	uint64_t					page_size_mask;
+	/* Supported IOVA range */
+	struct virtio_iommu_range_64		input_range;
+	/* Max domain ID size */
+	struct virtio_iommu_range_32		domain_range;
+	/* Probe buffer size */
+	uint32_t					probe_size;
+};
+
+/* Request types */
+#define VIRTIO_IOMMU_T_ATTACH			0x01
+#define VIRTIO_IOMMU_T_DETACH			0x02
+#define VIRTIO_IOMMU_T_MAP			0x03
+#define VIRTIO_IOMMU_T_UNMAP			0x04
+#define VIRTIO_IOMMU_T_PROBE			0x05
+
+/* Status types */
+#define VIRTIO_IOMMU_S_OK			0x00
+#define VIRTIO_IOMMU_S_IOERR			0x01
+#define VIRTIO_IOMMU_S_UNSUPP			0x02
+#define VIRTIO_IOMMU_S_DEVERR			0x03
+#define VIRTIO_IOMMU_S_INVAL			0x04
+#define VIRTIO_IOMMU_S_RANGE			0x05
+#define VIRTIO_IOMMU_S_NOENT			0x06
+#define VIRTIO_IOMMU_S_FAULT			0x07
+#define VIRTIO_IOMMU_S_NOMEM			0x08
+
+struct virtio_iommu_req_head {
+	uint8_t					type;
+	uint8_t					reserved[3];
+};
+
+struct virtio_iommu_req_tail {
+	uint8_t					status;
+	uint8_t					reserved[3];
+};
+
+struct virtio_iommu_req_attach {
+	struct virtio_iommu_req_head		head;
+	uint32_t					domain;
+	uint32_t					endpoint;
+	uint8_t					reserved[8];
+	struct virtio_iommu_req_tail		tail;
+};
+
+struct virtio_iommu_req_detach {
+	struct virtio_iommu_req_head		head;
+	uint32_t					domain;
+	uint32_t					endpoint;
+	uint8_t					reserved[8];
+	struct virtio_iommu_req_tail		tail;
+};
+
+#define VIRTIO_IOMMU_MAP_F_READ			(1 << 0)
+#define VIRTIO_IOMMU_MAP_F_WRITE		(1 << 1)
+#define VIRTIO_IOMMU_MAP_F_MMIO			(1 << 2)
+
+#define VIRTIO_IOMMU_MAP_F_MASK			(VIRTIO_IOMMU_MAP_F_READ |	\
+						 VIRTIO_IOMMU_MAP_F_WRITE |	\
+						 VIRTIO_IOMMU_MAP_F_MMIO)
+
+struct virtio_iommu_req_map {
+	struct virtio_iommu_req_head		head;
+	uint32_t					domain;
+	uint64_t					virt_start;
+	uint64_t					virt_end;
+	uint64_t					phys_start;
+	uint32_t					flags;
+	struct virtio_iommu_req_tail		tail;
+};
+
+struct virtio_iommu_req_unmap {
+	struct virtio_iommu_req_head		head;
+	uint32_t					domain;
+	uint64_t					virt_start;
+	uint64_t					virt_end;
+	uint8_t					reserved[4];
+	struct virtio_iommu_req_tail		tail;
+};
+
+#define VIRTIO_IOMMU_PROBE_T_NONE		0
+#define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
+
+#define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
+
+struct virtio_iommu_probe_property {
+	uint16_t					type;
+	uint16_t					length;
+};
+
+#define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
+#define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
+
+struct virtio_iommu_probe_resv_mem {
+	struct virtio_iommu_probe_property	head;
+	uint8_t					subtype;
+	uint8_t					reserved[3];
+	uint64_t					start;
+	uint64_t					end;
+};
+
+struct virtio_iommu_req_probe {
+	struct virtio_iommu_req_head		head;
+	uint32_t					endpoint;
+	uint8_t					reserved[64];
+
+	uint8_t					properties[];
+
+	/*
+	 * Tail follows the variable-length properties array. No padding,
+	 * property lengths are all aligned on 8 bytes.
+	 */
+};
+
+/* Fault types */
+#define VIRTIO_IOMMU_FAULT_R_UNKNOWN		0
+#define VIRTIO_IOMMU_FAULT_R_DOMAIN		1
+#define VIRTIO_IOMMU_FAULT_R_MAPPING		2
+
+#define VIRTIO_IOMMU_FAULT_F_READ		(1 << 0)
+#define VIRTIO_IOMMU_FAULT_F_WRITE		(1 << 1)
+#define VIRTIO_IOMMU_FAULT_F_EXEC		(1 << 2)
+#define VIRTIO_IOMMU_FAULT_F_ADDRESS		(1 << 8)
+
+struct virtio_iommu_fault {
+	uint8_t					reason;
+	uint8_t					reserved[3];
+	uint32_t					flags;
+	uint32_t					endpoint;
+	uint8_t					reserved2[4];
+	uint64_t					address;
+};
+
+#endif
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
index abd238d0f7..c160a5354e 100644
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
@@ -64,6 +67,9 @@
 #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
 #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
=20
+#define MADV_COLD	20		/* deactivate these pages */
+#define MADV_PAGEOUT	21		/* reclaim these pages */
+
 /* compatibility flags */
 #define MAP_FILE	0
=20
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
index a87904daf1..1fc8faa6e9 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -569,7 +569,7 @@ __SYSCALL(__NR_semget, sys_semget)
 __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
 #define __NR_semtimedop 192
-__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_time32)
+__SC_3264(__NR_semtimedop, sys_semtimedop_time32, sys_semtimedop)
 #endif
 #define __NR_semop 193
 __SYSCALL(__NR_semop, sys_semop)
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
diff --git a/linux-headers/asm-mips/mman.h b/linux-headers/asm-mips/mman.=
h
index c2b40969eb..57dc2ac4f8 100644
--- a/linux-headers/asm-mips/mman.h
+++ b/linux-headers/asm-mips/mman.h
@@ -95,6 +95,9 @@
 #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
 #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
=20
+#define MADV_COLD	20		/* deactivate these pages */
+#define MADV_PAGEOUT	21		/* reclaim these pages */
+
 /* compatibility flags */
 #define MAP_FILE	0
=20
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
diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 03ab5968c7..0138ccb0d8 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -231,6 +231,12 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_GSCB   (1UL << 9)
 #define KVM_SYNC_BPBC   (1UL << 10)
 #define KVM_SYNC_ETOKEN (1UL << 11)
+
+#define KVM_SYNC_S390_VALID_FIELDS \
+	(KVM_SYNC_PREFIX | KVM_SYNC_GPRS | KVM_SYNC_ACRS | KVM_SYNC_CRS | \
+	 KVM_SYNC_ARCH0 | KVM_SYNC_PFAULT | KVM_SYNC_VRS | KVM_SYNC_RICCB | \
+	 KVM_SYNC_FPRS | KVM_SYNC_GSCB | KVM_SYNC_BPBC | KVM_SYNC_ETOKEN)
+
 /* length and alignment of the sdnx as a power of two */
 #define SDNXC 8
 #define SDNXL (1UL << SDNXC)
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
diff --git a/linux-headers/asm-x86/unistd.h b/linux-headers/asm-x86/unist=
d.h
index c04f638154..498d1515c6 100644
--- a/linux-headers/asm-x86/unistd.h
+++ b/linux-headers/asm-x86/unistd.h
@@ -3,7 +3,7 @@
 #define _ASM_X86_UNISTD_H
=20
 /* x32 syscall flag bit */
-#define __X32_SYSCALL_BIT	0x40000000
+#define __X32_SYSCALL_BIT	0x40000000UL
=20
 # ifdef __i386__
 #  include <asm/unistd_32.h>
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
index 18892d6541..3d9b18f7f8 100644
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
@@ -243,6 +243,8 @@ struct kvm_hyperv_exit {
 #define KVM_INTERNAL_ERROR_SIMUL_EX	2
 /* Encounter unexpected vm-exit due to delivery event. */
 #define KVM_INTERNAL_ERROR_DELIVERY_EV	3
+/* Encounter unexpected vm-exit reason */
+#define KVM_INTERNAL_ERROR_UNEXPECTED_EXIT_REASON	4
=20
 /* for KVM_RUN, returned by mmap(vcpu_fd, offset=3D0) */
 struct kvm_run {
@@ -995,6 +997,9 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_SVE 170
 #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
 #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
+#define KVM_CAP_PMU_EVENT_FILTER 173
+#define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
+#define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 175
=20
 #ifdef KVM_CAP_IRQ_ROUTING
=20
@@ -1085,7 +1090,7 @@ struct kvm_xen_hvm_config {
  *
  * KVM_IRQFD_FLAG_RESAMPLE indicates resamplefd is valid and specifies
  * the irqfd to operate in resampling mode for level triggered interrupt
- * emulation.  See Documentation/virtual/kvm/api.txt.
+ * emulation.  See Documentation/virt/kvm/api.txt.
  */
 #define KVM_IRQFD_FLAG_RESAMPLE (1 << 1)
=20
@@ -1141,6 +1146,7 @@ struct kvm_dirty_tlb {
 #define KVM_REG_S390		0x5000000000000000ULL
 #define KVM_REG_ARM64		0x6000000000000000ULL
 #define KVM_REG_MIPS		0x7000000000000000ULL
+#define KVM_REG_RISCV		0x8000000000000000ULL
=20
 #define KVM_REG_SIZE_SHIFT	52
 #define KVM_REG_SIZE_MASK	0x00f0000000000000ULL
@@ -1329,6 +1335,8 @@ struct kvm_s390_ucas_mapping {
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
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 24f505199f..fb10370d29 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -295,15 +295,38 @@ struct vfio_region_info_cap_type {
 	__u32 subtype;	/* type specific */
 };
=20
+/*
+ * List of region types, global per bus driver.
+ * If you introduce a new type, please add it here.
+ */
+
+/* PCI region type containing a PCI vendor part */
 #define VFIO_REGION_TYPE_PCI_VENDOR_TYPE	(1 << 31)
 #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
+#define VFIO_REGION_TYPE_GFX                    (1)
+#define VFIO_REGION_TYPE_CCW			(2)
=20
-/* 8086 Vendor sub-types */
+/* sub-types for VFIO_REGION_TYPE_PCI_* */
+
+/* 8086 vendor PCI sub-types */
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION	(1)
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
=20
-#define VFIO_REGION_TYPE_GFX                    (1)
+/* 10de vendor PCI sub-types */
+/*
+ * NVIDIA GPU NVlink2 RAM is coherent RAM mapped onto the host address s=
pace.
+ */
+#define VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM	(1)
+
+/* 1014 vendor PCI sub-types */
+/*
+ * IBM NPU NVlink2 ATSD (Address Translation Shootdown) register of NPU
+ * to do TLB invalidation on a GPU.
+ */
+#define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
+
+/* sub-types for VFIO_REGION_TYPE_GFX */
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
=20
 /**
@@ -353,25 +376,9 @@ struct vfio_region_gfx_edid {
 #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
 };
=20
-#define VFIO_REGION_TYPE_CCW			(2)
-/* ccw sub-types */
+/* sub-types for VFIO_REGION_TYPE_CCW */
 #define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
=20
-/*
- * 10de vendor sub-type
- *
- * NVIDIA GPU NVlink2 RAM is coherent RAM mapped onto the host address s=
pace.
- */
-#define VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RAM	(1)
-
-/*
- * 1014 vendor sub-type
- *
- * IBM NPU NVlink2 ATSD (Address Translation Shootdown) register of NPU
- * to do TLB invalidation on a GPU.
- */
-#define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
-
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be m=
mapped
  * which allows direct access to non-MSIX registers which happened to be=
 within
@@ -714,7 +721,31 @@ struct vfio_iommu_type1_info {
 	__u32	argsz;
 	__u32	flags;
 #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
-	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
+#define VFIO_IOMMU_INFO_CAPS	(1 << 1)	/* Info supports caps */
+	__u64	iova_pgsizes;	/* Bitmap of supported page sizes */
+	__u32   cap_offset;	/* Offset within info struct of first cap */
+};
+
+/*
+ * The IOVA capability allows to report the valid IOVA range(s)
+ * excluding any non-relaxable reserved regions exposed by
+ * devices attached to the container. Any DMA map attempt
+ * outside the valid iova range will return error.
+ *
+ * The structures below define version 1 of this capability.
+ */
+#define VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE  1
+
+struct vfio_iova_range {
+	__u64	start;
+	__u64	end;
+};
+
+struct vfio_iommu_type1_info_cap_iova_range {
+	struct	vfio_info_cap_header header;
+	__u32	nr_iovas;
+	__u32	reserved;
+	struct	vfio_iova_range iova_ranges[];
 };
=20
 #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
--=20
2.20.1


