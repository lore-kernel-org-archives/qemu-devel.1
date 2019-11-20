Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_75_100,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555D2C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB92820715
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbQ5/go3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB92820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXTyE-0001rl-Py
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iXTvW-0008KO-GD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iXTvS-0004vg-3z
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:38:02 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iXTvR-0004vM-NL
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:37:58 -0500
Received: by mail-wm1-x344.google.com with SMTP id j18so5677686wmk.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 09:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9BBNZ6fGCpd/ny8uLn7cPu8BRR4Te8RntZAwzYRNcOI=;
 b=HbQ5/go3xeGAtH2u1wgfJTJisgjVrO61AEeKBDhgdgX9kJ3m8tg9wES2znwAEHISFI
 WwbTQcEwNjbRED6iL23NbV9egujl9nXoBmj1nXjJERnkUq1yjCwVQc2fiLk1CDoxMypo
 4557yC5Wmu1NTp+b/spXCmE7SreN9qv1B/EG7YQqjO+F2zJXgN2PHE55wYoJhuYoQEKg
 NlQofNmAYkI12ypDGevwyw+ntD/fUqQHROMwc3ZM4GyphyWrhm9DLeH6gFfHRW7FV+DJ
 ADivfATVOwy4fNMdkjjhO8B3IIPa0wj5qOltAr1Zgx0j3Q0qOA8IV7pj/Xp8Ms5hP+6x
 iyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=9BBNZ6fGCpd/ny8uLn7cPu8BRR4Te8RntZAwzYRNcOI=;
 b=STah8XMwfRWjBbyDUeZARLyVZqbAfXwVySR5CR3Fboe5P25DAqlH9KbYbpxNjgkZWU
 ACdYHg/c+CrHxr8YnQOZ5smECyLP0hCv12Nb3zjLb7grguBDGwBYyUOxXVzjK2EDjPRP
 JgU6j6EIZPAIbkjOoUHgUHg/x7OuXhkMrZ9FNCLD8xZENhRCDhPjvoUQNwj5EVowUz61
 pVsK7qko7l2/nzfYqbjSty8PR1C+AjyusxcGGZvtH6Kh2BUm/1c5Va39VWC8hZ4vR5EX
 tGV52ulNtgbZcnG8zmdm0pfpFyVUlzOphttDNijUalARU3Ukw/vgXJOXOm5a/YdBDXa4
 jPqA==
X-Gm-Message-State: APjAAAVErWaR4ORvOBw/0GRZ6OfGNtMNfrE73eHHzrt5kYSNrEGZ/OKF
 sQV/R10ZQ428/LeFfXk7pmZPywXq
X-Google-Smtp-Source: APXvYqxtfxp3kDTmOeeoL0ccZ4LzE4huJFcz1IJJskfHzy/od9nGphL6QPZQdoefC3nU2xUEyF58DA==
X-Received: by 2002:a1c:46:: with SMTP id 67mr4949036wma.51.1574271475129;
 Wed, 20 Nov 2019 09:37:55 -0800 (PST)
Received: from donizetti.redhat.com ([151.48.115.61])
 by smtp.gmail.com with ESMTPSA id u142sm6796695wmu.40.2019.11.20.09.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 09:37:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: add VMX features to named CPU models
Date: Wed, 20 Nov 2019 18:37:53 +0100
Message-Id: <20191120173753.8894-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

This allows using "-cpu Haswell,+vmx", which we did not really want to
support in QEMU but was produced by Libvirt when using the "host-model"
CPU model.

