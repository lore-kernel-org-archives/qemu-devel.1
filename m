Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DF3C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B419F2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B419F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33570 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEt82-0005X2-SV
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 06:09:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt38-0000x2-UV
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt37-0003he-Ah
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:04:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hEt30-0003ce-9j; Fri, 12 Apr 2019 06:04:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 058A83088B82;
	Fri, 12 Apr 2019 10:04:37 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-161.ams2.redhat.com [10.36.117.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6550519C65;
	Fri, 12 Apr 2019 10:04:34 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Fri, 12 Apr 2019 12:03:31 +0200
Message-Id: <20190412100354.6409-5-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 12 Apr 2019 10:04:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v3 04/27] header update against 5.1-rc3 and
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
Cc: yi.l.liu@intel.com, mst@redhat.com, jean-philippe.brucker@arm.com,
	peterx@redhat.com, alex.williamson@redhat.com, vincent.stehle@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412100331.p7R_tsJg8q2xp5FQ92NmBeHL0peiM_yabEI3pUYs6_c@z>

This is an update against the following development branch:
https://github.com/eauger/linux/tree/v5.1-rc3-2stage-v7.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 linux-headers/linux/iommu.h | 240 ++++++++++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)
 create mode 100644 linux-headers/linux/iommu.h

diff --git a/linux-headers/linux/iommu.h b/linux-headers/linux/iommu.h
new file mode 100644
index 0000000000..558f3095b9
--- /dev/null
+++ b/linux-headers/linux/iommu.h
@@ -0,0 +1,240 @@
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
+#define IOMMU_FAULT_PERM_WRITE	(1 << 0) /* write */
+#define IOMMU_FAULT_PERM_EXEC	(1 << 1) /* exec */
+#define IOMMU_FAULT_PERM_PRIV	(1 << 2) /* privileged */
+
+/*  Generic fault types, can be expanded IRQ remapping fault */
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
+	/* pasid entry is invalid or has configuration errors */
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
+ * Unrecoverable fault data
+ * @reason: reason of the fault
+ * @addr: offending page address
+ * @fetch_addr: address that caused a fetch abort, if any
+ * @pasid: contains process address space ID, used in shared virtual mem=
ory
+ * @perm: Requested permission access using by the incoming transaction
+ * (IOMMU_FAULT_PERM_* values)
+ */
+struct iommu_fault_unrecoverable {
+	__u32	reason; /* enum iommu_fault_reason */
+#define IOMMU_FAULT_UNRECOV_PASID_VALID		(1 << 0)
+#define IOMMU_FAULT_UNRECOV_PERM_VALID		(1 << 1)
+#define IOMMU_FAULT_UNRECOV_ADDR_VALID		(1 << 2)
+#define IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID	(1 << 3)
+	__u32	flags;
+	__u32	pasid;
+	__u32	perm;
+	__u64	addr;
+	__u64	fetch_addr;
+};
+
+/*
+ * Page Request data (aka. recoverable fault data)
+ * @flags : encodes whether the pasid is valid and whether this
+ * is the last page in group
+ * @pasid: pasid
+ * @grpid: page request group index
+ * @perm: requested page permissions (IOMMU_FAULT_PERM_* values)
+ * @addr: page address
+ */
+struct iommu_fault_page_request {
+#define IOMMU_FAULT_PAGE_REQUEST_PASID_VALID	(1 << 0)
+#define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
+#define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA	(1 << 2)
+	__u32   flags;
+	__u32	pasid;
+	__u32	grpid;
+	__u32	perm;
+	__u64	addr;
+	__u64	private_data[2];
+};
+
+/**
+ * struct iommu_fault - Generic fault data
+ *
+ * @type contains fault type
+ */
+
+struct iommu_fault {
+	__u32	type;   /* enum iommu_fault_type */
+	__u32	reserved;
+	union {
+		struct iommu_fault_unrecoverable event;
+		struct iommu_fault_page_request prm;
+	};
+};
+
+/**
+ * SMMUv3 Stream Table Entry stage 1 related information
+ * The PASID table is referred to as the context descriptor (CD) table.
+ *
+ * @s1fmt: STE s1fmt (format of the CD table: single CD, linear table
+   or 2-level table)
+ * @s1dss: STE s1dss (specifies the behavior when pasid_bits !=3D 0
+   and no pasid is passed along with the incoming transaction)
+ * Please refer to the smmu 3.x spec (ARM IHI 0070A) for full details
+ */
+struct iommu_pasid_smmuv3 {
+#define PASID_TABLE_SMMUV3_CFG_VERSION_1 1
+	__u32	version;
+	__u8 s1fmt;
+	__u8 s1dss;
+	__u8 padding[2];
+};
+
+/**
+ * PASID table data used to bind guest PASID table to the host IOMMU
+ * Note PASID table corresponds to the Context Table on ARM SMMUv3.
+ *
+ * @version: API version to prepare for future extensions
+ * @format: format of the PASID table
+ * @base_ptr: guest physical address of the PASID table
+ * @pasid_bits: number of PASID bits used in the PASID table
+ * @config: indicates whether the guest translation stage must
+ * be translated, bypassed or aborted.
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
+	IOMMU_INV_GRANU_PASID,	/* pasid-selective invalidation */
+	IOMMU_INV_GRANU_ADDR,	/* page-selective invalidation */
+};
+
+/**
+ * Address Selective Invalidation Structure
+ *
+ * @flags indicates the granularity of the address-selective invalidatio=
n
+ * - if PASID bit is set, @pasid field is populated and the invalidation
+ *   relates to cache entries tagged with this PASID and matching the
+ *   address range.
+ * - if ARCHID bit is set, @archid is populated and the invalidation rel=
ates
+ *   to cache entries tagged with this architecture specific id and matc=
hing
+ *   the address range.
+ * - Both PASID and ARCHID can be set as they may tag different caches.
+ * - if neither PASID or ARCHID is set, global addr invalidation applies
+ * - LEAF flag indicates whether only the leaf PTE caching needs to be
+ *   invalidated and other paging structure caches can be preserved.
+ * @pasid: process address space id
+ * @archid: architecture-specific id
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
+ * First level/stage invalidation information
+ * @cache: bitfield that allows to select which caches to invalidate
+ * @granularity: defines the lowest granularity used for the invalidatio=
n:
+ *     domain > pasid > addr
+ *
+ * Not all the combinations of cache/granularity make sense:
+ *
+ *         type |   DEV_IOTLB   |     IOTLB     |      PASID    |
+ * granularity	|		|		|      cache	|
+ * -------------+---------------+---------------+---------------+
+ * DOMAIN	|	N/A	|       Y	|	Y	|
+ * PASID	|	Y	|       Y	|	Y	|
+ * ADDR		|       Y	|       Y	|	N/A	|
+ *
+ * Invalidations by %IOMMU_INV_GRANU_ADDR use field @addr_info.
+ * Invalidations by %IOMMU_INV_GRANU_PASID use field @pasid.
+ * Invalidations by %IOMMU_INV_GRANU_DOMAIN don't take any argument.
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
+	__u8	cache;
+	__u8	granularity;
+	__u8	padding[2];
+	union {
+		__u64	pasid;
+		struct iommu_inv_addr_info addr_info;
+	};
+};
+
+
+#endif /* _IOMMU_H */
--=20
2.20.1


