Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27123C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 11:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D832220673
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 11:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D832220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44138 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVEAO-0001LJ-V3
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 07:51:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hVE1v-00039M-1u
	for qemu-devel@nongnu.org; Mon, 27 May 2019 07:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hVE1s-0003LP-UK
	for qemu-devel@nongnu.org; Mon, 27 May 2019 07:43:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hVE1o-0003IH-GN; Mon, 27 May 2019 07:42:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8AB3811BE;
	Mon, 27 May 2019 11:42:55 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-67.ams2.redhat.com [10.36.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 297575D723;
	Mon, 27 May 2019 11:42:49 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Mon, 27 May 2019 13:41:40 +0200
Message-Id: <20190527114203.2762-5-eric.auger@redhat.com>
In-Reply-To: <20190527114203.2762-1-eric.auger@redhat.com>
References: <20190527114203.2762-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 27 May 2019 11:42:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v4 04/27] header update against 5.2.0-rc1 and
 IOMMU/VFIO nested stage APIs
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
Cc: drjones@redhat.com, yi.l.liu@intel.com, mst@redhat.com,
	jean-philippe.brucker@arm.com, zhangfei.gao@foxmail.com,
	peterx@redhat.com, alex.williamson@redhat.com, vincent.stehle@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an update against the following development branch:
https://github.com/eauger/linux/tree/v5.2.0-rc1-2stage-v8.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 linux-headers/linux/iommu.h | 280 ++++++++++++++++++++++++++++++++++++
 linux-headers/linux/vfio.h  | 107 ++++++++++++++
 2 files changed, 387 insertions(+)
 create mode 100644 linux-headers/linux/iommu.h

