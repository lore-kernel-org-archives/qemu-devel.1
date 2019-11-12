Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DBEC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 03:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1DA2084E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 03:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar5AXk2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1DA2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUMxt-0001px-0m
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 22:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lantianyu1986@gmail.com>) id 1iUMxE-0001KY-R8
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 22:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lantianyu1986@gmail.com>) id 1iUMxD-0005vl-KT
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 22:34:56 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lantianyu1986@gmail.com>)
 id 1iUMxD-0005vC-Cr
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 22:34:55 -0500
Received: by mail-pg1-x543.google.com with SMTP id z188so4967697pgb.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 19:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=RjB3o0NjWZXINNESvPz4COiSojg7wROs/y6CgxKZ/Pw=;
 b=Ar5AXk2psvjukJXi6gdH+xtvXmPp9uIXKwTYX28+pv4edMenYVt2Q9cSx6Sir1B8To
 U/Mp7UNwz4u9P6dJcQtjMhdBxKtaekycaC+pbD1ure7q3xluNVB4AY694Wdw5hhbXVnj
 LCOw7QFIpSTm4GC9WPrTKXscJfsQ5h8EPGAgNsqrxdBSfO9qYez338FgkBWHcDsFytET
 4/fJcb2Qp8DPFg75MLd5Ed36cVo8VjZ3GhwtHY9VWQHzYNHgzp95trzk4oApjEOf1+Sv
 GdWYuiYl0LWZalpZUzwibW2heGA4Ks6Bn4tUENTyBrSlyKKZ4H+7oZX0er/id3Ug2alL
 KMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=RjB3o0NjWZXINNESvPz4COiSojg7wROs/y6CgxKZ/Pw=;
 b=A1NdleHDwT5Pccw35edVBk6peafY+4ZmvVTAJeBSh8dzi3wg8BeDDFyjyPWh3HRTsd
 qJEU8ZvcQoSQnPrp2TI1SsxHIWCQywhVek17MWq3JkCVPKbGQnvlUYmSuxLt2Fu+28sS
 01T2v9puAx/HpyfDOca/qtbovuevZdsroiMs4kdpejWbNX5hY/8DADrmpPrTdbXiw3l4
 SVOZKzoABW8oFgbL/fFjsVGXN8DxVa+4xUvld5ZDrpFwaKC2Rp4Lx7bufUIiTLVkqQXP
 DDBw0ooLhdv6gZOGQAJV6or/3w3QKMAyjx4Keju6YSqUAZMcu8d27g0t/3ydSgAyr6g6
 aH8A==
X-Gm-Message-State: APjAAAVWrxvxzoP8oU78XnYIifbdsH3kNv0kGRMGIVRs7wAy7k0voaY6
 pbVmXkXoZJRVLLf3O5ekhuA=
X-Google-Smtp-Source: APXvYqxm3G75qyaUjRQQIkPwyZGO7sh/u2z8W5LqAbtVsVJkIsjXh8sN7kIATp92EqxAESEhDElMYQ==
X-Received: by 2002:a65:46c1:: with SMTP id n1mr11037437pgr.257.1573529693925; 
 Mon, 11 Nov 2019 19:34:53 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
 by smtp.googlemail.com with ESMTPSA id f5sm114018pjp.1.2019.11.11.19.34.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Nov 2019 19:34:53 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 mtosatti@redhat.com, rkagan@virtuozzo.com, vkuznets@redhat.com
Subject: [PATCH V4] target/i386/kvm: Add Hyper-V direct tlb flush support
Date: Tue, 12 Nov 2019 11:34:27 +0800
Message-Id: <20191112033427.7204-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V direct tlb flush targets KVM on Hyper-V guest.
Enable direct TLB flush for its guests meaning that TLB
flush hypercalls are handled by Level 0 hypervisor (Hyper-V)
bypassing KVM in Level 1. Due to the different ABI for hypercall
parameters between Hyper-V and KVM, KVM capabilities should be
hidden when enable Hyper-V direct tlb flush otherwise KVM
hypercalls may be intercepted by Hyper-V. Add new parameter
"hv-direct-tlbflush". Check expose_kvm and Hyper-V tlb flush
capability status before enabling the feature.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v3:
       - Fix logic of Hyper-V passthrough mode with direct
       tlb flush.

Change sicne v2:
       - Update new feature description and name.
       - Change failure print log.

