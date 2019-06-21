Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC69FC48BE3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8D12084E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFPAMP0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8D12084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60378 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heIQB-0002EL-0w
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49133)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkh-0000ms-JH
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHke-0005uN-Fo
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:36799)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1heHkc-0005lr-CI
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id u8so6233444wmm.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 04:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6T+CvKxhIT/wD43F8C6X0mfQEc7rDvNDe6JNobc9BRE=;
 b=TFPAMP0vaKeogxMyW16FMWXC2XE55AU9NaaFBmNrCnf9pOaA3Awp2uPgmSA/ATjhWN
 ceJMZxwBOYYSN/msRVDXu1Obee4owYDUdPBR795iPnN8Lmk6VDoIE21K5YDcGDDGmr5O
 a6HMb27/fmI2nrc5oSslwyxiC2qPb3YC6gpCJESIkp7rUZTAFZgK/mcjHhgsv102vgXa
 L0h0WxFMdtXso39iLE3qfW23xHg1+pGXJmu7sSVA0jHnJCqFy2iK1R3CdI57YXM6ogIn
 d75WLTEj06QSkKnyEhXfM0Dti1VYsUgdNxD3tlQ0lDu4yt8Rz+lgvmgwJNzsSP0jNJrf
 hjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=6T+CvKxhIT/wD43F8C6X0mfQEc7rDvNDe6JNobc9BRE=;
 b=hWBSm1l45Fqvi5YfX6zozhZf3o+b5tpaNv/hnAeEFUC2RxeNHaAcae90TRt67wINAY
 ET0tczUN6nFJG9CtO8q5kEjfP33mhl6cJfYEA8mTpizePeJAKiAJFgFD22I5PEkpWbII
 amD6uv6iJY6KHRQJsIpxyQt91XCnW0LrBhxBA7b/ETz8XhFW6kjRCJQsnqrDwu7HvX8J
 8pQPE7U1iqLlquYPWZHTKAwxWvUS8hsOR4cPdCOkDFMzk697/pgYJz46mXlwv96djbC/
 xbaDsasHi2s1bBu8goiD89d+0NzCCo2LLacpESKltI0eh6Vbbl5QBr9bN8GdMRClEABo
 zQ4Q==
X-Gm-Message-State: APjAAAWb/iMmI4tBXpovc7ypOJMx7gKj3zMHSSCy4bXIGIiNzvov/F0V
 RpxVXX5uJe0YFYPhELUT651WNBn9
X-Google-Smtp-Source: APXvYqz7Pce7OFwypJLOSTBwDgyffKgjU77hMV049nta2c+kkS//hAaXVuUhc+NTisXDJJonxPGzyQ==
X-Received: by 2002:a1c:a848:: with SMTP id r69mr3750914wme.12.1561116636277; 
 Fri, 21 Jun 2019 04:30:36 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r3sm2712851wrr.61.2019.06.21.04.30.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 04:30:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:30:09 +0200
Message-Id: <1561116620-22245-15-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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



