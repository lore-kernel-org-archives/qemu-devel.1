Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D83C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBBA2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hOFpnWQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBBA2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih57k-0002VD-Sh
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4j2-00018i-KC
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4j1-0006Zz-0a
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:48 -0500
Received: from ozlabs.org ([203.11.71.1]:56989)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4j0-00061k-D8; Mon, 16 Dec 2019 23:44:46 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWY5xcqz9sTC; Tue, 17 Dec 2019 15:43:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557817;
 bh=uUiqDKLLVTBBPiFHlPyXS5b1JgnGOzsSFBr2SRaf5go=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hOFpnWQlMFYLN0RdPJpRXybpptSxIj5G1JKBu3IAtaatvgV+Z+BYo4bGOAP6xuKF4
 6iIkjjN36+1yg8xL6B/iIWc3j8PKBVUymDy6H5sZ01DXtRtPSClupFKqmPxdt4scjv
 Y2tFfn+NEYMttjp1FJunt9Bh69WbY7kzFlFNei/s=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 39/88] linux-headers: Update
Date: Tue, 17 Dec 2019 15:42:33 +1100
Message-Id: <20191217044322.351838-40-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Update to mainline commit be2eca94d144 ("Merge tag 'for-linus-5.5-1'`
of git://github.com/cminyard/linux-ipmi")

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157478677756.67101.11558821804418331832.stgit@bahia.tlslab.i=
bm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/standard-headers/linux/ethtool.h     |  6 ++++++
 include/standard-headers/linux/virtio_ring.h |  2 +-
 linux-headers/asm-arm/kvm.h                  |  3 ++-
 linux-headers/asm-arm64/kvm.h                |  5 ++++-
 linux-headers/asm-mips/unistd_n32.h          |  1 +
 linux-headers/asm-mips/unistd_n64.h          |  1 +
 linux-headers/asm-mips/unistd_o32.h          |  1 +
 linux-headers/asm-powerpc/kvm.h              |  3 +++
 linux-headers/linux/kvm.h                    | 11 +++++++++++
 linux-headers/linux/psp-sev.h                |  3 +++
 10 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-=
headers/linux/ethtool.h
index 4ff422b635..6e8a10ee10 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -1507,6 +1507,11 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT	 =3D 66,
 	ETHTOOL_LINK_MODE_100baseT1_Full_BIT		 =3D 67,
 	ETHTOOL_LINK_MODE_1000baseT1_Full_BIT		 =3D 68,
+	ETHTOOL_LINK_MODE_400000baseKR8_Full_BIT	 =3D 69,
+	ETHTOOL_LINK_MODE_400000baseSR8_Full_BIT	 =3D 70,
+	ETHTOOL_LINK_MODE_400000baseLR8_ER8_FR8_Full_BIT =3D 71,
+	ETHTOOL_LINK_MODE_400000baseDR8_Full_BIT	 =3D 72,
+	ETHTOOL_LINK_MODE_400000baseCR8_Full_BIT	 =3D 73,
=20
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
@@ -1618,6 +1623,7 @@ enum ethtool_link_mode_bit_indices {
 #define SPEED_56000		56000
 #define SPEED_100000		100000
 #define SPEED_200000		200000
+#define SPEED_400000		400000
=20
 #define SPEED_UNKNOWN		-1
=20
diff --git a/include/standard-headers/linux/virtio_ring.h b/include/stand=
ard-headers/linux/virtio_ring.h
index 306cd41147..f230fed479 100644
--- a/include/standard-headers/linux/virtio_ring.h
+++ b/include/standard-headers/linux/virtio_ring.h
@@ -167,7 +167,7 @@ static inline void vring_init(struct vring *vr, unsig=
ned int num, void *p,
 {
 	vr->num =3D num;
 	vr->desc =3D p;
-	vr->avail =3D p + num*sizeof(struct vring_desc);
+	vr->avail =3D (struct vring_avail *)((char *)p + num * sizeof(struct vr=
ing_desc));
 	vr->used =3D (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virt=
io16)
 		+ align-1) & ~(align - 1));
 }
diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
index 9d379d3372..0db5644e27 100644
--- a/linux-headers/asm-arm/kvm.h
+++ b/linux-headers/asm-arm/kvm.h
@@ -131,8 +131,9 @@ struct kvm_vcpu_events {
 	struct {
 		__u8 serror_pending;
 		__u8 serror_has_esr;
+		__u8 ext_dabt_pending;
 		/* Align it to 8 bytes */
-		__u8 pad[6];
+		__u8 pad[5];
 		__u64 serror_esr;
 	} exception;
 	__u32 reserved[12];
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.=
h
index 0ce6e49f3a..920af01c8b 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -164,8 +164,9 @@ struct kvm_vcpu_events {
 	struct {
 		__u8 serror_pending;
 		__u8 serror_has_esr;
+		__u8 ext_dabt_pending;
 		/* Align it to 8 bytes */
-		__u8 pad[6];
+		__u8 pad[5];
 		__u64 serror_esr;
 	} exception;
 	__u32 reserved[12];
@@ -323,6 +324,8 @@ struct kvm_vcpu_events {
 #define KVM_ARM_VCPU_TIMER_CTRL		1
 #define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
 #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
+#define KVM_ARM_VCPU_PVTIME_CTRL	2
+#define   KVM_ARM_VCPU_PVTIME_IPA	0
=20
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_VCPU2_SHIFT		28
diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips=
/unistd_n32.h
index 7dffe8e34e..659d5c9ade 100644
--- a/linux-headers/asm-mips/unistd_n32.h
+++ b/linux-headers/asm-mips/unistd_n32.h
@@ -364,6 +364,7 @@
 #define __NR_fsmount	(__NR_Linux + 432)
 #define __NR_fspick	(__NR_Linux + 433)
 #define __NR_pidfd_open	(__NR_Linux + 434)
+#define __NR_clone3	(__NR_Linux + 435)
=20
=20
 #endif /* _ASM_MIPS_UNISTD_N32_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips=
/unistd_n64.h
index f4592d6fc5..4b6310a05c 100644
--- a/linux-headers/asm-mips/unistd_n64.h
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -340,6 +340,7 @@
 #define __NR_fsmount	(__NR_Linux + 432)
 #define __NR_fspick	(__NR_Linux + 433)
 #define __NR_pidfd_open	(__NR_Linux + 434)
+#define __NR_clone3	(__NR_Linux + 435)
=20
=20
 #endif /* _ASM_MIPS_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips=
/unistd_o32.h
index 04c6728352..4ce7b4e288 100644
--- a/linux-headers/asm-mips/unistd_o32.h
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -410,6 +410,7 @@
 #define __NR_fsmount	(__NR_Linux + 432)
 #define __NR_fspick	(__NR_Linux + 433)
 #define __NR_pidfd_open	(__NR_Linux + 434)
+#define __NR_clone3	(__NR_Linux + 435)
=20
=20
 #endif /* _ASM_MIPS_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/=
kvm.h
index b0f72dea8b..264e266a85 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -667,6 +667,8 @@ struct kvm_ppc_cpu_char {
=20
 /* PPC64 eXternal Interrupt Controller Specification */
 #define KVM_DEV_XICS_GRP_SOURCES	1	/* 64-bit source attributes */
+#define KVM_DEV_XICS_GRP_CTRL		2
+#define   KVM_DEV_XICS_NR_SERVERS	1
=20
 /* Layout of 64-bit source attribute values */
 #define  KVM_XICS_DESTINATION_SHIFT	0
@@ -683,6 +685,7 @@ struct kvm_ppc_cpu_char {
 #define KVM_DEV_XIVE_GRP_CTRL		1
 #define   KVM_DEV_XIVE_RESET		1
 #define   KVM_DEV_XIVE_EQ_SYNC		2
+#define   KVM_DEV_XIVE_NR_SERVERS	3
 #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source identifier */
 #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source identifier */
 #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit EQ identifier */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 3d9b18f7f8..3b27a1ae85 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -235,6 +235,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_S390_STSI        25
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
+#define KVM_EXIT_ARM_NISV         28
=20
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -394,6 +395,11 @@ struct kvm_run {
 		} eoi;
 		/* KVM_EXIT_HYPERV */
 		struct kvm_hyperv_exit hyperv;
+		/* KVM_EXIT_ARM_NISV */
+		struct {
+			__u64 esr_iss;
+			__u64 fault_ipa;
+		} arm_nisv;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -1000,6 +1006,9 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PMU_EVENT_FILTER 173
 #define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
 #define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 175
+#define KVM_CAP_PPC_GUEST_DEBUG_SSTEP 176
+#define KVM_CAP_ARM_NISV_TO_USER 177
+#define KVM_CAP_ARM_INJECT_EXT_DABT 178
=20
 #ifdef KVM_CAP_IRQ_ROUTING
=20
@@ -1227,6 +1236,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_ARM_VGIC_ITS	KVM_DEV_TYPE_ARM_VGIC_ITS
 	KVM_DEV_TYPE_XIVE,
 #define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
+	KVM_DEV_TYPE_ARM_PV_TIME,
+#define KVM_DEV_TYPE_ARM_PV_TIME	KVM_DEV_TYPE_ARM_PV_TIME
 	KVM_DEV_TYPE_MAX,
 };
=20
diff --git a/linux-headers/linux/psp-sev.h b/linux-headers/linux/psp-sev.=
h
index 34c39690c0..31f971e896 100644
--- a/linux-headers/linux/psp-sev.h
+++ b/linux-headers/linux/psp-sev.h
@@ -58,6 +58,9 @@ typedef enum {
 	SEV_RET_HWSEV_RET_PLATFORM,
 	SEV_RET_HWSEV_RET_UNSAFE,
 	SEV_RET_UNSUPPORTED,
+	SEV_RET_INVALID_PARAM,
+	SEV_RET_RESOURCE_LIMIT,
+	SEV_RET_SECURE_DATA_INVALID,
 	SEV_RET_MAX,
 } sev_ret_code;
=20
--=20
2.23.0


