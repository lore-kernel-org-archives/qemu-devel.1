Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8981EC04AB4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 03:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E82E2081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 03:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E82E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57075 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSYlt-0007Qt-78
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 23:15:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hSYfb-0001sO-JL
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hSYfU-0001SJ-Je
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:08:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hSYfU-0001R5-85
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:08:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8401F3086203
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 03:08:51 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DFA841001E66;
	Mon, 20 May 2019 03:08:48 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 11:08:26 +0800
Message-Id: <20190520030839.6795-3-peterx@redhat.com>
In-Reply-To: <20190520030839.6795-1-peterx@redhat.com>
References: <20190520030839.6795-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Mon, 20 May 2019 03:08:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 02/15] linux-headers: Update to Linux 5.2-rc1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	peterx@redhat.com, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h |  15 +-
 include/standard-headers/drm/drm_fourcc.h     | 114 +++++++++++-
 include/standard-headers/linux/ethtool.h      |  48 +++--
 .../linux/input-event-codes.h                 |   9 +-
 include/standard-headers/linux/input.h        |   6 +-
 include/standard-headers/linux/pci_regs.h     | 140 ++++++++-------
 .../standard-headers/linux/virtio_config.h    |   6 +
 include/standard-headers/linux/virtio_gpu.h   |  12 +-
 include/standard-headers/linux/virtio_ring.h  |  10 --
 .../standard-headers/rdma/vmw_pvrdma-abi.h    |   1 +
 linux-headers/asm-arm/unistd-common.h         |  32 ++++
 linux-headers/asm-arm64/kvm.h                 |  43 +++++
 linux-headers/asm-arm64/unistd.h              |   2 +
 linux-headers/asm-generic/mman-common.h       |   4 +-
 linux-headers/asm-generic/unistd.h            | 170 ++++++++++++++----
 linux-headers/asm-mips/mman.h                 |   4 +-
 linux-headers/asm-mips/unistd_n32.h           |  30 ++++
 linux-headers/asm-mips/unistd_n64.h           |  10 ++
 linux-headers/asm-mips/unistd_o32.h           |  40 +++++
 linux-headers/asm-powerpc/kvm.h               |  48 +++++
 linux-headers/asm-powerpc/unistd_32.h         |  40 +++++
 linux-headers/asm-powerpc/unistd_64.h         |  21 +++
 linux-headers/asm-s390/kvm.h                  |   5 +-
 linux-headers/asm-s390/unistd_32.h            |  43 +++++
 linux-headers/asm-s390/unistd_64.h            |  24 +++
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/asm-x86/unistd_32.h             |  40 +++++
 linux-headers/asm-x86/unistd_64.h             |  10 ++
 linux-headers/asm-x86/unistd_x32.h            |  10 ++
 linux-headers/linux/kvm.h                     |  15 +-
 linux-headers/linux/mman.h                    |   4 +
 linux-headers/linux/psci.h                    |   7 +
 linux-headers/linux/psp-sev.h                 |  18 +-
 linux-headers/linux/vfio.h                    |   4 +
 linux-headers/linux/vfio_ccw.h                |  12 ++
 35 files changed, 854 insertions(+), 144 deletions(-)

diff --git a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
index 422eb3f4c1..d019872608 100644
--- a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
+++ b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
@@ -57,7 +57,8 @@
 
 #define PVRDMA_ROCEV1_VERSION		17
 #define PVRDMA_ROCEV2_VERSION		18
-#define PVRDMA_VERSION			PVRDMA_ROCEV2_VERSION
+#define PVRDMA_PPN64_VERSION		19
+#define PVRDMA_VERSION			PVRDMA_PPN64_VERSION
 
 #define PVRDMA_BOARD_ID			1
 #define PVRDMA_REV_ID			1
@@ -279,8 +280,10 @@ struct pvrdma_device_shared_region {
 						/* W: Async ring page info. */
 	struct pvrdma_ring_page_info cq_ring_pages;
 						/* W: CQ ring page info. */
-	uint32_t uar_pfn;				/* W: UAR pageframe. */
-	uint32_t pad2;				/* Pad to 8-byte align. */
+	union {
+		uint32_t uar_pfn;			/* W: UAR pageframe. */
+		uint64_t uar_pfn64;			/* W: 64-bit UAR page frame. */
+	};
 	struct pvrdma_device_caps caps;		/* R: Device capabilities. */
 };
 
