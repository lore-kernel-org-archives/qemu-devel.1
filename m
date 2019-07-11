Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E961C71142
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C99208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C99208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hld4O-0004ii-TJ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 13:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38217)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hld3r-0002xq-Eg
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hld3i-0004Xq-Dg
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:40:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hld3a-0004P7-CE; Thu, 11 Jul 2019 13:40:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8A024308FBAC;
 Thu, 11 Jul 2019 17:40:33 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-46.ams2.redhat.com [10.36.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 49BFA6092E;
 Thu, 11 Jul 2019 17:40:30 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Thu, 11 Jul 2019 19:39:12 +0200
Message-Id: <20190711173933.31203-9-eric.auger@redhat.com>
In-Reply-To: <20190711173933.31203-1-eric.auger@redhat.com>
References: <20190711173933.31203-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 11 Jul 2019 17:40:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v5 08/29] header update against 5.3.0-rc0 and
 IOMMU/VFIO nested stage APIs
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
Cc: drjones@redhat.com, yi.l.liu@intel.com, mst@redhat.com,
 jean-philippe.brucker@arm.com, zhangfei.gao@foxmail.com, peterx@redhat.com,
 alex.williamson@redhat.com, vincent.stehle@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an update against
https://github.com/eauger/linux/tree/v5.3.0-rc0-2stage-v9.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/standard-headers/asm-x86/bootparam.h |   2 +
 include/standard-headers/linux/virtio_ids.h  |   1 -
 include/standard-headers/linux/virtio_pmem.h |  34 --
 linux-headers/asm-arm/unistd-common.h        |   1 +
 linux-headers/asm-arm64/kvm.h                |   7 +
 linux-headers/asm-generic/unistd.h           |   4 +-
 linux-headers/asm-mips/unistd_n32.h          |   1 +
 linux-headers/asm-mips/unistd_n64.h          |   1 +
 linux-headers/asm-mips/unistd_o32.h          |   1 +
 linux-headers/asm-powerpc/unistd_32.h        |   1 +
 linux-headers/asm-powerpc/unistd_64.h        |   1 +
 linux-headers/asm-s390/unistd_32.h           |   1 +
 linux-headers/asm-s390/unistd_64.h           |   1 +
 linux-headers/asm-x86/kvm.h                  |   6 +-
 linux-headers/asm-x86/unistd_32.h            |   1 +
 linux-headers/asm-x86/unistd_64.h            |   1 +
 linux-headers/asm-x86/unistd_x32.h           |   1 +
 linux-headers/linux/iommu.h                  | 316 +++++++++++++++++++
 linux-headers/linux/psp-sev.h                |   5 +-
 linux-headers/linux/vfio.h                   | 109 ++++++-
 20 files changed, 451 insertions(+), 44 deletions(-)
 delete mode 100644 include/standard-headers/linux/virtio_pmem.h
 create mode 100644 linux-headers/linux/iommu.h

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
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standa=
rd-headers/linux/virtio_ids.h
index 32b2f94d1f..6d5c3b2d4f 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -43,6 +43,5 @@
 #define VIRTIO_ID_INPUT        18 /* virtio input */
 #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
-#define VIRTIO_ID_PMEM         27 /* virtio pmem */
=20
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/include/standard-headers/linux/virtio_pmem.h b/include/stand=
ard-headers/linux/virtio_pmem.h
deleted file mode 100644
index 7e3d43b121..0000000000
--- a/include/standard-headers/linux/virtio_pmem.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/*
- * Definitions for virtio-pmem devices.
- *
- * Copyright (C) 2019 Red Hat, Inc.
- *
- * Author(s): Pankaj Gupta <pagupta@redhat.com>
- */
-
-#ifndef _UAPI_LINUX_VIRTIO_PMEM_H
-#define _UAPI_LINUX_VIRTIO_PMEM_H
-
-#include "standard-headers/linux/types.h"
-#include "standard-headers/linux/virtio_ids.h"
-#include "standard-headers/linux/virtio_config.h"
-
-struct virtio_pmem_config {
-	uint64_t start;
-	uint64_t size;
-};
-
-#define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
-
-struct virtio_pmem_resp {
-	/* Host return status corresponding to flush request */
-	uint32_t ret;
-};
-
-struct virtio_pmem_req {
-	/* command type */
-	uint32_t type;
-};
-
-#endif
diff --git a/linux-headers/asm-arm/unistd-common.h b/linux-headers/asm-ar=
m/unistd-common.h
index 27a9b6da27..fe1d2e5334 100644
--- a/linux-headers/asm-arm/unistd-common.h
+++ b/linux-headers/asm-arm/unistd-common.h
@@ -388,5 +388,6 @@
 #define __NR_fsconfig (__NR_SYSCALL_BASE + 431)
 #define __NR_fsmount (__NR_SYSCALL_BASE + 432)
 #define __NR_fspick (__NR_SYSCALL_BASE + 433)
