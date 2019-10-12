Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4452CC4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 03:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106B52067B
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 03:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqpvzdog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106B52067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ8Iu-0004w9-8z
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 23:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lantianyu1986@gmail.com>) id 1iJ8IC-0004X4-2x
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 23:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lantianyu1986@gmail.com>) id 1iJ8IA-0002ae-Lm
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 23:42:07 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lantianyu1986@gmail.com>)
 id 1iJ8IA-0002aG-E4
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 23:42:06 -0400
Received: by mail-pg1-x544.google.com with SMTP id b8so6840526pgm.13
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 20:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=GZeFYLsCbWX3apu2MdiEFh9Sy8YdIPqXB58kHqtr/Y8=;
 b=lqpvzdognJAYXQUoX6/ALFsg7p1Yo6zo7/1SUDSjsQgWcjMp4iOgapdSBAGwIppui0
 lP6l5l6JvLKfT13BHWz4U5EbLEMOzgXcXVp20NHJG/vDj6U8ccNjNtnCroDifS2kqY5P
 mHt47mDoV1nTT+R5jE9BvUd8d2+igUFQGP92UOI0EVDvF8wGgS1N83lTHQzXztSjP1lh
 ws2p9jb99kiQi12LrHikeQ9iu2sIteL2iVQ8oVwyIhmglwGAV3mBzlQHzy8XtgmwmBRs
 DWItLSdE8Lzr33AwaKXRp73H+TOdikGr1s1MpxDZDUtow9dyiM4Podw8HSLaxA/eT9Ew
 76+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=GZeFYLsCbWX3apu2MdiEFh9Sy8YdIPqXB58kHqtr/Y8=;
 b=lGi/Ayw71gbJh5zQ9nY/Zr+sJtjCtBM0tZzLLFkUaeMbosgPlTOE4OHMRgwG5Nnjke
 PUPySSmkGP01pitcH2TO2jQYPO8KDDUPf1RN2UKXiCb4GySE5rRo5BOBUa801mnHFBX2
 eoqIa7LonR3paswkXyy94VGzq/QNWCmmFwgIf9X2OdYkgost1ka3SQJkdFKfd8DKER5+
 CrxNqGfHVCIUfnaRlykok92byEOlY03JbRHRgJGRTF+q4BPTB0gEWToOT0gQ3hhybjYU
 EKHYZ0lpBL3W4yTyytcvZnTvT+YULY2/Uu02dGckrwpFOt1ODG/eSf1HdosB6WS3/2ae
 Mvrw==
X-Gm-Message-State: APjAAAURDJ3p8HNCjm7hZrgrXQVOKXsE5waf8y4Urg8HQ/1xb/KAcKGZ
 cYo79fb7fKTeeRch7JHPpKo=
X-Google-Smtp-Source: APXvYqwhCGJrhNIlOhl/+bRtU2W9TAdYBDoyIW3dkdjMr2gMMRKREEufY01eo/4AQPTNN0h7OGbduw==
X-Received: by 2002:a63:e013:: with SMTP id e19mr21341809pgh.274.1570851725070; 
 Fri, 11 Oct 2019 20:42:05 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.255.39])
 by smtp.googlemail.com with ESMTPSA id m34sm18129460pgb.91.2019.10.11.20.42.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Oct 2019 20:42:04 -0700 (PDT)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, mtosatti@redhat.com, vkuznets@redhat.com
Subject: [PATCH] target/i386/kvm: Add Hyper-V direct tlb flush support
Date: Sat, 12 Oct 2019 11:41:53 +0800
Message-Id: <20191012034153.31817-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
 docs/hyperv.txt           | 12 ++++++++++++
 linux-headers/linux/kvm.h |  1 +
 target/i386/cpu.c         |  2 ++
 target/i386/cpu.h         |  1 +
 target/i386/kvm.c         | 21 +++++++++++++++++++++
 5 files changed, 37 insertions(+)

diff --git a/docs/hyperv.txt b/docs/hyperv.txt
index 8fdf25c829..ceab8c21fe 100644
--- a/docs/hyperv.txt
+++ b/docs/hyperv.txt
@@ -184,6 +184,18 @@ enabled.
 
 Requires: hv-vpindex, hv-synic, hv-time, hv-stimer
 
+3.18. hv-direct-tlbflush
+=======================
+The enlightenment targets KVM on Hyper-V guest. Enable direct TLB flush for
+its guests meaning that TLB flush hypercalls are handled by Level 0 hypervisor
+(Hyper-V) bypassing KVM in Level 1. Due to the different ABI for hypercall
+parameters between Hyper-V and KVM, enabling this capability effectively
+disables all hypercall handling by KVM (as some KVM hypercall may be mistakenly
+treated as TLB flush hypercalls by Hyper-V). So kvm capability should not show
+to guest when enable this capability. If not, user will fail to enable this
+capability.
+
+Requires: hv-tlbflush, -kvm
 
 4. Development features
 ========================
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 18892d6541..923fb33a01 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -995,6 +995,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_SVE 170
 #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
 #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
+#define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 174
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
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
index 11b9c854b5..8e999dbcf1 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1235,6 +1235,27 @@ static int hyperv_handle_properties(CPUState *cs,
         r |= 1;
     }
 
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_DIRECT_TLBFLUSH)) {
+        if (!kvm_check_extension(cs->kvm_state,
+            KVM_CAP_HYPERV_DIRECT_TLBFLUSH)) {
+            fprintf(stderr,
+                    "Kernel doesn't support Hyper-V direct tlbflush.\n");
+            r = -ENOSYS;
+            goto free;
+        }
+
+        if (cpu->expose_kvm ||
+            !hyperv_feat_enabled(cpu, HYPERV_FEAT_TLBFLUSH)) {
+            fprintf(stderr, "Hyper-V direct tlbflush requires Hyper-V %s"
+                    " and not expose KVM.\n",
+                    kvm_hyperv_properties[HYPERV_FEAT_TLBFLUSH].desc);
+            r = -ENOSYS;
+            goto free;
+        }
+
+        kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_DIRECT_TLBFLUSH, 0, 0);
+    }
+
     /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
     env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
 
-- 
2.14.5


