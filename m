Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E933C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D9020760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFDt0Koj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D9020760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhkD-0004dM-Mg
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQC-0002hB-6g
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:51955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQA-0001Ph-9i
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:03 -0400
Received: by mail-wm1-x32d.google.com with SMTP id d81so1835639wmc.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=McojN4hgI2v8lMIA/0vIa8DUoBcoEwCymxJZE7NE5hM=;
 b=fFDt0KojN8zQR9IVBJ+icCKNvvLKDjnRP4iBHVkL8keuPLAw8/klDMzIx3r+dWzj+N
 bvE3VCB11ai9FGokMmLgzdZ8i2pGO6wW37dfo47S1qMoIUSOtgsTe4WuI8Lygenc2JKt
 mZ+sH+wXEBEa063R75XVH72V7wISSjfFyfUcYURurTvjXB14Nb6YfZMYTqpsaU7i3uzL
 MSXx1kIB0FzWWPd01MJ9b0KBwdzoa+o+nkD+Hnf/FRGprftFRm2b3Ib8s5+qrNsrQMrI
 Qq1tyUMRaLRJtxa072r9ig2prMSKTIfXY0Fe9SgMSYS3GdEbko9wetZaYpaVXI14UddX
 bBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=McojN4hgI2v8lMIA/0vIa8DUoBcoEwCymxJZE7NE5hM=;
 b=e6/7yTrmL3EHZLudmBhvAxNlbn0ZwU3dbzJgL2IbNzhRE8A6yzsvOPJd4ULpcq+ySQ
 /Lh9vVHaEWKzEnGFZZVfk4F3uP1ORKDoWcBk7XfzZVq+XGKDCR9dP4vM9UiOAH3XM7BH
 wtjr4aqylpRegbJlFC9WuFKJt3RKGvb3k1K4lYia890bE0yGhUC/K9dk4MzqIdeOa7Mj
 i/pifdWjBW5awpN62WGLmJOqA3EZxZn5w0SlsK0AhU6yO4UaYcIZ3tTz1m/fUS9/83h4
 akhhxS1YJvd359SstNrA2Hbkud5ShdCvnd3wt0TlGPTLUmlDlwf366rT74+K9KgPCsdg
 uLTg==
X-Gm-Message-State: AOAM533k2SQ7RUXRSRO1srsJxl5KjPw+TkTNHKM4HXSVFTC9wUgWniS4
 e+i4Am3rSRW3aeAE3CgcWTH6UNF/FE8=
X-Google-Smtp-Source: ABdhPJzFERkBba6rm09u5DrrABvfxBt8C8M0KaEImWlih2J/7WsC5VGEuxVnJhSZi5tosbLEFLHyqQ==
X-Received: by 2002:a7b:c92c:: with SMTP id h12mr3204449wml.121.1601969400582; 
 Tue, 06 Oct 2020 00:30:00 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/37] kvm: remove kvm specific functions from global includes
Date: Tue,  6 Oct 2020 09:29:26 +0200
Message-Id: <20201006072947.487729-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-cpus.h   |  7 +++++++
 accel/stubs/kvm-stub.c | 22 ----------------------
 include/sysemu/kvm.h   |  7 -------
 3 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h
index 547fbee111..60c5a554c2 100644
--- a/accel/kvm/kvm-cpus.h
+++ b/accel/kvm/kvm-cpus.h
@@ -14,4 +14,11 @@
 
 extern const CpusAccel kvm_cpus;
 
+int kvm_init_vcpu(CPUState *cpu);
+int kvm_cpu_exec(CPUState *cpu);
+void kvm_destroy_vcpu(CPUState *cpu);
+void kvm_cpu_synchronize_post_reset(CPUState *cpu);
+void kvm_cpu_synchronize_post_init(CPUState *cpu);
+void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu);
+
 #endif /* KVM_CPUS_H */
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 69f8a842da..680e099463 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -32,15 +32,6 @@ bool kvm_readonly_mem_allowed;
 bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
 
-void kvm_destroy_vcpu(CPUState *cpu)
-{
-}
-
-int kvm_init_vcpu(CPUState *cpu)
-{
-    return -ENOSYS;
-}
-
 void kvm_flush_coalesced_mmio_buffer(void)
 {
 }
@@ -49,19 +40,6 @@ void kvm_cpu_synchronize_state(CPUState *cpu)
 {
 }
 
-void kvm_cpu_synchronize_post_reset(CPUState *cpu)
-{
-}
-
-void kvm_cpu_synchronize_post_init(CPUState *cpu)
-{
-}
-
-int kvm_cpu_exec(CPUState *cpu)
-{
-    abort();
-}
-
 bool kvm_has_sync_mmu(void)
 {
     return false;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 07937454d2..fe7dab1466 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -223,10 +223,6 @@ int kvm_has_many_ioeventfds(void);
 int kvm_has_gsi_routing(void);
 int kvm_has_intx_set_mask(void);
 
-int kvm_init_vcpu(CPUState *cpu);
-int kvm_cpu_exec(CPUState *cpu);
-void kvm_destroy_vcpu(CPUState *cpu);
-
 /**
  * kvm_arm_supports_user_irq
  *
@@ -486,9 +482,6 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
 #endif /* NEED_CPU_H */
 
 void kvm_cpu_synchronize_state(CPUState *cpu);
-void kvm_cpu_synchronize_post_reset(CPUState *cpu);
-void kvm_cpu_synchronize_post_init(CPUState *cpu);
-void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu);
 
 void kvm_init_cpu_signals(CPUState *cpu);
 
-- 
2.26.2



