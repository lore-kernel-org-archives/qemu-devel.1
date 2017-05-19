Received: from eggs.gnu.org ([2001:4830:134:3::10]:41556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBfa3-00056b-GP
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBfa0-0008UO-8V
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:56:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dBfZz-0008TF-SE
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:56:20 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JAnBpI138391
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:56:18 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahrwn0jsj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:56:18 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 19 May 2017 11:56:15 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 19 May 2017 12:55:48 +0200
In-Reply-To: <20170519105600.11589-1-cornelia.huck@de.ibm.com>
References: <20170519105600.11589-1-cornelia.huck@de.ibm.com>
Message-Id: <20170519105600.11589-10-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 09/21] linux-headers: update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Cornelia Huck <cornelia.huck@de.ibm.com>

Update against Linux v4.12-rc1.

Also include the new vfio_ccw.h header.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 include/standard-headers/asm-x86/hyperv.h          |  7 +++++-
 include/standard-headers/linux/input-event-codes.h |  1 +
 include/standard-headers/linux/input.h             | 11 +++++---
 include/standard-headers/linux/pci_regs.h          |  3 ++-
 linux-headers/asm-arm/kvm.h                        | 10 +++++++-
 linux-headers/asm-arm/unistd-common.h              |  1 +
 linux-headers/asm-arm64/kvm.h                      | 10 +++++++-
 linux-headers/asm-powerpc/kvm.h                    |  3 +++
 linux-headers/asm-powerpc/unistd.h                 |  1 +
 linux-headers/asm-s390/kvm.h                       | 29 +++++++++++++++++++---
 linux-headers/asm-s390/unistd.h                    |  4 ++-
 linux-headers/asm-x86/kvm.h                        |  3 +++
 linux-headers/asm-x86/unistd_32.h                  |  2 ++
 linux-headers/asm-x86/unistd_64.h                  |  1 +
 linux-headers/asm-x86/unistd_x32.h                 |  1 +
 linux-headers/linux/kvm.h                          | 25 +++++++++++++++++++
 linux-headers/linux/userfaultfd.h                  | 11 +++++---
 linux-headers/linux/vfio.h                         | 18 ++++++++++++++
 linux-headers/linux/vfio_ccw.h                     | 24 ++++++++++++++++++
 scripts/update-linux-headers.sh                    |  2 +-
 20 files changed, 151 insertions(+), 16 deletions(-)
 create mode 100644 linux-headers/linux/vfio_ccw.h

diff --git a/include/standard-headers/asm-x86/hyperv.h b/include/standard-headers/asm-x86/hyperv.h
index eca9a2ca22..d0c6e0a079 100644
--- a/include/standard-headers/asm-x86/hyperv.h
+++ b/include/standard-headers/asm-x86/hyperv.h
@@ -124,7 +124,7 @@
   * Recommend using hypercall for address space switches rather
   * than MOV to CR3 instruction
   */
-#define HV_X64_MWAIT_RECOMMENDED		(1 << 0)
+#define HV_X64_AS_SWITCH_RECOMMENDED		(1 << 0)
 /* Recommend using hypercall for local TLB flushes rather
  * than INVLPG or MOV to CR3 instructions */
 #define HV_X64_LOCAL_TLB_FLUSH_RECOMMENDED	(1 << 1)
@@ -148,6 +148,11 @@
 #define HV_X64_RELAXED_TIMING_RECOMMENDED	(1 << 5)
 
 /*
+ * Virtual APIC support
+ */
+#define HV_X64_DEPRECATING_AEOI_RECOMMENDED	(1 << 9)
+
+/*
  * Crash notification flag.
  */
 #define HV_CRASH_CTL_CRASH_NOTIFY (1ULL << 63)
diff --git a/include/standard-headers/linux/input-event-codes.h b/include/standard-headers/linux/input-event-codes.h
index c8b3338375..29d463af37 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -641,6 +641,7 @@
  * e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)
  */
 #define KEY_DATA			0x277
