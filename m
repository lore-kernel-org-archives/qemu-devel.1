Received: from eggs.gnu.org ([2001:4830:134:3::10]:44847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDL-0006Vv-6R
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHDG-0000zm-9N
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVHDF-0000yw-VJ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:57:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CCsXAe006433
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:52 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bncjb9uw1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:57:51 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 12 Jul 2017 13:57:49 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Jul 2017 14:57:36 +0200
In-Reply-To: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499864265-144136-3-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 02/11] linux-headers: update to 4.13-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

commit af3c8d98508d37541d4bf57f13a984a7f73a328c
    Merge tag 'drm-for-v4.13' of git://people.freedesktop.org/~airlied/linux

will be replaced with a header-sync against v4.13-rc1

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/standard-headers/asm-x86/hyperv.h          | 21 +++++++------
 include/standard-headers/linux/input-event-codes.h |  1 +
 include/standard-headers/linux/pci_regs.h          |  1 +
 linux-headers/asm-arm/kvm.h                        |  8 +++++
 linux-headers/asm-arm64/kvm.h                      |  3 ++
 linux-headers/asm-powerpc/kvm.h                    |  6 ++++
 linux-headers/asm-s390/kvm.h                       | 12 ++++++++
 linux-headers/linux/kvm.h                          | 35 ++++++++++++++++++++++
 8 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/include/standard-headers/asm-x86/hyperv.h b/include/standard-headers/asm-x86/hyperv.h
index d0c6e0a..fac7651 100644
--- a/include/standard-headers/asm-x86/hyperv.h
+++ b/include/standard-headers/asm-x86/hyperv.h
@@ -34,16 +34,10 @@
 #define HV_X64_MSR_REFERENCE_TSC		0x40000021
 
 /*
- * There is a single feature flag that signifies the presence of the MSR
- * that can be used to retrieve both the local APIC Timer frequency as
- * well as the TSC frequency.
+ * There is a single feature flag that signifies if the partition has access
+ * to MSRs with local APIC and TSC frequencies.
  */
-
-/* Local APIC timer frequency MSR (HV_X64_MSR_APIC_FREQUENCY) is available */
-#define HV_X64_MSR_APIC_FREQUENCY_AVAILABLE (1 << 11)
-
-/* TSC frequency MSR (HV_X64_MSR_TSC_FREQUENCY) is available */
-#define HV_X64_MSR_TSC_FREQUENCY_AVAILABLE (1 << 11)
+#define HV_X64_ACCESS_FREQUENCY_MSRS		(1 << 11)
 
 /*
  * Basic SynIC MSRs (HV_X64_MSR_SCONTROL through HV_X64_MSR_EOM
@@ -73,6 +67,9 @@
   */
 #define HV_X64_MSR_STAT_PAGES_AVAILABLE		(1 << 8)
 
+/* Frequency MSRs available */
+#define HV_FEATURE_FREQUENCY_MSRS_AVAILABLE	(1 << 8)
+
 /* Crash MSR available */
 #define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE (1 << 10)
 
@@ -153,6 +150,12 @@
 #define HV_X64_DEPRECATING_AEOI_RECOMMENDED	(1 << 9)
 
 /*
+ * HV_VP_SET available
+ */
+#define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED	(1 << 11)
+
+
+/*
  * Crash notification flag.
  */
 #define HV_CRASH_CTL_CRASH_NOTIFY (1ULL << 63)
diff --git a/include/standard-headers/linux/input-event-codes.h b/include/standard-headers/linux/input-event-codes.h
index 29d463a..2fa0f4e 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -600,6 +600,7 @@
 #define KEY_APPSELECT		0x244	/* AL Select Task/Application */
 #define KEY_SCREENSAVER		0x245	/* AL Screen Saver */
 #define KEY_VOICECOMMAND		0x246	/* Listening Voice Command */
+#define KEY_ASSISTANT		0x247	/* AL Context-aware desktop assistant */
 
 #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
 #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index d56bb00..c22d3eb 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -517,6 +517,7 @@
 #define  PCI_EXP_LNKCAP_SLS	0x0000000f /* Supported Link Speeds */
 #define  PCI_EXP_LNKCAP_SLS_2_5GB 0x00000001 /* LNKCAP2 SLS Vector bit 0 */
 #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
+#define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
 #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
