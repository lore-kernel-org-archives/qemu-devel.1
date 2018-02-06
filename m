Received: from eggs.gnu.org ([2001:4830:134:3::10]:44161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iq-0005Po-Uj
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ik-00081d-W1
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8ik-00080y-K0
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:58 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JFAF4064833
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:57 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyhx2hbm0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:55 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:54 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:50 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-30-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 29/54] linux-headers: update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Cornelia Huck <cohuck@redhat.com>

From: Cornelia Huck <cohuck@redhat.com>

Update headers against 4.15-rc9.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit 9cbb636270b4df6f0a548e5c34b895330db5df8b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/standard-headers/asm-s390/virtio-ccw.h |  6 +-----
 linux-headers/asm-powerpc/kvm.h                | 25 +++++++++++++++++++++++++
 linux-headers/asm-s390/kvm.h                   |  9 ++++-----
 linux-headers/asm-s390/kvm_para.h              |  4 ----
 linux-headers/linux/kvm.h                      |  8 ++++++--
 5 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/include/standard-headers/asm-s390/virtio-ccw.h b/include/standard-headers/asm-s390/virtio-ccw.h
index 967aad3901..2b605f7e84 100644
--- a/include/standard-headers/asm-s390/virtio-ccw.h
+++ b/include/standard-headers/asm-s390/virtio-ccw.h
@@ -1,13 +1,9 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * Definitions for virtio-ccw devices.
  *
  * Copyright IBM Corp. 2013
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *  Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
  */
 #ifndef __KVM_VIRTIO_CCW_H
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 61d6049f4c..637b7263cb 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -443,6 +443,31 @@ struct kvm_ppc_rmmu_info {
 	__u32	ap_encodings[8];
 };
 
+/* For KVM_PPC_GET_CPU_CHAR */
+struct kvm_ppc_cpu_char {
+	__u64	character;		/* characteristics of the CPU */
+	__u64	behaviour;		/* recommended software behaviour */
+	__u64	character_mask;		/* valid bits in character */
+	__u64	behaviour_mask;		/* valid bits in behaviour */
+};
+
+/*
+ * Values for character and character_mask.
+ * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
+ */
+#define KVM_PPC_CPU_CHAR_SPEC_BAR_ORI31		(1ULL << 63)
+#define KVM_PPC_CPU_CHAR_BCCTRL_SERIALISED	(1ULL << 62)
+#define KVM_PPC_CPU_CHAR_L1D_FLUSH_ORI30	(1ULL << 61)
+#define KVM_PPC_CPU_CHAR_L1D_FLUSH_TRIG2	(1ULL << 60)
+#define KVM_PPC_CPU_CHAR_L1D_THREAD_PRIV	(1ULL << 59)
+#define KVM_PPC_CPU_CHAR_BR_HINT_HONOURED	(1ULL << 58)
+#define KVM_PPC_CPU_CHAR_MTTRIG_THR_RECONF	(1ULL << 57)
+#define KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS	(1ULL << 56)
+
+#define KVM_PPC_CPU_BEHAV_FAVOUR_SECURITY	(1ULL << 63)
+#define KVM_PPC_CPU_BEHAV_L1D_FLUSH_PR		(1ULL << 62)
+#define KVM_PPC_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ULL << 61)
+
 /* Per-vcpu XICS interrupt controller state */
 #define KVM_REG_PPC_ICP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x8c)
 
diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 32d372e977..11def14301 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -6,10 +6,6 @@
  *
  * Copyright IBM Corp. 2008
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
  */
@@ -228,6 +224,7 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_RICCB  (1UL << 7)
 #define KVM_SYNC_FPRS   (1UL << 8)
 #define KVM_SYNC_GSCB   (1UL << 9)
+#define KVM_SYNC_BPBC   (1UL << 10)
 /* length and alignment of the sdnx as a power of two */
 #define SDNXC 8
 #define SDNXL (1UL << SDNXC)
@@ -251,7 +248,9 @@ struct kvm_sync_regs {
 	};
 	__u8  reserved[512];	/* for future vector expansion */
 	__u32 fpc;		/* valid on KVM_SYNC_VRS or KVM_SYNC_FPRS */
-	__u8 padding1[52];	/* riccb needs to be 64byte aligned */
+	__u8 bpbc : 1;		/* bp mode */
+	__u8 reserved2 : 7;
+	__u8 padding1[51];	/* riccb needs to be 64byte aligned */
 	__u8 riccb[64];		/* runtime instrumentation controls block */
 	__u8 padding2[192];	/* sdnx needs to be 256byte aligned */
 	union {
diff --git a/linux-headers/asm-s390/kvm_para.h b/linux-headers/asm-s390/kvm_para.h
index 0dc86b3a7c..b9ab584adf 100644
--- a/linux-headers/asm-s390/kvm_para.h
+++ b/linux-headers/asm-s390/kvm_para.h
@@ -4,9 +4,5 @@
  *
  * Copyright IBM Corp. 2008
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License (version 2 only)
- * as published by the Free Software Foundation.
- *
  *    Author(s): Christian Borntraeger <borntraeger@de.ibm.com>
  */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index ce6c2f11f4..d92c9b2f0e 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -630,9 +630,9 @@ struct kvm_s390_irq {
 
 struct kvm_s390_irq_state {
 	__u64 buf;
-	__u32 flags;
+	__u32 flags;        /* will stay unused for compatibility reasons */
 	__u32 len;
-	__u32 reserved[4];
+	__u32 reserved[4];  /* will stay unused for compatibility reasons */
 };
 
 /* for KVM_SET_GUEST_DEBUG */
@@ -932,6 +932,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_SYNIC2 148
 #define KVM_CAP_HYPERV_VP_INDEX 149
 #define KVM_CAP_S390_AIS_MIGRATION 150
+#define KVM_CAP_PPC_GET_CPU_CHAR 151
+#define KVM_CAP_S390_BPB 152
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1261,6 +1263,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_PPC_CONFIGURE_V3_MMU  _IOW(KVMIO,  0xaf, struct kvm_ppc_mmuv3_cfg)
 /* Available with KVM_CAP_PPC_RADIX_MMU */
 #define KVM_PPC_GET_RMMU_INFO	  _IOW(KVMIO,  0xb0, struct kvm_ppc_rmmu_info)
+/* Available with KVM_CAP_PPC_GET_CPU_CHAR */
+#define KVM_PPC_GET_CPU_CHAR	  _IOR(KVMIO,  0xb1, struct kvm_ppc_cpu_char)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.11.0