diff --git a/linux-headers/linux/iommu.h b/linux-headers/linux/iommu.h
new file mode 100644
index 0000000000..0a59d6439c
--- /dev/null
+++ b/linux-headers/linux/iommu.h
@@ -0,0 +1,280 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * IOMMU user API definitions
+ */
+
+#ifndef _IOMMU_H
+#define _IOMMU_H
+
+#include <linux/types.h>
+
+#define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
+#define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
+#define IOMMU_FAULT_PERM_EXEC	(1 << 2) /* exec */
+#define IOMMU_FAULT_PERM_PRIV	(1 << 3) /* privileged */
+
+/* Generic fault types, can be expanded IRQ remapping fault */
+enum iommu_fault_type {
+	IOMMU_FAULT_DMA_UNRECOV =3D 1,	/* unrecoverable fault */
+	IOMMU_FAULT_PAGE_REQ,		/* page request fault */
+};
+
+enum iommu_fault_reason {
+	IOMMU_FAULT_REASON_UNKNOWN =3D 0,
+
+	/* Could not access the PASID table (fetch caused external abort) */
+	IOMMU_FAULT_REASON_PASID_FETCH,
+
+	/* PASID entry is invalid or has configuration errors */
+	IOMMU_FAULT_REASON_BAD_PASID_ENTRY,
+
+	/*
+	 * PASID is out of range (e.g. exceeds the maximum PASID
+	 * supported by the IOMMU) or disabled.
+	 */
+	IOMMU_FAULT_REASON_PASID_INVALID,
+
+	/*
+	 * An external abort occurred fetching (or updating) a translation
+	 * table descriptor
+	 */
+	IOMMU_FAULT_REASON_WALK_EABT,
+
+	/*
+	 * Could not access the page table entry (Bad address),
+	 * actual translation fault
+	 */
+	IOMMU_FAULT_REASON_PTE_FETCH,
+
+	/* Protection flag check failed */
+	IOMMU_FAULT_REASON_PERMISSION,
+
+	/* access flag check failed */
+	IOMMU_FAULT_REASON_ACCESS,
+
+	/* Output address of a translation stage caused Address Size fault */
+	IOMMU_FAULT_REASON_OOR_ADDRESS,
+};
+
+/**
+ * struct iommu_fault_unrecoverable - Unrecoverable fault data
+ * @reason: reason of the fault, from &enum iommu_fault_reason
+ * @flags: parameters of this fault (IOMMU_FAULT_UNRECOV_* values)
+ * @pasid: Process Address Space ID
+ * @perm: Requested permission access using by the incoming transaction
+ *        (IOMMU_FAULT_PERM_* values)
+ * @addr: offending page address
+ * @fetch_addr: address that caused a fetch abort, if any
+ */
+struct iommu_fault_unrecoverable {
+	__u32	reason;
+#define IOMMU_FAULT_UNRECOV_PASID_VALID		(1 << 0)
+#define IOMMU_FAULT_UNRECOV_ADDR_VALID		(1 << 1)
+#define IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID	(1 << 2)
+	__u32	flags;
+	__u32	pasid;
+	__u32	perm;
+	__u64	addr;
+	__u64	fetch_addr;
+};
+
+/**
+ * struct iommu_fault_page_request - Page Request data
+ * @flags: encodes whether the corresponding fields are valid and whethe=
r this
+ *         is the last page in group (IOMMU_FAULT_PAGE_REQUEST_* values)
+ * @pasid: Process Address Space ID
+ * @grpid: Page Request Group Index
+ * @perm: requested page permissions (IOMMU_FAULT_PERM_* values)
+ * @addr: page address
+ * @private_data: device-specific private information
+ */
+struct iommu_fault_page_request {
+#define IOMMU_FAULT_PAGE_REQUEST_PASID_VALID	(1 << 0)
+#define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
+#define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA	(1 << 2)
+	__u32	flags;
+	__u32	pasid;
+	__u32	grpid;
+	__u32	perm;
+	__u64	addr;
+	__u64	private_data[2];
+};
+
+/**
+ * struct iommu_fault - Generic fault data
+ * @type: fault type from &enum iommu_fault_type
+ * @padding: reserved for future use (should be zero)
+ * @event: Fault event, when @type is %IOMMU_FAULT_DMA_UNRECOV
+ * @prm: Page Request message, when @type is %IOMMU_FAULT_PAGE_REQ
+ */
+struct iommu_fault {
+	__u32	type;
+	__u32	padding;
+	union {
+		struct iommu_fault_unrecoverable event;
+		struct iommu_fault_page_request prm;
+	};
+};
+
+/**
+ * struct iommu_pasid_smmuv3 - ARM SMMUv3 Stream Table Entry stage 1 rel=
ated
+ *     information
+ * @version: API version of this structure
+ * @s1fmt: STE s1fmt (format of the CD table: single CD, linear table
+ *         or 2-level table)
+ * @s1dss: STE s1dss (specifies the behavior when @pasid_bits !=3D 0
+ *         and no PASID is passed along with the incoming transaction)
+ * @padding: reserved for future use (should be zero)
+ *
+ * The PASID table is referred to as the Context Descriptor (CD) table o=
n ARM
+ * SMMUv3. Please refer to the ARM SMMU 3.x spec (ARM IHI 0070A) for ful=
l
+ * details.
+ */
+struct iommu_pasid_smmuv3 {
+#define PASID_TABLE_SMMUV3_CFG_VERSION_1 1
+	__u32	version;
+	__u8	s1fmt;
+	__u8	s1dss;
+	__u8	padding[2];
+};
+
+/**
+ * struct iommu_pasid_table_config - PASID table data used to bind guest=
 PASID
+ *     table to the host IOMMU
+ * @version: API version to prepare for future extensions
+ * @format: format of the PASID table
+ * @base_ptr: guest physical address of the PASID table
+ * @pasid_bits: number of PASID bits used in the PASID table
+ * @config: indicates whether the guest translation stage must
+ *          be translated, bypassed or aborted.
+ * @padding: reserved for future use (should be zero)
+ * @smmuv3: table information when @format is %IOMMU_PASID_FORMAT_SMMUV3
+ */
+struct iommu_pasid_table_config {
+#define PASID_TABLE_CFG_VERSION_1 1
+	__u32	version;
+#define IOMMU_PASID_FORMAT_SMMUV3	1
+	__u32	format;
+	__u64	base_ptr;
+	__u8	pasid_bits;
+#define IOMMU_PASID_CONFIG_TRANSLATE	1
+#define IOMMU_PASID_CONFIG_BYPASS	2
+#define IOMMU_PASID_CONFIG_ABORT	3
+	__u8	config;
+	__u8    padding[6];
+	union {
+		struct iommu_pasid_smmuv3 smmuv3;
+	};
+};
+
+/* defines the granularity of the invalidation */
+enum iommu_inv_granularity {
+	IOMMU_INV_GRANU_DOMAIN,	/* domain-selective invalidation */
+	IOMMU_INV_GRANU_PASID,	/* PASID-selective invalidation */
+	IOMMU_INV_GRANU_ADDR,	/* page-selective invalidation */
+	IOMMU_INV_GRANU_NR,	/* number of invalidation granularities */
+};
+
+/**
+ * struct iommu_inv_addr_info - Address Selective Invalidation Structure
+ *
+ * @flags: indicates the granularity of the address-selective invalidati=
on
+ * - If the PASID bit is set, the @pasid field is populated and the inva=
lidation
+ *   relates to cache entries tagged with this PASID and matching the ad=
dress
+ *   range.
+ * - If ARCHID bit is set, @archid is populated and the invalidation rel=
ates
+ *   to cache entries tagged with this architecture specific ID and matc=
hing
+ *   the address range.
+ * - Both PASID and ARCHID can be set as they may tag different caches.
+ * - If neither PASID or ARCHID is set, global addr invalidation applies=
.
+ * - The LEAF flag indicates whether only the leaf PTE caching needs to =
be
+ *   invalidated and other paging structure caches can be preserved.
+ * @pasid: process address space ID
+ * @archid: architecture-specific ID
+ * @addr: first stage/level input address
+ * @granule_size: page/block size of the mapping in bytes
+ * @nb_granules: number of contiguous granules to be invalidated
+ */
+struct iommu_inv_addr_info {
+#define IOMMU_INV_ADDR_FLAGS_PASID	(1 << 0)
+#define IOMMU_INV_ADDR_FLAGS_ARCHID	(1 << 1)
+#define IOMMU_INV_ADDR_FLAGS_LEAF	(1 << 2)
+	__u32	flags;
+	__u32	archid;
+	__u64	pasid;
+	__u64	addr;
+	__u64	granule_size;
+	__u64	nb_granules;
+};
+
+/**
+ * struct iommu_inv_pasid_info - PASID Selective Invalidation Structure
+ *
+ * @flags: indicates the granularity of the PASID-selective invalidation
+ * - If the PASID bit is set, the @pasid field is populated and the inva=
lidation
+ *   relates to cache entries tagged with this PASID and matching the ad=
dress
+ *   range.
+ * - If the ARCHID bit is set, the @archid is populated and the invalida=
tion
+ *   relates to cache entries tagged with this architecture specific ID =
and
+ *   matching the address range.
+ * - Both PASID and ARCHID can be set as they may tag different caches.
+ * - At least one of PASID or ARCHID must be set.
+ * @pasid: process address space ID
+ * @archid: architecture-specific ID
+ */
+struct iommu_inv_pasid_info {
+#define IOMMU_INV_PASID_FLAGS_PASID	(1 << 0)
+#define IOMMU_INV_PASID_FLAGS_ARCHID	(1 << 1)
+	__u32	flags;
+	__u32	archid;
+	__u64	pasid;
+};
+
+/**
+ * struct iommu_cache_invalidate_info - First level/stage invalidation
+ *     information
+ * @version: API version of this structure
+ * @cache: bitfield that allows to select which caches to invalidate
+ * @granularity: defines the lowest granularity used for the invalidatio=
n:
+ *     domain > PASID > addr
+ * @padding: reserved for future use (should be zero)
+ * @pasid_info: invalidation data when @granularity is %IOMMU_INV_GRANU_=
PASID
+ * @addr_info: invalidation data when @granularity is %IOMMU_INV_GRANU_A=
DDR
+ *
+ * Not all the combinations of cache/granularity are valid:
+ *
+ * +--------------+---------------+---------------+---------------+
+ * | type /       |   DEV_IOTLB   |     IOTLB     |      PASID    |
+ * | granularity  |               |               |      cache    |
+ * +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+ * | DOMAIN       |       N/A     |       Y       |       Y       |
+ * +--------------+---------------+---------------+---------------+
+ * | PASID        |       Y       |       Y       |       Y       |
+ * +--------------+---------------+---------------+---------------+
+ * | ADDR         |       Y       |       Y       |       N/A     |
+ * +--------------+---------------+---------------+---------------+
+ *
+ * Invalidations by %IOMMU_INV_GRANU_DOMAIN don't take any argument othe=
r than
+ * @version and @cache.
+ *
+ * If multiple cache types are invalidated simultaneously, they all
+ * must support the used granularity.
+ */
+struct iommu_cache_invalidate_info {
+#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
+	__u32	version;
+/* IOMMU paging structure cache */
+#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU IOTLB */
+#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /* Device IOTLB */
+#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /* PASID cache */
+#define IOMMU_CACHE_INV_TYPE_NR		(3)
+	__u8	cache;
+	__u8	granularity;
+	__u8	padding[2];
+	union {
+		struct iommu_inv_pasid_info pasid_info;
+		struct iommu_inv_addr_info addr_info;
+	};
+};
+
+#endif /* _IOMMU_H */
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 24f505199f..f8e355896c 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -14,6 +14,7 @@
=20
 #include <linux/types.h>
 #include <linux/ioctl.h>
