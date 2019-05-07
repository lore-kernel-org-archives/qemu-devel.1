Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5C0C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291AF20B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291AF20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48979 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO2Mw-0005K0-F3
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:51:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hO2Jp-0003Cz-KG
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hO2Jk-00076h-MC
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:47:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hO2Jk-00075h-Bh; Tue, 07 May 2019 11:47:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22390300182B;
	Tue,  7 May 2019 15:47:43 +0000 (UTC)
Received: from localhost (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 062ED3DA5;
	Tue,  7 May 2019 15:47:39 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Date: Tue,  7 May 2019 17:47:32 +0200
Message-Id: <20190507154733.28604-2-cohuck@redhat.com>
In-Reply-To: <20190507154733.28604-1-cohuck@redhat.com>
References: <20190507154733.28604-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 07 May 2019 15:47:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 1/2] linux-headers: update
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update against 71ae5fc87c34 ("Merge tag 'linux-kselftest-5.2-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest")

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h |  15 +-
 include/standard-headers/drm/drm_fourcc.h     |  63 +++++++
 include/standard-headers/linux/ethtool.h      |  37 ++--
 .../linux/input-event-codes.h                 |   8 +-
 include/standard-headers/linux/input.h        |   6 +-
 include/standard-headers/linux/pci_regs.h     |   2 +
 .../standard-headers/linux/virtio_config.h    |   6 +
 include/standard-headers/linux/virtio_ring.h  |  10 --
 .../standard-headers/rdma/vmw_pvrdma-abi.h    |   1 +
 linux-headers/asm-arm/unistd-common.h         |  26 +++
 linux-headers/asm-arm64/unistd.h              |   2 +
 linux-headers/asm-generic/mman-common.h       |   4 +-
 linux-headers/asm-generic/unistd.h            | 158 ++++++++++++++----
 linux-headers/asm-mips/mman.h                 |   4 +-
 linux-headers/asm-mips/unistd_n32.h           |  24 +++
 linux-headers/asm-mips/unistd_n64.h           |   4 +
 linux-headers/asm-mips/unistd_o32.h           |  34 ++++
 linux-headers/asm-powerpc/kvm.h               |   2 +
 linux-headers/asm-powerpc/unistd_32.h         |  34 ++++
 linux-headers/asm-powerpc/unistd_64.h         |  15 ++
 linux-headers/asm-s390/unistd_32.h            |  37 ++++
 linux-headers/asm-s390/unistd_64.h            |  18 ++
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/asm-x86/unistd_32.h             |  34 ++++
 linux-headers/asm-x86/unistd_64.h             |   4 +
 linux-headers/asm-x86/unistd_x32.h            |   4 +
 linux-headers/linux/mman.h                    |   4 +
 linux-headers/linux/psci.h                    |   7 +
 linux-headers/linux/psp-sev.h                 |  18 +-
 linux-headers/linux/vfio.h                    |   4 +
 linux-headers/linux/vfio_ccw.h                |  12 ++
 31 files changed, 527 insertions(+), 71 deletions(-)

diff --git a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pv=
rdma_dev_api.h b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdm=
a/pvrdma_dev_api.h
index 422eb3f4c140..d019872608d5 100644
--- a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_de=
v_api.h
+++ b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_de=
v_api.h
@@ -57,7 +57,8 @@
=20
 #define PVRDMA_ROCEV1_VERSION		17
 #define PVRDMA_ROCEV2_VERSION		18