Change since v1:
       - Add direct tlb flush's Hyper-V property and use
       hv_cpuid_check_and_set() to check the dependency of tlbflush
       feature.
       - Make new feature work with Hyper-V passthrough mode.
---
 docs/hyperv.txt   | 10 ++++++++++
 target/i386/cpu.c |  2 ++
 target/i386/cpu.h |  1 +
 target/i386/kvm.c | 24 ++++++++++++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/docs/hyperv.txt b/docs/hyperv.txt
index 8fdf25c829..140a5c7e44 100644
--- a/docs/hyperv.txt
+++ b/docs/hyperv.txt
@@ -184,6 +184,16 @@ enabled.
 
 Requires: hv-vpindex, hv-synic, hv-time, hv-stimer
 
+3.18. hv-direct-tlbflush
+=======================
+Enable direct TLB flush for KVM when it is running as a nested
+hypervisor on top Hyper-V. When enabled, TLB flush hypercalls from L2
+guests are being passed through to L0 (Hyper-V) for handling. Due to ABI
+differences between Hyper-V and KVM hypercalls, L2 guests will not be
+able to issue KVM hypercalls (as those could be mishanled by L0
+Hyper-V), this requires KVM hypervisor signature to be hidden.
+
+Requires: hv-tlbflush, -kvm
 
 4. Development features
 ========================
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 44f1bbdcac..7bc7fee512 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6156,6 +6156,8 @@ static Property x86_cpu_properties[] = {
                       HYPERV_FEAT_IPI, 0),
     DEFINE_PROP_BIT64("hv-stimer-direct", X86CPU, hyperv_features,
                       HYPERV_FEAT_STIMER_DIRECT, 0),
+    DEFINE_PROP_BIT64("hv-direct-tlbflush", X86CPU, hyperv_features,
+                      HYPERV_FEAT_DIRECT_TLBFLUSH, 0),
     DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, false),
 
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index eaa5395aa5..3cb105f7d6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -907,6 +907,7 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define HYPERV_FEAT_EVMCS               12
 #define HYPERV_FEAT_IPI                 13
 #define HYPERV_FEAT_STIMER_DIRECT       14
+#define HYPERV_FEAT_DIRECT_TLBFLUSH     15
 
 #ifndef HYPERV_SPINLOCK_NEVER_RETRY
 #define HYPERV_SPINLOCK_NEVER_RETRY             0xFFFFFFFF
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 11b9c854b5..43f5cbc3f6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -900,6 +900,10 @@ static struct {
         },
         .dependencies = BIT(HYPERV_FEAT_STIMER)
     },
+    [HYPERV_FEAT_DIRECT_TLBFLUSH] = {
+        .desc = "direct paravirtualized TLB flush (hv-direct-tlbflush)",
+        .dependencies = BIT(HYPERV_FEAT_TLBFLUSH)
+    },
 };
 
 static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
@@ -1224,6 +1228,7 @@ static int hyperv_handle_properties(CPUState *cs,
     r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_EVMCS);
     r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_IPI);
     r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_STIMER_DIRECT);
+    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_DIRECT_TLBFLUSH);
 
     /* Additional dependencies not covered by kvm_hyperv_properties[] */
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
@@ -1243,6 +1248,25 @@ static int hyperv_handle_properties(CPUState *cs,
         goto free;
     }
 
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_DIRECT_TLBFLUSH)) {
+        if (kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_DIRECT_TLBFLUSH, 0, 0)) {
+            if (!cpu->hyperv_passthrough) {
+                fprintf(stderr,
+                    "Hyper-V %s is not supported by kernel\n",
+                    kvm_hyperv_properties[HYPERV_FEAT_DIRECT_TLBFLUSH].desc);
+                return -ENOSYS;
+            }
+
+            cpu->hyperv_features &= ~BIT(HYPERV_FEAT_DIRECT_TLBFLUSH);
+        } else if (cpu->expose_kvm) {
+            fprintf(stderr,
+                "Hyper-V %s requires KVM hypervisor signature "
+                "to be hidden (-kvm).\n",
+                kvm_hyperv_properties[HYPERV_FEAT_DIRECT_TLBFLUSH].desc);
+            return -ENOSYS;
+        }
+    }
+
     if (cpu->hyperv_passthrough) {
         /* We already copied all feature words from KVM as is */
         r = cpuid->nent;
-- 
2.14.5


