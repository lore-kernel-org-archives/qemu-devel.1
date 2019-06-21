Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2520AC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 01:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F4C2084A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 01:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6d0U7k6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F4C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54068 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he8l0-0004o7-8Z
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 21:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40790)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8Zg-0006OC-9B
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8Zc-0006GK-W9
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:43 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45945)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1he8Zc-0006E4-Lz
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:40 -0400
Received: by mail-wr1-x430.google.com with SMTP id f9so4835845wre.12
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Iq0W4QsPIXfjOn4JNS6Kd8bNeG3F7+GRE1ESQz9CIvE=;
 b=L6d0U7k6n1jHkXg8Ft90EM3hgq8ZH2V8mczoPKLNRjeI0g0+jgqHRHScNVa6RMl4N3
 U5ih8fq0VXDwxANtpn1sg7c3PJT1ZuOcQMAcxlxcD5FkiIUYi6xMrQzT6x9y4npZSci2
 XKfxbCIPQjTgrwmhldfzSVuyqSgqGU+Ukb6go8FNw2yAxnGWf1QG1FHd0a98jKg7w6AL
 9R7U8AkpXaJaOjCehx7kLN5aEmqpxG3dgs21WEi3+1aW9DNn4GM6n3b/ndZXSLgGToUG
 xtRwoEjYoHKy3DrSiDyslxTcVW6WVR4yS4UJ0mOsx//Bpt8GSDb6vURMA5yhEn+tpPD0
 +r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Iq0W4QsPIXfjOn4JNS6Kd8bNeG3F7+GRE1ESQz9CIvE=;
 b=lklhFLWDVhNG9/Z1MCE7Q5a0Ya6FWjMdzxLdKf2GdXEHlm0IxCT5gCYNemjsoBkogB
 KTZqcq3a8X5Qr90tNQ6mzUXwsPDSNexWYIMy7LfKZfCNN/AE7Yxtz+i90VQKYDF9P0Tu
 GiDHXfgnVJNZM3XkQdORMoNmu61ToOglOPDn8hoKW7y4oBe6Vv1UyTTfGH5Ji144+CTT
 rJoqph4xwSt+VEX2RmmDsGXQsjojMi/fFzvocbylXubuEKCr5pGMuuM0htmIUA1N79YH
 G9DBeW+POd8h1UD6ceBkJ59wmeVD33wZbNA8hlz+ksnEaF4+vSf498jlWqLAsNmfsvO3
 hUkg==
X-Gm-Message-State: APjAAAWvCszQ10lr8uwtY9sWsXp5XM3jHLf+sJklhukeeKoLTIBUsdI7
 LTAfJc2JGiARRiaQasaIyNSibXHa
X-Google-Smtp-Source: APXvYqy8WbTVCekVmHqN9QQPC7jKo0W+1vK2vNJOTr3Lxvk3yo+ef2FYEN+IVW5OFzS5lu7OZlxY6g==
X-Received: by 2002:a5d:53c2:: with SMTP id a2mr42080186wrw.8.1561081359003;
 Thu, 20 Jun 2019 18:42:39 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d1sm1123125wru.41.2019.06.20.18.42.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:42:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 03:42:11 +0200
Message-Id: <1561081350-3723-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
References: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL 06/25] i386/kvm: document existing Hyper-V
 enlightenments
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Currently, there is no doc describing hv-* CPU flags, people are
encouraged to get the information from Microsoft Hyper-V Top Level
Functional specification (TLFS). There is, however, a bit of QEMU
specifics.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20190517141924.19024-5-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/hyperv.txt | 181 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 docs/hyperv.txt