-#define PVRDMA_VERSION			PVRDMA_ROCEV2_VERSION
+#define PVRDMA_PPN64_VERSION		19
+#define PVRDMA_VERSION			PVRDMA_PPN64_VERSION
=20
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
=20
@@ -411,8 +414,10 @@ struct pvrdma_cmd_query_pkey_resp {
=20
 struct pvrdma_cmd_create_uc {
 	struct pvrdma_cmd_hdr hdr;
-	uint32_t pfn; /* UAR page frame number */
-	uint8_t reserved[4];
+	union {
+		uint32_t pfn; /* UAR page frame number */
+		uint64_t pfn64; /* 64-bit UAR page frame number */
+	};
 };
=20
 struct pvrdma_cmd_create_uc_resp {
diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard=
-headers/drm/drm_fourcc.h
index 44490607f951..7f42babe9ec7 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -194,6 +194,27 @@ extern "C" {
 #define DRM_FORMAT_NV24		fourcc_code('N', 'V', '2', '4') /* non-subsampl=
ed Cr:Cb plane */
 #define DRM_FORMAT_NV42		fourcc_code('N', 'V', '4', '2') /* non-subsampl=
ed Cb:Cr plane */
=20
+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 =3D Y plane, [15:0] Y:x [10:6] little endian
+ * index 1 =3D Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
+ */
+#define DRM_FORMAT_P010		fourcc_code('P', '0', '1', '0') /* 2x2 subsampl=
ed Cr:Cb plane 10 bits per channel */
+
+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 =3D Y plane, [15:0] Y:x [12:4] little endian
+ * index 1 =3D Cr:Cb plane, [31:0] Cr:x:Cb:x [12:4:12:4] little endian
+ */
+#define DRM_FORMAT_P012		fourcc_code('P', '0', '1', '2') /* 2x2 subsampl=
ed Cr:Cb plane 12 bits per channel */
+
+/*
+ * 2 plane YCbCr MSB aligned
+ * index 0 =3D Y plane, [15:0] Y little endian
+ * index 1 =3D Cr:Cb plane, [31:0] Cr:Cb [16:16] little endian
+ */
+#define DRM_FORMAT_P016		fourcc_code('P', '0', '1', '6') /* 2x2 subsampl=
ed Cr:Cb plane 16 bits per channel */
+
 /*
  * 3 plane YCbCr
  * index 0: Y plane, [7:0] Y
@@ -237,6 +258,8 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_VIVANTE 0x06
 #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
 #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
+#define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
+
 /* add more to the end as needed */
=20
 #define DRM_FORMAT_RESERVED	      ((1ULL << 56) - 1)
@@ -571,6 +594,9 @@ extern "C" {
  * AFBC has several features which may be supported and/or used, which a=
re
  * represented using bits in the modifier. Not all combinations are vali=
d,
  * and different devices or use-cases may support different combinations=
.
+ *
+ * Further information on the use of AFBC modifiers can be found in
+ * Documentation/gpu/afbc.rst
  */
 #define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, __afbc=
_mode)
=20
@@ -580,10 +606,18 @@ extern "C" {
  * Indicates the superblock size(s) used for the AFBC buffer. The buffer
  * size (in pixels) must be aligned to a multiple of the superblock size=
.
  * Four lowest significant bits(LSBs) are reserved for block size.
+ *
+ * Where one superblock size is specified, it applies to all planes of t=
he
+ * buffer (e.g. 16x16, 32x8). When multiple superblock sizes are specifi=
ed,
+ * the first applies to the Luma plane and the second applies to the Chr=
oma
+ * plane(s). e.g. (32x8_64x4 means 32x8 Luma, with 64x4 Chroma).
+ * Multiple superblock sizes are only valid for multi-plane YCbCr format=
s.
  */
 #define AFBC_FORMAT_MOD_BLOCK_SIZE_MASK      0xf
 #define AFBC_FORMAT_MOD_BLOCK_SIZE_16x16     (1ULL)
 #define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8      (2ULL)
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_64x4      (3ULL)
+#define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8_64x4 (4ULL)
=20
 /*
  * AFBC lossless colorspace transform
@@ -643,6 +677,35 @@ extern "C" {
  */
 #define AFBC_FORMAT_MOD_SC      (1ULL <<  9)
=20
+/*
+ * AFBC double-buffer
+ *
+ * Indicates that the buffer is allocated in a layout safe for front-buf=
fer
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
+ * This tiling mode is implemented by the VPU found on all Allwinner pla=
tforms,
+ * codenamed sunxi. It is associated with a YUV format that uses either =
2 or 3
+ * planes.
+ *
+ * With this tiling, the luminance samples are disposed in tiles represe=
nting
+ * 32x32 pixels and the chrominance samples in tiles representing 32x64 =
pixels.
+ * The pixel order in each tile is linear and the tiles are disposed lin=
early,
+ * both in row-major order.
+ */
+#define DRM_FORMAT_MOD_ALLWINNER_TILED fourcc_mod_code(ALLWINNER, 1)
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-=
headers/linux/ethtool.h
index 063c814278f6..b3a391bcd499 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -1432,6 +1432,13 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_56000baseSR4_Full_BIT	=3D 29,
 	ETHTOOL_LINK_MODE_56000baseLR4_Full_BIT	=3D 30,
 	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT	=3D 31,
+
+	/* Last allowed bit for __ETHTOOL_LINK_MODE_LEGACY_MASK is bit
+	 * 31. Please do NOT define any SUPPORTED_* or ADVERTISED_*
+	 * macro for bits > 31. The only way to use indices > 31 is to
+	 * use the new ETHTOOL_GLINKSETTINGS/ETHTOOL_SLINKSETTINGS API.
+	 */
+
 	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT	=3D 32,
 	ETHTOOL_LINK_MODE_25000baseSR_Full_BIT	=3D 33,
 	ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT	=3D 34,
@@ -1453,15 +1460,24 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_FEC_NONE_BIT	=3D 49,
 	ETHTOOL_LINK_MODE_FEC_RS_BIT	=3D 50,
 	ETHTOOL_LINK_MODE_FEC_BASER_BIT	=3D 51,
-
-	/* Last allowed bit for __ETHTOOL_LINK_MODE_LEGACY_MASK is bit
-	 * 31. Please do NOT define any SUPPORTED_* or ADVERTISED_*
-	 * macro for bits > 31. The only way to use indices > 31 is to
-	 * use the new ETHTOOL_GLINKSETTINGS/ETHTOOL_SLINKSETTINGS API.
-	 */
-
-	__ETHTOOL_LINK_MODE_LAST
-	  =3D ETHTOOL_LINK_MODE_FEC_BASER_BIT,
+	ETHTOOL_LINK_MODE_50000baseKR_Full_BIT		 =3D 52,
+	ETHTOOL_LINK_MODE_50000baseSR_Full_BIT		 =3D 53,
+	ETHTOOL_LINK_MODE_50000baseCR_Full_BIT		 =3D 54,
+	ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT	 =3D 55,
+	ETHTOOL_LINK_MODE_50000baseDR_Full_BIT		 =3D 56,
+	ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT	 =3D 57,
+	ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT	 =3D 58,
+	ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT	 =3D 59,
+	ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT =3D 60,
+	ETHTOOL_LINK_MODE_100000baseDR2_Full_BIT	 =3D 61,
+	ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT	 =3D 62,
+	ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT	 =3D 63,
+	ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT =3D 64,
+	ETHTOOL_LINK_MODE_200000baseDR4_Full_BIT	 =3D 65,
+	ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT	 =3D 66,
+
+	/* must be last entry */
+	__ETHTOOL_LINK_MODE_MASK_NBITS
 };
=20
 #define __ETHTOOL_LINK_MODE_LEGACY_MASK(base_name)	\
@@ -1569,12 +1585,13 @@ enum ethtool_link_mode_bit_indices {
 #define SPEED_50000		50000
 #define SPEED_56000		56000
 #define SPEED_100000		100000
+#define SPEED_200000		200000
=20
 #define SPEED_UNKNOWN		-1
=20
 static inline int ethtool_validate_speed(uint32_t speed)
 {
-	return speed <=3D INT_MAX || speed =3D=3D SPEED_UNKNOWN;
+	return speed <=3D INT_MAX || speed =3D=3D (uint32_t)SPEED_UNKNOWN;
 }
=20
 /* Duplex, half or full. */
diff --git a/include/standard-headers/linux/input-event-codes.h b/include=
/standard-headers/linux/input-event-codes.h
index 871ac933ebe9..78af54b87307 100644
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
@@ -716,6 +718,8 @@
  * the situation described above.
  */
 #define REL_RESERVED		0x0a
+#define REL_WHEEL_HI_RES	0x0b
+#define REL_HWHEEL_HI_RES	0x0c
 #define REL_MAX			0x0f
 #define REL_CNT			(REL_MAX+1)
=20
diff --git a/include/standard-headers/linux/input.h b/include/standard-he=
aders/linux/input.h
index c0ad9fc2c343..d8914f25a5e0 100644
--- a/include/standard-headers/linux/input.h
+++ b/include/standard-headers/linux/input.h
@@ -23,13 +23,17 @@
  */
=20
 struct input_event {
-#if (HOST_LONG_BITS !=3D 32 || !defined(__USE_TIME_BITS64)) && !defined(=
__KERNEL)
+#if (HOST_LONG_BITS !=3D 32 || !defined(__USE_TIME_BITS64)) && !defined(=
__KERNEL__)
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
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard=
-headers/linux/pci_regs.h
index e1e9888c85e6..5c98133f2c94 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -866,6 +866,7 @@
 #define PCI_ATS_CAP		0x04	/* ATS Capability Register */
 #define  PCI_ATS_CAP_QDEP(x)	((x) & 0x1f)	/* Invalidate Queue Depth */
 #define  PCI_ATS_MAX_QDEP	32	/* Max Invalidate Queue Depth */
+#define  PCI_ATS_CAP_PAGE_ALIGNED	0x0020 /* Page Aligned Request */
 #define PCI_ATS_CTRL		0x06	/* ATS Control Register */
 #define  PCI_ATS_CTRL_ENABLE	0x8000	/* ATS Enable */
 #define  PCI_ATS_CTRL_STU(x)	((x) & 0x1f)	/* Smallest Translation Unit *=
/
@@ -880,6 +881,7 @@
 #define  PCI_PRI_STATUS_RF	0x001	/* Response Failure */
 #define  PCI_PRI_STATUS_UPRGI	0x002	/* Unexpected PRG index */
 #define  PCI_PRI_STATUS_STOPPED	0x100	/* PRI Stopped */
+#define  PCI_PRI_STATUS_PASID	0x8000	/* PRG Response PASID Required */
 #define PCI_PRI_MAX_REQ		0x08	/* PRI max reqs supported */
 #define PCI_PRI_ALLOC_REQ	0x0c	/* PRI max reqs allowed */
 #define PCI_EXT_CAP_PRI_SIZEOF	16
diff --git a/include/standard-headers/linux/virtio_config.h b/include/sta=
ndard-headers/linux/virtio_config.h
index 24e30af5ecdd..9a69d9e2420b 100644
--- a/include/standard-headers/linux/virtio_config.h
+++ b/include/standard-headers/linux/virtio_config.h
@@ -78,6 +78,12 @@
 /* This feature indicates support for the packed virtqueue layout. */
 #define VIRTIO_F_RING_PACKED		34
=20
+/*
+ * This feature indicates that memory accesses by the driver and the
+ * device are ordered in a way described by the platform.
+ */
+#define VIRTIO_F_ORDER_PLATFORM		36
+
 /*
  * Does the device support Single Root I/O Virtualization?
  */
diff --git a/include/standard-headers/linux/virtio_ring.h b/include/stand=
ard-headers/linux/virtio_ring.h
index e89931f634ac..306cd41147be 100644
--- a/include/standard-headers/linux/virtio_ring.h
+++ b/include/standard-headers/linux/virtio_ring.h
@@ -211,14 +211,4 @@ struct vring_packed_desc {
 	uint16_t flags;
 };
=20
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
diff --git a/include/standard-headers/rdma/vmw_pvrdma-abi.h b/include/sta=
ndard-headers/rdma/vmw_pvrdma-abi.h
index 6c2bc461167f..336a8d596f24 100644
--- a/include/standard-headers/rdma/vmw_pvrdma-abi.h
+++ b/include/standard-headers/rdma/vmw_pvrdma-abi.h
@@ -78,6 +78,7 @@ enum pvrdma_wr_opcode {
 	PVRDMA_WR_MASKED_ATOMIC_FETCH_AND_ADD,
 	PVRDMA_WR_BIND_MW,
 	PVRDMA_WR_REG_SIG_MR,
+	PVRDMA_WR_ERROR,
 };
=20
 enum pvrdma_wc_status {
diff --git a/linux-headers/asm-arm/unistd-common.h b/linux-headers/asm-ar=
m/unistd-common.h
index 8c84bcf10f72..7d70b6b70e25 100644
--- a/linux-headers/asm-arm/unistd-common.h
+++ b/linux-headers/asm-arm/unistd-common.h
@@ -356,5 +356,31 @@
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
=20
 #endif /* _ASM_ARM_UNISTD_COMMON_H */
diff --git a/linux-headers/asm-arm64/unistd.h b/linux-headers/asm-arm64/u=
nistd.h
index dae1584cf017..4703d218663a 100644
--- a/linux-headers/asm-arm64/unistd.h
+++ b/linux-headers/asm-arm64/unistd.h
@@ -17,5 +17,7 @@
=20
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_TIME32_SYSCALLS
=20
 #include <asm-generic/unistd.h>
diff --git a/linux-headers/asm-generic/mman-common.h b/linux-headers/asm-=
generic/mman-common.h
index e7ee32861d51..abd238d0f7a4 100644
--- a/linux-headers/asm-generic/mman-common.h
+++ b/linux-headers/asm-generic/mman-common.h
@@ -15,9 +15,7 @@
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to sta=
rt of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end o=
f growsup vma */
=20
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+/* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x0f		/* Mask for type of mapping */
 #define MAP_FIXED	0x10		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-gener=
ic/unistd.h
index d90127298f12..dee7292e1df6 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -38,8 +38,10 @@ __SYSCALL(__NR_io_destroy, sys_io_destroy)
 __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
 #define __NR_io_cancel 3
 __SYSCALL(__NR_io_cancel, sys_io_cancel)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
 #define __NR_io_getevents 4
-__SC_COMP(__NR_io_getevents, sys_io_getevents, compat_sys_io_getevents)
+__SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
+#endif
=20
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
@@ -222,10 +224,12 @@ __SC_COMP(__NR_pwritev, sys_pwritev, compat_sys_pwr=
itev)
 __SYSCALL(__NR3264_sendfile, sys_sendfile64)
=20
 /* fs/select.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
 #define __NR_pselect6 72
-__SC_COMP(__NR_pselect6, sys_pselect6, compat_sys_pselect6)
+__SC_COMP_3264(__NR_pselect6, sys_pselect6_time32, sys_pselect6, compat_=
sys_pselect6_time32)
 #define __NR_ppoll 73
-__SC_COMP(__NR_ppoll, sys_ppoll, compat_sys_ppoll)
+__SC_COMP_3264(__NR_ppoll, sys_ppoll_time32, sys_ppoll, compat_sys_ppoll=
_time32)
+#endif
=20
 /* fs/signalfd.c */
 #define __NR_signalfd4 74
@@ -269,16 +273,20 @@ __SC_COMP(__NR_sync_file_range, sys_sync_file_range=
, \
 /* fs/timerfd.c */
 #define __NR_timerfd_create 85
 __SYSCALL(__NR_timerfd_create, sys_timerfd_create)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
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
=20
 /* fs/utimes.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
 #define __NR_utimensat 88
-__SC_COMP(__NR_utimensat, sys_utimensat, compat_sys_utimensat)
+__SC_3264(__NR_utimensat, sys_utimensat_time32, sys_utimensat)
+#endif
=20
 /* kernel/acct.c */
 #define __NR_acct 89
@@ -309,8 +317,10 @@ __SYSCALL(__NR_set_tid_address, sys_set_tid_address)
 __SYSCALL(__NR_unshare, sys_unshare)
=20
 /* kernel/futex.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
 #define __NR_futex 98
-__SC_COMP(__NR_futex, sys_futex, compat_sys_futex)
+__SC_3264(__NR_futex, sys_futex_time32, sys_futex)
+#endif
 #define __NR_set_robust_list 99
 __SC_COMP(__NR_set_robust_list, sys_set_robust_list, \
 	  compat_sys_set_robust_list)
@@ -319,8 +329,10 @@ __SC_COMP(__NR_get_robust_list, sys_get_robust_list,=
 \
 	  compat_sys_get_robust_list)
=20
 /* kernel/hrtimer.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
 #define __NR_nanosleep 101
-__SC_COMP(__NR_nanosleep, sys_nanosleep, compat_sys_nanosleep)
+__SC_3264(__NR_nanosleep, sys_nanosleep_time32, sys_nanosleep)
+#endif
=20
 /* kernel/itimer.c */
 #define __NR_getitimer 102
@@ -341,23 +353,29 @@ __SYSCALL(__NR_delete_module, sys_delete_module)
 /* kernel/posix-timers.c */
 #define __NR_timer_create 107
 __SC_COMP(__NR_timer_create, sys_timer_create, compat_sys_timer_create)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
 #define __NR_timer_gettime 108
-__SC_COMP(__NR_timer_gettime, sys_timer_gettime, compat_sys_timer_gettim=
e)
+__SC_3264(__NR_timer_gettime, sys_timer_gettime32, sys_timer_gettime)
+#endif
 #define __NR_timer_getoverrun 109
 __SYSCALL(__NR_timer_getoverrun, sys_timer_getoverrun)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
 #define __NR_timer_settime 110
-__SC_COMP(__NR_timer_settime, sys_timer_settime, compat_sys_timer_settim=
e)
+__SC_3264(__NR_timer_settime, sys_timer_settime32, sys_timer_settime)
+#endif
 #define __NR_timer_delete 111
 __SYSCALL(__NR_timer_delete, sys_timer_delete)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
 #define __NR_clock_settime 112
-__SC_COMP(__NR_clock_settime, sys_clock_settime, compat_sys_clock_settim=
e)
+__SC_3264(__NR_clock_settime, sys_clock_settime32, sys_clock_settime)
 #define __NR_clock_gettime 113
-__SC_COMP(__NR_clock_gettime, sys_clock_gettime, compat_sys_clock_gettim=
e)
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
=20
 /* kernel/printk.c */
 #define __NR_syslog 116
@@ -388,9 +406,11 @@ __SYSCALL(__NR_sched_yield, sys_sched_yield)
 __SYSCALL(__NR_sched_get_priority_max, sys_sched_get_priority_max)
 #define __NR_sched_get_priority_min 126
 __SYSCALL(__NR_sched_get_priority_min, sys_sched_get_priority_min)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
 #define __NR_sched_rr_get_interval 127
-__SC_COMP(__NR_sched_rr_get_interval, sys_sched_rr_get_interval, \
-	  compat_sys_sched_rr_get_interval)
+__SC_3264(__NR_sched_rr_get_interval, sys_sched_rr_get_interval_time32, =
\
+	  sys_sched_rr_get_interval)
+#endif
=20
 /* kernel/signal.c */
 #define __NR_restart_syscall 128
@@ -411,9 +431,11 @@ __SC_COMP(__NR_rt_sigaction, sys_rt_sigaction, compa=
t_sys_rt_sigaction)
 __SC_COMP(__NR_rt_sigprocmask, sys_rt_sigprocmask, compat_sys_rt_sigproc=
mask)
 #define __NR_rt_sigpending 136
 __SC_COMP(__NR_rt_sigpending, sys_rt_sigpending, compat_sys_rt_sigpendin=
g)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
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
=20
 /* kernel/time.c */
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
 #define __NR_gettimeofday 169
 __SC_COMP(__NR_gettimeofday, sys_gettimeofday, compat_sys_gettimeofday)
 #define __NR_settimeofday 170
 __SC_COMP(__NR_settimeofday, sys_settimeofday, compat_sys_settimeofday)
 #define __NR_adjtimex 171
-__SC_COMP(__NR_adjtimex, sys_adjtimex, compat_sys_adjtimex)
+__SC_3264(__NR_adjtimex, sys_adjtimex_time32, sys_adjtimex)
+#endif
=20
 /* kernel/timer.c */
 #define __NR_getpid 172
@@ -511,11 +540,13 @@ __SC_COMP(__NR_sysinfo, sys_sysinfo, compat_sys_sys=
info)
 __SC_COMP(__NR_mq_open, sys_mq_open, compat_sys_mq_open)
 #define __NR_mq_unlink 181
 __SYSCALL(__NR_mq_unlink, sys_mq_unlink)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
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
@@ -536,8 +567,10 @@ __SC_COMP(__NR_msgsnd, sys_msgsnd, compat_sys_msgsnd=
)
 __SYSCALL(__NR_semget, sys_semget)
 #define __NR_semctl 191
 __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
 #define __NR_semtimedop 192
-__SC_COMP(__NR_semtimedop, sys_semtimedop, compat_sys_semtimedop)
+__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_time32)
+#endif
 #define __NR_semop 193
 __SYSCALL(__NR_semop, sys_semop)
=20
@@ -658,8 +691,10 @@ __SC_COMP(__NR_rt_tgsigqueueinfo, sys_rt_tgsigqueuei=
nfo, \
 __SYSCALL(__NR_perf_event_open, sys_perf_event_open)
 #define __NR_accept4 242
 __SYSCALL(__NR_accept4, sys_accept4)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
 #define __NR_recvmmsg 243
-__SC_COMP(__NR_recvmmsg, sys_recvmmsg, compat_sys_recvmmsg)
+__SC_COMP_3264(__NR_recvmmsg, sys_recvmmsg_time32, sys_recvmmsg, compat_=
sys_recvmmsg_time32)
+#endif
=20
 /*
  * Architectures may provide up to 16 syscalls of their own
@@ -667,8 +702,10 @@ __SC_COMP(__NR_recvmmsg, sys_recvmmsg, compat_sys_re=
cvmmsg)
  */
 #define __NR_arch_specific_syscall 244
=20
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
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
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
 #define __NR_clock_adjtime 266
-__SC_COMP(__NR_clock_adjtime, sys_clock_adjtime, compat_sys_clock_adjtim=
e)
+__SC_3264(__NR_clock_adjtime, sys_clock_adjtime32, sys_clock_adjtime)
+#endif
 #define __NR_syncfs 267
 __SYSCALL(__NR_syncfs, sys_syncfs)
 #define __NR_setns 268
@@ -734,15 +772,69 @@ __SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
 __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 #define __NR_statx 291
 __SYSCALL(__NR_statx,     sys_statx)
+#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
 #define __NR_io_pgetevents 292
-__SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevent=
s)
+__SC_COMP_3264(__NR_io_pgetevents, sys_io_pgetevents_time32, sys_io_pget=
events, compat_sys_io_pgetevents)
+#endif
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
+/* 295 through 402 are unassigned to sync up with generic numbers, don't=
 use */
+#if __BITS_PER_LONG =3D=3D 32
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
+__SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time64=
)
+#define __NR_ppoll_time64 414
+__SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
+#define __NR_io_pgetevents_time64 416
+__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+#define __NR_recvmmsg_time64 417
+__SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64=
)
+#define __NR_mq_timedsend_time64 418
+__SYSCALL(__NR_mq_timedsend_time64, sys_mq_timedsend)
+#define __NR_mq_timedreceive_time64 419
+__SYSCALL(__NR_mq_timedreceive_time64, sys_mq_timedreceive)
+#define __NR_semtimedop_time64 420
+__SYSCALL(__NR_semtimedop_time64, sys_semtimedop)
+#define __NR_rt_sigtimedwait_time64 421
+__SC_COMP(__NR_rt_sigtimedwait_time64, sys_rt_sigtimedwait, compat_sys_r=
t_sigtimedwait_time64)
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
=20
 #undef __NR_syscalls
-#define __NR_syscalls 295
+#define __NR_syscalls 428
=20
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-mips/mman.h b/linux-headers/asm-mips/mman.=
h
index 3035ca499cd8..c2b40969eb1f 100644
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
=20
diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips=
/unistd_n32.h
index b744f4d520bf..bcc3771b6a76 100644
--- a/linux-headers/asm-mips/unistd_n32.h
+++ b/linux-headers/asm-mips/unistd_n32.h
@@ -333,6 +333,30 @@
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
=20
=20
 #endif /* _ASM_MIPS_UNISTD_N32_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips=
/unistd_n64.h
index 8083de1f2507..0daa8a6aea70 100644
--- a/linux-headers/asm-mips/unistd_n64.h
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -329,6 +329,10 @@
 #define __NR_statx	(__NR_Linux + 326)
 #define __NR_rseq	(__NR_Linux + 327)
 #define __NR_io_pgetevents	(__NR_Linux + 328)
+#define __NR_pidfd_send_signal	(__NR_Linux + 424)
+#define __NR_io_uring_setup	(__NR_Linux + 425)
+#define __NR_io_uring_enter	(__NR_Linux + 426)
+#define __NR_io_uring_register	(__NR_Linux + 427)
=20
=20
 #endif /* _ASM_MIPS_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips=
/unistd_o32.h
index b03835b28682..657c2d330e1f 100644
--- a/linux-headers/asm-mips/unistd_o32.h
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -369,6 +369,40 @@
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
=20
=20
 #endif /* _ASM_MIPS_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/=
kvm.h
index 8c876c166ef2..26ca425f4c2c 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -463,10 +463,12 @@ struct kvm_ppc_cpu_char {
 #define KVM_PPC_CPU_CHAR_BR_HINT_HONOURED	(1ULL << 58)
 #define KVM_PPC_CPU_CHAR_MTTRIG_THR_RECONF	(1ULL << 57)
 #define KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS	(1ULL << 56)
+#define KVM_PPC_CPU_CHAR_BCCTR_FLUSH_ASSIST	(1ull << 54)
=20
 #define KVM_PPC_CPU_BEHAV_FAVOUR_SECURITY	(1ULL << 63)
 #define KVM_PPC_CPU_BEHAV_L1D_FLUSH_PR		(1ULL << 62)
 #define KVM_PPC_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ULL << 61)
+#define KVM_PPC_CPU_BEHAV_FLUSH_COUNT_CACHE	(1ull << 58)
=20
 /* Per-vcpu XICS interrupt controller state */
 #define KVM_REG_PPC_ICP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8c)
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-po=
werpc/unistd_32.h
index b8403d700d84..7ca649212eee 100644
--- a/linux-headers/asm-powerpc/unistd_32.h
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -376,6 +376,40 @@
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
=20
=20
 #endif /* _ASM_POWERPC_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-po=
werpc/unistd_64.h
index f6a25fbbdd58..7ab9640de7e0 100644
--- a/linux-headers/asm-powerpc/unistd_64.h
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -367,6 +367,21 @@
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
=20
=20
 #endif /* _ASM_POWERPC_UNISTD_64_H */
diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/=
unistd_32.h
index 514e302ba12c..027c380de083 100644
--- a/linux-headers/asm-s390/unistd_32.h
+++ b/linux-headers/asm-s390/unistd_32.h
@@ -363,5 +363,42 @@
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
=20
 #endif /* _ASM_S390_UNISTD_32_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/=
unistd_64.h
index d2b73de0ed73..241240d8468a 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -330,5 +330,23 @@
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
=20
 #endif /* _ASM_S390_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index dabfcf7c3941..7a0e64ccd6ff 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -381,6 +381,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
 #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
 #define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
+#define KVM_X86_QUIRK_OUT_7E_INC_RIP	(1 << 3)
=20
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/un=
istd_32.h
index c1b30a0cf472..e71e53b32bb0 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -384,5 +384,39 @@
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
=20
 #endif /* _ASM_X86_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/un=
istd_64.h
index c2e464c115f2..5a7e5b73ff2a 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -336,5 +336,9 @@
 #define __NR_statx 332
 #define __NR_io_pgetevents 333
 #define __NR_rseq 334
+#define __NR_pidfd_send_signal 424
+#define __NR_io_uring_setup 425
+#define __NR_io_uring_enter 426
+#define __NR_io_uring_register 427
=20
 #endif /* _ASM_X86_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/u=
nistd_x32.h
index 37229021f077..0e98f4392129 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -289,6 +289,10 @@
 #define __NR_statx (__X32_SYSCALL_BIT + 332)
 #define __NR_io_pgetevents (__X32_SYSCALL_BIT + 333)
 #define __NR_rseq (__X32_SYSCALL_BIT + 334)
+#define __NR_pidfd_send_signal (__X32_SYSCALL_BIT + 424)
+#define __NR_io_uring_setup (__X32_SYSCALL_BIT + 425)
+#define __NR_io_uring_enter (__X32_SYSCALL_BIT + 426)
+#define __NR_io_uring_register (__X32_SYSCALL_BIT + 427)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/mman.h b/linux-headers/linux/mman.h
index 3c44b6f480c7..1f6e2cd89ccb 100644
--- a/linux-headers/linux/mman.h
+++ b/linux-headers/linux/mman.h
@@ -12,6 +12,10 @@
 #define OVERCOMMIT_ALWAYS		1
 #define OVERCOMMIT_NEVER		2
=20
+#define MAP_SHARED	0x01		/* Share changes */
+#define MAP_PRIVATE	0x02		/* Changes are private */
+#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+
 /*
  * Huge page size encoding when MAP_HUGETLB is specified, and a huge pag=
e
  * size other than the default is desired.  See hugetlb_encode.h.
diff --git a/linux-headers/linux/psci.h b/linux-headers/linux/psci.h
index 3905492d181f..a6772d508b25 100644
--- a/linux-headers/linux/psci.h
+++ b/linux-headers/linux/psci.h
@@ -49,8 +49,11 @@
=20
 #define PSCI_1_0_FN_PSCI_FEATURES		PSCI_0_2_FN(10)
 #define PSCI_1_0_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)
+#define PSCI_1_0_FN_SET_SUSPEND_MODE		PSCI_0_2_FN(15)
+#define PSCI_1_1_FN_SYSTEM_RESET2		PSCI_0_2_FN(18)
=20
 #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
+#define PSCI_1_1_FN64_SYSTEM_RESET2		PSCI_0_2_FN64(18)
=20
 /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
 #define PSCI_0_2_POWER_STATE_ID_MASK		0xffff
@@ -97,6 +100,10 @@
 #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK	\
 			(0x1 << PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT)
=20
+#define PSCI_1_0_OS_INITIATED			BIT(0)
+#define PSCI_1_0_SUSPEND_MODE_PC		0
+#define PSCI_1_0_SUSPEND_MODE_OSI		1
+
 /* PSCI return values (inclusive of all PSCI versions) */
 #define PSCI_RET_SUCCESS			0
 #define PSCI_RET_NOT_SUPPORTED			-1
diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.=
h
index b7b933ffaa38..36bbe17d8fa7 100644
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
=20
 	SEV_MAX,
 };
@@ -125,7 +125,7 @@ struct sev_user_data_pdh_cert_export {
 } __attribute__((packed));
=20
 /**
- * struct sev_user_data_get_id - GET_ID command parameters
+ * struct sev_user_data_get_id - GET_ID command parameters (deprecated)
  *
  * @socket1: Buffer to pass unique ID of first socket
  * @socket2: Buffer to pass unique ID of second socket
@@ -135,6 +135,16 @@ struct sev_user_data_get_id {
 	__u8 socket2[64];			/* Out */
 } __attribute__((packed));
=20
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
index 12a7b1dc53c8..24f505199f83 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -353,6 +353,10 @@ struct vfio_region_gfx_edid {
 #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
 };
=20
+#define VFIO_REGION_TYPE_CCW			(2)
+/* ccw sub-types */
+#define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
+
 /*
  * 10de vendor sub-type
  *
diff --git a/linux-headers/linux/vfio_ccw.h b/linux-headers/linux/vfio_cc=
w.h
index 5bf96c3812d2..fcc3e69ef526 100644
--- a/linux-headers/linux/vfio_ccw.h
+++ b/linux-headers/linux/vfio_ccw.h
@@ -12,6 +12,7 @@
=20
 #include <linux/types.h>
=20
+/* used for START SUBCHANNEL, always present */
 struct ccw_io_region {
 #define ORB_AREA_SIZE 12
 	__u8	orb_area[ORB_AREA_SIZE];
@@ -22,4 +23,15 @@ struct ccw_io_region {
 	__u32	ret_code;
 } __attribute__((packed));
=20
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
--=20
2.20.1