+#define KEY_ONSCREEN_KEYBOARD		0x278
 
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
diff --git a/include/standard-headers/linux/input.h b/include/standard-headers/linux/input.h
index b472b8530c..666e201ddb 100644
--- a/include/standard-headers/linux/input.h
+++ b/include/standard-headers/linux/input.h
@@ -58,9 +58,14 @@ struct input_id {
  * Note that input core does not clamp reported values to the
  * [minimum, maximum] limits, such task is left to userspace.
  *
- * Resolution for main axes (ABS_X, ABS_Y, ABS_Z) is reported in
- * units per millimeter (units/mm), resolution for rotational axes
- * (ABS_RX, ABS_RY, ABS_RZ) is reported in units per radian.
+ * The default resolution for main axes (ABS_X, ABS_Y, ABS_Z)
+ * is reported in units per millimeter (units/mm), resolution
+ * for rotational axes (ABS_RX, ABS_RY, ABS_RZ) is reported
+ * in units per radian.
+ * When INPUT_PROP_ACCELEROMETER is set the resolution changes.
+ * The main axes (ABS_X, ABS_Y, ABS_Z) are then reported in
+ * in units per g (units/g) and in units per degree per second
+ * (units/deg/s) for rotational axes (ABS_RX, ABS_RY, ABS_RZ).
  */
 struct input_absinfo {
 	int32_t value;
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index 634c9c44ed..d56bb00510 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -114,7 +114,7 @@
 #define PCI_SUBSYSTEM_ID	0x2e
 #define PCI_ROM_ADDRESS		0x30	/* Bits 31..11 are address, 10..1 reserved */
 #define  PCI_ROM_ADDRESS_ENABLE	0x01
-#define PCI_ROM_ADDRESS_MASK	(~0x7ffUL)
+#define PCI_ROM_ADDRESS_MASK	(~0x7ffU)
 
 #define PCI_CAPABILITY_LIST	0x34	/* Offset of first capability list entry */
 
@@ -630,6 +630,7 @@
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_ARI		0x0020	/* Alternative Routing-ID */
 #define PCI_EXP_DEVCTL2_ATOMIC_REQ	0x0040	/* Set Atomic requests */
+#define PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK 0x0080 /* Block atomic egress */
 #define  PCI_EXP_DEVCTL2_IDO_REQ_EN	0x0100	/* Allow IDO for requests */
 #define  PCI_EXP_DEVCTL2_IDO_CMP_EN	0x0200	/* Allow IDO for completions */
 #define  PCI_EXP_DEVCTL2_LTR_EN		0x0400	/* Enable LTR mechanism */
diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
index 1101d55d2f..7258a00225 100644
--- a/linux-headers/asm-arm/kvm.h
+++ b/linux-headers/asm-arm/kvm.h
@@ -27,6 +27,8 @@
 #define __KVM_HAVE_IRQ_LINE
 #define __KVM_HAVE_READONLY_MEM
 
+#define KVM_COALESCED_MMIO_PAGE_OFFSET 1
+
 #define KVM_REG_SIZE(id)						\
 	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
 
@@ -114,6 +116,8 @@ struct kvm_debug_exit_arch {
 };
 
 struct kvm_sync_regs {
+	/* Used with KVM_CAP_ARM_USER_IRQ */
+	__u64 device_irq_level;
 };
 
 struct kvm_arch_memory_slot {
@@ -192,13 +196,17 @@ struct kvm_arch_memory_slot {
 #define KVM_DEV_ARM_VGIC_GRP_REDIST_REGS 5
 #define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
 #define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
+#define KVM_DEV_ARM_VGIC_GRP_ITS_REGS	8
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
 			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK 0x3ff
 #define VGIC_LEVEL_INFO_LINE_LEVEL	0
 
-#define   KVM_DEV_ARM_VGIC_CTRL_INIT    0
+#define   KVM_DEV_ARM_VGIC_CTRL_INIT		0
+#define   KVM_DEV_ARM_ITS_SAVE_TABLES		1
+#define   KVM_DEV_ARM_ITS_RESTORE_TABLES	2
+#define   KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES	3
 
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_TYPE_SHIFT		24
diff --git a/linux-headers/asm-arm/unistd-common.h b/linux-headers/asm-arm/unistd-common.h
index 13a74afd02..8d5ceaee1a 100644
--- a/linux-headers/asm-arm/unistd-common.h
+++ b/linux-headers/asm-arm/unistd-common.h
@@ -353,5 +353,6 @@
 #define __NR_pkey_mprotect (__NR_SYSCALL_BASE + 394)
 #define __NR_pkey_alloc (__NR_SYSCALL_BASE + 395)
 #define __NR_pkey_free (__NR_SYSCALL_BASE + 396)
+#define __NR_statx (__NR_SYSCALL_BASE + 397)
 
 #endif /* _ASM_ARM_UNISTD_COMMON_H */
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 651ec30040..31bb1dd924 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -39,6 +39,8 @@
 #define __KVM_HAVE_IRQ_LINE
 #define __KVM_HAVE_READONLY_MEM
 
+#define KVM_COALESCED_MMIO_PAGE_OFFSET 1
+
 #define KVM_REG_SIZE(id)						\
 	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
 
@@ -143,6 +145,8 @@ struct kvm_debug_exit_arch {
 #define KVM_GUESTDBG_USE_HW		(1 << 17)
 
 struct kvm_sync_regs {
+	/* Used with KVM_CAP_ARM_USER_IRQ */
+	__u64 device_irq_level;
 };
 
 struct kvm_arch_memory_slot {
@@ -212,13 +216,17 @@ struct kvm_arch_memory_slot {
 #define KVM_DEV_ARM_VGIC_GRP_REDIST_REGS 5
 #define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
 #define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
+#define KVM_DEV_ARM_VGIC_GRP_ITS_REGS 8
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
 			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK	0x3ff
 #define VGIC_LEVEL_INFO_LINE_LEVEL	0
 
-#define   KVM_DEV_ARM_VGIC_CTRL_INIT	0
+#define   KVM_DEV_ARM_VGIC_CTRL_INIT		0
+#define   KVM_DEV_ARM_ITS_SAVE_TABLES           1
+#define   KVM_DEV_ARM_ITS_RESTORE_TABLES        2
+#define   KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES	3
 
 /* Device Control API on vcpu fd */
 #define KVM_ARM_VCPU_PMU_V3_CTRL	0
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 4edbe4bb0e..07fbeb9278 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -29,6 +29,9 @@
 #define __KVM_HAVE_IRQ_LINE
 #define __KVM_HAVE_GUEST_DEBUG
 
+/* Not always available, but if it is, this is the correct offset.  */
+#define KVM_COALESCED_MMIO_PAGE_OFFSET 1
+
 struct kvm_regs {
 	__u64 pc;
 	__u64 cr;
diff --git a/linux-headers/asm-powerpc/unistd.h b/linux-headers/asm-powerpc/unistd.h
index 598043c7b6..a1786340e9 100644
--- a/linux-headers/asm-powerpc/unistd.h
+++ b/linux-headers/asm-powerpc/unistd.h
@@ -393,5 +393,6 @@
 #define __NR_preadv2		380
 #define __NR_pwritev2		381
 #define __NR_kexec_file_load	382
+#define __NR_statx		383
 
 #endif /* _ASM_POWERPC_UNISTD_H_ */
diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index ac63ca630b..243f195776 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -26,6 +26,8 @@
 #define KVM_DEV_FLIC_ADAPTER_REGISTER	6
 #define KVM_DEV_FLIC_ADAPTER_MODIFY	7
 #define KVM_DEV_FLIC_CLEAR_IO_IRQ	8
+#define KVM_DEV_FLIC_AISM		9
+#define KVM_DEV_FLIC_AIRQ_INJECT	10
 /*
  * We can have up to 4*64k pending subchannels + 8 adapter interrupts,
  * as well as up  to ASYNC_PF_PER_VCPU*KVM_MAX_VCPUS pfault done interrupts.
@@ -41,7 +43,14 @@ struct kvm_s390_io_adapter {
 	__u8 isc;
 	__u8 maskable;
 	__u8 swap;
-	__u8 pad;
+	__u8 flags;
+};
+
+#define KVM_S390_ADAPTER_SUPPRESSIBLE 0x01
+
+struct kvm_s390_ais_req {
+	__u8 isc;
+	__u16 mode;
 };
 
 #define KVM_S390_IO_ADAPTER_MASK 1
@@ -110,6 +119,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_CMMA	10
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
+#define KVM_S390_VM_CPU_FEAT_KSS	13
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
@@ -131,7 +141,8 @@ struct kvm_s390_vm_cpu_subfunc {
 	__u8 kmo[16];		/* with MSA4 */
 	__u8 pcc[16];		/* with MSA4 */
 	__u8 ppno[16];		/* with MSA5 */
-	__u8 reserved[1824];
+	__u8 kma[16];		/* with MSA8 */
+	__u8 reserved[1808];
 };
 
 /* kvm attributes for crypto */
@@ -197,6 +208,10 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_VRS    (1UL << 6)
 #define KVM_SYNC_RICCB  (1UL << 7)
 #define KVM_SYNC_FPRS   (1UL << 8)
+#define KVM_SYNC_GSCB   (1UL << 9)
+/* length and alignment of the sdnx as a power of two */
+#define SDNXC 8
+#define SDNXL (1UL << SDNXC)
 /* definition of registers in kvm_run */
 struct kvm_sync_regs {
 	__u64 prefix;	/* prefix register */
@@ -217,8 +232,16 @@ struct kvm_sync_regs {
 	};
 	__u8  reserved[512];	/* for future vector expansion */
 	__u32 fpc;		/* valid on KVM_SYNC_VRS or KVM_SYNC_FPRS */
-	__u8 padding[52];	/* riccb needs to be 64byte aligned */
+	__u8 padding1[52];	/* riccb needs to be 64byte aligned */
 	__u8 riccb[64];		/* runtime instrumentation controls block */
+	__u8 padding2[192];	/* sdnx needs to be 256byte aligned */
+	union {
+		__u8 sdnx[SDNXL];  /* state description annex */
+		struct {
+			__u64 reserved1[2];
+			__u64 gscb[4];
+		};
+	};
 };
 
 #define KVM_REG_S390_TODPR	(KVM_REG_S390 | KVM_REG_SIZE_U32 | 0x1)
diff --git a/linux-headers/asm-s390/unistd.h b/linux-headers/asm-s390/unistd.h
index 8a404fd3a1..65e7e59dbb 100644
--- a/linux-headers/asm-s390/unistd.h
+++ b/linux-headers/asm-s390/unistd.h
@@ -313,7 +313,9 @@
 #define __NR_copy_file_range	375
 #define __NR_preadv2		376
 #define __NR_pwritev2		377
-#define NR_syscalls 378
+#define __NR_s390_guarded_storage	378
+#define __NR_statx		379
+#define NR_syscalls 380
 
 /* 
  * There are some system calls that are not present on 64 bit, some
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 739c0c5940..c2824d02ba 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -9,6 +9,9 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
+#define KVM_PIO_PAGE_OFFSET 1
+#define KVM_COALESCED_MMIO_PAGE_OFFSET 2
+
 #define DE_VECTOR 0
 #define DB_VECTOR 1
 #define BP_VECTOR 3
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
index d45ea28e15..8a206df454 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -380,5 +380,7 @@
 #define __NR_pkey_mprotect 380
 #define __NR_pkey_alloc 381
 #define __NR_pkey_free 382
+#define __NR_statx 383
+#define __NR_arch_prctl 384
 
 #endif /* _ASM_X86_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
index e22db9171e..336c2e4aaa 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -333,5 +333,6 @@
 #define __NR_pkey_mprotect 329
 #define __NR_pkey_alloc 330
 #define __NR_pkey_free 331
+#define __NR_statx 332
 
 #endif /* _ASM_X86_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index 84e58b202d..cb98a52998 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -286,6 +286,7 @@
 #define __NR_pkey_mprotect (__X32_SYSCALL_BIT + 329)
 #define __NR_pkey_alloc (__X32_SYSCALL_BIT + 330)
 #define __NR_pkey_free (__X32_SYSCALL_BIT + 331)
+#define __NR_statx (__X32_SYSCALL_BIT + 332)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 4e082a81b4..d2892da172 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -702,6 +702,10 @@ struct kvm_ppc_resize_hpt {
 #define KVM_VM_PPC_HV 1
 #define KVM_VM_PPC_PR 2
 
+/* on MIPS, 0 forces trap & emulate, 1 forces VZ ASE */
+#define KVM_VM_MIPS_TE		0
+#define KVM_VM_MIPS_VZ		1
+
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
 /*
@@ -883,6 +887,14 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_MMU_RADIX 134
 #define KVM_CAP_PPC_MMU_HASH_V3 135
 #define KVM_CAP_IMMEDIATE_EXIT 136
+#define KVM_CAP_MIPS_VZ 137
+#define KVM_CAP_MIPS_TE 138
+#define KVM_CAP_MIPS_64BIT 139
+#define KVM_CAP_S390_GS 140
+#define KVM_CAP_S390_AIS 141
+#define KVM_CAP_SPAPR_TCE_VFIO 142
+#define KVM_CAP_X86_GUEST_MWAIT 143
+#define KVM_CAP_ARM_USER_IRQ 144
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1087,6 +1099,7 @@ struct kvm_device_attr {
 #define  KVM_DEV_VFIO_GROUP			1
 #define   KVM_DEV_VFIO_GROUP_ADD			1
 #define   KVM_DEV_VFIO_GROUP_DEL			2
+#define   KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE		3
 
 enum kvm_device_type {
 	KVM_DEV_TYPE_FSL_MPIC_20	= 1,
@@ -1108,6 +1121,11 @@ enum kvm_device_type {
 	KVM_DEV_TYPE_MAX,
 };
 
+struct kvm_vfio_spapr_tce {
+	__s32	groupfd;
+	__s32	tablefd;
+};
+
 /*
  * ioctls for VM fds
  */
@@ -1354,4 +1372,11 @@ struct kvm_assigned_msix_entry {
 #define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
 #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
 
+/* Available with KVM_CAP_ARM_USER_IRQ */
+
+/* Bits for run->s.regs.device_irq_level */
+#define KVM_ARM_DEV_EL1_VTIMER		(1 << 0)
+#define KVM_ARM_DEV_EL1_PTIMER		(1 << 1)
+#define KVM_ARM_DEV_PMU			(1 << 2)
+
 #endif /* __LINUX_KVM_H */
diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
index 2ed5dc3775..9701772497 100644
--- a/linux-headers/linux/userfaultfd.h
+++ b/linux-headers/linux/userfaultfd.h
@@ -20,7 +20,8 @@
 #define UFFD_API ((__u64)0xAA)
 #define UFFD_API_FEATURES (UFFD_FEATURE_EVENT_FORK |		\
 			   UFFD_FEATURE_EVENT_REMAP |		\
-			   UFFD_FEATURE_EVENT_MADVDONTNEED |	\
+			   UFFD_FEATURE_EVENT_REMOVE |	\
+			   UFFD_FEATURE_EVENT_UNMAP |		\
 			   UFFD_FEATURE_MISSING_HUGETLBFS |	\
 			   UFFD_FEATURE_MISSING_SHMEM)
 #define UFFD_API_IOCTLS				\
@@ -92,7 +93,7 @@ struct uffd_msg {
 		struct {
 			__u64	start;
 			__u64	end;
-		} madv_dn;
+		} remove;
 
 		struct {
 			/* unused reserved fields */
@@ -109,7 +110,8 @@ struct uffd_msg {
 #define UFFD_EVENT_PAGEFAULT	0x12
 #define UFFD_EVENT_FORK		0x13
 #define UFFD_EVENT_REMAP	0x14
-#define UFFD_EVENT_MADVDONTNEED	0x15
+#define UFFD_EVENT_REMOVE	0x15
+#define UFFD_EVENT_UNMAP	0x16
 
 /* flags for UFFD_EVENT_PAGEFAULT */
 #define UFFD_PAGEFAULT_FLAG_WRITE	(1<<0)	/* If this was a write fault */
@@ -155,9 +157,10 @@ struct uffdio_api {
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
 #define UFFD_FEATURE_EVENT_REMAP		(1<<2)
-#define UFFD_FEATURE_EVENT_MADVDONTNEED		(1<<3)
+#define UFFD_FEATURE_EVENT_REMOVE		(1<<3)
 #define UFFD_FEATURE_MISSING_HUGETLBFS		(1<<4)
 #define UFFD_FEATURE_MISSING_SHMEM		(1<<5)
+#define UFFD_FEATURE_EVENT_UNMAP		(1<<6)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 531cb2eda9..4e7ab4c52a 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -198,6 +198,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
 #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
+#define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 };
@@ -212,6 +213,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_API_PCI_STRING		"vfio-pci"
 #define VFIO_DEVICE_API_PLATFORM_STRING		"vfio-platform"
 #define VFIO_DEVICE_API_AMBA_STRING		"vfio-amba"
+#define VFIO_DEVICE_API_CCW_STRING		"vfio-ccw"
 
 /**
  * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
@@ -446,6 +448,22 @@ enum {
 	VFIO_PCI_NUM_IRQS
 };
 
+/*
+ * The vfio-ccw bus driver makes use of the following fixed region and
+ * IRQ index mapping. Unimplemented regions return a size of zero.
+ * Unimplemented IRQ types return a count of zero.
+ */
+
+enum {
+	VFIO_CCW_CONFIG_REGION_INDEX,
+	VFIO_CCW_NUM_REGIONS
+};
+
+enum {
+	VFIO_CCW_IO_IRQ_INDEX,
+	VFIO_CCW_NUM_IRQS
+};
+
 /**
  * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IORW(VFIO_TYPE, VFIO_BASE + 12,
  *					      struct vfio_pci_hot_reset_info)
diff --git a/linux-headers/linux/vfio_ccw.h b/linux-headers/linux/vfio_ccw.h
new file mode 100644
index 0000000000..3a565511ab
--- /dev/null
+++ b/linux-headers/linux/vfio_ccw.h
@@ -0,0 +1,24 @@
+/*
+ * Interfaces for vfio-ccw
+ *
+ * Copyright IBM Corp. 2017
+ *
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ */
+
+#ifndef _VFIO_CCW_H_
+#define _VFIO_CCW_H_
+
+#include <linux/types.h>
+
+struct ccw_io_region {
+#define ORB_AREA_SIZE 12
+	__u8	orb_area[ORB_AREA_SIZE];
+#define SCSW_AREA_SIZE 12
+	__u8	scsw_area[SCSW_AREA_SIZE];
+#define IRB_AREA_SIZE 96
+	__u8	irb_area[IRB_AREA_SIZE];
+	__u32	ret_code;
+} __attribute__((packed));
+
+#endif
diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 6a370a8669..2f906c4d16 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -113,7 +113,7 @@ done
 
 rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
-for header in kvm.h kvm_para.h vfio.h vhost.h \
+for header in kvm.h kvm_para.h vfio.h vfio_ccw.h vhost.h \
               psci.h userfaultfd.h; do
     cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
 done
-- 
2.13.0
