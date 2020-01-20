Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D30C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0000B20684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T63F3fOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0000B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itU3N-0008F0-SB
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1itU10-0005PJ-N0
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:10:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1itU0w-0002zi-4U
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:10:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49990
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1itU0w-0002zQ-0O
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579515033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5JK0SPejtfnhDv2PZmh14HOx+dBSg1c8oIKDy0lXZ34=;
 b=T63F3fOggoWKldbIOZ0fWrE7T+L2AxzMrusD/DDv0P4hd+NMDeWODWzqaYofh+uWxst30e
 baL6yHov9Kdoe5aysTYQ0ZOskyJXITyxG9ZczjNOvyNFmcDn2qKAjiPvDIwiWtR4fgm/kd
 JPiDl9q+N3BHesuZZpv4u1kUpMa2mwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-2FuIHtcgPqWv671Nk2Qayg-1; Mon, 20 Jan 2020 05:10:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E25E9800D48;
 Mon, 20 Jan 2020 10:10:28 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24C3C48;
 Mon, 20 Jan 2020 10:10:26 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [RFC PATCH v3 1/6] target/arm/kvm: trivial: Clean up header
 documentation
Date: Mon, 20 Jan 2020 11:10:18 +0100
Message-Id: <20200120101023.16030-2-drjones@redhat.com>
In-Reply-To: <20200120101023.16030-1-drjones@redhat.com>
References: <20200120101023.16030-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 2FuIHtcgPqWv671Nk2Qayg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org,
 richard.henderson@linaro.org, guoheyi@huawei.com, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 target/arm/kvm_arm.h | 46 ++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 8e14d400e8ab..b48a9c95573b 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -28,9 +28,9 @@
 int kvm_arm_vcpu_init(CPUState *cs);
=20
 /**
- * kvm_arm_vcpu_finalize
+ * kvm_arm_vcpu_finalize:
  * @cs: CPUState
- * @feature: int
+ * @feature: feature to finalize
  *
  * Finalizes the configuration of the specified VCPU feature by
  * invoking the KVM_ARM_VCPU_FINALIZE ioctl. Features requiring
@@ -75,8 +75,8 @@ void kvm_arm_register_device(MemoryRegion *mr, uint64_t d=
evid, uint64_t group,
 int kvm_arm_init_cpreg_list(ARMCPU *cpu);
=20
 /**
- * kvm_arm_reg_syncs_via_cpreg_list
- * regidx: KVM register index
+ * kvm_arm_reg_syncs_via_cpreg_list:
+ * @regidx: KVM register index
  *
  * Return true if this KVM register should be synchronized via the
  * cpreg list of arbitrary system registers, false if it is synchronized
@@ -85,8 +85,8 @@ int kvm_arm_init_cpreg_list(ARMCPU *cpu);
 bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx);
=20
 /**
- * kvm_arm_cpreg_level
- * regidx: KVM register index
+ * kvm_arm_cpreg_level:
+ * @regidx: KVM register index
  *
  * Return the level of this coprocessor/system register.  Return value is
  * either KVM_PUT_RUNTIME_STATE, KVM_PUT_RESET_STATE, or KVM_PUT_FULL_STAT=
E.
@@ -148,6 +148,8 @@ void kvm_arm_init_serror_injection(CPUState *cs);
  * @cpu: ARMCPU
  *
  * Get VCPU related state from kvm.
+ *
+ * Returns: 0 if success else < 0 error code
  */
 int kvm_get_vcpu_events(ARMCPU *cpu);
=20
@@ -156,6 +158,8 @@ int kvm_get_vcpu_events(ARMCPU *cpu);
  * @cpu: ARMCPU
  *
  * Put VCPU related state to kvm.
+ *
+ * Returns: 0 if success else < 0 error code
  */
 int kvm_put_vcpu_events(ARMCPU *cpu);
=20
@@ -205,10 +209,12 @@ typedef struct ARMHostCPUFeatures {
=20
 /**
  * kvm_arm_get_host_cpu_features:
- * @ahcc: ARMHostCPUClass to fill in
+ * @ahcf: ARMHostCPUClass to fill in
  *
  * Probe the capabilities of the host kernel's preferred CPU and fill
  * in the ARMHostCPUClass struct accordingly.
+ *
+ * Returns true on success and false otherwise.
  */
 bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf);
=20
@@ -242,7 +248,7 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
 bool kvm_arm_aarch32_supported(CPUState *cs);
=20
 /**
- * bool kvm_arm_pmu_supported:
+ * kvm_arm_pmu_supported:
  * @cs: CPUState
  *
  * Returns: true if the KVM VCPU can enable its PMU
@@ -251,7 +257,7 @@ bool kvm_arm_aarch32_supported(CPUState *cs);
 bool kvm_arm_pmu_supported(CPUState *cs);
=20
 /**
- * bool kvm_arm_sve_supported:
+ * kvm_arm_sve_supported:
  * @cs: CPUState
  *
  * Returns true if the KVM VCPU can enable SVE and false otherwise.
@@ -259,26 +265,30 @@ bool kvm_arm_pmu_supported(CPUState *cs);
 bool kvm_arm_sve_supported(CPUState *cs);
=20
 /**
- * kvm_arm_get_max_vm_ipa_size - Returns the number of bits in the
- * IPA address space supported by KVM
- *
+ * kvm_arm_get_max_vm_ipa_size:
  * @ms: Machine state handle
+ *
+ * Returns the number of bits in the IPA address space supported by KVM
  */
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms);
=20
 /**
- * kvm_arm_sync_mpstate_to_kvm
+ * kvm_arm_sync_mpstate_to_kvm:
  * @cpu: ARMCPU
  *
  * If supported set the KVM MP_STATE based on QEMU's model.
+ *
+ * Returns 0 on success and -1 on failure.
  */
 int kvm_arm_sync_mpstate_to_kvm(ARMCPU *cpu);
=20
 /**
- * kvm_arm_sync_mpstate_to_qemu
+ * kvm_arm_sync_mpstate_to_qemu:
  * @cpu: ARMCPU
  *
  * If supported get the MP_STATE from KVM and store in QEMU's model.
+ *
+ * Returns 0 on success and aborts on failure.
  */
 int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu);
=20
@@ -292,7 +302,8 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int =
level);
=20
 static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
 {
-    /* This should never actually be called in the "not KVM" case,
+    /*
+     * This should never actually be called in the "not KVM" case,
      * but set up the fields to indicate an error anyway.
      */
     cpu->kvm_target =3D QEMU_KVM_ARM_TARGET_NONE;
@@ -377,23 +388,20 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_de=
bug_exit_arch *debug_exit);
  *
  * Return: TRUE if any hardware breakpoints in use.
  */
-
 bool kvm_arm_hw_debug_active(CPUState *cs);
=20
 /**
  * kvm_arm_copy_hw_debug_data:
- *
  * @ptr: kvm_guest_debug_arch structure
  *
  * Copy the architecture specific debug registers into the
  * kvm_guest_debug ioctl structure.
  */
 struct kvm_guest_debug_arch;
-
 void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
=20
 /**
- * its_class_name
+ * its_class_name:
  *
  * Return the ITS class name to use depending on whether KVM acceleration
  * and KVM CAP_SIGNAL_MSI are supported
--=20
2.21.1


