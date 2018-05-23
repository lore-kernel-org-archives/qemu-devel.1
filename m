Received: from eggs.gnu.org ([2001:4830:134:3::10]:48852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyn-0001iF-7j
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyl-0000mY-0T
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLUyk-0000mQ-Pw
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:02 -0400
Date: Wed, 23 May 2018 17:43:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-9-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 08/28] linux-headers: drop kvm_para.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Unused now and can be removed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 linux-headers/asm-arm/kvm_para.h         |   2 -
 linux-headers/asm-arm64/kvm_para.h       |   1 -
 linux-headers/asm-generic/kvm_para.h     |   4 --
 linux-headers/asm-mips/kvm_para.h        |   5 --
 linux-headers/asm-powerpc/epapr_hcalls.h |  99 --------------------------
 linux-headers/asm-powerpc/kvm_para.h     |  98 -------------------------
 linux-headers/asm-s390/kvm_para.h        |   8 ---
 linux-headers/asm-x86/kvm_para.h         | 118 -------------------------------
 linux-headers/linux/kvm_para.h           |  35 ---------
 9 files changed, 370 deletions(-)
 delete mode 100644 linux-headers/asm-arm/kvm_para.h
 delete mode 100644 linux-headers/asm-arm64/kvm_para.h
 delete mode 100644 linux-headers/asm-generic/kvm_para.h
 delete mode 100644 linux-headers/asm-mips/kvm_para.h
 delete mode 100644 linux-headers/asm-powerpc/epapr_hcalls.h
 delete mode 100644 linux-headers/asm-powerpc/kvm_para.h
 delete mode 100644 linux-headers/asm-s390/kvm_para.h
 delete mode 100644 linux-headers/asm-x86/kvm_para.h
 delete mode 100644 linux-headers/linux/kvm_para.h