diff --git a/docs/hyperv.txt b/docs/hyperv.txt
new file mode 100644
index 0000000..c423e0f
--- /dev/null
+++ b/docs/hyperv.txt
@@ -0,0 +1,181 @@
+Hyper-V Enlightenments
+======================
+
+
+1. Description
+===============
+In some cases when implementing a hardware interface in software is slow, KVM
+implements its own paravirtualized interfaces. This works well for Linux as
+guest support for such features is added simultaneously with the feature itself.
+It may, however, be hard-to-impossible to add support for these interfaces to
+proprietary OSes, namely, Microsoft Windows.
+
+KVM on x86 implements Hyper-V Enlightenments for Windows guests. These features
+make Windows and Hyper-V guests think they're running on top of a Hyper-V
+compatible hypervisor and use Hyper-V specific features.
+
+
+2. Setup
+=========
+No Hyper-V enlightenments are enabled by default by either KVM or QEMU. In
+QEMU, individual enlightenments can be enabled through CPU flags, e.g:
+
+  qemu-system-x86_64 --enable-kvm --cpu host,hv_relaxed,hv_vpindex,hv_time, ...
+
+Sometimes there are dependencies between enlightenments, QEMU is supposed to
+check that the supplied configuration is sane.
+
+When any set of the Hyper-V enlightenments is enabled, QEMU changes hypervisor
+identification (CPUID 0x40000000..0x4000000A) to Hyper-V. KVM identification
+and features are kept in leaves 0x40000100..0x40000101.
+
+
+3. Existing enlightenments
+===========================
+
+3.1. hv-relaxed
+================
+This feature tells guest OS to disable watchdog timeouts as it is running on a
+hypervisor. It is known that some Windows versions will do this even when they
+see 'hypervisor' CPU flag.
+
+3.2. hv-vapic
+==============
+Provides so-called VP Assist page MSR to guest allowing it to work with APIC
+more efficiently. In particular, this enlightenment allows paravirtualized
+(exit-less) EOI processing.
+
+3.3. hv-spinlocks=xxx
+======================
+Enables paravirtualized spinlocks. The parameter indicates how many times
+spinlock acquisition should be attempted before indicating the situation to the
+hypervisor. A special value 0xffffffff indicates "never to retry".
+
+3.4. hv-vpindex
+================
+Provides HV_X64_MSR_VP_INDEX (0x40000002) MSR to the guest which has Virtual
+processor index information. This enlightenment makes sense in conjunction with
+hv-synic, hv-stimer and other enlightenments which require the guest to know its
+Virtual Processor indices (e.g. when VP index needs to be passed in a
+hypercall).
+
+3.5. hv-runtime
+================
+Provides HV_X64_MSR_VP_RUNTIME (0x40000010) MSR to the guest. The MSR keeps the
+virtual processor run time in 100ns units. This gives guest operating system an
+idea of how much time was 'stolen' from it (when the virtual CPU was preempted
+to perform some other work).
+
+3.6. hv-crash
+==============
+Provides HV_X64_MSR_CRASH_P0..HV_X64_MSR_CRASH_P5 (0x40000100..0x40000105) and
+HV_X64_MSR_CRASH_CTL (0x40000105) MSRs to the guest. These MSRs are written to
+by the guest when it crashes, HV_X64_MSR_CRASH_P0..HV_X64_MSR_CRASH_P5 MSRs
+contain additional crash information. This information is outputted in QEMU log
+and through QAPI.
+Note: unlike under genuine Hyper-V, write to HV_X64_MSR_CRASH_CTL causes guest
+to shutdown. This effectively blocks crash dump generation by Windows.
+
+3.7. hv-time
+=============
+Enables two Hyper-V-specific clocksources available to the guest: MSR-based
+Hyper-V clocksource (HV_X64_MSR_TIME_REF_COUNT, 0x40000020) and Reference TSC
+page (enabled via MSR HV_X64_MSR_REFERENCE_TSC, 0x40000021). Both clocksources
+are per-guest, Reference TSC page clocksource allows for exit-less time stamp
+readings. Using this enlightenment leads to significant speedup of all timestamp
+related operations.
+
+3.8. hv-synic
+==============
+Enables Hyper-V Synthetic interrupt controller - an extension of a local APIC.
+When enabled, this enlightenment provides additional communication facilities
+to the guest: SynIC messages and Events. This is a pre-requisite for
+implementing VMBus devices (not yet in QEMU). Additionally, this enlightenment
+is needed to enable Hyper-V synthetic timers. SynIC is controlled through MSRs
+HV_X64_MSR_SCONTROL..HV_X64_MSR_EOM (0x40000080..0x40000084) and
+HV_X64_MSR_SINT0..HV_X64_MSR_SINT15 (0x40000090..0x4000009F)
+
+Requires: hv-vpindex
+
+3.9. hv-stimer
+===============
+Enables Hyper-V synthetic timers. There are four synthetic timers per virtual
+CPU controlled through HV_X64_MSR_STIMER0_CONFIG..HV_X64_MSR_STIMER3_COUNT
+(0x400000B0..0x400000B7) MSRs. These timers can work either in single-shot or
+periodic mode. It is known that certain Windows versions revert to using HPET
+(or even RTC when HPET is unavailable) extensively when this enlightenment is
+not provided; this can lead to significant CPU consumption, even when virtual
+CPU is idle.
+
+Requires: hv-vpindex, hv-synic, hv-time
+
+3.10. hv-tlbflush
+==================
+Enables paravirtualized TLB shoot-down mechanism. On x86 architecture, remote
+TLB flush procedure requires sending IPIs and waiting for other CPUs to perform
+local TLB flush. In virtualized environment some virtual CPUs may not even be
+scheduled at the time of the call and may not require flushing (or, flushing
+may be postponed until the virtual CPU is scheduled). hv-tlbflush enlightenment
+implements TLB shoot-down through hypervisor enabling the optimization.
+
+Requires: hv-vpindex
+
+3.11. hv-ipi
+=============
+Enables paravirtualized IPI send mechanism. HvCallSendSyntheticClusterIpi
+hypercall may target more than 64 virtual CPUs simultaneously, doing the same
+through APIC requires more than one access (and thus exit to the hypervisor).
+
+Requires: hv-vpindex
+
+3.12. hv-vendor-id=xxx
+=======================
+This changes Hyper-V identification in CPUID 0x40000000.EBX-EDX from the default
+"Microsoft Hv". The parameter should be no longer than 12 characters. According
+to the specification, guests shouldn't use this information and it is unknown
+if there is a Windows version which acts differently.
+Note: hv-vendor-id is not an enlightenment and thus doesn't enable Hyper-V
+identification when specified without some other enlightenment.
+
+3.13. hv-reset
+===============
+Provides HV_X64_MSR_RESET (0x40000003) MSR to the guest allowing it to reset
+itself by writing to it. Even when this MSR is enabled, it is not a recommended
+way for Windows to perform system reboot and thus it may not be used.
+
+3.14. hv-frequencies
+============================================
+Provides HV_X64_MSR_TSC_FREQUENCY (0x40000022) and HV_X64_MSR_APIC_FREQUENCY
+(0x40000023) allowing the guest to get its TSC/APIC frequencies without doing
+measurements.
+
+3.15 hv-reenlightenment
+========================
+The enlightenment is nested specific, it targets Hyper-V on KVM guests. When
+enabled, it provides HV_X64_MSR_REENLIGHTENMENT_CONTROL (0x40000106),
+HV_X64_MSR_TSC_EMULATION_CONTROL (0x40000107)and HV_X64_MSR_TSC_EMULATION_STATUS
+(0x40000108) MSRs allowing the guest to get notified when TSC frequency changes
+(only happens on migration) and keep using old frequency (through emulation in
+the hypervisor) until it is ready to switch to the new one. This, in conjunction
+with hv-frequencies, allows Hyper-V on KVM to pass stable clocksource (Reference
+TSC page) to its own guests.
+
+Recommended: hv-frequencies
+
+3.16. hv-evmcs
+===============
+The enlightenment is nested specific, it targets Hyper-V on KVM guests. When
+enabled, it provides Enlightened VMCS feature to the guest. The feature
+implements paravirtualized protocol between L0 (KVM) and L1 (Hyper-V)
+hypervisors making L2 exits to the hypervisor faster. The feature is Intel-only.
+Note: some virtualization features (e.g. Posted Interrupts) are disabled when
+hv-evmcs is enabled. It may make sense to measure your nested workload with and
+without the feature to find out if enabling it is beneficial.
+
+Requires: hv-vapic
+
+
+4. Useful links
+================
+Hyper-V Top Level Functional specification and other information:
+https://github.com/MicrosoftDocs/Virtualization-Documentation
-- 
1.8.3.1