index 7258a00..fa9fae8 100644
--- a/linux-headers/asm-arm/kvm.h
+++ b/linux-headers/asm-arm/kvm.h
@@ -203,6 +203,14 @@ struct kvm_arch_memory_slot {
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK 0x3ff
 #define VGIC_LEVEL_INFO_LINE_LEVEL	0
 
+/* Device Control API on vcpu fd */
+#define KVM_ARM_VCPU_PMU_V3_CTRL	0
+#define   KVM_ARM_VCPU_PMU_V3_IRQ	0
+#define   KVM_ARM_VCPU_PMU_V3_INIT	1
+#define KVM_ARM_VCPU_TIMER_CTRL		1
+#define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
+#define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
+
 #define   KVM_DEV_ARM_VGIC_CTRL_INIT		0
 #define   KVM_DEV_ARM_ITS_SAVE_TABLES		1
 #define   KVM_DEV_ARM_ITS_RESTORE_TABLES	2
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 31bb1dd..d254700 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -232,6 +232,9 @@ struct kvm_arch_memory_slot {
 #define KVM_ARM_VCPU_PMU_V3_CTRL	0
 #define   KVM_ARM_VCPU_PMU_V3_IRQ	0
 #define   KVM_ARM_VCPU_PMU_V3_INIT	1
+#define KVM_ARM_VCPU_TIMER_CTRL		1
+#define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
+#define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
 
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_TYPE_SHIFT		24
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 07fbeb9..8cf8f0c 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -60,6 +60,12 @@ struct kvm_regs {
 
 #define KVM_SREGS_E_FSL_PIDn	(1 << 0) /* PID1/PID2 */
 
+/* flags for kvm_run.flags */
+#define KVM_RUN_PPC_NMI_DISP_MASK		(3 << 0)
+#define   KVM_RUN_PPC_NMI_DISP_FULLY_RECOV	(1 << 0)
+#define   KVM_RUN_PPC_NMI_DISP_LIMITED_RECOV	(2 << 0)
+#define   KVM_RUN_PPC_NMI_DISP_NOT_RECOV	(3 << 0)
+
 /*
  * Feature bits indicate which sections of the sregs struct are valid,
  * both in KVM_GET_SREGS and KVM_SET_SREGS.  On KVM_SET_SREGS, registers
diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 243f195..8387d71 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -28,6 +28,7 @@
 #define KVM_DEV_FLIC_CLEAR_IO_IRQ	8
 #define KVM_DEV_FLIC_AISM		9
 #define KVM_DEV_FLIC_AIRQ_INJECT	10
+#define KVM_DEV_FLIC_AISM_ALL		11
 /*
  * We can have up to 4*64k pending subchannels + 8 adapter interrupts,
  * as well as up  to ASYNC_PF_PER_VCPU*KVM_MAX_VCPUS pfault done interrupts.
@@ -53,6 +54,11 @@ struct kvm_s390_ais_req {
 	__u16 mode;
 };
 
+struct kvm_s390_ais_all {
+	__u8 simm;
+	__u8 nimm;
+};
+
 #define KVM_S390_IO_ADAPTER_MASK 1
 #define KVM_S390_IO_ADAPTER_MAP 2
 #define KVM_S390_IO_ADAPTER_UNMAP 3
@@ -70,6 +76,7 @@ struct kvm_s390_io_adapter_req {
 #define KVM_S390_VM_TOD			1
 #define KVM_S390_VM_CRYPTO		2
 #define KVM_S390_VM_CPU_MODEL		3
+#define KVM_S390_VM_MIGRATION		4
 
 /* kvm attributes for mem_ctrl */
 #define KVM_S390_VM_MEM_ENABLE_CMMA	0
@@ -151,6 +158,11 @@ struct kvm_s390_vm_cpu_subfunc {
 #define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
 #define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
 
+/* kvm attributes for migration mode */
+#define KVM_S390_VM_MIGRATION_STOP	0
+#define KVM_S390_VM_MIGRATION_START	1
+#define KVM_S390_VM_MIGRATION_STATUS	2
+
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 	/* general purpose regs for s390 */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index d2892da..43e2d82 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -155,6 +155,35 @@ struct kvm_s390_skeys {
 	__u32 reserved[9];
 };
 
+#define KVM_S390_CMMA_PEEK (1 << 0)
+
+/**
+ * kvm_s390_cmma_log - Used for CMMA migration.
+ *
+ * Used both for input and output.
+ *
+ * @start_gfn: Guest page number to start from.
+ * @count: Size of the result buffer.
+ * @flags: Control operation mode via KVM_S390_CMMA_* flags
+ * @remaining: Used with KVM_S390_GET_CMMA_BITS. Indicates how many dirty
+ *             pages are still remaining.
+ * @mask: Used with KVM_S390_SET_CMMA_BITS. Bitmap of bits to actually set
+ *        in the PGSTE.
+ * @values: Pointer to the values buffer.
+ *
+ * Used in KVM_S390_{G,S}ET_CMMA_BITS ioctls.
+ */
+struct kvm_s390_cmma_log {
+	__u64 start_gfn;
+	__u32 count;
+	__u32 flags;
+	union {
+		__u64 remaining;
+		__u64 mask;
+	};
+	__u64 values;
+};
+
 struct kvm_hyperv_exit {
 #define KVM_EXIT_HYPERV_SYNIC          1
 #define KVM_EXIT_HYPERV_HCALL          2
@@ -895,6 +924,9 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_SPAPR_TCE_VFIO 142
 #define KVM_CAP_X86_GUEST_MWAIT 143
 #define KVM_CAP_ARM_USER_IRQ 144
+#define KVM_CAP_S390_CMMA_MIGRATION 145
+#define KVM_CAP_PPC_FWNMI 146
+#define KVM_CAP_PPC_SMT_POSSIBLE 147
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1318,6 +1350,9 @@ struct kvm_s390_ucas_mapping {
 #define KVM_S390_GET_IRQ_STATE	  _IOW(KVMIO, 0xb6, struct kvm_s390_irq_state)
 /* Available with KVM_CAP_X86_SMM */
 #define KVM_SMI                   _IO(KVMIO,   0xb7)
+/* Available with KVM_CAP_S390_CMMA_MIGRATION */
+#define KVM_S390_GET_CMMA_BITS      _IOW(KVMIO, 0xb8, struct kvm_s390_cmma_log)
+#define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_cmma_log)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
 #define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
-- 
2.7.4