+#define __NR_pidfd_open (__NR_SYSCALL_BASE + 434)
=20
 #endif /* _ASM_ARM_UNISTD_COMMON_H */
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.=
h
index 2431ec35a9..9d701b6cbd 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -260,6 +260,13 @@ struct kvm_vcpu_events {
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
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-gener=
ic/unistd.h
index a87904daf1..e5684a4512 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -844,9 +844,11 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_pidfd_open 434
+__SYSCALL(__NR_pidfd_open, sys_pidfd_open)
=20
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 435
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
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-po=
werpc/unistd_32.h
index 04cb2d3e61..2af478a7fe 100644
--- a/linux-headers/asm-powerpc/unistd_32.h
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -416,6 +416,7 @@
 #define __NR_fsconfig	431
 #define __NR_fsmount	432
 #define __NR_fspick	433
+#define __NR_pidfd_open	434
=20
=20
 #endif /* _ASM_POWERPC_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-po=
werpc/unistd_64.h
index b1e6921490..4d76f18222 100644
--- a/linux-headers/asm-powerpc/unistd_64.h
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -388,6 +388,7 @@
 #define __NR_fsconfig	431
 #define __NR_fsmount	432
 #define __NR_fspick	433
+#define __NR_pidfd_open	434
=20
=20
 #endif /* _ASM_POWERPC_UNISTD_64_H */
diff --git a/linux-headers/asm-s390/unistd_32.h b/linux-headers/asm-s390/=
unistd_32.h
index 941853f3e9..6d6cf02d06 100644
--- a/linux-headers/asm-s390/unistd_32.h
+++ b/linux-headers/asm-s390/unistd_32.h
@@ -406,5 +406,6 @@
 #define __NR_fsconfig 431
 #define __NR_fsmount 432
 #define __NR_fspick 433
+#define __NR_pidfd_open 434
=20
 #endif /* _ASM_S390_UNISTD_32_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/=
unistd_64.h
index 90271d7f82..93bf370741 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -354,5 +354,6 @@
 #define __NR_fsconfig 431
 #define __NR_fsmount 432
 #define __NR_fspick 433
+#define __NR_pidfd_open 434
=20
 #endif /* _ASM_S390_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 6e7dd792e4..d6ab5b4d15 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -384,17 +384,17 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_OUT_7E_INC_RIP	(1 << 3)
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
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/un=
istd_32.h
index 57bb48854c..3685335df2 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -424,5 +424,6 @@
 #define __NR_fsconfig 431
 #define __NR_fsmount 432
 #define __NR_fspick 433
+#define __NR_pidfd_open 434
=20
 #endif /* _ASM_X86_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/un=
istd_64.h
index fe6aa0688a..e42933d117 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -346,5 +346,6 @@
 #define __NR_fsconfig 431
 #define __NR_fsmount 432
 #define __NR_fspick 433
+#define __NR_pidfd_open 434
=20
 #endif /* _ASM_X86_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/u=
nistd_x32.h
index 09cca49ba7..95890e5df7 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -299,6 +299,7 @@
 #define __NR_fsconfig (__X32_SYSCALL_BIT + 431)
 #define __NR_fsmount (__X32_SYSCALL_BIT + 432)
 #define __NR_fspick (__X32_SYSCALL_BIT + 433)
+#define __NR_pidfd_open (__X32_SYSCALL_BIT + 434)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/iommu.h b/linux-headers/linux/iommu.h
new file mode 100644
index 0000000000..9304e16ae9
--- /dev/null
+++ b/linux-headers/linux/iommu.h
@@ -0,0 +1,316 @@
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
+ * @perm: requested permission access using by the incoming transaction
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
+ * @event: fault event, when @type is %IOMMU_FAULT_DMA_UNRECOV
+ * @prm: Page Request message, when @type is %IOMMU_FAULT_PAGE_REQ
+ * @padding2: sets the fault size to allow for future extensions
+ */
+struct iommu_fault {
+	__u32	type;
+	__u32	padding;
+	union {
+		struct iommu_fault_unrecoverable event;
+		struct iommu_fault_page_request prm;
+		__u8 padding2[56];
+	};
+};
+
+/**
+ * enum iommu_page_response_code - Return status of fault handlers
+ * @IOMMU_PAGE_RESP_SUCCESS: Fault has been handled and the page tables
+ *	populated, retry the access. This is "Success" in PCI PRI.
+ * @IOMMU_PAGE_RESP_FAILURE: General error. Drop all subsequent faults f=
rom
+ *	this device if possible. This is "Response Failure" in PCI PRI.
+ * @IOMMU_PAGE_RESP_INVALID: Could not handle this fault, don't retry th=
e
+ *	access. This is "Invalid Request" in PCI PRI.
+ */
+enum iommu_page_response_code {
+	IOMMU_PAGE_RESP_SUCCESS =3D 0,
+	IOMMU_PAGE_RESP_INVALID,
+	IOMMU_PAGE_RESP_FAILURE,
+};
+
+/**
+ * struct iommu_page_response - Generic page response information
+ * @version: API version of this structure
+ * @flags: encodes whether the corresponding fields are valid
+ *         (IOMMU_FAULT_PAGE_RESPONSE_* values)
+ * @pasid: Process Address Space ID
+ * @grpid: Page Request Group Index
+ * @code: response code from &enum iommu_page_response_code
+ */
+struct iommu_page_response {
+#define IOMMU_PAGE_RESP_VERSION_1	1
+	__u32	version;
+#define IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)
+	__u32	flags;
+	__u32	pasid;
+	__u32	grpid;
+	__u32	code;
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
+ * @archid: architecture-specific ID
+ * @pasid: process address space ID
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
+ * @archid: architecture-specific ID
+ * @pasid: process address space ID
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
diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.=
h
index 36bbe17d8f..bb45d2123f 100644
--- a/linux-headers/linux/psp-sev.h
+++ b/linux-headers/linux/psp-sev.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
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
index 24f505199f..d27610b54c 100644
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
@@ -306,6 +307,9 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_TYPE_GFX                    (1)
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
=20
+#define VFIO_REGION_TYPE_NESTED			(2)
+#define VFIO_REGION_SUBTYPE_NESTED_DMA_FAULT	(1)
+
 /**
  * struct vfio_region_gfx_edid - EDID region layout.
  *
@@ -448,11 +452,30 @@ struct vfio_irq_info {
 #define VFIO_IRQ_INFO_MASKABLE		(1 << 1)
 #define VFIO_IRQ_INFO_AUTOMASKED	(1 << 2)
 #define VFIO_IRQ_INFO_NORESIZE		(1 << 3)
+#define VFIO_IRQ_INFO_FLAG_CAPS		(1 << 4) /* Info supports caps */
 	__u32	index;		/* IRQ index */
 	__u32	count;		/* Number of IRQs within this index */
+	__u32	cap_offset;	/* Offset within info struct of first cap */
 };
 #define VFIO_DEVICE_GET_IRQ_INFO	_IO(VFIO_TYPE, VFIO_BASE + 9)
=20
+/*
+ * The irq type capability allows IRQs unique to a specific device or
+ * class of devices to be exposed.
+ *
+ * The structures below define version 1 of this capability.
+ */
+#define VFIO_IRQ_INFO_CAP_TYPE      3
+
+struct vfio_irq_info_cap_type {
+	struct vfio_info_cap_header header;
+	__u32 type;     /* global per bus driver */
+	__u32 subtype;  /* type specific */
+};
+
+#define VFIO_IRQ_TYPE_NESTED				(1)
+#define VFIO_IRQ_SUBTYPE_DMA_FAULT			(1)
+
 /**
  * VFIO_DEVICE_SET_IRQS - _IOW(VFIO_TYPE, VFIO_BASE + 10, struct vfio_ir=
q_set)
  *
@@ -554,7 +577,8 @@ enum {
 	VFIO_PCI_MSIX_IRQ_INDEX,
 	VFIO_PCI_ERR_IRQ_INDEX,
 	VFIO_PCI_REQ_IRQ_INDEX,
-	VFIO_PCI_NUM_IRQS
+	VFIO_PCI_NUM_IRQS =3D 5	/* Fixed user ABI, IRQ indexes >=3D5 use   */
+				/* device specific cap to define content */
 };
