Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A382C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 22:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF098206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 22:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRtFb92V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF098206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgyZR-0003US-1l
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 18:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgyYd-00032M-G8
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 18:41:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23250
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgyYb-0001VR-DJ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 18:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591310511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DgEdlPytZKygvzpJFdiN8HqqeLkpP2rgjzcVWgyQqDE=;
 b=eRtFb92VobuZziVj3+oRuhEM/32ZhbyjiIEDnqaeagq7njCEvnhzu0NPyu/2glqWIUN6YG
 NbL2WJ0JCg4C8LutXPdJXBFV1trV/83foyTGB+ScfaEFH7lin0PapuHfgEd2atV8iq7CGL
 CLzLumZFMBfXCeuN+hhKcI53tngNLik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-p7bH9BTQMGWqv57Z6GsLIQ-1; Thu, 04 Jun 2020 18:41:49 -0400
X-MC-Unique: p7bH9BTQMGWqv57Z6GsLIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C48AA86ABD5
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 22:41:48 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FE1F60BF4
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 22:41:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-headers: update to Linux 5.8-rc1
Date: Thu,  4 Jun 2020 18:41:48 -0400
Message-Id: <20200604224148.2536-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FUZZY_XPILL=2.799, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/standard-headers/asm-x86/kvm_para.h |  17 ++-
 include/standard-headers/drm/drm_fourcc.h   | 140 ++++++++++++++++++--
 include/standard-headers/linux/ethtool.h    |  16 ++-
 linux-headers/asm-arm/unistd-common.h       |   1 +
 linux-headers/asm-arm64/mman.h              |   8 ++
 linux-headers/asm-generic/unistd.h          |   4 +-
 linux-headers/asm-mips/unistd_n32.h         |   1 +
 linux-headers/asm-mips/unistd_n64.h         |   1 +
 linux-headers/asm-mips/unistd_o32.h         |   1 +
 linux-headers/asm-powerpc/unistd_32.h       |   1 +
 linux-headers/asm-powerpc/unistd_64.h       |   1 +
 linux-headers/asm-s390/unistd_32.h          |   1 +
 linux-headers/asm-s390/unistd_64.h          |   1 +
 linux-headers/asm-x86/kvm.h                 |  20 ++-
 linux-headers/asm-x86/unistd.h              |  11 +-
 linux-headers/asm-x86/unistd_32.h           |   1 +
 linux-headers/asm-x86/unistd_64.h           |   1 +
 linux-headers/asm-x86/unistd_x32.h          |   1 +
 linux-headers/linux/kvm.h                   |  18 ++-
 linux-headers/linux/psp-sev.h               |   2 +
 20 files changed, 224 insertions(+), 23 deletions(-)

diff --git a/include/standard-headers/asm-x86/kvm_para.h b/include/standard-headers/asm-x86/kvm_para.h
index 90604a8fb7..07877d3295 100644
--- a/include/standard-headers/asm-x86/kvm_para.h
+++ b/include/standard-headers/asm-x86/kvm_para.h
@@ -31,6 +31,7 @@
 #define KVM_FEATURE_PV_SEND_IPI	11
 #define KVM_FEATURE_POLL_CONTROL	12
 #define KVM_FEATURE_PV_SCHED_YIELD	13
+#define KVM_FEATURE_ASYNC_PF_INT	14
 
 #define KVM_HINTS_REALTIME      0
 
@@ -50,6 +51,8 @@
 #define MSR_KVM_STEAL_TIME  0x4b564d03
 #define MSR_KVM_PV_EOI_EN      0x4b564d04
 #define MSR_KVM_POLL_CONTROL	0x4b564d05
