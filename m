Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256DAC4646C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDBE32084E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDhqWwpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBE32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54124 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he8vk-0003rR-0G
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 22:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41104)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a3-0006b2-Pv
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a1-0006Yj-UT
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:07 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:39749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1he8Zw-0006Ki-Ml
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:01 -0400
Received: by mail-wr1-x432.google.com with SMTP id x4so4878741wrt.6
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6T+CvKxhIT/wD43F8C6X0mfQEc7rDvNDe6JNobc9BRE=;
 b=XDhqWwpP8SOls3rUCVN3Fdp9LDJoXkaD3Xr12NwOSvCRJIeludk44jelRs+W3zLi38
 zpIzqU6SfVtRgpa7HMmUH7EpA8fS1n5PWwiw2dgPT2ORR4EFhO4mZOXDl0Ox01H8eisU
 yQBaFI+jeLJUfAbxP9JAeFo5MrH0Z5ykhMYl7hLqd4FjMmTwo19Tl2KFNykl3mZJrqVk
 K66/wr5f+Wi/afGXIqmk9+kab6kkda5qF5pE6RwNBeZTiZ+o4/cne8b0sdEAbLsHxUqx
 cZlz4HfEUkg1O6+A/76wXeZSXs2y4hmx9HUJcq8nuNNV3iVWbwSraMCiHG7cJvtqU60/
 4MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=6T+CvKxhIT/wD43F8C6X0mfQEc7rDvNDe6JNobc9BRE=;
 b=prOixgobMnzwMTKLMsAuiCcNLs51JomboFqUilWmDg5KjaiUO3sQpFpf6TWV8pGzsM
 FP+6Dvt2VXdS9N5rA9L3bxdAVM++YzzOfXqsuMwQnIrk9UZp9d3u5LcxdwN0AX0ggLlK
 ZTGarhsHRj4O3eJmo/jE8eqR2Q6nuTekqA1DbggDFXumZRymbDXWoN29SDQV8mt1Zwq6
 PqHn22lTFwE7ipBfFKpoFF9a2G86SRqeXmqf+sx5Hg504NlC6wg9gcojhoeI4pXqEf+t
 S6RdpmEg09WU2BAIwNZoGGQZ6BJt0apTxlcf/Tb3Y6xj4mf23eTsvLtZ2aaeK5XwYNDd
 ldDQ==
X-Gm-Message-State: APjAAAWxD+uz98FXPK1g/EFT5YaIp9fT3m++o9kFsCkVmYDuu/66vDMA
 s36PGX9E5MnHccBMevAJuesn4zKZ
X-Google-Smtp-Source: APXvYqx8ElBEfZ/vW5ce+4tsoc7CJ/352laHkfQ61vXO7xS+1cYyCCzbBX46GPwUREsBNfRNjeB/bw==
X-Received: by 2002:a5d:484e:: with SMTP id n14mr8853354wrs.348.1561081367029; 
 Thu, 20 Jun 2019 18:42:47 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d1sm1123125wru.41.2019.06.20.18.42.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:42:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 03:42:19 +0200
Message-Id: <1561081350-3723-15-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
References: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 14/25] KVM: Introduce kvm_arch_destroy_vcpu()
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
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

Simiar to how kvm_init_vcpu() calls kvm_arch_init_vcpu() to perform
arch-dependent initialisation, introduce kvm_arch_destroy_vcpu()
to be called from kvm_destroy_vcpu() to perform arch-dependent
destruction.

This was added because some architectures (Such as i386)
currently do not free memory that it have allocated in
kvm_arch_init_vcpu().

Suggested-by: Maran Wilson <maran.wilson@oracle.com>
Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20190619162140.133674-3-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c  |  5 +++++
 include/sysemu/kvm.h |  1 +
 target/arm/kvm32.c   |  5 +++++
 target/arm/kvm64.c   |  5 +++++
 target/i386/kvm.c    | 12 ++++++++++++
 target/mips/kvm.c    |  5 +++++
 target/ppc/kvm.c     |  5 +++++
 target/s390x/kvm.c   | 10 ++++++++++
 8 files changed, 48 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d2f481a..f0f5ab8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -291,6 +291,11 @@ int kvm_destroy_vcpu(CPUState *cpu)
 
     DPRINTF("kvm_destroy_vcpu\n");
 
+    ret = kvm_arch_destroy_vcpu(cpu);
+    if (ret < 0) {
+        goto err;
+    }
+
     mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
     if (mmap_size < 0) {
         ret = mmap_size;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index a6d1cd1..64f55e5 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -371,6 +371,7 @@ int kvm_arch_put_registers(CPUState *cpu, int level);
 int kvm_arch_init(MachineState *ms, KVMState *s);
 
 int kvm_arch_init_vcpu(CPUState *cpu);
+int kvm_arch_destroy_vcpu(CPUState *cpu);
 
 bool kvm_vcpu_id_is_valid(int vcpu_id);
 
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 4e54e37..51f78f7 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -240,6 +240,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return kvm_arm_init_cpreg_list(cpu);
 }
 
+int kvm_arch_destroy_vcpu(CPUState *cs)
+{
+	return 0;
+}
+
 typedef struct Reg {
     uint64_t id;
     int offset;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 998d21f..22d19c9 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -654,6 +654,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return kvm_arm_init_cpreg_list(cpu);
 }
 
+int kvm_arch_destroy_vcpu(CPUState *cs)
+{
+    return 0;
+}
+
 bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
 {
     /* Return true if the regidx is a register we should synchronize
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index c5cbead..26d8c61 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1679,6 +1679,18 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return r;
 }
 
+int kvm_arch_destroy_vcpu(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+
+    if (cpu->kvm_msr_buf) {
+        g_free(cpu->kvm_msr_buf);
+        cpu->kvm_msr_buf = NULL;
+    }
+
+    return 0;
+}
+
 void kvm_arch_reset_vcpu(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 8e72850..938f8f1 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -91,6 +91,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return ret;
 }
 
+int kvm_arch_destroy_vcpu(CPUState *cs)
+{
+    return 0;
+}
+
 void kvm_mips_reset_vcpu(MIPSCPU *cpu)
 {
     CPUMIPSState *env = &cpu->env;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d4107dd..4b4989c 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -521,6 +521,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return ret;
 }
 
+int kvm_arch_destroy_vcpu(CPUState *cs)
+{
+    return 0;
+}
+
 static void kvm_sw_tlb_put(PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index bcec979..0267c6c 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -368,6 +368,16 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return 0;
 }
 
+int kvm_arch_destroy_vcpu(CPUState *cs)
+{
+    S390CPU *cpu = S390_CPU(cs);
+
+    g_free(cpu->irqstate);
+    cpu->irqstate = NULL;
+
+    return 0;
+}
+
 void kvm_s390_reset_vcpu(S390CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
-- 
1.8.3.1