+#include <linux/iommu.h>
=20
 #define VFIO_API_VERSION	0
=20
@@ -306,6 +307,10 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_TYPE_GFX                    (1)
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
=20
+#define VFIO_REGION_TYPE_NESTED			(2)
+#define VFIO_REGION_SUBTYPE_NESTED_FAULT_PROD	(1)
+#define VFIO_REGION_SUBTYPE_NESTED_FAULT_CONS	(2)
+
 /**
  * struct vfio_region_gfx_edid - EDID region layout.
  *
@@ -554,6 +559,7 @@ enum {
 	VFIO_PCI_MSIX_IRQ_INDEX,
 	VFIO_PCI_ERR_IRQ_INDEX,
 	VFIO_PCI_REQ_IRQ_INDEX,
+	VFIO_PCI_DMA_FAULT_IRQ_INDEX,
 	VFIO_PCI_NUM_IRQS
 };
=20
@@ -700,6 +706,44 @@ struct vfio_device_ioeventfd {
=20
 #define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
=20
+
+/*
+ * Capability exposed by the Producer Fault Region
+ * @version: max fault ABI version supported by the kernel
+ */
+#define VFIO_REGION_INFO_CAP_PRODUCER_FAULT	6
+
+struct vfio_region_info_cap_fault {
+	struct vfio_info_cap_header header;
+	__u32 version;
+};
+
+/*
+ * Producer Fault Region (Read-Only from user space perspective)
+ * Contains the fault circular buffer and the producer index
+ * @version: version of the fault record uapi
+ * @entry_size: size of each fault record
+ * @offset: offset of the start of the queue
+ * @prod: producer index relative to the start of the queue
+ */
+struct vfio_region_fault_prod {
+	__u32   version;
+	__u32	nb_entries;
+	__u32   entry_size;
+	__u32	offset;
+	__u32   prod;
+};
+
+/*
+ * Consumer Fault Region (Write-Only from the user space perspective)
+ * @version: ABI version requested by the userspace
+ * @cons: consumer index relative to the start of the queue
+ */
+struct vfio_region_fault_cons {
+	__u32 version;
+	__u32 cons;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
=20
 /**
@@ -763,6 +807,69 @@ struct vfio_iommu_type1_dma_unmap {
 #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
 #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
=20
+/**
+ * VFIO_IOMMU_ATTACH_PASID_TABLE - _IOWR(VFIO_TYPE, VFIO_BASE + 22,
+ *			struct vfio_iommu_type1_attach_pasid_table)
+ *
+ * Passes the PASID table to the host. Calling ATTACH_PASID_TABLE
+ * while a table is already installed is allowed: it replaces the old
+ * table. DETACH does a comprehensive tear down of the nested mode.
+ */
+struct vfio_iommu_type1_attach_pasid_table {
+	__u32	argsz;
+	__u32	flags;
+	struct iommu_pasid_table_config config;
+};
+#define VFIO_IOMMU_ATTACH_PASID_TABLE	_IO(VFIO_TYPE, VFIO_BASE + 22)
+
+/**
+ * VFIO_IOMMU_DETACH_PASID_TABLE - - _IOWR(VFIO_TYPE, VFIO_BASE + 23)
+ * Detaches the PASID table
+ */
+#define VFIO_IOMMU_DETACH_PASID_TABLE	_IO(VFIO_TYPE, VFIO_BASE + 23)
+
+/**
+ * VFIO_IOMMU_CACHE_INVALIDATE - _IOWR(VFIO_TYPE, VFIO_BASE + 24,
+ *			struct vfio_iommu_type1_cache_invalidate)
+ *
+ * Propagate guest IOMMU cache invalidation to the host.
+ */
+struct vfio_iommu_type1_cache_invalidate {
+	__u32   argsz;
+	__u32   flags;
+	struct iommu_cache_invalidate_info info;
+};
+#define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 24)
+
+/**
+ * VFIO_IOMMU_BIND_MSI - _IOWR(VFIO_TYPE, VFIO_BASE + 25,
+ *			struct vfio_iommu_type1_bind_msi)
+ *
+ * Pass a stage 1 MSI doorbell mapping to the host so that this
+ * latter can build a nested stage2 mapping
+ */
+struct vfio_iommu_type1_bind_msi {
+	__u32   argsz;
+	__u32   flags;
+	__u64	iova;
+	__u64	gpa;
+	__u64	size;
+};
+#define VFIO_IOMMU_BIND_MSI      _IO(VFIO_TYPE, VFIO_BASE + 25)
+
+/**
+ * VFIO_IOMMU_UNBIND_MSI - _IOWR(VFIO_TYPE, VFIO_BASE + 26,
+ *			struct vfio_iommu_type1_unbind_msi)
+ *
+ * Unregister an MSI mapping
+ */
+struct vfio_iommu_type1_unbind_msi {
+	__u32   argsz;
+	__u32   flags;
+	__u64	iova;
+};
+#define VFIO_IOMMU_UNBIND_MSI      _IO(VFIO_TYPE, VFIO_BASE + 26)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU --------=
 */
=20
 /*
--=20
2.20.1