@@ -411,8 +414,10 @@ struct pvrdma_cmd_query_pkey_resp {
 
 struct pvrdma_cmd_create_uc {
 	struct pvrdma_cmd_hdr hdr;
-	uint32_t pfn; /* UAR page frame number */
-	uint8_t reserved[4];
+	union {
+		uint32_t pfn; /* UAR page frame number */
+		uint64_t pfn64; /* 64-bit UAR page frame number */
+	};
 };
 
 struct pvrdma_cmd_create_uc_resp {
diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
index 44490607f9..a308c91b4f 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -143,6 +143,17 @@ extern "C" {
 #define DRM_FORMAT_RGBA1010102	fourcc_code('R', 'A', '3', '0') /* [31:0] R:G:B:A 10:10:10:2 little endian */
 #define DRM_FORMAT_BGRA1010102	fourcc_code('B', 'A', '3', '0') /* [31:0] B:G:R:A 10:10:10:2 little endian */
 
+/*
+ * Floating point 64bpp RGB
+ * IEEE 754-2008 binary16 half-precision float
+ * [15:0] sign:exponent:mantissa 1:5:10
+ */
+#define DRM_FORMAT_XRGB16161616F fourcc_code('X', 'R', '4', 'H') /* [63:0] x:R:G:B 16:16:16:16 little endian */
+#define DRM_FORMAT_XBGR16161616F fourcc_code('X', 'B', '4', 'H') /* [63:0] x:B:G:R 16:16:16:16 little endian */
+
+#define DRM_FORMAT_ARGB16161616F fourcc_code('A', 'R', '4', 'H') /* [63:0] A:R:G:B 16:16:16:16 little endian */
+#define DRM_FORMAT_ABGR16161616F fourcc_code('A', 'B', '4', 'H') /* [63:0] A:B:G:R 16:16:16:16 little endian */
+
 /* packed YCbCr */
 #define DRM_FORMAT_YUYV		fourcc_code('Y', 'U', 'Y', 'V') /* [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian */
 #define DRM_FORMAT_YVYU		fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
@@ -150,7 +161,29 @@ extern "C" {
 #define DRM_FORMAT_VYUY		fourcc_code('V', 'Y', 'U', 'Y') /* [31:0] Y1:Cb0:Y0:Cr0 8:8:8:8 little endian */
 
 #define DRM_FORMAT_AYUV		fourcc_code('A', 'Y', 'U', 'V') /* [31:0] A:Y:Cb:Cr 8:8:8:8 little endian */
-#define DRM_FORMAT_XYUV8888		fourcc_code('X', 'Y', 'U', 'V') /* [31:0] X:Y:Cb:Cr 8:8:8:8 little endian */
+#define DRM_FORMAT_XYUV8888	fourcc_code('X', 'Y', 'U', 'V') /* [31:0] X:Y:Cb:Cr 8:8:8:8 little endian */
+#define DRM_FORMAT_VUY888	fourcc_code('V', 'U', '2', '4') /* [23:0] Cr:Cb:Y 8:8:8 little endian */
+#define DRM_FORMAT_VUY101010	fourcc_code('V', 'U', '3', '0') /* Y followed by U then V, 10:10:10. Non-linear modifier only */
+
+/*
+ * packed Y2xx indicate for each component, xx valid data occupy msb
+ * 16-xx padding occupy lsb
+ */
+#define DRM_FORMAT_Y210         fourcc_code('Y', '2', '1', '0') /* [63:0] Cr0:0:Y1:0:Cb0:0:Y0:0 10:6:10:6:10:6:10:6 little endian per 2 Y pixels */
+#define DRM_FORMAT_Y212         fourcc_code('Y', '2', '1', '2') /* [63:0] Cr0:0:Y1:0:Cb0:0:Y0:0 12:4:12:4:12:4:12:4 little endian per 2 Y pixels */
+#define DRM_FORMAT_Y216         fourcc_code('Y', '2', '1', '6') /* [63:0] Cr0:Y1:Cb0:Y0 16:16:16:16 little endian per 2 Y pixels */
+
+/*
+ * packed Y4xx indicate for each component, xx valid data occupy msb
+ * 16-xx padding occupy lsb except Y410
+ */
+#define DRM_FORMAT_Y410         fourcc_code('Y', '4', '1', '0') /* [31:0] A:Cr:Y:Cb 2:10:10:10 little endian */
+#define DRM_FORMAT_Y412         fourcc_code('Y', '4', '1', '2') /* [63:0] A:0:Cr:0:Y:0:Cb:0 12:4:12:4:12:4:12:4 little endian */
+#define DRM_FORMAT_Y416         fourcc_code('Y', '4', '1', '6') /* [63:0] A:Cr:Y:Cb 16:16:16:16 little endian */
+
+#define DRM_FORMAT_XVYU2101010	fourcc_code('X', 'V', '3', '0') /* [31:0] X:Cr:Y:Cb 2:10:10:10 little endian */
+#define DRM_FORMAT_XVYU12_16161616	fourcc_code('X', 'V', '3', '6') /* [63:0] X:0:Cr:0:Y:0:Cb:0 12:4:12:4:12:4:12:4 little endian */
+#define DRM_FORMAT_XVYU16161616	fourcc_code('X', 'V', '4', '8') /* [63:0] X:Cr:Y:Cb 16:16:16:16 little endian */
 
 /*
  * packed YCbCr420 2x2 tiled formats
@@ -166,6 +199,15 @@ extern "C" {
 /* [63:0]   X3:X2:Y3:Cr0:Y2:X1:X0:Y1:Cb0:Y0  1:1:10:10:10:1:1:10:10:10 little endian */
 #define DRM_FORMAT_X0L2		fourcc_code('X', '0', 'L', '2')
 
+/*
+ * 1-plane YUV 4:2:0
+ * In these formats, the component ordering is specified (Y, followed by U
+ * then V), but the exact Linear layout is undefined.
+ * These formats can only be used with a non-Linear modifier.
+ */
+#define DRM_FORMAT_YUV420_8BIT	fourcc_code('Y', 'U', '0', '8')
+#define DRM_FORMAT_YUV420_10BIT	fourcc_code('Y', 'U', '1', '0')
+
 /*
  * 2 plane RGB + A
  * index 0 = RGB plane, same format as the corresponding non _A8 format has
@@ -194,6 +236,34 @@ extern "C" {
 #define DRM_FORMAT_NV24		fourcc_code('N', 'V', '2', '4') /* non-subsampled Cr:Cb plane */
 #define DRM_FORMAT_NV42		fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
 
+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 = Y plane, [15:0] Y:x [10:6] little endian
+ * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
+ */
+#define DRM_FORMAT_P210		fourcc_code('P', '2', '1', '0') /* 2x1 subsampled Cr:Cb plane, 10 bit per channel */
+
+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 = Y plane, [15:0] Y:x [10:6] little endian
+ * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
+ */
+#define DRM_FORMAT_P010		fourcc_code('P', '0', '1', '0') /* 2x2 subsampled Cr:Cb plane 10 bits per channel */
+
+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 = Y plane, [15:0] Y:x [12:4] little endian
+ * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [12:4:12:4] little endian
+ */
+#define DRM_FORMAT_P012		fourcc_code('P', '0', '1', '2') /* 2x2 subsampled Cr:Cb plane 12 bits per channel */
+
+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 = Y plane, [15:0] Y little endian
+ * index 1 = Cr:Cb plane, [31:0] Cr:Cb [16:16] little endian
+ */
+#define DRM_FORMAT_P016		fourcc_code('P', '0', '1', '6') /* 2x2 subsampled Cr:Cb plane 16 bits per channel */
+
 /*
  * 3 plane YCbCr
  * index 0: Y plane, [7:0] Y
@@ -237,6 +307,8 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_VIVANTE 0x06
 #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
 #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
+#define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
+
 /* add more to the end as needed */
 
 #define DRM_FORMAT_RESERVED	      ((1ULL << 56) - 1)
@@ -571,6 +643,9 @@ extern "C" {
  * AFBC has several features which may be supported and/or used, which are
  * represented using bits in the modifier. Not all combinations are valid,
  * and different devices or use-cases may support different combinations.
+ *
+ * Further information on the use of AFBC modifiers can be found in
+ * Documentation/gpu/afbc.rst
  */
 #define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, __afbc_mode)
 
@@ -580,10 +655,18 @@ extern "C" {
  * Indicates the superblock size(s) used for the AFBC buffer. The buffer
  * size (in pixels) must be aligned to a multiple of the superblock size.
  * Four lowest significant bits(LSBs) are reserved for block size.
+ *
+ * Where one superblock size is specified, it applies to all planes of the
+ * buffer (e.g. 16x16, 32x8). When multiple superblock sizes are specified,
+ * the first applies to the Luma plane and the second applies to the Chroma
+ * plane(s). e.g. (32x8_64x4 means 32x8 Luma, with 64x4 Chroma).
+ * Multiple superblock sizes are only valid for multi-plane YCbCr formats.
  */
 #define AFBC_FORMAT_MOD_BLOCK_SIZE_MASK      0xf
 #define AFBC_FORMAT_MOD_BLOCK_SIZE_16x16     (1ULL)
 #define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8      (2ULL)
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_64x4      (3ULL)
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8_64x4 (4ULL)
 
 /*
  * AFBC lossless colorspace transform
@@ -643,6 +726,35 @@ extern "C" {
  */
 #define AFBC_FORMAT_MOD_SC      (1ULL <<  9)
 
+/*
+ * AFBC double-buffer
+ *
+ * Indicates that the buffer is allocated in a layout safe for front-buffer
+ * rendering.
+ */
+#define AFBC_FORMAT_MOD_DB      (1ULL << 10)
+
+/*
+ * AFBC buffer content hints
+ *
+ * Indicates that the buffer includes per-superblock content hints.
+ */
+#define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
+
+/*
+ * Allwinner tiled modifier
+ *
+ * This tiling mode is implemented by the VPU found on all Allwinner platforms,
+ * codenamed sunxi. It is associated with a YUV format that uses either 2 or 3
+ * planes.
+ *
+ * With this tiling, the luminance samples are disposed in tiles representing
+ * 32x32 pixels and the chrominance samples in tiles representing 32x64 pixels.
+ * The pixel order in each tile is linear and the tiles are disposed linearly,
+ * both in row-major order.
+ */
+#define DRM_FORMAT_MOD_ALLWINNER_TILED fourcc_mod_code(ALLWINNER, 1)
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index 063c814278..9b9919a8f6 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -252,9 +252,17 @@ struct ethtool_tunable {
 #define DOWNSHIFT_DEV_DEFAULT_COUNT	0xff
 #define DOWNSHIFT_DEV_DISABLE		0
 
+/* Time in msecs after which link is reported as down
+ * 0 = lowest time supported by the PHY
+ * 0xff = off, link down detection according to standard
+ */
+#define ETHTOOL_PHY_FAST_LINK_DOWN_ON	0
+#define ETHTOOL_PHY_FAST_LINK_DOWN_OFF	0xff
+
 enum phy_tunable_id {
 	ETHTOOL_PHY_ID_UNSPEC,
 	ETHTOOL_PHY_DOWNSHIFT,
+	ETHTOOL_PHY_FAST_LINK_DOWN,
 	/*
 	 * Add your fresh new phy tunable attribute above and remember to update
 	 * phy_tunable_strings[] in net/core/ethtool.c
@@ -1432,6 +1440,13 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_56000baseSR4_Full_BIT	= 29,
 	ETHTOOL_LINK_MODE_56000baseLR4_Full_BIT	= 30,
 	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT	= 31,
+
+	/* Last allowed bit for __ETHTOOL_LINK_MODE_LEGACY_MASK is bit
+	 * 31. Please do NOT define any SUPPORTED_* or ADVERTISED_*
+	 * macro for bits > 31. The only way to use indices > 31 is to
+	 * use the new ETHTOOL_GLINKSETTINGS/ETHTOOL_SLINKSETTINGS API.
+	 */
+
 	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT	= 32,
 	ETHTOOL_LINK_MODE_25000baseSR_Full_BIT	= 33,
 	ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT	= 34,
@@ -1453,15 +1468,24 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_FEC_NONE_BIT	= 49,
 	ETHTOOL_LINK_MODE_FEC_RS_BIT	= 50,
 	ETHTOOL_LINK_MODE_FEC_BASER_BIT	= 51,
-
-	/* Last allowed bit for __ETHTOOL_LINK_MODE_LEGACY_MASK is bit
-	 * 31. Please do NOT define any SUPPORTED_* or ADVERTISED_*
-	 * macro for bits > 31. The only way to use indices > 31 is to
-	 * use the new ETHTOOL_GLINKSETTINGS/ETHTOOL_SLINKSETTINGS API.
-	 */
-
-	__ETHTOOL_LINK_MODE_LAST
-	  = ETHTOOL_LINK_MODE_FEC_BASER_BIT,
+	ETHTOOL_LINK_MODE_50000baseKR_Full_BIT		 = 52,
+	ETHTOOL_LINK_MODE_50000baseSR_Full_BIT		 = 53,
+	ETHTOOL_LINK_MODE_50000baseCR_Full_BIT		 = 54,
+	ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT	 = 55,
+	ETHTOOL_LINK_MODE_50000baseDR_Full_BIT		 = 56,
+	ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT	 = 57,
+	ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT	 = 58,
+	ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT	 = 59,
+	ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT = 60,
+	ETHTOOL_LINK_MODE_100000baseDR2_Full_BIT	 = 61,
+	ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT	 = 62,
+	ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT	 = 63,
+	ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT = 64,
+	ETHTOOL_LINK_MODE_200000baseDR4_Full_BIT	 = 65,
+	ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT	 = 66,
+
+	/* must be last entry */
+	__ETHTOOL_LINK_MODE_MASK_NBITS
 };
 
 #define __ETHTOOL_LINK_MODE_LEGACY_MASK(base_name)	\
@@ -1569,12 +1593,13 @@ enum ethtool_link_mode_bit_indices {
 #define SPEED_50000		50000
 #define SPEED_56000		56000
 #define SPEED_100000		100000
+#define SPEED_200000		200000
 
 #define SPEED_UNKNOWN		-1
 
 static inline int ethtool_validate_speed(uint32_t speed)
 {
-	return speed <= INT_MAX || speed == SPEED_UNKNOWN;
+	return speed <= INT_MAX || speed == (uint32_t)SPEED_UNKNOWN;
 }
 
 /* Duplex, half or full. */
@@ -1687,6 +1712,9 @@ static inline int ethtool_validate_duplex(uint8_t duplex)
 #define ETH_MODULE_SFF_8436		0x4
 #define ETH_MODULE_SFF_8436_LEN		256
 
+#define ETH_MODULE_SFF_8636_MAX_LEN     640
+#define ETH_MODULE_SFF_8436_MAX_LEN     640
+
 /* Reset flags */
 /* The reset() operation must clear the flags for the components which
  * were actually reset.  On successful return, the flags indicate the
diff --git a/include/standard-headers/linux/input-event-codes.h b/include/standard-headers/linux/input-event-codes.h
index 871ac933eb..eb08cb8598 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -439,10 +439,12 @@
 #define KEY_TITLE		0x171
 #define KEY_SUBTITLE		0x172
 #define KEY_ANGLE		0x173
-#define KEY_ZOOM		0x174
+#define KEY_FULL_SCREEN		0x174	/* AC View Toggle */
+#define KEY_ZOOM		KEY_FULL_SCREEN
 #define KEY_MODE		0x175
 #define KEY_KEYBOARD		0x176
-#define KEY_SCREEN		0x177
+#define KEY_ASPECT_RATIO	0x177	/* HUTRR37: Aspect */
+#define KEY_SCREEN		KEY_ASPECT_RATIO
 #define KEY_PC			0x178	/* Media Select Computer */
 #define KEY_TV			0x179	/* Media Select TV */
 #define KEY_TV2			0x17a	/* Media Select Cable */
@@ -604,6 +606,7 @@
 #define KEY_SCREENSAVER		0x245	/* AL Screen Saver */
 #define KEY_VOICECOMMAND		0x246	/* Listening Voice Command */
 #define KEY_ASSISTANT		0x247	/* AL Context-aware desktop assistant */
+#define KEY_KBD_LAYOUT_NEXT	0x248	/* AC Next Keyboard Layout Select */
 
 #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
 #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
@@ -716,6 +719,8 @@
  * the situation described above.
  */
 #define REL_RESERVED		0x0a
+#define REL_WHEEL_HI_RES	0x0b
+#define REL_HWHEEL_HI_RES	0x0c
 #define REL_MAX			0x0f
 #define REL_CNT			(REL_MAX+1)
 
diff --git a/include/standard-headers/linux/input.h b/include/standard-headers/linux/input.h
index c0ad9fc2c3..d8914f25a5 100644
--- a/include/standard-headers/linux/input.h
+++ b/include/standard-headers/linux/input.h
@@ -23,13 +23,17 @@
  */
 
 struct input_event {
-#if (HOST_LONG_BITS != 32 || !defined(__USE_TIME_BITS64)) && !defined(__KERNEL)
+#if (HOST_LONG_BITS != 32 || !defined(__USE_TIME_BITS64)) && !defined(__KERNEL__)
 	struct timeval time;
 #define input_event_sec time.tv_sec
 #define input_event_usec time.tv_usec
 #else
 	unsigned long __sec;
+#if defined(__sparc__) && defined(__arch64__)
+	unsigned int __usec;
+#else
 	unsigned long __usec;
+#endif
 #define input_event_sec  __sec
 #define input_event_usec __usec
 #endif
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index e1e9888c85..27164769d1 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
- *	pci_regs.h
- *
  *	PCI standard defines
  *	Copyright 1994, Drew Eckhardt
  *	Copyright 1997--1999 Martin Mares <mj@ucw.cz>
@@ -15,7 +13,7 @@
  *	PCI System Design Guide
  *
  *	For HyperTransport information, please consult the following manuals
- *	from http://www.hypertransport.org
+ *	from http://www.hypertransport.org :
  *
  *	The HyperTransport I/O Link Specification
  */
@@ -301,7 +299,7 @@
 #define  PCI_SID_ESR_FIC	0x20	/* First In Chassis Flag */
 #define PCI_SID_CHASSIS_NR	3	/* Chassis Number */
 
-/* Message Signalled Interrupts registers */
+/* Message Signalled Interrupt registers */
 
 #define PCI_MSI_FLAGS		2	/* Message Control */
 #define  PCI_MSI_FLAGS_ENABLE	0x0001	/* MSI feature enabled */
@@ -319,7 +317,7 @@
 #define PCI_MSI_MASK_64		16	/* Mask bits register for 64-bit devices */
 #define PCI_MSI_PENDING_64	20	/* Pending intrs for 64-bit devices */
 
-/* MSI-X registers */
+/* MSI-X registers (in MSI-X capability) */
 #define PCI_MSIX_FLAGS		2	/* Message Control */
 #define  PCI_MSIX_FLAGS_QSIZE	0x07FF	/* Table size */
 #define  PCI_MSIX_FLAGS_MASKALL	0x4000	/* Mask all vectors for this function */
@@ -333,13 +331,13 @@
 #define PCI_MSIX_FLAGS_BIRMASK	PCI_MSIX_PBA_BIR /* deprecated */
 #define PCI_CAP_MSIX_SIZEOF	12	/* size of MSIX registers */
 
-/* MSI-X Table entry format */
+/* MSI-X Table entry format (in memory mapped by a BAR) */
 #define PCI_MSIX_ENTRY_SIZE		16
-#define  PCI_MSIX_ENTRY_LOWER_ADDR	0
-#define  PCI_MSIX_ENTRY_UPPER_ADDR	4
-#define  PCI_MSIX_ENTRY_DATA		8
-#define  PCI_MSIX_ENTRY_VECTOR_CTRL	12
-#define   PCI_MSIX_ENTRY_CTRL_MASKBIT	1
+#define PCI_MSIX_ENTRY_LOWER_ADDR	0  /* Message Address */
+#define PCI_MSIX_ENTRY_UPPER_ADDR	4  /* Message Upper Address */
+#define PCI_MSIX_ENTRY_DATA		8  /* Message Data */
+#define PCI_MSIX_ENTRY_VECTOR_CTRL	12 /* Vector Control */
+#define  PCI_MSIX_ENTRY_CTRL_MASKBIT	0x00000001
 
 /* CompactPCI Hotswap Register */
 
@@ -372,6 +370,12 @@
 #define PCI_EA_FIRST_ENT_BRIDGE	8	/* First EA Entry for Bridges */
 #define  PCI_EA_ES		0x00000007 /* Entry Size */
 #define  PCI_EA_BEI		0x000000f0 /* BAR Equivalent Indicator */
+
+/* EA fixed Secondary and Subordinate bus numbers for Bridge */
+#define PCI_EA_SEC_BUS_MASK	0xff
+#define PCI_EA_SUB_BUS_MASK	0xff00
+#define PCI_EA_SUB_BUS_SHIFT	8
+
 /* 0-5 map to BARs 0-5 respectively */
 #define   PCI_EA_BEI_BAR0		0
 #define   PCI_EA_BEI_BAR5		5
@@ -465,19 +469,19 @@
 /* PCI Express capability registers */
 
 #define PCI_EXP_FLAGS		2	/* Capabilities register */
-#define PCI_EXP_FLAGS_VERS	0x000f	/* Capability version */
-#define PCI_EXP_FLAGS_TYPE	0x00f0	/* Device/Port type */
-#define  PCI_EXP_TYPE_ENDPOINT	0x0	/* Express Endpoint */
-#define  PCI_EXP_TYPE_LEG_END	0x1	/* Legacy Endpoint */
-#define  PCI_EXP_TYPE_ROOT_PORT 0x4	/* Root Port */
-#define  PCI_EXP_TYPE_UPSTREAM	0x5	/* Upstream Port */
-#define  PCI_EXP_TYPE_DOWNSTREAM 0x6	/* Downstream Port */
-#define  PCI_EXP_TYPE_PCI_BRIDGE 0x7	/* PCIe to PCI/PCI-X Bridge */
-#define  PCI_EXP_TYPE_PCIE_BRIDGE 0x8	/* PCI/PCI-X to PCIe Bridge */
-#define  PCI_EXP_TYPE_RC_END	0x9	/* Root Complex Integrated Endpoint */
-#define  PCI_EXP_TYPE_RC_EC	0xa	/* Root Complex Event Collector */
-#define PCI_EXP_FLAGS_SLOT	0x0100	/* Slot implemented */
-#define PCI_EXP_FLAGS_IRQ	0x3e00	/* Interrupt message number */
+#define  PCI_EXP_FLAGS_VERS	0x000f	/* Capability version */
+#define  PCI_EXP_FLAGS_TYPE	0x00f0	/* Device/Port type */
+#define   PCI_EXP_TYPE_ENDPOINT	   0x0	/* Express Endpoint */
+#define   PCI_EXP_TYPE_LEG_END	   0x1	/* Legacy Endpoint */
+#define   PCI_EXP_TYPE_ROOT_PORT   0x4	/* Root Port */
+#define   PCI_EXP_TYPE_UPSTREAM	   0x5	/* Upstream Port */
+#define   PCI_EXP_TYPE_DOWNSTREAM  0x6	/* Downstream Port */
+#define   PCI_EXP_TYPE_PCI_BRIDGE  0x7	/* PCIe to PCI/PCI-X Bridge */
+#define   PCI_EXP_TYPE_PCIE_BRIDGE 0x8	/* PCI/PCI-X to PCIe Bridge */
+#define   PCI_EXP_TYPE_RC_END	   0x9	/* Root Complex Integrated Endpoint */
+#define   PCI_EXP_TYPE_RC_EC	   0xa	/* Root Complex Event Collector */
+#define  PCI_EXP_FLAGS_SLOT	0x0100	/* Slot implemented */
+#define  PCI_EXP_FLAGS_IRQ	0x3e00	/* Interrupt message number */
 #define PCI_EXP_DEVCAP		4	/* Device capabilities */
 #define  PCI_EXP_DEVCAP_PAYLOAD	0x00000007 /* Max_Payload_Size */
 #define  PCI_EXP_DEVCAP_PHANTOM	0x00000018 /* Phantom functions */
@@ -616,8 +620,8 @@
 #define PCI_EXP_RTCAP		30	/* Root Capabilities */
 #define  PCI_EXP_RTCAP_CRSVIS	0x0001	/* CRS Software Visibility capability */
 #define PCI_EXP_RTSTA		32	/* Root Status */
-#define PCI_EXP_RTSTA_PME	0x00010000 /* PME status */
-#define PCI_EXP_RTSTA_PENDING	0x00020000 /* PME pending */
+#define  PCI_EXP_RTSTA_PME	0x00010000 /* PME status */
+#define  PCI_EXP_RTSTA_PENDING	0x00020000 /* PME pending */
 /*
  * The Device Capabilities 2, Device Status 2, Device Control 2,
  * Link Capabilities 2, Link Status 2, Link Control 2,
@@ -637,13 +641,13 @@
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
-#define PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
+#define  PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
 #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
 #define  PCI_EXP_DEVCTL2_ARI		0x0020	/* Alternative Routing-ID */
-#define PCI_EXP_DEVCTL2_ATOMIC_REQ	0x0040	/* Set Atomic requests */
-#define PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK 0x0080 /* Block atomic egress */
+#define  PCI_EXP_DEVCTL2_ATOMIC_REQ	0x0040	/* Set Atomic requests */
+#define  PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK 0x0080 /* Block atomic egress */
 #define  PCI_EXP_DEVCTL2_IDO_REQ_EN	0x0100	/* Allow IDO for requests */
 #define  PCI_EXP_DEVCTL2_IDO_CMP_EN	0x0200	/* Allow IDO for completions */
 #define  PCI_EXP_DEVCTL2_LTR_EN		0x0400	/* Enable LTR mechanism */
@@ -659,11 +663,11 @@
 #define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
-#define PCI_EXP_LNKCTL2_TLS		0x000f
-#define PCI_EXP_LNKCTL2_TLS_2_5GT	0x0001 /* Supported Speed 2.5GT/s */
-#define PCI_EXP_LNKCTL2_TLS_5_0GT	0x0002 /* Supported Speed 5GT/s */
-#define PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
-#define PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
+#define  PCI_EXP_LNKCTL2_TLS		0x000f
+#define  PCI_EXP_LNKCTL2_TLS_2_5GT	0x0001 /* Supported Speed 2.5GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_5_0GT	0x0002 /* Supported Speed 5GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
@@ -752,18 +756,18 @@
 #define  PCI_ERR_CAP_ECRC_CHKE	0x00000100	/* ECRC Check Enable */
 #define PCI_ERR_HEADER_LOG	28	/* Header Log Register (16 bytes) */
 #define PCI_ERR_ROOT_COMMAND	44	/* Root Error Command */
-#define PCI_ERR_ROOT_CMD_COR_EN		0x00000001 /* Correctable Err Reporting Enable */
-#define PCI_ERR_ROOT_CMD_NONFATAL_EN	0x00000002 /* Non-Fatal Err Reporting Enable */
-#define PCI_ERR_ROOT_CMD_FATAL_EN	0x00000004 /* Fatal Err Reporting Enable */
+#define  PCI_ERR_ROOT_CMD_COR_EN	0x00000001 /* Correctable Err Reporting Enable */
+#define  PCI_ERR_ROOT_CMD_NONFATAL_EN	0x00000002 /* Non-Fatal Err Reporting Enable */
+#define  PCI_ERR_ROOT_CMD_FATAL_EN	0x00000004 /* Fatal Err Reporting Enable */
 #define PCI_ERR_ROOT_STATUS	48
-#define PCI_ERR_ROOT_COR_RCV		0x00000001 /* ERR_COR Received */
-#define PCI_ERR_ROOT_MULTI_COR_RCV	0x00000002 /* Multiple ERR_COR */
-#define PCI_ERR_ROOT_UNCOR_RCV		0x00000004 /* ERR_FATAL/NONFATAL */
-#define PCI_ERR_ROOT_MULTI_UNCOR_RCV	0x00000008 /* Multiple FATAL/NONFATAL */
-#define PCI_ERR_ROOT_FIRST_FATAL	0x00000010 /* First UNC is Fatal */
-#define PCI_ERR_ROOT_NONFATAL_RCV	0x00000020 /* Non-Fatal Received */
-#define PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
-#define PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
+#define  PCI_ERR_ROOT_COR_RCV		0x00000001 /* ERR_COR Received */
+#define  PCI_ERR_ROOT_MULTI_COR_RCV	0x00000002 /* Multiple ERR_COR */
+#define  PCI_ERR_ROOT_UNCOR_RCV		0x00000004 /* ERR_FATAL/NONFATAL */
+#define  PCI_ERR_ROOT_MULTI_UNCOR_RCV	0x00000008 /* Multiple FATAL/NONFATAL */
+#define  PCI_ERR_ROOT_FIRST_FATAL	0x00000010 /* First UNC is Fatal */
+#define  PCI_ERR_ROOT_NONFATAL_RCV	0x00000020 /* Non-Fatal Received */
+#define  PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
+#define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
 #define PCI_ERR_ROOT_ERR_SRC	52	/* Error Source Identification */
 
 /* Virtual Channel */
@@ -866,6 +870,7 @@
 #define PCI_ATS_CAP		0x04	/* ATS Capability Register */
 #define  PCI_ATS_CAP_QDEP(x)	((x) & 0x1f)	/* Invalidate Queue Depth */
 #define  PCI_ATS_MAX_QDEP	32	/* Max Invalidate Queue Depth */
+#define  PCI_ATS_CAP_PAGE_ALIGNED	0x0020 /* Page Aligned Request */
 #define PCI_ATS_CTRL		0x06	/* ATS Control Register */
 #define  PCI_ATS_CTRL_ENABLE	0x8000	/* ATS Enable */
 #define  PCI_ATS_CTRL_STU(x)	((x) & 0x1f)	/* Smallest Translation Unit */
@@ -874,12 +879,13 @@
 
 /* Page Request Interface */
 #define PCI_PRI_CTRL		0x04	/* PRI control register */
-#define  PCI_PRI_CTRL_ENABLE	0x01	/* Enable */
-#define  PCI_PRI_CTRL_RESET	0x02	/* Reset */
+#define  PCI_PRI_CTRL_ENABLE	0x0001	/* Enable */
+#define  PCI_PRI_CTRL_RESET	0x0002	/* Reset */
 #define PCI_PRI_STATUS		0x06	/* PRI status register */
-#define  PCI_PRI_STATUS_RF	0x001	/* Response Failure */
-#define  PCI_PRI_STATUS_UPRGI	0x002	/* Unexpected PRG index */
-#define  PCI_PRI_STATUS_STOPPED	0x100	/* PRI Stopped */
+#define  PCI_PRI_STATUS_RF	0x0001	/* Response Failure */
+#define  PCI_PRI_STATUS_UPRGI	0x0002	/* Unexpected PRG index */
+#define  PCI_PRI_STATUS_STOPPED	0x0100	/* PRI Stopped */
+#define  PCI_PRI_STATUS_PASID	0x8000	/* PRG Response PASID Required */
 #define PCI_PRI_MAX_REQ		0x08	/* PRI max reqs supported */
 #define PCI_PRI_ALLOC_REQ	0x0c	/* PRI max reqs allowed */
 #define PCI_EXT_CAP_PRI_SIZEOF	16
@@ -896,16 +902,16 @@
 
 /* Single Root I/O Virtualization */
 #define PCI_SRIOV_CAP		0x04	/* SR-IOV Capabilities */
-#define  PCI_SRIOV_CAP_VFM	0x01	/* VF Migration Capable */
+#define  PCI_SRIOV_CAP_VFM	0x00000001  /* VF Migration Capable */
 #define  PCI_SRIOV_CAP_INTR(x)	((x) >> 21) /* Interrupt Message Number */
 #define PCI_SRIOV_CTRL		0x08	/* SR-IOV Control */
-#define  PCI_SRIOV_CTRL_VFE	0x01	/* VF Enable */
-#define  PCI_SRIOV_CTRL_VFM	0x02	/* VF Migration Enable */
-#define  PCI_SRIOV_CTRL_INTR	0x04	/* VF Migration Interrupt Enable */
-#define  PCI_SRIOV_CTRL_MSE	0x08	/* VF Memory Space Enable */
-#define  PCI_SRIOV_CTRL_ARI	0x10	/* ARI Capable Hierarchy */
+#define  PCI_SRIOV_CTRL_VFE	0x0001	/* VF Enable */
+#define  PCI_SRIOV_CTRL_VFM	0x0002	/* VF Migration Enable */
+#define  PCI_SRIOV_CTRL_INTR	0x0004	/* VF Migration Interrupt Enable */
+#define  PCI_SRIOV_CTRL_MSE	0x0008	/* VF Memory Space Enable */
+#define  PCI_SRIOV_CTRL_ARI	0x0010	/* ARI Capable Hierarchy */
 #define PCI_SRIOV_STATUS	0x0a	/* SR-IOV Status */
-#define  PCI_SRIOV_STATUS_VFM	0x01	/* VF Migration Status */
+#define  PCI_SRIOV_STATUS_VFM	0x0001	/* VF Migration Status */
 #define PCI_SRIOV_INITIAL_VF	0x0c	/* Initial VFs */
 #define PCI_SRIOV_TOTAL_VF	0x0e	/* Total VFs */
 #define PCI_SRIOV_NUM_VF	0x10	/* Number of VFs */
@@ -935,13 +941,13 @@
 
 /* Access Control Service */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
-#define  PCI_ACS_SV		0x01	/* Source Validation */
-#define  PCI_ACS_TB		0x02	/* Translation Blocking */
-#define  PCI_ACS_RR		0x04	/* P2P Request Redirect */
-#define  PCI_ACS_CR		0x08	/* P2P Completion Redirect */
-#define  PCI_ACS_UF		0x10	/* Upstream Forwarding */
-#define  PCI_ACS_EC		0x20	/* P2P Egress Control */
-#define  PCI_ACS_DT		0x40	/* Direct Translated P2P */
+#define  PCI_ACS_SV		0x0001	/* Source Validation */
+#define  PCI_ACS_TB		0x0002	/* Translation Blocking */
+#define  PCI_ACS_RR		0x0004	/* P2P Request Redirect */
+#define  PCI_ACS_CR		0x0008	/* P2P Completion Redirect */
+#define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
+#define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
+#define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
 #define PCI_ACS_EGRESS_BITS	0x05	/* ACS Egress Control Vector Size */
 #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
 #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */
@@ -991,9 +997,9 @@
 #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
 
 #define PCI_EXP_DPC_CTL			6	/* DPC control */
-#define  PCI_EXP_DPC_CTL_EN_FATAL 	0x0001	/* Enable trigger on ERR_FATAL message */
-#define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x0002	/* Enable trigger on ERR_NONFATAL message */
-#define  PCI_EXP_DPC_CTL_INT_EN 	0x0008	/* DPC Interrupt Enable */
+#define  PCI_EXP_DPC_CTL_EN_FATAL	0x0001	/* Enable trigger on ERR_FATAL message */
+#define  PCI_EXP_DPC_CTL_EN_NONFATAL	0x0002	/* Enable trigger on ERR_NONFATAL message */
+#define  PCI_EXP_DPC_CTL_INT_EN		0x0008	/* DPC Interrupt Enable */
 
 #define PCI_EXP_DPC_STATUS		8	/* DPC Status */
 #define  PCI_EXP_DPC_STATUS_TRIGGER	    0x0001 /* Trigger Status */
diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
index 24e30af5ec..9a69d9e242 100644
--- a/include/standard-headers/linux/virtio_config.h
+++ b/include/standard-headers/linux/virtio_config.h
@@ -78,6 +78,12 @@
 /* This feature indicates support for the packed virtqueue layout. */
 #define VIRTIO_F_RING_PACKED		34
 
+/*
+ * This feature indicates that memory accesses by the driver and the
+ * device are ordered in a way described by the platform.
+ */
+#define VIRTIO_F_ORDER_PLATFORM		36
+
 /*
  * Does the device support Single Root I/O Virtualization?
  */
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 27bb5111f9..b8fa15f0ac 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -40,8 +40,16 @@
 
 #include "standard-headers/linux/types.h"
 
-#define VIRTIO_GPU_F_VIRGL 0
-#define VIRTIO_GPU_F_EDID  1
+/*
+ * VIRTIO_GPU_CMD_CTX_*
+ * VIRTIO_GPU_CMD_*_3D
+ */
+#define VIRTIO_GPU_F_VIRGL               0
+
+/*
+ * VIRTIO_GPU_CMD_GET_EDID
+ */
+#define VIRTIO_GPU_F_EDID                1
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
diff --git a/include/standard-headers/linux/virtio_ring.h b/include/standard-headers/linux/virtio_ring.h
index e89931f634..306cd41147 100644
--- a/include/standard-headers/linux/virtio_ring.h
+++ b/include/standard-headers/linux/virtio_ring.h
@@ -211,14 +211,4 @@ struct vring_packed_desc {
 	uint16_t flags;
 };
 
-struct vring_packed {
-	unsigned int num;
-
-	struct vring_packed_desc *desc;
-
-	struct vring_packed_desc_event *driver;
-
-	struct vring_packed_desc_event *device;
-};
-
 #endif /* _LINUX_VIRTIO_RING_H */
diff --git a/include/standard-headers/rdma/vmw_pvrdma-abi.h b/include/standard-headers/rdma/vmw_pvrdma-abi.h
index 6c2bc46116..336a8d596f 100644
--- a/include/standard-headers/rdma/vmw_pvrdma-abi.h
+++ b/include/standard-headers/rdma/vmw_pvrdma-abi.h
@@ -78,6 +78,7 @@ enum pvrdma_wr_opcode {
 	PVRDMA_WR_MASKED_ATOMIC_FETCH_AND_ADD,
 	PVRDMA_WR_BIND_MW,
 	PVRDMA_WR_REG_SIG_MR,
+	PVRDMA_WR_ERROR,
 };
 
 enum pvrdma_wc_status {
diff --git a/linux-headers/asm-arm/unistd-common.h b/linux-headers/asm-arm/unistd-common.h
index 8c84bcf10f..27a9b6da27 100644
--- a/linux-headers/asm-arm/unistd-common.h
+++ b/linux-headers/asm-arm/unistd-common.h
@@ -356,5 +356,37 @@
 #define __NR_statx (__NR_SYSCALL_BASE + 397)
 #define __NR_rseq (__NR_SYSCALL_BASE + 398)
 #define __NR_io_pgetevents (__NR_SYSCALL_BASE + 399)
+#define __NR_migrate_pages (__NR_SYSCALL_BASE + 400)
+#define __NR_kexec_file_load (__NR_SYSCALL_BASE + 401)
+#define __NR_clock_gettime64 (__NR_SYSCALL_BASE + 403)
+#define __NR_clock_settime64 (__NR_SYSCALL_BASE + 404)
+#define __NR_clock_adjtime64 (__NR_SYSCALL_BASE + 405)
+#define __NR_clock_getres_time64 (__NR_SYSCALL_BASE + 406)
+#define __NR_clock_nanosleep_time64 (__NR_SYSCALL_BASE + 407)
+#define __NR_timer_gettime64 (__NR_SYSCALL_BASE + 408)
+#define __NR_timer_settime64 (__NR_SYSCALL_BASE + 409)
+#define __NR_timerfd_gettime64 (__NR_SYSCALL_BASE + 410)
+#define __NR_timerfd_settime64 (__NR_SYSCALL_BASE + 411)
+#define __NR_utimensat_time64 (__NR_SYSCALL_BASE + 412)
+#define __NR_pselect6_time64 (__NR_SYSCALL_BASE + 413)
+#define __NR_ppoll_time64 (__NR_SYSCALL_BASE + 414)
+#define __NR_io_pgetevents_time64 (__NR_SYSCALL_BASE + 416)
+#define __NR_recvmmsg_time64 (__NR_SYSCALL_BASE + 417)
+#define __NR_mq_timedsend_time64 (__NR_SYSCALL_BASE + 418)
+#define __NR_mq_timedreceive_time64 (__NR_SYSCALL_BASE + 419)
+#define __NR_semtimedop_time64 (__NR_SYSCALL_BASE + 420)
+#define __NR_rt_sigtimedwait_time64 (__NR_SYSCALL_BASE + 421)
+#define __NR_futex_time64 (__NR_SYSCALL_BASE + 422)
+#define __NR_sched_rr_get_interval_time64 (__NR_SYSCALL_BASE + 423)
+#define __NR_pidfd_send_signal (__NR_SYSCALL_BASE + 424)
+#define __NR_io_uring_setup (__NR_SYSCALL_BASE + 425)
+#define __NR_io_uring_enter (__NR_SYSCALL_BASE + 426)
+#define __NR_io_uring_register (__NR_SYSCALL_BASE + 427)
+#define __NR_open_tree (__NR_SYSCALL_BASE + 428)
+#define __NR_move_mount (__NR_SYSCALL_BASE + 429)
+#define __NR_fsopen (__NR_SYSCALL_BASE + 430)
+#define __NR_fsconfig (__NR_SYSCALL_BASE + 431)
+#define __NR_fsmount (__NR_SYSCALL_BASE + 432)
+#define __NR_fspick (__NR_SYSCALL_BASE + 433)
 
 #endif /* _ASM_ARM_UNISTD_COMMON_H */
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index e6a98c14c8..2431ec35a9 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -35,6 +35,7 @@
 #include <linux/psci.h>
 #include <linux/types.h>
 #include <asm/ptrace.h>
+#include <asm/sve_context.h>
 
 #define __KVM_HAVE_GUEST_DEBUG
 #define __KVM_HAVE_IRQ_LINE
@@ -102,6 +103,9 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
 #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
 #define KVM_ARM_VCPU_PMU_V3		3 /* Support guest PMUv3 */
+#define KVM_ARM_VCPU_SVE		4 /* enable SVE for this CPU */
+#define KVM_ARM_VCPU_PTRAUTH_ADDRESS	5 /* VCPU uses address authentication */
+#define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
 
 struct kvm_vcpu_init {
 	__u32 target;
@@ -226,6 +230,45 @@ struct kvm_vcpu_events {
 					 KVM_REG_ARM_FW | ((r) & 0xffff))
 #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
 
+/* SVE registers */
+#define KVM_REG_ARM64_SVE		(0x15 << KVM_REG_ARM_COPROC_SHIFT)
+
+/* Z- and P-regs occupy blocks at the following offsets within this range: */
+#define KVM_REG_ARM64_SVE_ZREG_BASE	0
+#define KVM_REG_ARM64_SVE_PREG_BASE	0x400
+#define KVM_REG_ARM64_SVE_FFR_BASE	0x600
+
+#define KVM_ARM64_SVE_NUM_ZREGS		__SVE_NUM_ZREGS
+#define KVM_ARM64_SVE_NUM_PREGS		__SVE_NUM_PREGS
+
+#define KVM_ARM64_SVE_MAX_SLICES	32
+
+#define KVM_REG_ARM64_SVE_ZREG(n, i)					\
+	(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | KVM_REG_ARM64_SVE_ZREG_BASE | \
+	 KVM_REG_SIZE_U2048 |						\
+	 (((n) & (KVM_ARM64_SVE_NUM_ZREGS - 1)) << 5) |			\
+	 ((i) & (KVM_ARM64_SVE_MAX_SLICES - 1)))
+
+#define KVM_REG_ARM64_SVE_PREG(n, i)					\
+	(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | KVM_REG_ARM64_SVE_PREG_BASE | \
+	 KVM_REG_SIZE_U256 |						\
+	 (((n) & (KVM_ARM64_SVE_NUM_PREGS - 1)) << 5) |			\
+	 ((i) & (KVM_ARM64_SVE_MAX_SLICES - 1)))
+
+#define KVM_REG_ARM64_SVE_FFR(i)					\
+	(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | KVM_REG_ARM64_SVE_FFR_BASE | \
+	 KVM_REG_SIZE_U256 |						\
+	 ((i) & (KVM_ARM64_SVE_MAX_SLICES - 1)))
+
+#define KVM_ARM64_SVE_VQ_MIN __SVE_VQ_MIN
+#define KVM_ARM64_SVE_VQ_MAX __SVE_VQ_MAX
+
+/* Vector lengths pseudo-register: */
+#define KVM_REG_ARM64_SVE_VLS		(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | \
+					 KVM_REG_SIZE_U512 | 0xffff)
+#define KVM_ARM64_SVE_VLS_WORDS	\
+	((KVM_ARM64_SVE_VQ_MAX - KVM_ARM64_SVE_VQ_MIN) / 64 + 1)
+
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
diff --git a/linux-headers/asm-arm64/unistd.h b/linux-headers/asm-arm64/unistd.h
index dae1584cf0..4703d21866 100644
--- a/linux-headers/asm-arm64/unistd.h
+++ b/linux-headers/asm-arm64/unistd.h
@@ -17,5 +17,7 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_TIME32_SYSCALLS
 
 #include <asm-generic/unistd.h>
diff --git a/linux-headers/asm-generic/mman-common.h b/linux-headers/asm-generic/mman-common.h
index e7ee32861d..abd238d0f7 100644
--- a/linux-headers/asm-generic/mman-common.h
+++ b/linux-headers/asm-generic/mman-common.h
@@ -15,9 +15,7 @@
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
 
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+/* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x0f		/* Mask for type of mapping */
 #define MAP_FIXED	0x10		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index d90127298f..a87904daf1 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -38,8 +38,10 @@ __SYSCALL(__NR_io_destroy, sys_io_destroy)
 __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
 #define __NR_io_cancel 3
 __SYSCALL(__NR_io_cancel, sys_io_cancel)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_io_getevents 4
-__SC_COMP(__NR_io_getevents, sys_io_getevents, compat_sys_io_getevents)
+__SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
+#endif
 
 /* fs/xattr.c */
 #define __NR_setxattr 5
@@ -179,7 +181,7 @@ __SYSCALL(__NR_fchownat, sys_fchownat)
 #define __NR_fchown 55
 __SYSCALL(__NR_fchown, sys_fchown)
 #define __NR_openat 56
-__SC_COMP(__NR_openat, sys_openat, compat_sys_openat)
+__SYSCALL(__NR_openat, sys_openat)
 #define __NR_close 57
 __SYSCALL(__NR_close, sys_close)
 #define __NR_vhangup 58
@@ -222,10 +224,12 @@ __SC_COMP(__NR_pwritev, sys_pwritev, compat_sys_pwritev)
 __SYSCALL(__NR3264_sendfile, sys_sendfile64)
 
 /* fs/select.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_pselect6 72
-__SC_COMP(__NR_pselect6, sys_pselect6, compat_sys_pselect6)
+__SC_COMP_3264(__NR_pselect6, sys_pselect6_time32, sys_pselect6, compat_sys_pselect6_time32)
 #define __NR_ppoll 73
-__SC_COMP(__NR_ppoll, sys_ppoll, compat_sys_ppoll)
+__SC_COMP_3264(__NR_ppoll, sys_ppoll_time32, sys_ppoll, compat_sys_ppoll_time32)
+#endif
 
 /* fs/signalfd.c */
 #define __NR_signalfd4 74
@@ -269,16 +273,20 @@ __SC_COMP(__NR_sync_file_range, sys_sync_file_range, \
 /* fs/timerfd.c */
 #define __NR_timerfd_create 85
 __SYSCALL(__NR_timerfd_create, sys_timerfd_create)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timerfd_settime 86
-__SC_COMP(__NR_timerfd_settime, sys_timerfd_settime, \
-	  compat_sys_timerfd_settime)
+__SC_3264(__NR_timerfd_settime, sys_timerfd_settime32, \
+	  sys_timerfd_settime)
 #define __NR_timerfd_gettime 87
-__SC_COMP(__NR_timerfd_gettime, sys_timerfd_gettime, \
-	  compat_sys_timerfd_gettime)
+__SC_3264(__NR_timerfd_gettime, sys_timerfd_gettime32, \
+	  sys_timerfd_gettime)
+#endif
 
 /* fs/utimes.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_utimensat 88
-__SC_COMP(__NR_utimensat, sys_utimensat, compat_sys_utimensat)
+__SC_3264(__NR_utimensat, sys_utimensat_time32, sys_utimensat)
+#endif
 
 /* kernel/acct.c */
 #define __NR_acct 89
@@ -309,8 +317,10 @@ __SYSCALL(__NR_set_tid_address, sys_set_tid_address)
 __SYSCALL(__NR_unshare, sys_unshare)
 
 /* kernel/futex.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_futex 98
-__SC_COMP(__NR_futex, sys_futex, compat_sys_futex)
+__SC_3264(__NR_futex, sys_futex_time32, sys_futex)
+#endif
 #define __NR_set_robust_list 99
 __SC_COMP(__NR_set_robust_list, sys_set_robust_list, \
 	  compat_sys_set_robust_list)
@@ -319,8 +329,10 @@ __SC_COMP(__NR_get_robust_list, sys_get_robust_list, \
 	  compat_sys_get_robust_list)
 
 /* kernel/hrtimer.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_nanosleep 101
-__SC_COMP(__NR_nanosleep, sys_nanosleep, compat_sys_nanosleep)
+__SC_3264(__NR_nanosleep, sys_nanosleep_time32, sys_nanosleep)
+#endif
 
 /* kernel/itimer.c */
 #define __NR_getitimer 102
@@ -341,23 +353,29 @@ __SYSCALL(__NR_delete_module, sys_delete_module)
 /* kernel/posix-timers.c */
 #define __NR_timer_create 107
 __SC_COMP(__NR_timer_create, sys_timer_create, compat_sys_timer_create)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timer_gettime 108
-__SC_COMP(__NR_timer_gettime, sys_timer_gettime, compat_sys_timer_gettime)
+__SC_3264(__NR_timer_gettime, sys_timer_gettime32, sys_timer_gettime)
+#endif
 #define __NR_timer_getoverrun 109
 __SYSCALL(__NR_timer_getoverrun, sys_timer_getoverrun)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_timer_settime 110
-__SC_COMP(__NR_timer_settime, sys_timer_settime, compat_sys_timer_settime)
+__SC_3264(__NR_timer_settime, sys_timer_settime32, sys_timer_settime)
+#endif
 #define __NR_timer_delete 111
 __SYSCALL(__NR_timer_delete, sys_timer_delete)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_clock_settime 112
-__SC_COMP(__NR_clock_settime, sys_clock_settime, compat_sys_clock_settime)
+__SC_3264(__NR_clock_settime, sys_clock_settime32, sys_clock_settime)
 #define __NR_clock_gettime 113
-__SC_COMP(__NR_clock_gettime, sys_clock_gettime, compat_sys_clock_gettime)
+__SC_3264(__NR_clock_gettime, sys_clock_gettime32, sys_clock_gettime)
 #define __NR_clock_getres 114
-__SC_COMP(__NR_clock_getres, sys_clock_getres, compat_sys_clock_getres)
+__SC_3264(__NR_clock_getres, sys_clock_getres_time32, sys_clock_getres)
 #define __NR_clock_nanosleep 115
-__SC_COMP(__NR_clock_nanosleep, sys_clock_nanosleep, \
-	  compat_sys_clock_nanosleep)
+__SC_3264(__NR_clock_nanosleep, sys_clock_nanosleep_time32, \
+	  sys_clock_nanosleep)
+#endif
 
 /* kernel/printk.c */
 #define __NR_syslog 116
@@ -388,9 +406,11 @@ __SYSCALL(__NR_sched_yield, sys_sched_yield)
 __SYSCALL(__NR_sched_get_priority_max, sys_sched_get_priority_max)
 #define __NR_sched_get_priority_min 126
 __SYSCALL(__NR_sched_get_priority_min, sys_sched_get_priority_min)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_sched_rr_get_interval 127
-__SC_COMP(__NR_sched_rr_get_interval, sys_sched_rr_get_interval, \
-	  compat_sys_sched_rr_get_interval)
+__SC_3264(__NR_sched_rr_get_interval, sys_sched_rr_get_interval_time32, \
+	  sys_sched_rr_get_interval)
+#endif
 
 /* kernel/signal.c */
 #define __NR_restart_syscall 128
@@ -411,9 +431,11 @@ __SC_COMP(__NR_rt_sigaction, sys_rt_sigaction, compat_sys_rt_sigaction)
 __SC_COMP(__NR_rt_sigprocmask, sys_rt_sigprocmask, compat_sys_rt_sigprocmask)
 #define __NR_rt_sigpending 136
 __SC_COMP(__NR_rt_sigpending, sys_rt_sigpending, compat_sys_rt_sigpending)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_rt_sigtimedwait 137
-__SC_COMP(__NR_rt_sigtimedwait, sys_rt_sigtimedwait, \
-	  compat_sys_rt_sigtimedwait)
+__SC_COMP_3264(__NR_rt_sigtimedwait, sys_rt_sigtimedwait_time32, \
+	  sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time32)
+#endif
 #define __NR_rt_sigqueueinfo 138
 __SC_COMP(__NR_rt_sigqueueinfo, sys_rt_sigqueueinfo, \
 	  compat_sys_rt_sigqueueinfo)
@@ -467,10 +489,15 @@ __SYSCALL(__NR_uname, sys_newuname)
 __SYSCALL(__NR_sethostname, sys_sethostname)
 #define __NR_setdomainname 162
 __SYSCALL(__NR_setdomainname, sys_setdomainname)
+
+#ifdef __ARCH_WANT_SET_GET_RLIMIT
+/* getrlimit and setrlimit are superseded with prlimit64 */
 #define __NR_getrlimit 163
 __SC_COMP(__NR_getrlimit, sys_getrlimit, compat_sys_getrlimit)
 #define __NR_setrlimit 164
 __SC_COMP(__NR_setrlimit, sys_setrlimit, compat_sys_setrlimit)
+#endif
+
 #define __NR_getrusage 165
 __SC_COMP(__NR_getrusage, sys_getrusage, compat_sys_getrusage)
 #define __NR_umask 166
@@ -481,12 +508,14 @@ __SYSCALL(__NR_prctl, sys_prctl)
 __SYSCALL(__NR_getcpu, sys_getcpu)
 
 /* kernel/time.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_gettimeofday 169
 __SC_COMP(__NR_gettimeofday, sys_gettimeofday, compat_sys_gettimeofday)
 #define __NR_settimeofday 170
 __SC_COMP(__NR_settimeofday, sys_settimeofday, compat_sys_settimeofday)
 #define __NR_adjtimex 171
-__SC_COMP(__NR_adjtimex, sys_adjtimex, compat_sys_adjtimex)
+__SC_3264(__NR_adjtimex, sys_adjtimex_time32, sys_adjtimex)
+#endif
 
 /* kernel/timer.c */
 #define __NR_getpid 172
@@ -511,11 +540,13 @@ __SC_COMP(__NR_sysinfo, sys_sysinfo, compat_sys_sysinfo)
 __SC_COMP(__NR_mq_open, sys_mq_open, compat_sys_mq_open)
 #define __NR_mq_unlink 181
 __SYSCALL(__NR_mq_unlink, sys_mq_unlink)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_mq_timedsend 182
-__SC_COMP(__NR_mq_timedsend, sys_mq_timedsend, compat_sys_mq_timedsend)
+__SC_3264(__NR_mq_timedsend, sys_mq_timedsend_time32, sys_mq_timedsend)
 #define __NR_mq_timedreceive 183
-__SC_COMP(__NR_mq_timedreceive, sys_mq_timedreceive, \
-	  compat_sys_mq_timedreceive)
+__SC_3264(__NR_mq_timedreceive, sys_mq_timedreceive_time32, \
+	  sys_mq_timedreceive)
+#endif
 #define __NR_mq_notify 184
 __SC_COMP(__NR_mq_notify, sys_mq_notify, compat_sys_mq_notify)
 #define __NR_mq_getsetattr 185
@@ -536,8 +567,10 @@ __SC_COMP(__NR_msgsnd, sys_msgsnd, compat_sys_msgsnd)
 __SYSCALL(__NR_semget, sys_semget)
 #define __NR_semctl 191
 __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_semtimedop 192
-__SC_COMP(__NR_semtimedop, sys_semtimedop, compat_sys_semtimedop)
+__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_time32)
+#endif
 #define __NR_semop 193
 __SYSCALL(__NR_semop, sys_semop)
 
@@ -658,8 +691,10 @@ __SC_COMP(__NR_rt_tgsigqueueinfo, sys_rt_tgsigqueueinfo, \
 __SYSCALL(__NR_perf_event_open, sys_perf_event_open)
 #define __NR_accept4 242
 __SYSCALL(__NR_accept4, sys_accept4)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_recvmmsg 243
-__SC_COMP(__NR_recvmmsg, sys_recvmmsg, compat_sys_recvmmsg)
+__SC_COMP_3264(__NR_recvmmsg, sys_recvmmsg_time32, sys_recvmmsg, compat_sys_recvmmsg_time32)
+#endif
 
 /*
  * Architectures may provide up to 16 syscalls of their own
@@ -667,8 +702,10 @@ __SC_COMP(__NR_recvmmsg, sys_recvmmsg, compat_sys_recvmmsg)
  */
 #define __NR_arch_specific_syscall 244
 
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_wait4 260
 __SC_COMP(__NR_wait4, sys_wait4, compat_sys_wait4)
+#endif
 #define __NR_prlimit64 261
 __SYSCALL(__NR_prlimit64, sys_prlimit64)
 #define __NR_fanotify_init 262
@@ -678,10 +715,11 @@ __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
 #define __NR_name_to_handle_at         264
 __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
 #define __NR_open_by_handle_at         265
-__SC_COMP(__NR_open_by_handle_at, sys_open_by_handle_at, \
-	  compat_sys_open_by_handle_at)
+__SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_clock_adjtime 266
-__SC_COMP(__NR_clock_adjtime, sys_clock_adjtime, compat_sys_clock_adjtime)
+__SC_3264(__NR_clock_adjtime, sys_clock_adjtime32, sys_clock_adjtime)
+#endif
 #define __NR_syncfs 267
 __SYSCALL(__NR_syncfs, sys_syncfs)
 #define __NR_setns 268
@@ -734,15 +772,81 @@ __SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
 __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 #define __NR_statx 291
 __SYSCALL(__NR_statx,     sys_statx)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_io_pgetevents 292
-__SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
+__SC_COMP_3264(__NR_io_pgetevents, sys_io_pgetevents_time32, sys_io_pgetevents, compat_sys_io_pgetevents)
+#endif
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
+/* 295 through 402 are unassigned to sync up with generic numbers, don't use */
+#if __BITS_PER_LONG == 32
+#define __NR_clock_gettime64 403
+__SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
+#define __NR_clock_settime64 404
+__SYSCALL(__NR_clock_settime64, sys_clock_settime)
+#define __NR_clock_adjtime64 405
+__SYSCALL(__NR_clock_adjtime64, sys_clock_adjtime)
+#define __NR_clock_getres_time64 406
+__SYSCALL(__NR_clock_getres_time64, sys_clock_getres)
+#define __NR_clock_nanosleep_time64 407
+__SYSCALL(__NR_clock_nanosleep_time64, sys_clock_nanosleep)
+#define __NR_timer_gettime64 408
+__SYSCALL(__NR_timer_gettime64, sys_timer_gettime)
+#define __NR_timer_settime64 409
+__SYSCALL(__NR_timer_settime64, sys_timer_settime)
+#define __NR_timerfd_gettime64 410
+__SYSCALL(__NR_timerfd_gettime64, sys_timerfd_gettime)
+#define __NR_timerfd_settime64 411
+__SYSCALL(__NR_timerfd_settime64, sys_timerfd_settime)
+#define __NR_utimensat_time64 412
+__SYSCALL(__NR_utimensat_time64, sys_utimensat)
+#define __NR_pselect6_time64 413
+__SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time64)
+#define __NR_ppoll_time64 414
+__SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
+#define __NR_io_pgetevents_time64 416
+__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+#define __NR_recvmmsg_time64 417
+__SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
+#define __NR_mq_timedsend_time64 418
+__SYSCALL(__NR_mq_timedsend_time64, sys_mq_timedsend)
+#define __NR_mq_timedreceive_time64 419
+__SYSCALL(__NR_mq_timedreceive_time64, sys_mq_timedreceive)
+#define __NR_semtimedop_time64 420
+__SYSCALL(__NR_semtimedop_time64, sys_semtimedop)
+#define __NR_rt_sigtimedwait_time64 421
+__SC_COMP(__NR_rt_sigtimedwait_time64, sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time64)
+#define __NR_futex_time64 422
+__SYSCALL(__NR_futex_time64, sys_futex)
+#define __NR_sched_rr_get_interval_time64 423
+__SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
+#endif
+
+#define __NR_pidfd_send_signal 424
+__SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
+#define __NR_io_uring_setup 425
+__SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
+#define __NR_io_uring_enter 426
+__SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
+#define __NR_io_uring_register 427
+__SYSCALL(__NR_io_uring_register, sys_io_uring_register)
+#define __NR_open_tree 428
+__SYSCALL(__NR_open_tree, sys_open_tree)
+#define __NR_move_mount 429
+__SYSCALL(__NR_move_mount, sys_move_mount)
+#define __NR_fsopen 430
+__SYSCALL(__NR_fsopen, sys_fsopen)
+#define __NR_fsconfig 431
+__SYSCALL(__NR_fsconfig, sys_fsconfig)
+#define __NR_fsmount 432
+__SYSCALL(__NR_fsmount, sys_fsmount)
+#define __NR_fspick 433
+__SYSCALL(__NR_fspick, sys_fspick)
 
 #undef __NR_syscalls
-#define __NR_syscalls 295
+#define __NR_syscalls 434
 
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-mips/mman.h b/linux-headers/asm-mips/mman.h
index 3035ca499c..c2b40969eb 100644
--- a/linux-headers/asm-mips/mman.h
+++ b/linux-headers/asm-mips/mman.h
@@ -27,9 +27,7 @@
 /*
  * Flags for mmap
  */
-#define MAP_SHARED	0x001		/* Share changes */
-#define MAP_PRIVATE	0x002		/* Changes are private */
-#define MAP_SHARED_VALIDATE 0x003	/* share + validate extension flags */
+/* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x00f		/* Mask for type of mapping */
 #define MAP_FIXED	0x010		/* Interpret addr exactly */
 
diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips/unistd_n32.h
index b744f4d520..fb988de900 100644
--- a/linux-headers/asm-mips/unistd_n32.h
+++ b/linux-headers/asm-mips/unistd_n32.h
@@ -333,6 +333,36 @@
 #define __NR_statx	(__NR_Linux + 330)
 #define __NR_rseq	(__NR_Linux + 331)
 #define __NR_io_pgetevents	(__NR_Linux + 332)
+#define __NR_clock_gettime64	(__NR_Linux + 403)
+#define __NR_clock_settime64	(__NR_Linux + 404)
+#define __NR_clock_adjtime64	(__NR_Linux + 405)
+#define __NR_clock_getres_time64	(__NR_Linux + 406)
+#define __NR_clock_nanosleep_time64	(__NR_Linux + 407)
+#define __NR_timer_gettime64	(__NR_Linux + 408)
+#define __NR_timer_settime64	(__NR_Linux + 409)
+#define __NR_timerfd_gettime64	(__NR_Linux + 410)
+#define __NR_timerfd_settime64	(__NR_Linux + 411)
+#define __NR_utimensat_time64	(__NR_Linux + 412)
+#define __NR_pselect6_time64	(__NR_Linux + 413)
+#define __NR_ppoll_time64	(__NR_Linux + 414)
+#define __NR_io_pgetevents_time64	(__NR_Linux + 416)
+#define __NR_recvmmsg_time64	(__NR_Linux + 417)
+#define __NR_mq_timedsend_time64	(__NR_Linux + 418)
+#define __NR_mq_timedreceive_time64	(__NR_Linux + 419)
+#define __NR_semtimedop_time64	(__NR_Linux + 420)
+#define __NR_rt_sigtimedwait_time64	(__NR_Linux + 421)
+#define __NR_futex_time64	(__NR_Linux + 422)
+#define __NR_sched_rr_get_interval_time64	(__NR_Linux + 423)
+#define __NR_pidfd_send_signal	(__NR_Linux + 424)
+#define __NR_io_uring_setup	(__NR_Linux + 425)
+#define __NR_io_uring_enter	(__NR_Linux + 426)
+#define __NR_io_uring_register	(__NR_Linux + 427)
+#define __NR_open_tree	(__NR_Linux + 428)
+#define __NR_move_mount	(__NR_Linux + 429)
+#define __NR_fsopen	(__NR_Linux + 430)
+#define __NR_fsconfig	(__NR_Linux + 431)
+#define __NR_fsmount	(__NR_Linux + 432)
+#define __NR_fspick	(__NR_Linux + 433)
 
 
 #endif /* _ASM_MIPS_UNISTD_N32_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips/unistd_n64.h
index 8083de1f25..17359163c9 100644
--- a/linux-headers/asm-mips/unistd_n64.h
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -329,6 +329,16 @@
 #define __NR_statx	(__NR_Linux + 326)
 #define __NR_rseq	(__NR_Linux + 327)
 #define __NR_io_pgetevents	(__NR_Linux + 328)
+#define __NR_pidfd_send_signal	(__NR_Linux + 424)
+#define __NR_io_uring_setup	(__NR_Linux + 425)
+#define __NR_io_uring_enter	(__NR_Linux + 426)
+#define __NR_io_uring_register	(__NR_Linux + 427)
+#define __NR_open_tree	(__NR_Linux + 428)
+#define __NR_move_mount	(__NR_Linux + 429)
+#define __NR_fsopen	(__NR_Linux + 430)
+#define __NR_fsconfig	(__NR_Linux + 431)
+#define __NR_fsmount	(__NR_Linux + 432)
+#define __NR_fspick	(__NR_Linux + 433)
 
 
 #endif /* _ASM_MIPS_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips/unistd_o32.h
index b03835b286..83c8d8fb83 100644
--- a/linux-headers/asm-mips/unistd_o32.h
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -369,6 +369,46 @@
 #define __NR_statx	(__NR_Linux + 366)
 #define __NR_rseq	(__NR_Linux + 367)
 #define __NR_io_pgetevents	(__NR_Linux + 368)
+#define __NR_semget	(__NR_Linux + 393)
+#define __NR_semctl	(__NR_Linux + 394)
+#define __NR_shmget	(__NR_Linux + 395)
+#define __NR_shmctl	(__NR_Linux + 396)
+#define __NR_shmat	(__NR_Linux + 397)
+#define __NR_shmdt	(__NR_Linux + 398)
+#define __NR_msgget	(__NR_Linux + 399)
+#define __NR_msgsnd	(__NR_Linux + 400)
+#define __NR_msgrcv	(__NR_Linux + 401)
+#define __NR_msgctl	(__NR_Linux + 402)
+#define __NR_clock_gettime64	(__NR_Linux + 403)
+#define __NR_clock_settime64	(__NR_Linux + 404)
+#define __NR_clock_adjtime64	(__NR_Linux + 405)
+#define __NR_clock_getres_time64	(__NR_Linux + 406)
+#define __NR_clock_nanosleep_time64	(__NR_Linux + 407)
+#define __NR_timer_gettime64	(__NR_Linux + 408)
+#define __NR_timer_settime64	(__NR_Linux + 409)
+#define __NR_timerfd_gettime64	(__NR_Linux + 410)
+#define __NR_timerfd_settime64	(__NR_Linux + 411)
+#define __NR_utimensat_time64	(__NR_Linux + 412)
+#define __NR_pselect6_time64	(__NR_Linux + 413)
+#define __NR_ppoll_time64	(__NR_Linux + 414)
+#define __NR_io_pgetevents_time64	(__NR_Linux + 416)
+#define __NR_recvmmsg_time64	(__NR_Linux + 417)
+#define __NR_mq_timedsend_time64	(__NR_Linux + 418)
+#define __NR_mq_timedreceive_time64	(__NR_Linux + 419)
+#define __NR_semtimedop_time64	(__NR_Linux + 420)
+#define __NR_rt_sigtimedwait_time64	(__NR_Linux + 421)
+#define __NR_futex_time64	(__NR_Linux + 422)
+#define __NR_sched_rr_get_interval_time64	(__NR_Linux + 423)
+#define __NR_pidfd_send_signal	(__NR_Linux + 424)
+#define __NR_io_uring_setup	(__NR_Linux + 425)
+#define __NR_io_uring_enter	(__NR_Linux + 426)
+#define __NR_io_uring_register	(__NR_Linux + 427)
+#define __NR_open_tree	(__NR_Linux + 428)
+#define __NR_move_mount	(__NR_Linux + 429)
+#define __NR_fsopen	(__NR_Linux + 430)
+#define __NR_fsconfig	(__NR_Linux + 431)
+#define __NR_fsmount	(__NR_Linux + 432)
+#define __NR_fspick	(__NR_Linux + 433)
 
 
 #endif /* _ASM_MIPS_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 8c876c166e..b0f72dea8b 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -463,10 +463,12 @@ struct kvm_ppc_cpu_char {
 #define KVM_PPC_CPU_CHAR_BR_HINT_HONOURED	(1ULL << 58)
 #define KVM_PPC_CPU_CHAR_MTTRIG_THR_RECONF	(1ULL << 57)
 #define KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS	(1ULL << 56)
+#define KVM_PPC_CPU_CHAR_BCCTR_FLUSH_ASSIST	(1ull << 54)
 
 #define KVM_PPC_CPU_BEHAV_FAVOUR_SECURITY	(1ULL << 63)
 #define KVM_PPC_CPU_BEHAV_L1D_FLUSH_PR		(1ULL << 62)
 #define KVM_PPC_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ULL << 61)
+#define KVM_PPC_CPU_BEHAV_FLUSH_COUNT_CACHE	(1ull << 58)
 
 /* Per-vcpu XICS interrupt controller state */
 #define KVM_REG_PPC_ICP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8c)
@@ -480,6 +482,8 @@ struct kvm_ppc_cpu_char {
 #define  KVM_REG_PPC_ICP_PPRI_SHIFT	16	/* pending irq priority */
 #define  KVM_REG_PPC_ICP_PPRI_MASK	0xff
 
+#define KVM_REG_PPC_VP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U128 | 0x8d)
+
 /* Device control API: PPC-specific devices */
 #define KVM_DEV_MPIC_GRP_MISC		1
 #define   KVM_DEV_MPIC_BASE_ADDR	0	/* 64-bit */
@@ -675,4 +679,48 @@ struct kvm_ppc_cpu_char {
 #define  KVM_XICS_PRESENTED		(1ULL << 43)
 #define  KVM_XICS_QUEUED		(1ULL << 44)
 
+/* POWER9 XIVE Native Interrupt Controller */
+#define KVM_DEV_XIVE_GRP_CTRL		1
+#define   KVM_DEV_XIVE_RESET		1
+#define   KVM_DEV_XIVE_EQ_SYNC		2
+#define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source identifier */
+#define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source identifier */
+#define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit EQ identifier */
+#define KVM_DEV_XIVE_GRP_SOURCE_SYNC	5       /* 64-bit source identifier */
+
+/* Layout of 64-bit XIVE source attribute values */
+#define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
+#define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
+
+/* Layout of 64-bit XIVE source configuration attribute values */
+#define KVM_XIVE_SOURCE_PRIORITY_SHIFT	0
+#define KVM_XIVE_SOURCE_PRIORITY_MASK	0x7
+#define KVM_XIVE_SOURCE_SERVER_SHIFT	3
+#define KVM_XIVE_SOURCE_SERVER_MASK	0xfffffff8ULL
+#define KVM_XIVE_SOURCE_MASKED_SHIFT	32
+#define KVM_XIVE_SOURCE_MASKED_MASK	0x100000000ULL
+#define KVM_XIVE_SOURCE_EISN_SHIFT	33
+#define KVM_XIVE_SOURCE_EISN_MASK	0xfffffffe00000000ULL
+
+/* Layout of 64-bit EQ identifier */
+#define KVM_XIVE_EQ_PRIORITY_SHIFT	0
+#define KVM_XIVE_EQ_PRIORITY_MASK	0x7
+#define KVM_XIVE_EQ_SERVER_SHIFT	3
+#define KVM_XIVE_EQ_SERVER_MASK		0xfffffff8ULL
+
+/* Layout of EQ configuration values (64 bytes) */
+struct kvm_ppc_xive_eq {
+	__u32 flags;
+	__u32 qshift;
+	__u64 qaddr;
+	__u32 qtoggle;
+	__u32 qindex;
+	__u8  pad[40];
+};
+
+#define KVM_XIVE_EQ_ALWAYS_NOTIFY	0x00000001
+
+#define KVM_XIVE_TIMA_PAGE_OFFSET	0
+#define KVM_XIVE_ESB_PAGE_OFFSET	4
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-powerpc/unistd_32.h
index b8403d700d..04cb2d3e61 100644
--- a/linux-headers/asm-powerpc/unistd_32.h
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -376,6 +376,46 @@
 #define __NR_pkey_mprotect	386
 #define __NR_rseq	387
 #define __NR_io_pgetevents	388
+#define __NR_semget	393
+#define __NR_semctl	394
+#define __NR_shmget	395
+#define __NR_shmctl	396
+#define __NR_shmat	397
+#define __NR_shmdt	398
+#define __NR_msgget	399
+#define __NR_msgsnd	400
+#define __NR_msgrcv	401
+#define __NR_msgctl	402
+#define __NR_clock_gettime64	403
+#define __NR_clock_settime64	404
+#define __NR_clock_adjtime64	405
+#define __NR_clock_getres_time64	406
+#define __NR_clock_nanosleep_time64	407
+#define __NR_timer_gettime64	408
+#define __NR_timer_settime64	409
+#define __NR_timerfd_gettime64	410
+#define __NR_timerfd_settime64	411
+#define __NR_utimensat_time64	412
+#define __NR_pselect6_time64	413
+#define __NR_ppoll_time64	414
+#define __NR_io_pgetevents_time64	416
+#define __NR_recvmmsg_time64	417
+#define __NR_mq_timedsend_time64	418
+#define __NR_mq_timedreceive_time64	419
+#define __NR_semtimedop_time64	420
+#define __NR_rt_sigtimedwait_time64	421
+#define __NR_futex_time64	422
+#define __NR_sched_rr_get_interval_time64	423
+#define __NR_pidfd_send_signal	424
+#define __NR_io_uring_setup	425
+#define __NR_io_uring_enter	426
+#define __NR_io_uring_register	427
+#define __NR_open_tree	428
+#define __NR_move_mount	429
+#define __NR_fsopen	430
+#define __NR_fsconfig	431
+#define __NR_fsmount	432
+#define __NR_fspick	433
 
 
 #endif /* _ASM_POWERPC_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-powerpc/unistd_64.h
index f6a25fbbdd..b1e6921490 100644
--- a/linux-headers/asm-powerpc/unistd_64.h
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -367,6 +367,27 @@
 #define __NR_pkey_mprotect	386
 #define __NR_rseq	387
 #define __NR_io_pgetevents	388
+#define __NR_semtimedop	392
+#define __NR_semget	393
+#define __NR_semctl	394
+#define __NR_shmget	395
+#define __NR_shmctl	396
+#define __NR_shmat	397
+#define __NR_shmdt	398
+#define __NR_msgget	399
+#define __NR_msgsnd	400
+#define __NR_msgrcv	401
+#define __NR_msgctl	402
+#define __NR_pidfd_send_signal	424
+#define __NR_io_uring_setup	425
+#define __NR_io_uring_enter	426
+#define __NR_io_uring_register	427
+#define __NR_open_tree	428
+#define __NR_move_mount	429
+#define __NR_fsopen	430
+#define __NR_fsconfig	431
+#define __NR_fsmount	432
+#define __NR_fspick	433
 
 
 #endif /* _ASM_POWERPC_UNISTD_64_H */
diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 0265482f8f..03ab5968c7 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -152,7 +152,10 @@ struct kvm_s390_vm_cpu_subfunc {
 	__u8 pcc[16];		/* with MSA4 */
 	__u8 ppno[16];		/* with MSA5 */
 	__u8 kma[16];		/* with MSA8 */
-	__u8 reserved[1808];
+	__u8 kdsa[16];		/* with MSA9 */
+	__u8 sortl[32];		/* with STFLE.150 */
+	__u8 dfltcc[32];	/* with STFLE.151 */
+	__u8 reserved[1728];
 };
 
 /* kvm attributes for crypto */
diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/unistd_32.h
index 514e302ba1..941853f3e9 100644
--- a/linux-headers/asm-s390/unistd_32.h
+++ b/linux-headers/asm-s390/unistd_32.h
@@ -363,5 +363,48 @@
 #define __NR_kexec_file_load 381
 #define __NR_io_pgetevents 382
 #define __NR_rseq 383
+#define __NR_pkey_mprotect 384
+#define __NR_pkey_alloc 385
+#define __NR_pkey_free 386
+#define __NR_semget 393
+#define __NR_semctl 394
+#define __NR_shmget 395
+#define __NR_shmctl 396
+#define __NR_shmat 397
+#define __NR_shmdt 398
+#define __NR_msgget 399
+#define __NR_msgsnd 400
+#define __NR_msgrcv 401
+#define __NR_msgctl 402
+#define __NR_clock_gettime64 403
+#define __NR_clock_settime64 404
+#define __NR_clock_adjtime64 405
+#define __NR_clock_getres_time64 406
+#define __NR_clock_nanosleep_time64 407
+#define __NR_timer_gettime64 408
+#define __NR_timer_settime64 409
+#define __NR_timerfd_gettime64 410
+#define __NR_timerfd_settime64 411
+#define __NR_utimensat_time64 412
+#define __NR_pselect6_time64 413
+#define __NR_ppoll_time64 414
+#define __NR_io_pgetevents_time64 416
+#define __NR_recvmmsg_time64 417
+#define __NR_mq_timedsend_time64 418
+#define __NR_mq_timedreceive_time64 419
+#define __NR_semtimedop_time64 420
+#define __NR_rt_sigtimedwait_time64 421
+#define __NR_futex_time64 422
+#define __NR_sched_rr_get_interval_time64 423
+#define __NR_pidfd_send_signal 424
+#define __NR_io_uring_setup 425
+#define __NR_io_uring_enter 426
+#define __NR_io_uring_register 427
+#define __NR_open_tree 428
+#define __NR_move_mount 429
+#define __NR_fsopen 430
+#define __NR_fsconfig 431
+#define __NR_fsmount 432
+#define __NR_fspick 433
 
 #endif /* _ASM_S390_UNISTD_32_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
index d2b73de0ed..90271d7f82 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -330,5 +330,29 @@
 #define __NR_kexec_file_load 381
 #define __NR_io_pgetevents 382
 #define __NR_rseq 383
+#define __NR_pkey_mprotect 384
+#define __NR_pkey_alloc 385
+#define __NR_pkey_free 386
+#define __NR_semtimedop 392
+#define __NR_semget 393
+#define __NR_semctl 394
+#define __NR_shmget 395
+#define __NR_shmctl 396
+#define __NR_shmat 397
+#define __NR_shmdt 398
+#define __NR_msgget 399
+#define __NR_msgsnd 400
+#define __NR_msgrcv 401
+#define __NR_msgctl 402
+#define __NR_pidfd_send_signal 424
+#define __NR_io_uring_setup 425
+#define __NR_io_uring_enter 426
+#define __NR_io_uring_register 427
+#define __NR_open_tree 428
+#define __NR_move_mount 429
+#define __NR_fsopen 430
+#define __NR_fsconfig 431
+#define __NR_fsmount 432
+#define __NR_fspick 433
 
 #endif /* _ASM_S390_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index dabfcf7c39..7a0e64ccd6 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -381,6 +381,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
 #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
 #define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
+#define KVM_X86_QUIRK_OUT_7E_INC_RIP	(1 << 3)
 
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
index c1b30a0cf4..57bb48854c 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -384,5 +384,45 @@
 #define __NR_arch_prctl 384
 #define __NR_io_pgetevents 385
 #define __NR_rseq 386
+#define __NR_semget 393
+#define __NR_semctl 394
+#define __NR_shmget 395
+#define __NR_shmctl 396
+#define __NR_shmat 397
+#define __NR_shmdt 398
+#define __NR_msgget 399
+#define __NR_msgsnd 400
+#define __NR_msgrcv 401
+#define __NR_msgctl 402
+#define __NR_clock_gettime64 403
+#define __NR_clock_settime64 404
+#define __NR_clock_adjtime64 405
+#define __NR_clock_getres_time64 406
+#define __NR_clock_nanosleep_time64 407
+#define __NR_timer_gettime64 408
+#define __NR_timer_settime64 409
+#define __NR_timerfd_gettime64 410
+#define __NR_timerfd_settime64 411
+#define __NR_utimensat_time64 412
+#define __NR_pselect6_time64 413
+#define __NR_ppoll_time64 414
+#define __NR_io_pgetevents_time64 416
+#define __NR_recvmmsg_time64 417
+#define __NR_mq_timedsend_time64 418
+#define __NR_mq_timedreceive_time64 419
+#define __NR_semtimedop_time64 420
+#define __NR_rt_sigtimedwait_time64 421
+#define __NR_futex_time64 422
+#define __NR_sched_rr_get_interval_time64 423
+#define __NR_pidfd_send_signal 424
+#define __NR_io_uring_setup 425
+#define __NR_io_uring_enter 426
+#define __NR_io_uring_register 427
+#define __NR_open_tree 428
+#define __NR_move_mount 429
+#define __NR_fsopen 430
+#define __NR_fsconfig 431
+#define __NR_fsmount 432
+#define __NR_fspick 433
 
 #endif /* _ASM_X86_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
index c2e464c115..fe6aa0688a 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -336,5 +336,15 @@
 #define __NR_statx 332
 #define __NR_io_pgetevents 333
 #define __NR_rseq 334
+#define __NR_pidfd_send_signal 424
+#define __NR_io_uring_setup 425
+#define __NR_io_uring_enter 426
+#define __NR_io_uring_register 427
+#define __NR_open_tree 428
+#define __NR_move_mount 429
+#define __NR_fsopen 430
+#define __NR_fsconfig 431
+#define __NR_fsmount 432
+#define __NR_fspick 433
 
 #endif /* _ASM_X86_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index 37229021f0..09cca49ba7 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -289,6 +289,16 @@
 #define __NR_statx (__X32_SYSCALL_BIT + 332)
 #define __NR_io_pgetevents (__X32_SYSCALL_BIT + 333)
 #define __NR_rseq (__X32_SYSCALL_BIT + 334)
+#define __NR_pidfd_send_signal (__X32_SYSCALL_BIT + 424)
+#define __NR_io_uring_setup (__X32_SYSCALL_BIT + 425)
+#define __NR_io_uring_enter (__X32_SYSCALL_BIT + 426)
+#define __NR_io_uring_register (__X32_SYSCALL_BIT + 427)
+#define __NR_open_tree (__X32_SYSCALL_BIT + 428)
+#define __NR_move_mount (__X32_SYSCALL_BIT + 429)
+#define __NR_fsopen (__X32_SYSCALL_BIT + 430)
+#define __NR_fsconfig (__X32_SYSCALL_BIT + 431)
+#define __NR_fsmount (__X32_SYSCALL_BIT + 432)
+#define __NR_fspick (__X32_SYSCALL_BIT + 433)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index b53ee59748..c8423e760c 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -986,8 +986,13 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
 #define KVM_CAP_EXCEPTION_PAYLOAD 164
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
-#define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
+#define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166 /* Obsolete */
 #define KVM_CAP_HYPERV_CPUID 167
+#define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 168
+#define KVM_CAP_PPC_IRQ_XIVE 169
+#define KVM_CAP_ARM_SVE 170
+#define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
+#define KVM_CAP_ARM_PTRAUTH_GENERIC 172
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1145,6 +1150,7 @@ struct kvm_dirty_tlb {
 #define KVM_REG_SIZE_U256	0x0050000000000000ULL
 #define KVM_REG_SIZE_U512	0x0060000000000000ULL
 #define KVM_REG_SIZE_U1024	0x0070000000000000ULL
+#define KVM_REG_SIZE_U2048	0x0080000000000000ULL
 
 struct kvm_reg_list {
 	__u64 n; /* number of regs */
@@ -1211,6 +1217,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_ARM_VGIC_V3	KVM_DEV_TYPE_ARM_VGIC_V3
 	KVM_DEV_TYPE_ARM_VGIC_ITS,
 #define KVM_DEV_TYPE_ARM_VGIC_ITS	KVM_DEV_TYPE_ARM_VGIC_ITS
+	KVM_DEV_TYPE_XIVE,
+#define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
 	KVM_DEV_TYPE_MAX,
 };
 
@@ -1434,12 +1442,15 @@ struct kvm_enc_region {
 #define KVM_GET_NESTED_STATE         _IOWR(KVMIO, 0xbe, struct kvm_nested_state)
 #define KVM_SET_NESTED_STATE         _IOW(KVMIO,  0xbf, struct kvm_nested_state)
 
-/* Available with KVM_CAP_MANUAL_DIRTY_LOG_PROTECT */
+/* Available with KVM_CAP_MANUAL_DIRTY_LOG_PROTECT_2 */
 #define KVM_CLEAR_DIRTY_LOG          _IOWR(KVMIO, 0xc0, struct kvm_clear_dirty_log)
 
 /* Available with KVM_CAP_HYPERV_CPUID */
 #define KVM_GET_SUPPORTED_HV_CPUID _IOWR(KVMIO, 0xc1, struct kvm_cpuid2)
 
+/* Available with KVM_CAP_ARM_SVE */
+#define KVM_ARM_VCPU_FINALIZE	  _IOW(KVMIO,  0xc2, int)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
diff --git a/linux-headers/linux/mman.h b/linux-headers/linux/mman.h
index 3c44b6f480..1f6e2cd89c 100644
--- a/linux-headers/linux/mman.h
+++ b/linux-headers/linux/mman.h
@@ -12,6 +12,10 @@
 #define OVERCOMMIT_ALWAYS		1
 #define OVERCOMMIT_NEVER		2
 
+#define MAP_SHARED	0x01		/* Share changes */
+#define MAP_PRIVATE	0x02		/* Changes are private */
+#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+
 /*
  * Huge page size encoding when MAP_HUGETLB is specified, and a huge page
  * size other than the default is desired.  See hugetlb_encode.h.
diff --git a/linux-headers/linux/psci.h b/linux-headers/linux/psci.h
index 3905492d18..a6772d508b 100644
--- a/linux-headers/linux/psci.h
+++ b/linux-headers/linux/psci.h
@@ -49,8 +49,11 @@
 
 #define PSCI_1_0_FN_PSCI_FEATURES		PSCI_0_2_FN(10)
 #define PSCI_1_0_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)
+#define PSCI_1_0_FN_SET_SUSPEND_MODE		PSCI_0_2_FN(15)
+#define PSCI_1_1_FN_SYSTEM_RESET2		PSCI_0_2_FN(18)
 
 #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
+#define PSCI_1_1_FN64_SYSTEM_RESET2		PSCI_0_2_FN64(18)
 
 /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
 #define PSCI_0_2_POWER_STATE_ID_MASK		0xffff
@@ -97,6 +100,10 @@
 #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK	\
 			(0x1 << PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT)
 
+#define PSCI_1_0_OS_INITIATED			BIT(0)
+#define PSCI_1_0_SUSPEND_MODE_PC		0
+#define PSCI_1_0_SUSPEND_MODE_OSI		1
+
 /* PSCI return values (inclusive of all PSCI versions) */
 #define PSCI_RET_SUCCESS			0
 #define PSCI_RET_NOT_SUPPORTED			-1
diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.h
index b7b933ffaa..36bbe17d8f 100644
--- a/linux-headers/linux/psp-sev.h
+++ b/linux-headers/linux/psp-sev.h
@@ -6,8 +6,7 @@
  *
  * Author: Brijesh Singh <brijesh.singh@amd.com>
  *
- * SEV spec 0.14 is available at:
- * http://support.amd.com/TechDocs/55766_SEV-KM%20API_Specification.pdf
+ * SEV API specification is available at: https://developer.amd.com/sev/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -30,7 +29,8 @@ enum {
 	SEV_PDH_GEN,
 	SEV_PDH_CERT_EXPORT,
 	SEV_PEK_CERT_IMPORT,
-	SEV_GET_ID,
+	SEV_GET_ID,	/* This command is deprecated, use SEV_GET_ID2 */
+	SEV_GET_ID2,
 
 	SEV_MAX,
 };
@@ -125,7 +125,7 @@ struct sev_user_data_pdh_cert_export {
 } __attribute__((packed));
 
 /**
- * struct sev_user_data_get_id - GET_ID command parameters
+ * struct sev_user_data_get_id - GET_ID command parameters (deprecated)
  *
  * @socket1: Buffer to pass unique ID of first socket
  * @socket2: Buffer to pass unique ID of second socket
@@ -135,6 +135,16 @@ struct sev_user_data_get_id {
 	__u8 socket2[64];			/* Out */
 } __attribute__((packed));
 
+/**
+ * struct sev_user_data_get_id2 - GET_ID command parameters
+ * @address: Buffer to store unique ID
+ * @length: length of the unique ID
+ */
+struct sev_user_data_get_id2 {
+	__u64 address;				/* In */
+	__u32 length;				/* In/Out */
+} __attribute__((packed));
+
 /**
  * struct sev_issue_cmd - SEV ioctl parameters
  *
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 12a7b1dc53..24f505199f 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -353,6 +353,10 @@ struct vfio_region_gfx_edid {
 #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
 };
 
+#define VFIO_REGION_TYPE_CCW			(2)
+/* ccw sub-types */
+#define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
+
 /*
  * 10de vendor sub-type
  *
diff --git a/linux-headers/linux/vfio_ccw.h b/linux-headers/linux/vfio_ccw.h
index 5bf96c3812..fcc3e69ef5 100644
--- a/linux-headers/linux/vfio_ccw.h
+++ b/linux-headers/linux/vfio_ccw.h
@@ -12,6 +12,7 @@
 
 #include <linux/types.h>
 
+/* used for START SUBCHANNEL, always present */
 struct ccw_io_region {
 #define ORB_AREA_SIZE 12
 	__u8	orb_area[ORB_AREA_SIZE];
@@ -22,4 +23,15 @@ struct ccw_io_region {
 	__u32	ret_code;
 } __attribute__((packed));
 
+/*
+ * used for processing commands that trigger asynchronous actions
+ * Note: this is controlled by a capability
+ */
+#define VFIO_CCW_ASYNC_CMD_HSCH (1 << 0)
+#define VFIO_CCW_ASYNC_CMD_CSCH (1 << 1)
+struct ccw_cmd_region {
+	__u32 command;
+	__u32 ret_code;
+} __attribute__((packed));
+
 #endif
-- 
2.17.1


