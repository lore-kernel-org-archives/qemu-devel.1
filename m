Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3043BC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8EB206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhxZA+fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8EB206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipApi-00079c-W6
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWZ-00042f-Hy
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWY-0004Ry-84
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:23 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:35060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWY-0004RO-1r
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:22 -0500
Received: by mail-wr1-x435.google.com with SMTP id g17so3219927wro.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UeENLvRwrDsNkqw+B9afODa0EzPzMsyGlro5fDioYQ4=;
 b=uhxZA+fcpFGZkJxCF0Qw7W4oES8cuOWk88MnvMC74dlwsbHRm5TMMm0UfKFej6teJU
 oCUIvXZrm5UEE0UJXxkxVW6vbSK9dO3R/hAYiL4ljuSUCfvksS/DeEceqv2u84Sch4Pq
 4qCn1BK3qyLB5/k1wVo1eISZaIFrJtYwj8BSHlfl2jWM0zSKn12VYCdpy4/NdlL/igQF
 m3ffUNyMLRI6upmxhkp+S8qX958NPhH9Xa8rleCa5HmGwD3JVXAUp1+rkNvv1jcGM6q3
 FJX5j0rY2YljpGvx302LGtQgDAEj9v9RCUD3LsEgihwnO3ahZDmyE/6Z4+66zRzJ0ZiK
 PSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=UeENLvRwrDsNkqw+B9afODa0EzPzMsyGlro5fDioYQ4=;
 b=MAztcjSt9P6HRBDVc0r6or1PIDrmy6RNQtK+9gLN7N53A8lvBt4zqT+x3Nor+etS/4
 N/8kslcG2CT4p0kHRUKVv4wVFWeAOusGWeW8/dLhHkcpITnpLzNAs0/dqdSn1pjn8Uc5
 qWDISgCWw9yLo7VKJVVNaLHeGerdPT8Cev5ahW4MsIVXLicrlktY+rhmO5pvogArfguk
 bGE+h/vK66X64TYM7ika1oiSD0mIajIRHSQ9saTSXkfbdkGeTSeOQWrZSWXP7oW4ZsvV
 Wh8c70hsdguwrbtQZdFdV8cmIUY+UucYJfd226PGrhIBzdJkvRL1q0gvaLp4vgcg9ecE
 CnFQ==
X-Gm-Message-State: APjAAAWnMwAfh62sAeyk4mN/u7DgYwORd1avi85VwF+3wG/xCzov849R
 jPcuksPvBBEmNykK5jrwcOZw+bWp
X-Google-Smtp-Source: APXvYqzNITZ/My5eZyTBBG5Iicdwvi2V349rc6JrfxWBLfPzkutf2PejGVUBfJ0QGYeBTwHxfNVl2w==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr4264098wrn.280.1578486800886; 
 Wed, 08 Jan 2020 04:33:20 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/38] target/i386: Add missed features to Cooperlake CPU model
Date: Wed,  8 Jan 2020 13:32:40 +0100
Message-Id: <1578486775-52247-24-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xiaoyao Li <xiaoyao.li@intel.com>

It lacks VMX features and two security feature bits (disclosed recently) in
MSR_IA32_ARCH_CAPABILITIES in current Cooperlake CPU model, so add them.

Fixes: 22a866b6166d ("i386: Add new CPU model Cooperlake")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20191225063018.20038-3-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 31556b7..41f28ce 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3198,7 +3198,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EDX_SPEC_CTRL_SSBD | CPUID_7_0_EDX_ARCH_CAPABILITIES,
         .features[FEAT_ARCH_CAPABILITIES] =
             MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
-            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO,
+            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
+            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_TAA_NO,
         .features[FEAT_7_1_EAX] =
             CPUID_7_1_EAX_AVX512_BF16,
         /*
@@ -3213,6 +3214,54 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Cooperlake)",
     },
-- 
1.8.3.1