This was produced from the output of scripts/kvm/vmxcap using the following
very ugly Python script:

    bits = {
            'INS/OUTS instruction information': ['FEAT_VMX_BASIC', 'MSR_VMX_BASIC_INS_OUTS'],
            'IA32_VMX_TRUE_*_CTLS support': ['FEAT_VMX_BASIC', 'MSR_VMX_BASIC_TRUE_CTLS'],
            'External interrupt exiting': ['FEAT_VMX_PINBASED_CTLS', 'VMX_PIN_BASED_EXT_INTR_MASK'],
            'NMI exiting': ['FEAT_VMX_PINBASED_CTLS', 'VMX_PIN_BASED_NMI_EXITING'],
            'Virtual NMIs': ['FEAT_VMX_PINBASED_CTLS', 'VMX_PIN_BASED_VIRTUAL_NMIS'],
            'Activate VMX-preemption timer': ['FEAT_VMX_PINBASED_CTLS', 'VMX_PIN_BASED_VMX_PREEMPTION_TIMER'],
            'Process posted interrupts': ['FEAT_VMX_PINBASED_CTLS', 'VMX_PIN_BASED_POSTED_INTR'],
            'Interrupt window exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_VIRTUAL_INTR_PENDING'],
            'Use TSC offsetting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_USE_TSC_OFFSETING'],
            'HLT exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_HLT_EXITING'],
            'INVLPG exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_INVLPG_EXITING'],
            'MWAIT exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_MWAIT_EXITING'],
            'RDPMC exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_RDPMC_EXITING'],
            'RDTSC exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_RDTSC_EXITING'],
            'CR3-load exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_CR3_LOAD_EXITING'],
            'CR3-store exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_CR3_STORE_EXITING'],
            'CR8-load exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_CR8_LOAD_EXITING'],
            'CR8-store exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_CR8_STORE_EXITING'],
            'Use TPR shadow': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_TPR_SHADOW'],
            'NMI-window exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_VIRTUAL_NMI_PENDING'],
            'MOV-DR exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_MOV_DR_EXITING'],
            'Unconditional I/O exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_UNCOND_IO_EXITING'],
            'Use I/O bitmaps': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_USE_IO_BITMAPS'],
            'Monitor trap flag': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_MONITOR_TRAP_FLAG'],
            'Use MSR bitmaps': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_USE_MSR_BITMAPS'],
            'MONITOR exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_MONITOR_EXITING'],
            'PAUSE exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_PAUSE_EXITING'],
            'Activate secondary control': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS'],
            'Virtualize APIC accesses': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES'],
            'Enable EPT': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_ENABLE_EPT'],
            'Descriptor-table exiting': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_DESC'],
            'Enable RDTSCP': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_RDTSCP'],
            'Virtualize x2APIC mode': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE'],
            'Enable VPID': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_ENABLE_VPID'],
            'WBINVD exiting': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_WBINVD_EXITING'],
            'Unrestricted guest': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST'],
            'APIC register emulation': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT'],
            'Virtual interrupt delivery': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY'],
            'PAUSE-loop exiting': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING'],
            'RDRAND exiting': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_RDRAND_EXITING'],
            'Enable INVPCID': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_ENABLE_INVPCID'],
            'Enable VM functions': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_ENABLE_VMFUNC'],
            'VMCS shadowing': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_SHADOW_VMCS'],
            'RDSEED exiting': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_RDSEED_EXITING'],
            'Enable PML': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_ENABLE_PML'],
            'Enable XSAVES/XRSTORS': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_XSAVES'],
            'Save debug controls': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_SAVE_DEBUG_CONTROLS'],
            'Host address-space size': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE'],
            'Load IA32_PERF_GLOBAL_CTRL': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL'],
            'Acknowledge interrupt on exit': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_ACK_INTR_ON_EXIT'],
            'Save IA32_PAT': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_SAVE_IA32_PAT'],
            'Load IA32_PAT': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_LOAD_IA32_PAT'],
            'Save IA32_EFER': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_SAVE_IA32_EFER'],
            'Load IA32_EFER': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_LOAD_IA32_EFER'],
            'Save VMX-preemption timer value': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER'],
            'Clear IA32_BNDCFGS': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_CLEAR_BNDCFGS'],
            'Load debug controls': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS'],
            'IA-32e mode guest': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_IA32E_MODE'],
            'Load IA32_PERF_GLOBAL_CTRL': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL'],
            'Load IA32_PAT': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_LOAD_IA32_PAT'],
            'Load IA32_EFER': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_LOAD_IA32_EFER'],
            'Load IA32_BNDCFGS': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_LOAD_BNDCFGS'],
            'Store EFER.LMA into IA-32e mode guest control': ['FEAT_VMX_MISC', 'MSR_VMX_MISC_STORE_LMA'],
            'HLT activity state': ['FEAT_VMX_MISC', 'MSR_VMX_MISC_ACTIVITY_HLT'],
            'VMWRITE to VM-exit information fields': ['FEAT_VMX_MISC', 'MSR_VMX_MISC_VMWRITE_VMEXIT'],
            'Inject event with insn length=0': ['FEAT_VMX_MISC', 'MSR_VMX_MISC_ZERO_LEN_INJECT'],
            'Execute-only EPT translations': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_EXECONLY'],
            'Page-walk length 4': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_PAGE_WALK_LENGTH_4'],
            'Paging-structure memory type WB': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_WB'],
            '2MB EPT pages': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_2MB | MSR_VMX_EPT_1GB'],
            'INVEPT supported': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVEPT'],
            'EPT accessed and dirty flags': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_AD_BITS'],
            'Single-context INVEPT': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT'],
            'All-context INVEPT': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVEPT_ALL_CONTEXT'],
            'INVVPID supported': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVVPID'],
            'Individual-address INVVPID': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVVPID_SINGLE_ADDR'],
            'Single-context INVVPID': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT'],
            'All-context INVVPID': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVVPID_ALL_CONTEXT'],
            'Single-context-retaining-globals INVVPID': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS'],
            'EPTP Switching': ['FEAT_VMX_VMFUNC', 'MSR_VMX_VMFUNC_EPT_SWITCHING']
    }

    import sys
    import textwrap

    out = {}
    for l in sys.stdin.readlines():
        l = l.rstrip()
        if l.endswith('!!'):
            l = l[:-2].rstrip()
        if l.startswith('    ') and (l.endswith('default') or l.endswith('yes')):
            l = l[4:]
            for key, value in bits.items():
                if l.startswith(key):
                    ctl, bit = value
                    if ctl in out:
                        out[ctl] = out[ctl] + ' | '
                    else:
                        out[ctl] = '    [%s] = ' % ctl
                    out[ctl] = out[ctl] + bit

    for x in sorted(out.keys()):
        print("\n         ".join(textwrap.wrap(out[x] + ",")))

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 674 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 674 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8447f4b82c..0f38c82903 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1873,6 +1873,24 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_LAHF_LM,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES,
         .xlevel = 0x80000008,
         .model_id = "Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40GHz",
     },
