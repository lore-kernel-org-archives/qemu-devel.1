Received: from eggs.gnu.org ([2001:4830:134:3::10]:42304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBl-0002NJ-8r
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBh-0001BL-V2
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59090
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBh-0001As-Nu
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:21 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0jgUX079946
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:21 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm79050-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:20 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:20 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:43:55 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-2-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 01/67] linux-headers: update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Update headers against 4.8-rc2.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 include/standard-headers/linux/input-event-codes.h | 32 ++++++++
 include/standard-headers/linux/input.h             |  1 +
 include/standard-headers/linux/virtio_config.h     | 10 ++-
 include/standard-headers/linux/virtio_ids.h        |  1 +
 include/standard-headers/linux/virtio_net.h        |  3 +
 include/standard-headers/linux/virtio_vsock.h      | 94 ++++++++++++++++++++++
 linux-headers/asm-arm/kvm.h                        |  4 +-
 linux-headers/asm-arm64/kvm.h                      |  2 +
 linux-headers/asm-s390/kvm.h                       | 41 ++++++++++
 linux-headers/asm-x86/unistd_x32.h                 |  4 +-
 linux-headers/linux/kvm.h                          | 18 ++++-
 linux-headers/linux/vhost.h                        | 33 ++++++++
 12 files changed, 236 insertions(+), 7 deletions(-)
 create mode 100644 include/standard-headers/linux/virtio_vsock.h

diff --git a/include/standard-headers/linux/input-event-codes.h b/include/standard-headers/linux/input-event-codes.h
index 354f0de..5c10f7e 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -611,6 +611,37 @@
 #define KEY_KBDINPUTASSIST_ACCEPT		0x264
 #define KEY_KBDINPUTASSIST_CANCEL		0x265
 
+/* Diagonal movement keys */
+#define KEY_RIGHT_UP			0x266
+#define KEY_RIGHT_DOWN			0x267
+#define KEY_LEFT_UP			0x268
+#define KEY_LEFT_DOWN			0x269
+
+#define KEY_ROOT_MENU			0x26a /* Show Device's Root Menu */
+/* Show Top Menu of the Media (e.g. DVD) */
+#define KEY_MEDIA_TOP_MENU		0x26b
+#define KEY_NUMERIC_11			0x26c
+#define KEY_NUMERIC_12			0x26d
+/*
+ * Toggle Audio Description: refers to an audio service that helps blind and
+ * visually impaired consumers understand the action in a program. Note: in
+ * some countries this is referred to as "Video Description".
+ */
+#define KEY_AUDIO_DESC			0x26e
+#define KEY_3D_MODE			0x26f
+#define KEY_NEXT_FAVORITE		0x270
+#define KEY_STOP_RECORD			0x271
+#define KEY_PAUSE_RECORD		0x272
+#define KEY_VOD				0x273 /* Video on Demand */
+#define KEY_UNMUTE			0x274
+#define KEY_FASTREVERSE			0x275
+#define KEY_SLOWREVERSE			0x276
+/*
+ * Control a data application associated with the currently viewed channel,
+ * e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)
+ */
+#define KEY_DATA			0x275
+
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
 #define BTN_TRIGGER_HAPPY2		0x2c1
@@ -749,6 +780,7 @@
 #define SW_ROTATE_LOCK		0x0c  /* set = rotate locked/disabled */
 #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
 #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
+#define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
 #define SW_MAX_			0x0f
 #define SW_CNT			(SW_MAX_+1)
 