diff --git a/linux-headers/asm-arm/kvm_para.h b/linux-headers/asm-arm/kvm_para.h
deleted file mode 100644
index baacc49..0000000
--- a/linux-headers/asm-arm/kvm_para.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/kvm_para.h>
diff --git a/linux-headers/asm-arm64/kvm_para.h b/linux-headers/asm-arm64/kvm_para.h
deleted file mode 100644
index 14fab8f..0000000
--- a/linux-headers/asm-arm64/kvm_para.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/kvm_para.h>
diff --git a/linux-headers/asm-generic/kvm_para.h b/linux-headers/asm-generic/kvm_para.h
deleted file mode 100644
index 486f0af..0000000
--- a/linux-headers/asm-generic/kvm_para.h
+++ /dev/null
@@ -1,4 +0,0 @@
-/*
- * There isn't anything here, but the file must not be empty or patch
- * will delete it.
- */
diff --git a/linux-headers/asm-mips/kvm_para.h b/linux-headers/asm-mips/kvm_para.h
deleted file mode 100644
index dbb2464..0000000
--- a/linux-headers/asm-mips/kvm_para.h
+++ /dev/null
@@ -1,5 +0,0 @@
-#ifndef _ASM_MIPS_KVM_PARA_H
-#define _ASM_MIPS_KVM_PARA_H
-
-
-#endif /* _ASM_MIPS_KVM_PARA_H */
diff --git a/linux-headers/asm-powerpc/epapr_hcalls.h b/linux-headers/asm-powerpc/epapr_hcalls.h
deleted file mode 100644
index 6cca559..0000000
--- a/linux-headers/asm-powerpc/epapr_hcalls.h
+++ /dev/null
@@ -1,99 +0,0 @@
-/* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) */
-/*
- * ePAPR hcall interface
- *
- * Copyright 2008-2011 Freescale Semiconductor, Inc.
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * This file is provided under a dual BSD/GPL license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#ifndef _ASM_POWERPC_EPAPR_HCALLS_H
-#define _ASM_POWERPC_EPAPR_HCALLS_H
-
-#define EV_BYTE_CHANNEL_SEND		1
-#define EV_BYTE_CHANNEL_RECEIVE		2
-#define EV_BYTE_CHANNEL_POLL		3
-#define EV_INT_SET_CONFIG		4
-#define EV_INT_GET_CONFIG		5
-#define EV_INT_SET_MASK			6
-#define EV_INT_GET_MASK			7
-#define EV_INT_IACK			9
-#define EV_INT_EOI			10
-#define EV_INT_SEND_IPI			11
-#define EV_INT_SET_TASK_PRIORITY	12
-#define EV_INT_GET_TASK_PRIORITY	13
-#define EV_DOORBELL_SEND		14
-#define EV_MSGSND			15
-#define EV_IDLE				16
-
-/* vendor ID: epapr */
-#define EV_LOCAL_VENDOR_ID		0	/* for private use */
-#define EV_EPAPR_VENDOR_ID		1
-#define EV_FSL_VENDOR_ID		2	/* Freescale Semiconductor */
-#define EV_IBM_VENDOR_ID		3	/* IBM */
-#define EV_GHS_VENDOR_ID		4	/* Green Hills Software */
-#define EV_ENEA_VENDOR_ID		5	/* Enea */
-#define EV_WR_VENDOR_ID			6	/* Wind River Systems */
-#define EV_AMCC_VENDOR_ID		7	/* Applied Micro Circuits */
-#define EV_KVM_VENDOR_ID		42	/* KVM */
-
-/* The max number of bytes that a byte channel can send or receive per call */
-#define EV_BYTE_CHANNEL_MAX_BYTES	16
-
-
-#define _EV_HCALL_TOKEN(id, num) (((id) << 16) | (num))
-#define EV_HCALL_TOKEN(hcall_num) _EV_HCALL_TOKEN(EV_EPAPR_VENDOR_ID, hcall_num)
-
-/* epapr return codes */
-#define EV_SUCCESS		0
-#define EV_EPERM		1	/* Operation not permitted */
-#define EV_ENOENT		2	/*  Entry Not Found */
-#define EV_EIO			3	/* I/O error occurred */
-#define EV_EAGAIN		4	/* The operation had insufficient
-					 * resources to complete and should be
-					 * retried
-					 */
-#define EV_ENOMEM		5	/* There was insufficient memory to
-					 * complete the operation */
-#define EV_EFAULT		6	/* Bad guest address */
-#define EV_ENODEV		7	/* No such device */
-#define EV_EINVAL		8	/* An argument supplied to the hcall
-					   was out of range or invalid */
-#define EV_INTERNAL		9	/* An internal error occurred */
-#define EV_CONFIG		10	/* A configuration error was detected */
-#define EV_INVALID_STATE	11	/* The object is in an invalid state */
-#define EV_UNIMPLEMENTED	12	/* Unimplemented hypercall */
-#define EV_BUFFER_OVERFLOW	13	/* Caller-supplied buffer too small */
-
-#endif /* _ASM_POWERPC_EPAPR_HCALLS_H */
diff --git a/linux-headers/asm-powerpc/kvm_para.h b/linux-headers/asm-powerpc/kvm_para.h
deleted file mode 100644
index 9beb49c..0000000
--- a/linux-headers/asm-powerpc/kvm_para.h
+++ /dev/null
@@ -1,98 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
- *
- * Copyright IBM Corp. 2008
- *
- * Authors: Hollis Blanchard <hollisb@us.ibm.com>
- */
-
-#ifndef __POWERPC_KVM_PARA_H__
-#define __POWERPC_KVM_PARA_H__
-
-#include <linux/types.h>
-
-/*
- * Additions to this struct must only occur at the end, and should be
- * accompanied by a KVM_MAGIC_FEAT flag to advertise that they are present
- * (albeit not necessarily relevant to the current target hardware platform).
- *
- * Struct fields are always 32 or 64 bit aligned, depending on them being 32
- * or 64 bit wide respectively.
- *
- * See Documentation/virtual/kvm/ppc-pv.txt
- */
-struct kvm_vcpu_arch_shared {
-	__u64 scratch1;
-	__u64 scratch2;
-	__u64 scratch3;
-	__u64 critical;		/* Guest may not get interrupts if == r1 */
-	__u64 sprg0;
-	__u64 sprg1;
-	__u64 sprg2;
-	__u64 sprg3;
-	__u64 srr0;
-	__u64 srr1;
-	__u64 dar;		/* dear on BookE */
-	__u64 msr;
-	__u32 dsisr;
-	__u32 int_pending;	/* Tells the guest if we have an interrupt */
-	__u32 sr[16];
-	__u32 mas0;
-	__u32 mas1;
-	__u64 mas7_3;
-	__u64 mas2;
-	__u32 mas4;
-	__u32 mas6;
-	__u32 esr;
-	__u32 pir;
-
-	/*
-	 * SPRG4-7 are user-readable, so we can only keep these consistent
-	 * between the shared area and the real registers when there's an
-	 * intervening exit to KVM.  This also applies to SPRG3 on some
-	 * chips.
-	 *
-	 * This suffices for access by guest userspace, since in PR-mode
-	 * KVM, an exit must occur when changing the guest's MSR[PR].
-	 * If the guest kernel writes to SPRG3-7 via the shared area, it
-	 * must also use the shared area for reading while in kernel space.
-	 */
-	__u64 sprg4;
-	__u64 sprg5;
-	__u64 sprg6;
-	__u64 sprg7;
-};
-
-#define KVM_SC_MAGIC_R0		0x4b564d21 /* "KVM!" */
-
-#define KVM_HCALL_TOKEN(num)     _EV_HCALL_TOKEN(EV_KVM_VENDOR_ID, num)
-
-#include <asm/epapr_hcalls.h>
-
-#define KVM_FEATURE_MAGIC_PAGE	1
-
-/* Magic page flags from host to guest */
-
-#define KVM_MAGIC_FEAT_SR		(1 << 0)
-
-/* MASn, ESR, PIR, and high SPRGs */
-#define KVM_MAGIC_FEAT_MAS0_TO_SPRG7	(1 << 1)
-
-/* Magic page flags from guest to host */
-
-#define MAGIC_PAGE_FLAG_NOT_MAPPED_NX	(1 << 0)
-
-
-#endif /* __POWERPC_KVM_PARA_H__ */
diff --git a/linux-headers/asm-s390/kvm_para.h b/linux-headers/asm-s390/kvm_para.h
deleted file mode 100644
index b9ab584..0000000
--- a/linux-headers/asm-s390/kvm_para.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * User API definitions for paravirtual devices on s390
- *
- * Copyright IBM Corp. 2008
- *
- *    Author(s): Christian Borntraeger <borntraeger@de.ibm.com>
- */
diff --git a/linux-headers/asm-x86/kvm_para.h b/linux-headers/asm-x86/kvm_para.h
deleted file mode 100644
index 4c58184..0000000
--- a/linux-headers/asm-x86/kvm_para.h
+++ /dev/null
@@ -1,118 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_X86_KVM_PARA_H
-#define _ASM_X86_KVM_PARA_H
-
-#include <linux/types.h>
-#include <asm/hyperv.h>
-
-/* This CPUID returns the signature 'KVMKVMKVM' in ebx, ecx, and edx.  It
- * should be used to determine that a VM is running under KVM.
- */
-#define KVM_CPUID_SIGNATURE	0x40000000
-
-/* This CPUID returns a feature bitmap in eax.  Before enabling a particular
- * paravirtualization, the appropriate feature bit should be checked.
- */
-#define KVM_CPUID_FEATURES	0x40000001
-#define KVM_FEATURE_CLOCKSOURCE		0
-#define KVM_FEATURE_NOP_IO_DELAY	1
-#define KVM_FEATURE_MMU_OP		2
-/* This indicates that the new set of kvmclock msrs
- * are available. The use of 0x11 and 0x12 is deprecated
- */
-#define KVM_FEATURE_CLOCKSOURCE2        3
-#define KVM_FEATURE_ASYNC_PF		4
-#define KVM_FEATURE_STEAL_TIME		5
-#define KVM_FEATURE_PV_EOI		6
-#define KVM_FEATURE_PV_UNHALT		7
-#define KVM_FEATURE_PV_TLB_FLUSH	9
-#define KVM_FEATURE_ASYNC_PF_VMEXIT	10
-
-/* The last 8 bits are used to indicate how to interpret the flags field
- * in pvclock structure. If no bits are set, all flags are ignored.
- */
-#define KVM_FEATURE_CLOCKSOURCE_STABLE_BIT	24
-
-#define MSR_KVM_WALL_CLOCK  0x11
-#define MSR_KVM_SYSTEM_TIME 0x12
-
-#define KVM_MSR_ENABLED 1
-/* Custom MSRs falls in the range 0x4b564d00-0x4b564dff */
-#define MSR_KVM_WALL_CLOCK_NEW  0x4b564d00
-#define MSR_KVM_SYSTEM_TIME_NEW 0x4b564d01
-#define MSR_KVM_ASYNC_PF_EN 0x4b564d02
-#define MSR_KVM_STEAL_TIME  0x4b564d03
-#define MSR_KVM_PV_EOI_EN      0x4b564d04
-
-struct kvm_steal_time {
-	__u64 steal;
-	__u32 version;
-	__u32 flags;
-	__u8  preempted;
-	__u8  u8_pad[3];
-	__u32 pad[11];
-};
-
-#define KVM_VCPU_PREEMPTED          (1 << 0)
-#define KVM_VCPU_FLUSH_TLB          (1 << 1)
-
-#define KVM_CLOCK_PAIRING_WALLCLOCK 0
-struct kvm_clock_pairing {
-	__s64 sec;
-	__s64 nsec;
-	__u64 tsc;
-	__u32 flags;
-	__u32 pad[9];
-};
-
-#define KVM_STEAL_ALIGNMENT_BITS 5
-#define KVM_STEAL_VALID_BITS ((-1ULL << (KVM_STEAL_ALIGNMENT_BITS + 1)))
-#define KVM_STEAL_RESERVED_MASK (((1 << KVM_STEAL_ALIGNMENT_BITS) - 1 ) << 1)
-
-#define KVM_MAX_MMU_OP_BATCH           32
-
-#define KVM_ASYNC_PF_ENABLED			(1 << 0)
-#define KVM_ASYNC_PF_SEND_ALWAYS		(1 << 1)
-#define KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT	(1 << 2)
-
-/* Operations for KVM_HC_MMU_OP */
-#define KVM_MMU_OP_WRITE_PTE            1
-#define KVM_MMU_OP_FLUSH_TLB	        2
-#define KVM_MMU_OP_RELEASE_PT	        3
-
-/* Payload for KVM_HC_MMU_OP */
-struct kvm_mmu_op_header {
-	__u32 op;
-	__u32 pad;
-};
-
-struct kvm_mmu_op_write_pte {
-	struct kvm_mmu_op_header header;
-	__u64 pte_phys;
-	__u64 pte_val;
-};
-
-struct kvm_mmu_op_flush_tlb {
-	struct kvm_mmu_op_header header;
-};
-
-struct kvm_mmu_op_release_pt {
-	struct kvm_mmu_op_header header;
-	__u64 pt_phys;
-};
-
-#define KVM_PV_REASON_PAGE_NOT_PRESENT 1
-#define KVM_PV_REASON_PAGE_READY 2
-
-struct kvm_vcpu_pv_apf_data {
-	__u32 reason;
-	__u8 pad[60];
-	__u32 enabled;
-};
-
-#define KVM_PV_EOI_BIT 0
-#define KVM_PV_EOI_MASK (0x1 << KVM_PV_EOI_BIT)
-#define KVM_PV_EOI_ENABLED KVM_PV_EOI_MASK
-#define KVM_PV_EOI_DISABLED 0x0
-
-#endif /* _ASM_X86_KVM_PARA_H */
diff --git a/linux-headers/linux/kvm_para.h b/linux-headers/linux/kvm_para.h
deleted file mode 100644
index 8bcd0aa..0000000
--- a/linux-headers/linux/kvm_para.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __LINUX_KVM_PARA_H
-#define __LINUX_KVM_PARA_H
-
-/*
- * This header file provides a method for making a hypercall to the host
- * Architectures should define:
- * - kvm_hypercall0, kvm_hypercall1...
- * - kvm_arch_para_features
- * - kvm_para_available
- */
-
-/* Return values for hypercalls */
-#define KVM_ENOSYS		1000
-#define KVM_EFAULT		EFAULT
-#define KVM_E2BIG		E2BIG
-#define KVM_EPERM		EPERM
-#define KVM_EOPNOTSUPP		95
-
-#define KVM_HC_VAPIC_POLL_IRQ		1
-#define KVM_HC_MMU_OP			2
-#define KVM_HC_FEATURES			3
-#define KVM_HC_PPC_MAP_MAGIC_PAGE	4
-#define KVM_HC_KICK_CPU			5
-#define KVM_HC_MIPS_GET_CLOCK_FREQ	6
-#define KVM_HC_MIPS_EXIT_VM		7
-#define KVM_HC_MIPS_CONSOLE_OUTPUT	8
-#define KVM_HC_CLOCK_PAIRING		9
-
-/*
- * hypercalls use architecture specific
- */
-#include <asm/kvm_para.h>
-
-#endif /* __LINUX_KVM_PARA_H */
-- 
MST