@@ -1900,6 +1918,21 @@ static X86CPUDefinition builtin_x86_defs[] = {
                     CPUID_EXT3_OSVW, CPUID_EXT3_IBS, CPUID_EXT3_SVM */
         .features[FEAT_8000_0001_ECX] =
             0,
+        /* VMX features from Cedar Mill/Prescott */
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING,
         .xlevel = 0x80000008,
         .model_id = "Common KVM processor"
     },
@@ -1931,6 +1964,20 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_SSE3,
         .features[FEAT_8000_0001_ECX] =
             0,
+        /* VMX features from Yonah */
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXITING |
+             VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_EXITING |
+             VMX_CPU_BASED_PAUSE_EXITING | VMX_CPU_BASED_USE_MSR_BITMAPS,
         .xlevel = 0x80000008,
         .model_id = "Common 32-bit KVM processor"
     },
@@ -1952,6 +1999,19 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_SSE3 | CPUID_EXT_MONITOR,
         .features[FEAT_8000_0001_EDX] =
             CPUID_EXT2_NX,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXITING |
+             VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_EXITING |
+             VMX_CPU_BASED_PAUSE_EXITING | VMX_CPU_BASED_USE_MSR_BITMAPS,
         .xlevel = 0x80000008,
         .model_id = "Genuine Intel(R) CPU           T2600  @ 2.16GHz",
     },
@@ -2062,6 +2122,24 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_LAHF_LM,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES,
         .xlevel = 0x80000008,
         .model_id = "Intel Celeron_4x0 (Conroe/Merom Class Core 2)",
     },
@@ -2085,6 +2163,27 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_LAHF_LM,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING,
         .xlevel = 0x80000008,
         .model_id = "Intel Core 2 Duo P9xxx (Penryn Class Core 2)",
     },
@@ -2108,6 +2207,45 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_LAHF_LM,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS |
+             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
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
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID,
         .xlevel = 0x80000008,
         .model_id = "Intel Core i7 9xx (Nehalem Class Core i7)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2148,6 +2286,47 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT3_LAHF_LM,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS |
+             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
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
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING,
         .xlevel = 0x80000008,
         .model_id = "Westmere E56xx/L56xx/X56xx (Nehalem-C)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2193,6 +2372,47 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XSAVEOPT,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS |
+             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
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
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon E312xx (Sandy Bridge)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2241,6 +2461,50 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XSAVEOPT,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS |
+             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA,
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
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon E3-12xx v2 (Ivy Bridge)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2292,6 +2556,52 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XSAVEOPT,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS |
+             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
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
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Core Processor (Haswell)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2376,6 +2686,52 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XSAVEOPT,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS |
+             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
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
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Core Processor (Broadwell)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2460,6 +2816,50 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS |
+             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
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
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Core Processor (Skylake)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2524,6 +2924,52 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS |
+             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
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
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Skylake)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2594,6 +3040,52 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS |
+             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
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
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Cascadelake)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2663,6 +3155,50 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS |
+             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
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
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Core Processor (Icelake)",
     },
@@ -2721,6 +3257,52 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS |
+             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
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
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Icelake)",
     },
@@ -2768,6 +3350,52 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .features[FEAT_ARCH_CAPABILITIES] =
             MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS |
+             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
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
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Atom Processor (Denverton)",
     },
@@ -2838,6 +3466,52 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_IA32_EFER | VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS |
+             VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE |
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
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
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Atom Processor (SnowRidge)",
         .versions = (X86CPUVersionDefinition[]) {
-- 
2.21.0


