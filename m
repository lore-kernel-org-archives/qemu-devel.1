Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88952C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545C5206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms7ihd4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545C5206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXoZH-00030z-FF
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 10:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iXoVs-0006nH-1F
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iXoVq-0001Pe-JE
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:36:55 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:50500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iXoVq-0001Ob-CJ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:36:54 -0500
Received: by mail-wm1-x333.google.com with SMTP id l17so4237528wmh.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 07:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=W++B25PcncKXRBog45JaunAzgYs3JNNz2RLMkQBokMM=;
 b=Ms7ihd4qik5QgINSGNX8dxSUb0yzA/In20f3rdS/R1W6TTF1ohmPq23jaD5AFhIW+a
 3B9g+UukpprGunjNcwc43r/Gn4hXggJB45FY+cp1qwYee/w3wHCW/lGDfggViNFlpbv2
 v0pK9S6MRJz//S8IXFQCnLUwD5sESAgXjJd58S3Ortf3TaF3JWnaGqJe1LuWn0lJtx55
 dbuBPNo05l7ccfy5mvRgAndjb+pjtu0XUOACeKeF8wRvxs9GwcozONPweECbFKqG0NRI
 FUt8MxG23TddgophRkYpEL4mWcFGAawP+SgS4488ID1DQlJCPsmOXmBHLPlo6avXPKQU
 5cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=W++B25PcncKXRBog45JaunAzgYs3JNNz2RLMkQBokMM=;
 b=QndYsEcWT4Lgksr3+N+hBQcrRkTIM653u/t/NfrfSOc+O054JVTm8acxF1p0i/UqYK
 ISnBySF74OPVionU51heQN0Xgtb/EB78MyGWc+i/jtohUUYrpT80t5mcVMz8o4hNGvTF
 YHVkZW8H5GZ1r3x7hTuqFL+wycHI5t1izJpJiK36rPdWGYQZy+NBT2nMblL5Ws3iFazE
 N5b7qWHDNu0q8OcbX7SUTNS8VL9vib12vObw0Tu6oL3a7uYJQy6Wf4z1zl2vwvEG78Iw
 Q1oVgjzdgWEdjNMDeVLeoGLOi+7hDzJCTlmhRemzknbXZZTJf9QQmFsiZor9KRJZWKz5
 blRQ==
X-Gm-Message-State: APjAAAWf/UsCOLGrrIkvga1wPOWL41RB1zjiOxQYzER7sSr/L5rTfIf9
 O5WHlywtOeZu6udW6qH4WmpLjL+Y
X-Google-Smtp-Source: APXvYqynSfI2fSxXN2THmwVBljnKSdDZAFff4h33yAFTjn/XI8HRtAd2TjWpVk1yzRLKEwFCDGMQwA==
X-Received: by 2002:a1c:2395:: with SMTP id
 j143mr10478656wmj.128.1574350613059; 
 Thu, 21 Nov 2019 07:36:53 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id m15sm3970933wrj.52.2019.11.21.07.36.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Nov 2019 07:36:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] target/i386: add support for MSR_IA32_TSX_CTRL
Date: Thu, 21 Nov 2019 16:36:47 +0100
Message-Id: <1574350609-29518-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574350609-29518-1-git-send-email-pbonzini@redhat.com>
References: <1574350609-29518-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The MSR_IA32_TSX_CTRL MSR can be used to hide TSX (also known as the
Trusty Side-channel Extension).  By virtualizing the MSR, KVM guests
can disable TSX and avoid paying the price of mitigating TSX-based
attacks on microarchitectural side channels.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c     |  2 +-
 target/i386/cpu.h     |  5 +++++
 target/i386/kvm.c     | 13 +++++++++++++
 target/i386/machine.c | 20 ++++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 056874f..9cd9adf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1204,7 +1204,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
             "rdctl-no", "ibrs-all", "rsba", "skip-l1dfl-vmentry",
-            "ssb-no", "mds-no", "pschange-mc-no", NULL,
+            "ssb-no", "mds-no", "pschange-mc-no", "tsx-ctrl",
             "taa-no", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5352c9f..cde2a16 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -349,7 +349,11 @@ typedef enum X86Seg {
 #define MSR_VIRT_SSBD                   0xc001011f
 #define MSR_IA32_PRED_CMD               0x49
 #define MSR_IA32_CORE_CAPABILITY        0xcf
+
 #define MSR_IA32_ARCH_CAPABILITIES      0x10a
+#define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
+
+#define MSR_IA32_TSX_CTRL		0x122
 #define MSR_IA32_TSCDEADLINE            0x6e0
 
 #define FEATURE_CONTROL_LOCKED                    (1<<0)
@@ -1449,6 +1453,7 @@ typedef struct CPUX86State {
     uint64_t msr_smi_count;
 
     uint32_t pkru;
+    uint32_t tsx_ctrl;
 
     uint64_t spec_ctrl;
     uint64_t virt_ssbd;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index bfd09bd..bf16556 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -97,6 +97,7 @@ static bool has_msr_hv_reenlightenment;
 static bool has_msr_xss;
 static bool has_msr_umwait;
 static bool has_msr_spec_ctrl;
+static bool has_msr_tsx_ctrl;
 static bool has_msr_virt_ssbd;
 static bool has_msr_smi_count;
 static bool has_msr_arch_capabs;
@@ -2036,6 +2037,9 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_SPEC_CTRL:
                 has_msr_spec_ctrl = true;
                 break;
+            case MSR_IA32_TSX_CTRL:
+                has_msr_tsx_ctrl = true;
+                break;
             case MSR_VIRT_SSBD:
                 has_msr_virt_ssbd = true;
                 break;
@@ -2694,6 +2698,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     if (has_msr_spec_ctrl) {
         kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, env->spec_ctrl);
     }
+    if (has_msr_tsx_ctrl) {
+        kvm_msr_entry_add(cpu, MSR_IA32_TSX_CTRL, env->tsx_ctrl);
+    }
     if (has_msr_virt_ssbd) {
         kvm_msr_entry_add(cpu, MSR_VIRT_SSBD, env->virt_ssbd);
     }
@@ -3110,6 +3117,9 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (has_msr_spec_ctrl) {
         kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, 0);
     }
+    if (has_msr_tsx_ctrl) {
+        kvm_msr_entry_add(cpu, MSR_IA32_TSX_CTRL, 0);
+    }
     if (has_msr_virt_ssbd) {
         kvm_msr_entry_add(cpu, MSR_VIRT_SSBD, 0);
     }
@@ -3502,6 +3512,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_SPEC_CTRL:
             env->spec_ctrl = msrs[i].data;
             break;
+        case MSR_IA32_TSX_CTRL:
+            env->tsx_ctrl = msrs[i].data;
+            break;
         case MSR_VIRT_SSBD:
             env->virt_ssbd = msrs[i].data;
             break;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 7bdeb78..2699eed 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1293,6 +1293,25 @@ static const VMStateDescription vmstate_efer32 = {
 };
 #endif
 
+static bool msr_tsx_ctrl_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->features[FEAT_ARCH_CAPABILITIES] & ARCH_CAP_TSX_CTRL_MSR;
+}
+
+static const VMStateDescription vmstate_msr_tsx_ctrl = {
+    .name = "cpu/msr_tsx_ctrl",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = msr_tsx_ctrl_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.tsx_ctrl, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
@@ -1427,6 +1446,7 @@ VMStateDescription vmstate_x86_cpu = {
 #ifdef CONFIG_KVM
         &vmstate_nested_state,
 #endif
+        &vmstate_msr_tsx_ctrl,
         NULL
     }
 };
-- 
1.8.3.1