diff --git a/include/standard-headers/linux/input.h b/include/standard-headers/linux/input.h
index a52b202..7361a16 100644
--- a/include/standard-headers/linux/input.h
+++ b/include/standard-headers/linux/input.h
@@ -244,6 +244,7 @@ struct input_mask {
 #define BUS_ATARI		0x1B
 #define BUS_SPI			0x1C
 #define BUS_RMI			0x1D
+#define BUS_CEC			0x1E
 
 /*
  * MT_TOOL types
diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
index b30d0cb..b777069 100644
--- a/include/standard-headers/linux/virtio_config.h
+++ b/include/standard-headers/linux/virtio_config.h
@@ -49,7 +49,7 @@
  * transport being used (eg. virtio_ring), the rest are per-device feature
  * bits. */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		33
+#define VIRTIO_TRANSPORT_F_END		34
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -63,4 +63,12 @@
 /* v1.0 compliant. */
 #define VIRTIO_F_VERSION_1		32
 
+/*
+ * If clear - device has the IOMMU bypass quirk feature.
+ * If set - use platform tools to detect the IOMMU.
+ *
+ * Note the reverse polarity (compared to most other features),
+ * this is for compatibility with legacy systems.
+ */
+#define VIRTIO_F_IOMMU_PLATFORM		33
 #endif /* _LINUX_VIRTIO_CONFIG_H */
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 77925f5..3228d58 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -41,5 +41,6 @@
 #define VIRTIO_ID_CAIF	       12 /* Virtio caif */
 #define VIRTIO_ID_GPU          16 /* virtio GPU */
 #define VIRTIO_ID_INPUT        18 /* virtio input */
+#define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index a78f33e..30ff249 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -35,6 +35,7 @@
 #define VIRTIO_NET_F_CSUM	0	/* Host handles pkts w/ partial csum */
 #define VIRTIO_NET_F_GUEST_CSUM	1	/* Guest handles pkts w/ partial csum */
 #define VIRTIO_NET_F_CTRL_GUEST_OFFLOADS 2 /* Dynamic offload configuration. */
+#define VIRTIO_NET_F_MTU	3	/* Initial MTU advice */
 #define VIRTIO_NET_F_MAC	5	/* Host has given MAC address. */
 #define VIRTIO_NET_F_GUEST_TSO4	7	/* Guest can handle TSOv4 in. */
 #define VIRTIO_NET_F_GUEST_TSO6	8	/* Guest can handle TSOv6 in. */
@@ -73,6 +74,8 @@ struct virtio_net_config {
 	 * Legal values are between 1 and 0x8000
 	 */
 	uint16_t max_virtqueue_pairs;
+	/* Default maximum transmit unit advice */
+	uint16_t mtu;
 } QEMU_PACKED;
 
 /*
diff --git a/include/standard-headers/linux/virtio_vsock.h b/include/standard-headers/linux/virtio_vsock.h
new file mode 100644
index 0000000..be44321
--- /dev/null
+++ b/include/standard-headers/linux/virtio_vsock.h
@@ -0,0 +1,94 @@
+/*
+ * This header, excluding the #ifdef __KERNEL__ part, is BSD licensed so
+ * anyone can use the definitions to implement compatible drivers/servers:
+ *
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of IBM nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS''
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ *
+ * Copyright (C) Red Hat, Inc., 2013-2015
+ * Copyright (C) Asias He <asias@redhat.com>, 2013
+ * Copyright (C) Stefan Hajnoczi <stefanha@redhat.com>, 2015
+ */
+
+#ifndef _LINUX_VIRTIO_VSOCK_H
+#define _LINUX_VIRTIO_VSOCK_H
+
+#include "standard-headers/linux/types.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_config.h"
+
+struct virtio_vsock_config {
+	uint64_t guest_cid;
+} QEMU_PACKED;
+
+enum virtio_vsock_event_id {
+	VIRTIO_VSOCK_EVENT_TRANSPORT_RESET = 0,
+};
+
+struct virtio_vsock_event {
+	uint32_t id;
+} QEMU_PACKED;
+
+struct virtio_vsock_hdr {
+	uint64_t	src_cid;
+	uint64_t	dst_cid;
+	uint32_t	src_port;
+	uint32_t	dst_port;
+	uint32_t	len;
+	uint16_t	type;		/* enum virtio_vsock_type */
+	uint16_t	op;		/* enum virtio_vsock_op */
+	uint32_t	flags;
+	uint32_t	buf_alloc;
+	uint32_t	fwd_cnt;
+} QEMU_PACKED;
+
+enum virtio_vsock_type {
+	VIRTIO_VSOCK_TYPE_STREAM = 1,
+};
+
+enum virtio_vsock_op {
+	VIRTIO_VSOCK_OP_INVALID = 0,
+
+	/* Connect operations */
+	VIRTIO_VSOCK_OP_REQUEST = 1,
+	VIRTIO_VSOCK_OP_RESPONSE = 2,
+	VIRTIO_VSOCK_OP_RST = 3,
+	VIRTIO_VSOCK_OP_SHUTDOWN = 4,
+
+	/* To send payload */
+	VIRTIO_VSOCK_OP_RW = 5,
+
+	/* Tell the peer our credit info */
+	VIRTIO_VSOCK_OP_CREDIT_UPDATE = 6,
+	/* Request the peer to send the credit info to us */
+	VIRTIO_VSOCK_OP_CREDIT_REQUEST = 7,
+};
+
+/* VIRTIO_VSOCK_OP_SHUTDOWN flags values */
+enum virtio_vsock_shutdown {
+	VIRTIO_VSOCK_SHUTDOWN_RCV = 1,
+	VIRTIO_VSOCK_SHUTDOWN_SEND = 2,
+};
+
+#endif /* _LINUX_VIRTIO_VSOCK_H */
diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
index c98e4dc..541268c 100644
--- a/linux-headers/asm-arm/kvm.h
+++ b/linux-headers/asm-arm/kvm.h
@@ -139,8 +139,8 @@ struct kvm_arch_memory_slot {
 #define ARM_CP15_REG64(...) __ARM_CP15_REG64(__VA_ARGS__)
 
 #define KVM_REG_ARM_TIMER_CTL		ARM_CP15_REG32(0, 14, 3, 1)
-#define KVM_REG_ARM_TIMER_CNT		ARM_CP15_REG64(1, 14) 
-#define KVM_REG_ARM_TIMER_CVAL		ARM_CP15_REG64(3, 14) 
+#define KVM_REG_ARM_TIMER_CNT		ARM_CP15_REG64(1, 14)
+#define KVM_REG_ARM_TIMER_CVAL		ARM_CP15_REG64(3, 14)
 
 /* Normal registers are mapped as coprocessor 16. */
 #define KVM_REG_ARM_CORE		(0x0010 << KVM_REG_ARM_COPROC_SHIFT)
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 7d82d1f..fd5a276 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -87,9 +87,11 @@ struct kvm_regs {
 /* Supported VGICv3 address types  */
 #define KVM_VGIC_V3_ADDR_TYPE_DIST	2
 #define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
+#define KVM_VGIC_ITS_ADDR_TYPE		4
 
 #define KVM_VGIC_V3_DIST_SIZE		SZ_64K
 #define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
+#define KVM_VGIC_V3_ITS_SIZE		(2 * SZ_64K)
 
 #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
 #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 09ae5dc..ac63ca6 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -93,6 +93,47 @@ struct kvm_s390_vm_cpu_machine {
 	__u64 fac_list[256];
 };
 
+#define KVM_S390_VM_CPU_PROCESSOR_FEAT	2
+#define KVM_S390_VM_CPU_MACHINE_FEAT	3
+
+#define KVM_S390_VM_CPU_FEAT_NR_BITS	1024
+#define KVM_S390_VM_CPU_FEAT_ESOP	0
+#define KVM_S390_VM_CPU_FEAT_SIEF2	1
+#define KVM_S390_VM_CPU_FEAT_64BSCAO	2
+#define KVM_S390_VM_CPU_FEAT_SIIF	3
+#define KVM_S390_VM_CPU_FEAT_GPERE	4
+#define KVM_S390_VM_CPU_FEAT_GSLS	5
+#define KVM_S390_VM_CPU_FEAT_IB		6
+#define KVM_S390_VM_CPU_FEAT_CEI	7
+#define KVM_S390_VM_CPU_FEAT_IBS	8
+#define KVM_S390_VM_CPU_FEAT_SKEY	9
+#define KVM_S390_VM_CPU_FEAT_CMMA	10
+#define KVM_S390_VM_CPU_FEAT_PFMFI	11
+#define KVM_S390_VM_CPU_FEAT_SIGPIF	12
+struct kvm_s390_vm_cpu_feat {
+	__u64 feat[16];
+};
+
+#define KVM_S390_VM_CPU_PROCESSOR_SUBFUNC	4
+#define KVM_S390_VM_CPU_MACHINE_SUBFUNC		5
+/* for "test bit" instructions MSB 0 bit ordering, for "query" raw blocks */
+struct kvm_s390_vm_cpu_subfunc {
+	__u8 plo[32];		/* always */
+	__u8 ptff[16];		/* with TOD-clock steering */
+	__u8 kmac[16];		/* with MSA */
+	__u8 kmc[16];		/* with MSA */
+	__u8 km[16];		/* with MSA */
+	__u8 kimd[16];		/* with MSA */
+	__u8 klmd[16];		/* with MSA */
+	__u8 pckmo[16];		/* with MSA3 */
+	__u8 kmctr[16];		/* with MSA4 */
+	__u8 kmf[16];		/* with MSA4 */
+	__u8 kmo[16];		/* with MSA4 */
+	__u8 pcc[16];		/* with MSA4 */
+	__u8 ppno[16];		/* with MSA5 */
+	__u8 reserved[1824];
+};
+
 /* kvm attributes for crypto */
 #define KVM_S390_VM_CRYPTO_ENABLE_AES_KW	0
 #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index 0230779..e5aea76 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -306,9 +306,7 @@
 #define __NR_vmsplice (__X32_SYSCALL_BIT + 532)
 #define __NR_move_pages (__X32_SYSCALL_BIT + 533)
 #define __NR_preadv (__X32_SYSCALL_BIT + 534)
-#define __NR_preadv2 (__X32_SYSCALL_BIT + 534)
 #define __NR_pwritev (__X32_SYSCALL_BIT + 535)
-#define __NR_pwritev2 (__X32_SYSCALL_BIT + 535)
 #define __NR_rt_tgsigqueueinfo (__X32_SYSCALL_BIT + 536)
 #define __NR_recvmmsg (__X32_SYSCALL_BIT + 537)
 #define __NR_sendmmsg (__X32_SYSCALL_BIT + 538)
@@ -319,5 +317,7 @@
 #define __NR_io_setup (__X32_SYSCALL_BIT + 543)
 #define __NR_io_submit (__X32_SYSCALL_BIT + 544)
 #define __NR_execveat (__X32_SYSCALL_BIT + 545)
+#define __NR_preadv2 (__X32_SYSCALL_BIT + 546)
+#define __NR_pwritev2 (__X32_SYSCALL_BIT + 547)
 
 #endif /* _ASM_X86_UNISTD_X32_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index e60e21b..4806e06 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -866,6 +866,10 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_ARM_PMU_V3 126
 #define KVM_CAP_VCPU_ATTRIBUTES 127
 #define KVM_CAP_MAX_VCPU_ID 128
+#define KVM_CAP_X2APIC_API 129
+#define KVM_CAP_S390_USER_INSTR0 130
+#define KVM_CAP_MSI_DEVID 131
+#define KVM_CAP_PPC_HTM 132
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -878,7 +882,10 @@ struct kvm_irq_routing_msi {
 	__u32 address_lo;
 	__u32 address_hi;
 	__u32 data;
-	__u32 pad;
+	union {
+		__u32 pad;
+		__u32 devid;
+	};
 };
 
 struct kvm_irq_routing_s390_adapter {
@@ -1024,12 +1031,14 @@ struct kvm_one_reg {
 	__u64 addr;
 };
 
+#define KVM_MSI_VALID_DEVID	(1U << 0)
 struct kvm_msi {
 	__u32 address_lo;
 	__u32 address_hi;
 	__u32 data;
 	__u32 flags;
-	__u8  pad[16];
+	__u32 devid;
+	__u8  pad[12];
 };
 
 struct kvm_arm_device_addr {
@@ -1074,6 +1083,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_FLIC		KVM_DEV_TYPE_FLIC
 	KVM_DEV_TYPE_ARM_VGIC_V3,
 #define KVM_DEV_TYPE_ARM_VGIC_V3	KVM_DEV_TYPE_ARM_VGIC_V3
+	KVM_DEV_TYPE_ARM_VGIC_ITS,
+#define KVM_DEV_TYPE_ARM_VGIC_ITS	KVM_DEV_TYPE_ARM_VGIC_ITS
 	KVM_DEV_TYPE_MAX,
 };
 
@@ -1313,4 +1324,7 @@ struct kvm_assigned_msix_entry {
 	__u16 padding[3];
 };
 
+#define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
+#define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
+
 #endif /* __LINUX_KVM_H */
diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index 571294c..ac7a1f1 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -47,6 +47,32 @@ struct vhost_vring_addr {
 	__u64 log_guest_addr;
 };
 
+/* no alignment requirement */
+struct vhost_iotlb_msg {
+	__u64 iova;
+	__u64 size;
+	__u64 uaddr;
+#define VHOST_ACCESS_RO      0x1
+#define VHOST_ACCESS_WO      0x2
+#define VHOST_ACCESS_RW      0x3
+	__u8 perm;
+#define VHOST_IOTLB_MISS           1
+#define VHOST_IOTLB_UPDATE         2
+#define VHOST_IOTLB_INVALIDATE     3
+#define VHOST_IOTLB_ACCESS_FAIL    4
+	__u8 type;
+};
+
+#define VHOST_IOTLB_MSG 0x1
+
+struct vhost_msg {
+	int type;
+	union {
+		struct vhost_iotlb_msg iotlb;
+		__u8 padding[64];
+	};
+};
+
 struct vhost_memory_region {
 	__u64 guest_phys_addr;
 	__u64 memory_size; /* bytes */
@@ -146,6 +172,8 @@ struct vhost_memory {
 #define VHOST_F_LOG_ALL 26
 /* vhost-net should add virtio_net_hdr for RX, and strip for TX packets. */
 #define VHOST_NET_F_VIRTIO_NET_HDR 27
+/* Vhost have device IOTLB */
+#define VHOST_F_DEVICE_IOTLB 63
 
 /* VHOST_SCSI specific definitions */
 
@@ -175,4 +203,9 @@ struct vhost_scsi_target {
 #define VHOST_SCSI_SET_EVENTS_MISSED _IOW(VHOST_VIRTIO, 0x43, __u32)
 #define VHOST_SCSI_GET_EVENTS_MISSED _IOW(VHOST_VIRTIO, 0x44, __u32)
 
+/* VHOST_VSOCK specific defines */
+
+#define VHOST_VSOCK_SET_GUEST_CID	_IOW(VHOST_VIRTIO, 0x60, __u64)
+#define VHOST_VSOCK_SET_RUNNING		_IOW(VHOST_VIRTIO, 0x61, int)
+
 #endif
-- 
1.9.1