+#define MSR_KVM_ASYNC_PF_INT	0x4b564d06
+#define MSR_KVM_ASYNC_PF_ACK	0x4b564d07
 
 struct kvm_steal_time {
 	uint64_t steal;
@@ -81,6 +84,11 @@ struct kvm_clock_pairing {
 #define KVM_ASYNC_PF_ENABLED			(1 << 0)
 #define KVM_ASYNC_PF_SEND_ALWAYS		(1 << 1)
 #define KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT	(1 << 2)
+#define KVM_ASYNC_PF_DELIVERY_AS_INT		(1 << 3)
+
+/* MSR_KVM_ASYNC_PF_INT */
+#define KVM_ASYNC_PF_VEC_MASK			GENMASK(7, 0)
+
 
 /* Operations for KVM_HC_MMU_OP */
 #define KVM_MMU_OP_WRITE_PTE            1
@@ -112,8 +120,13 @@ struct kvm_mmu_op_release_pt {
 #define KVM_PV_REASON_PAGE_READY 2
 
 struct kvm_vcpu_pv_apf_data {
-	uint32_t reason;
-	uint8_t pad[60];
+	/* Used for 'page not present' events delivered via #PF */
+	uint32_t flags;
+
+	/* Used for 'page ready' events delivered via interrupt notification */
+	uint32_t token;
+
+	uint8_t pad[56];
 	uint32_t enabled;
 };
 
diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
index 66e838074c..909a66753c 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -353,9 +353,12 @@ extern "C" {
  * a platform-dependent stride. On top of that the memory can apply
  * platform-depending swizzling of some higher address bits into bit6.
  *
- * This format is highly platforms specific and not useful for cross-driver
- * sharing. It exists since on a given platform it does uniquely identify the
- * layout in a simple way for i915-specific userspace.
+ * Note that this layout is only accurate on intel gen 8+ or valleyview chipsets.
+ * On earlier platforms the is highly platforms specific and not useful for
+ * cross-driver sharing. It exists since on a given platform it does uniquely
+ * identify the layout in a simple way for i915-specific userspace, which
+ * facilitated conversion of userspace to modifiers. Additionally the exact
+ * format on some really old platforms is not known.
  */
 #define I915_FORMAT_MOD_X_TILED	fourcc_mod_code(INTEL, 1)
 
@@ -368,9 +371,12 @@ extern "C" {
  * memory can apply platform-depending swizzling of some higher address bits
  * into bit6.
  *
- * This format is highly platforms specific and not useful for cross-driver
- * sharing. It exists since on a given platform it does uniquely identify the
- * layout in a simple way for i915-specific userspace.
+ * Note that this layout is only accurate on intel gen 8+ or valleyview chipsets.
+ * On earlier platforms the is highly platforms specific and not useful for
+ * cross-driver sharing. It exists since on a given platform it does uniquely
+ * identify the layout in a simple way for i915-specific userspace, which
+ * facilitated conversion of userspace to modifiers. Additionally the exact
+ * format on some really old platforms is not known.
  */
 #define I915_FORMAT_MOD_Y_TILED	fourcc_mod_code(INTEL, 2)
 
@@ -520,7 +526,113 @@ extern "C" {
 #define DRM_FORMAT_MOD_NVIDIA_TEGRA_TILED fourcc_mod_code(NVIDIA, 1)
 
 /*
- * 16Bx2 Block Linear layout, used by desktop GPUs, and Tegra K1 and later
+ * Generalized Block Linear layout, used by desktop GPUs starting with NV50/G80,
+ * and Tegra GPUs starting with Tegra K1.
+ *
+ * Pixels are arranged in Groups of Bytes (GOBs).  GOB size and layout varies
+ * based on the architecture generation.  GOBs themselves are then arranged in
+ * 3D blocks, with the block dimensions (in terms of GOBs) always being a power
+ * of two, and hence expressible as their log2 equivalent (E.g., "2" represents
+ * a block depth or height of "4").
+ *
+ * Chapter 20 "Pixel Memory Formats" of the Tegra X1 TRM describes this format
+ * in full detail.
+ *
+ *       Macro
+ * Bits  Param Description
+ * ----  ----- -----------------------------------------------------------------
+ *
+ *  3:0  h     log2(height) of each block, in GOBs.  Placed here for
+ *             compatibility with the existing
+ *             DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK()-based modifiers.
+ *
+ *  4:4  -     Must be 1, to indicate block-linear layout.  Necessary for
+ *             compatibility with the existing
+ *             DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK()-based modifiers.
+ *
+ *  8:5  -     Reserved (To support 3D-surfaces with variable log2(depth) block
+ *             size).  Must be zero.
+ *
+ *             Note there is no log2(width) parameter.  Some portions of the
+ *             hardware support a block width of two gobs, but it is impractical
+ *             to use due to lack of support elsewhere, and has no known
+ *             benefits.
+ *
+ * 11:9  -     Reserved (To support 2D-array textures with variable array stride
+ *             in blocks, specified via log2(tile width in blocks)).  Must be
+ *             zero.
+ *
+ * 19:12 k     Page Kind.  This value directly maps to a field in the page
+ *             tables of all GPUs >= NV50.  It affects the exact layout of bits
+ *             in memory and can be derived from the tuple
+ *
+ *               (format, GPU model, compression type, samples per pixel)
+ *
+ *             Where compression type is defined below.  If GPU model were
+ *             implied by the format modifier, format, or memory buffer, page
+ *             kind would not need to be included in the modifier itself, but
+ *             since the modifier should define the layout of the associated
+ *             memory buffer independent from any device or other context, it
+ *             must be included here.
+ *
+ * 21:20 g     GOB Height and Page Kind Generation.  The height of a GOB changed
+ *             starting with Fermi GPUs.  Additionally, the mapping between page
+ *             kind and bit layout has changed at various points.
+ *
+ *               0 = Gob Height 8, Fermi - Volta, Tegra K1+ Page Kind mapping
+ *               1 = Gob Height 4, G80 - GT2XX Page Kind mapping
+ *               2 = Gob Height 8, Turing+ Page Kind mapping
+ *               3 = Reserved for future use.
+ *
+ * 22:22 s     Sector layout.  On Tegra GPUs prior to Xavier, there is a further
+ *             bit remapping step that occurs at an even lower level than the
+ *             page kind and block linear swizzles.  This causes the layout of
+ *             surfaces mapped in those SOC's GPUs to be incompatible with the
+ *             equivalent mapping on other GPUs in the same system.
+ *
+ *               0 = Tegra K1 - Tegra Parker/TX2 Layout.
+ *               1 = Desktop GPU and Tegra Xavier+ Layout
+ *
+ * 25:23 c     Lossless Framebuffer Compression type.
+ *
+ *               0 = none
+ *               1 = ROP/3D, layout 1, exact compression format implied by Page
+ *                   Kind field
+ *               2 = ROP/3D, layout 2, exact compression format implied by Page
+ *                   Kind field
+ *               3 = CDE horizontal
+ *               4 = CDE vertical
+ *               5 = Reserved for future use
+ *               6 = Reserved for future use
+ *               7 = Reserved for future use
+ *
+ * 55:25 -     Reserved for future use.  Must be zero.
+ */
+#define DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(c, s, g, k, h) \
+	fourcc_mod_code(NVIDIA, (0x10 | \
+				 ((h) & 0xf) | \
+				 (((k) & 0xff) << 12) | \
+				 (((g) & 0x3) << 20) | \
+				 (((s) & 0x1) << 22) | \
+				 (((c) & 0x7) << 23)))
+
+/* To grandfather in prior block linear format modifiers to the above layout,
+ * the page kind "0", which corresponds to "pitch/linear" and hence is unusable
+ * with block-linear layouts, is remapped within drivers to the value 0xfe,
+ * which corresponds to the "generic" kind used for simple single-sample
+ * uncompressed color formats on Fermi - Volta GPUs.
+ */
+static inline uint64_t
+drm_fourcc_canonicalize_nvidia_format_mod(uint64_t modifier)
+{
+	if (!(modifier & 0x10) || (modifier & (0xff << 12)))
+		return modifier;
+	else
+		return modifier | (0xfe << 12);
+}
+
+/*
+ * 16Bx2 Block Linear layout, used by Tegra K1 and later
  *
  * Pixels are arranged in 64x8 Groups Of Bytes (GOBs). GOBs are then stacked
  * vertically by a power of 2 (1 to 32 GOBs) to form a block.
@@ -541,20 +653,20 @@ extern "C" {
  * in full detail.
  */
 #define DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(v) \
-	fourcc_mod_code(NVIDIA, 0x10 | ((v) & 0xf))
+	DRM_FORMAT_MOD_NVIDIA_BLOCK_LINEAR_2D(0, 0, 0, 0, (v))
 
 #define DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK_ONE_GOB \
-	fourcc_mod_code(NVIDIA, 0x10)
+	DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(0)
 #define DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK_TWO_GOB \
-	fourcc_mod_code(NVIDIA, 0x11)
+	DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(1)
 #define DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK_FOUR_GOB \
-	fourcc_mod_code(NVIDIA, 0x12)
+	DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(2)
 #define DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK_EIGHT_GOB \
-	fourcc_mod_code(NVIDIA, 0x13)
+	DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(3)
 #define DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK_SIXTEEN_GOB \
-	fourcc_mod_code(NVIDIA, 0x14)
+	DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(4)
 #define DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK_THIRTYTWO_GOB \
-	fourcc_mod_code(NVIDIA, 0x15)
+	DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(5)
 
 /*
  * Some Broadcom modifiers take parameters, for example the number of
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index 1200890c86..fd8d2cccfe 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -1666,6 +1666,18 @@ static inline int ethtool_validate_duplex(uint8_t duplex)
 	return 0;
 }
 
+#define MASTER_SLAVE_CFG_UNSUPPORTED		0
+#define MASTER_SLAVE_CFG_UNKNOWN		1
+#define MASTER_SLAVE_CFG_MASTER_PREFERRED	2
+#define MASTER_SLAVE_CFG_SLAVE_PREFERRED	3
+#define MASTER_SLAVE_CFG_MASTER_FORCE		4
+#define MASTER_SLAVE_CFG_SLAVE_FORCE		5
+#define MASTER_SLAVE_STATE_UNSUPPORTED		0
+#define MASTER_SLAVE_STATE_UNKNOWN		1
+#define MASTER_SLAVE_STATE_MASTER		2
+#define MASTER_SLAVE_STATE_SLAVE		3
+#define MASTER_SLAVE_STATE_ERR			4
+
 /* Which connector port. */
 #define PORT_TP			0x00
 #define PORT_AUI		0x01
@@ -1904,7 +1916,9 @@ struct ethtool_link_settings {
 	uint8_t	eth_tp_mdix_ctrl;
 	int8_t	link_mode_masks_nwords;
 	uint8_t	transceiver;
-	uint8_t	reserved1[3];
+	uint8_t	master_slave_cfg;
+	uint8_t	master_slave_state;
+	uint8_t	reserved1[1];
 	uint32_t	reserved[7];
 	uint32_t	link_mode_masks[0];
 	/* layout of link_mode_masks fields:
diff --git a/linux-headers/asm-arm/unistd-common.h b/linux-headers/asm-arm/unistd-common.h
index 23de64e44c..57cd1f21db 100644
--- a/linux-headers/asm-arm/unistd-common.h
+++ b/linux-headers/asm-arm/unistd-common.h
@@ -392,5 +392,6 @@
 #define __NR_clone3 (__NR_SYSCALL_BASE + 435)
 #define __NR_openat2 (__NR_SYSCALL_BASE + 437)
 #define __NR_pidfd_getfd (__NR_SYSCALL_BASE + 438)
+#define __NR_faccessat2 (__NR_SYSCALL_BASE + 439)
 
 #endif /* _ASM_ARM_UNISTD_COMMON_H */
diff --git a/linux-headers/asm-arm64/mman.h b/linux-headers/asm-arm64/mman.h
index 8eebf89f5a..e94b9af859 100644
--- a/linux-headers/asm-arm64/mman.h
+++ b/linux-headers/asm-arm64/mman.h
@@ -1 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_MMAN_H
+#define __ASM_MMAN_H
+
 #include <asm-generic/mman.h>
+
+#define PROT_BTI	0x10		/* BTI guarded page */
+
+#endif /* ! _UAPI__ASM_MMAN_H */
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index 3a3201e461..f4a01305d9 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -855,9 +855,11 @@ __SYSCALL(__NR_clone3, sys_clone3)
 __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
+#define __NR_faccessat2 439
+__SYSCALL(__NR_faccessat2, sys_faccessat2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 439
+#define __NR_syscalls 440
 
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips/unistd_n32.h
index aec9f6081a..3b9eda7e7d 100644
--- a/linux-headers/asm-mips/unistd_n32.h
+++ b/linux-headers/asm-mips/unistd_n32.h
@@ -367,6 +367,7 @@
 #define __NR_clone3	(__NR_Linux + 435)
 #define __NR_openat2	(__NR_Linux + 437)
 #define __NR_pidfd_getfd	(__NR_Linux + 438)
+#define __NR_faccessat2	(__NR_Linux + 439)
 
 
 #endif /* _ASM_MIPS_UNISTD_N32_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips/unistd_n64.h
index 1c75d83df5..9cdf9b6c60 100644
--- a/linux-headers/asm-mips/unistd_n64.h
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -343,6 +343,7 @@
 #define __NR_clone3	(__NR_Linux + 435)
 #define __NR_openat2	(__NR_Linux + 437)
 #define __NR_pidfd_getfd	(__NR_Linux + 438)
+#define __NR_faccessat2	(__NR_Linux + 439)
 
 
 #endif /* _ASM_MIPS_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips/unistd_o32.h
index 660716e240..e3e5e238f0 100644
--- a/linux-headers/asm-mips/unistd_o32.h
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -413,6 +413,7 @@
 #define __NR_clone3	(__NR_Linux + 435)
 #define __NR_openat2	(__NR_Linux + 437)
 #define __NR_pidfd_getfd	(__NR_Linux + 438)
+#define __NR_faccessat2	(__NR_Linux + 439)
 
 
 #endif /* _ASM_MIPS_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-powerpc/unistd_32.h
index 4ba8e32f73..862edb7448 100644
--- a/linux-headers/asm-powerpc/unistd_32.h
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -420,6 +420,7 @@
 #define __NR_clone3	435
 #define __NR_openat2	437
 #define __NR_pidfd_getfd	438
+#define __NR_faccessat2	439
 
 
 #endif /* _ASM_POWERPC_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-powerpc/unistd_64.h
index ac20bb4f95..f553224ce4 100644
--- a/linux-headers/asm-powerpc/unistd_64.h
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -392,6 +392,7 @@
 #define __NR_clone3	435
 #define __NR_openat2	437
 #define __NR_pidfd_getfd	438
+#define __NR_faccessat2	439
 
 
 #endif /* _ASM_POWERPC_UNISTD_64_H */
diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/unistd_32.h
index e4a6b654f1..e08233c0c3 100644
--- a/linux-headers/asm-s390/unistd_32.h
+++ b/linux-headers/asm-s390/unistd_32.h
@@ -410,5 +410,6 @@
 #define __NR_clone3 435
 #define __NR_openat2 437
 #define __NR_pidfd_getfd 438
+#define __NR_faccessat2 439
 
 #endif /* _ASM_S390_UNISTD_32_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
index 472f732956..560e19ae2b 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -358,5 +358,6 @@
 #define __NR_clone3 435
 #define __NR_openat2 437
 #define __NR_pidfd_getfd 438
+#define __NR_faccessat2 439
 
 #endif /* _ASM_S390_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 3f3f780c8c..17c5a038f4 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -385,32 +385,48 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT (1 << 4)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
-#define KVM_STATE_NESTED_FORMAT_SVM	1	/* unused */
+#define KVM_STATE_NESTED_FORMAT_SVM	1
 
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
 #define KVM_STATE_NESTED_EVMCS		0x00000004
 #define KVM_STATE_NESTED_MTF_PENDING	0x00000008
+#define KVM_STATE_NESTED_GIF_SET	0x00000100
 
 #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
 
 #define KVM_STATE_NESTED_VMX_VMCS_SIZE	0x1000
 
+#define KVM_STATE_NESTED_SVM_VMCB_SIZE	0x1000
+
+#define KVM_STATE_VMX_PREEMPTION_TIMER_DEADLINE	0x00000001
+
 struct kvm_vmx_nested_state_data {
 	__u8 vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
 	__u8 shadow_vmcs12[KVM_STATE_NESTED_VMX_VMCS_SIZE];
 };
 
 struct kvm_vmx_nested_state_hdr {
+	__u32 flags;
 	__u64 vmxon_pa;
 	__u64 vmcs12_pa;
+	__u64 preemption_timer_deadline;
 
 	struct {
 		__u16 flags;
 	} smm;
 };
 
+struct kvm_svm_nested_state_data {
+	/* Save area only used if KVM_STATE_NESTED_RUN_PENDING.  */
+	__u8 vmcb12[KVM_STATE_NESTED_SVM_VMCB_SIZE];
+};
+
+struct kvm_svm_nested_state_hdr {
+	__u64 vmcb_pa;
+};
+
 /* for KVM_CAP_NESTED_STATE */
 struct kvm_nested_state {
 	__u16 flags;
@@ -419,6 +435,7 @@ struct kvm_nested_state {
 
 	union {
 		struct kvm_vmx_nested_state_hdr vmx;
+		struct kvm_svm_nested_state_hdr svm;
 
 		/* Pad the header to 128 bytes.  */
 		__u8 pad[120];
@@ -431,6 +448,7 @@ struct kvm_nested_state {
 	 */
 	union {
 		struct kvm_vmx_nested_state_data vmx[0];
+		struct kvm_svm_nested_state_data svm[0];
 	} data;
 };
 
diff --git a/linux-headers/asm-x86/unistd.h b/linux-headers/asm-x86/unistd.h
index 498d1515c6..d2af42d61d 100644
--- a/linux-headers/asm-x86/unistd.h
+++ b/linux-headers/asm-x86/unistd.h
@@ -2,8 +2,15 @@
 #ifndef _ASM_X86_UNISTD_H
 #define _ASM_X86_UNISTD_H
 
-/* x32 syscall flag bit */
-#define __X32_SYSCALL_BIT	0x40000000UL
+/*
+ * x32 syscall flag bit.  Some user programs expect syscall NR macros
+ * and __X32_SYSCALL_BIT to have type int, even though syscall numbers
+ * are, for practical purposes, unsigned long.
+ *
+ * Fortunately, expressions like (nr & ~__X32_SYSCALL_BIT) do the right
+ * thing regardless.
+ */
+#define __X32_SYSCALL_BIT	0x40000000
 
 # ifdef __i386__
 #  include <asm/unistd_32.h>
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
index 1e6c1a5867..c727981d4a 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -428,6 +428,7 @@
 #define __NR_clone3 435
 #define __NR_openat2 437
 #define __NR_pidfd_getfd 438
+#define __NR_faccessat2 439
 
 
 #endif /* _ASM_X86_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
index 6daf0aecb2..843fa62745 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -350,6 +350,7 @@
 #define __NR_clone3 435
 #define __NR_openat2 437
 #define __NR_pidfd_getfd 438
+#define __NR_faccessat2 439
 
 
 #endif /* _ASM_X86_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index e3f17ef370..7d63d703ca 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -303,6 +303,7 @@
 #define __NR_clone3 (__X32_SYSCALL_BIT + 435)
 #define __NR_openat2 (__X32_SYSCALL_BIT + 437)
 #define __NR_pidfd_getfd (__X32_SYSCALL_BIT + 438)
+#define __NR_faccessat2 (__X32_SYSCALL_BIT + 439)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 9804495a46..a28c366737 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -116,7 +116,7 @@ struct kvm_irq_level {
 	 * ACPI gsi notion of irq.
 	 * For IA-64 (APIC model) IOAPIC0: irq 0-23; IOAPIC1: irq 24-47..
 	 * For X86 (standard AT mode) PIC0/1: irq 0-15. IOAPIC0: 0-23..
-	 * For ARM: See Documentation/virt/kvm/api.txt
+	 * For ARM: See Documentation/virt/kvm/api.rst
 	 */
 	union {
 		__u32 irq;
@@ -188,10 +188,13 @@ struct kvm_s390_cmma_log {
 struct kvm_hyperv_exit {
 #define KVM_EXIT_HYPERV_SYNIC          1
 #define KVM_EXIT_HYPERV_HCALL          2
+#define KVM_EXIT_HYPERV_SYNDBG         3
 	__u32 type;
+	__u32 pad1;
 	union {
 		struct {
 			__u32 msr;
+			__u32 pad2;
 			__u64 control;
 			__u64 evt_page;
 			__u64 msg_page;
@@ -201,6 +204,15 @@ struct kvm_hyperv_exit {
 			__u64 result;
 			__u64 params[2];
 		} hcall;
+		struct {
+			__u32 msr;
+			__u32 pad2;
+			__u64 control;
+			__u64 status;
+			__u64 send_page;
+			__u64 recv_page;
+			__u64 pending_page;
+		} syndbg;
 	} u;
 };
 
@@ -1017,6 +1029,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_VCPU_RESETS 179
 #define KVM_CAP_S390_PROTECTED 180
 #define KVM_CAP_PPC_SECURE_GUEST 181
+#define KVM_CAP_HALT_POLL 182
+#define KVM_CAP_ASYNC_PF_INT 183
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1107,7 +1121,7 @@ struct kvm_xen_hvm_config {
  *
  * KVM_IRQFD_FLAG_RESAMPLE indicates resamplefd is valid and specifies
  * the irqfd to operate in resampling mode for level triggered interrupt
- * emulation.  See Documentation/virt/kvm/api.txt.
+ * emulation.  See Documentation/virt/kvm/api.rst.
  */
 #define KVM_IRQFD_FLAG_RESAMPLE (1 << 1)
 
diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.h
index 31f971e896..51d8b3940e 100644
--- a/linux-headers/linux/psp-sev.h
+++ b/linux-headers/linux/psp-sev.h
@@ -83,6 +83,8 @@ struct sev_user_data_status {
 	__u32 guest_count;			/* Out */
 } __attribute__((packed));
 
+#define SEV_STATUS_FLAGS_CONFIG_ES	0x0100
+
 /**
  * struct sev_user_data_pek_csr - PEK_CSR command parameters
  *
-- 
2.26.2