=20
 /*
@@ -700,6 +724,38 @@ struct vfio_device_ioeventfd {
=20
 #define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
=20
+
+/*
+ * Capability exposed by the DMA fault region
+ * @version: ABI version
+ */
+#define VFIO_REGION_INFO_CAP_DMA_FAULT	6
+
+struct vfio_region_info_cap_fault {
+	struct vfio_info_cap_header header;
+	__u32 version;
+};
+
+/*
+ * DMA Fault Region Layout
+ * @tail: index relative to the start of the ring buffer at which the
+ *        consumer finds the next item in the buffer
+ * @entry_size: fault ring buffer entry size in bytes
+ * @nb_entries: max capacity of the fault ring buffer
+ * @offset: ring buffer offset relative to the start of the region
+ * @head: index relative to the start of the ring buffer at which the
+ *        producer (kernel) inserts items into the buffers
+ */
+struct vfio_region_dma_fault {
+	/* Write-Only */
+	__u32   tail;
+	/* Read-Only */
+	__u32   entry_size;
+	__u32	nb_entries;
+	__u32	offset;
+	__u32   head;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
=20
 /**
@@ -763,6 +819,57 @@ struct vfio_iommu_type1_dma_unmap {
 #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
 #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
=20
+/**
+ * VFIO_IOMMU_SET_PASID_TABLE - _IOWR(VFIO_TYPE, VFIO_BASE + 22,
+ *			struct vfio_iommu_type1_set_pasid_table)
+ *
+ * The SET operation passes a PASID table to the host while the
+ * UNSET operation detaches the one currently programmed. Setting
+ * a table while another is already programmed replaces the old table.
+ */
+struct vfio_iommu_type1_set_pasid_table {
+	__u32	argsz;
+	__u32	flags;
+#define VFIO_PASID_TABLE_FLAG_SET	(1 << 0)
+#define VFIO_PASID_TABLE_FLAG_UNSET	(1 << 1)
+	struct iommu_pasid_table_config config; /* used on SET */
+};
+
+#define VFIO_IOMMU_SET_PASID_TABLE	_IO(VFIO_TYPE, VFIO_BASE + 22)
+
+/**
+ * VFIO_IOMMU_CACHE_INVALIDATE - _IOWR(VFIO_TYPE, VFIO_BASE + 23,
+ *			struct vfio_iommu_type1_cache_invalidate)
+ *
+ * Propagate guest IOMMU cache invalidation to the host.
+ */
+struct vfio_iommu_type1_cache_invalidate {
+	__u32   argsz;
+	__u32   flags;
+	struct iommu_cache_invalidate_info info;
+};
+#define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 23)
+
+/**
+ * VFIO_IOMMU_SET_MSI_BINDING - _IOWR(VFIO_TYPE, VFIO_BASE + 24,
+ *			struct vfio_iommu_type1_set_msi_binding)
+ *
+ * Pass a stage 1 MSI doorbell mapping to the host so that this
+ * latter can build a nested stage2 mapping. Or conversely tear
+ * down a previously bound stage 1 MSI binding.
+ */
+struct vfio_iommu_type1_set_msi_binding {
+	__u32   argsz;
+	__u32   flags;
+#define VFIO_IOMMU_BIND_MSI	(1 << 0)
+#define VFIO_IOMMU_UNBIND_MSI	(1 << 1)
+	__u64	iova;	/* MSI guest IOVA */
+	/* Fields below are used on BIND */
+	__u64	gpa;	/* MSI guest physical address */
+	__u64	size;	/* size of stage1 mapping (bytes) */
+};
+#define VFIO_IOMMU_SET_MSI_BINDING      _IO(VFIO_TYPE, VFIO_BASE + 24)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU --------=
 */
=20
 /*
--=20
2.20.1


