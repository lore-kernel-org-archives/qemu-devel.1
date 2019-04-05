Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E947CC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 14:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3DD21726
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 14:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3DD21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43113 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCQBi-0007ss-0G
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 10:51:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hCQ4S-0000at-9u
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hCPqe-0002GT-Ml
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:29:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hCPqd-00024a-7c
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:29:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so6917430wma.2
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 07:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
	:message-id:mime-version;
	bh=iwd5A/QyPxt+8C/qAqRvRP3DEcGXkzuiOkdWtMlQK+A=;
	b=rzA35ic320GknckhNWoxztq4vhAdQFPEP9B3zG+bwlcjpkiEqSYfgZj7eaPDPbwpcN
	7SvqypmwGrIfUVrz49i8Zmn1dKy9oRsoKMDw0vS3WIat9xPAuW34qN7c2lKV4ikaXjJk
	ZkWen7iGK+fibgEY3UvOAo/m+sxAYqYFyB6EG7a/IKfzVQrjFp2lDxwLCZYI4A7pAaGJ
	9Onesz6N4GsTLp6NLgVFq1CAFlsH4Tlnf1SJlnWTY0bO7BMlTOo2A49U4mJ2U84XsHsy
	MNksyH3lTHgbWfMQ3zh/wsfBXw+g0fCpRPiH92S/7k+2rWYV+tbLPKUko1dcwv2RzFRt
	MGhg==
X-Gm-Message-State: APjAAAXE5tzPPMdxU5wyg8C975EsZgwQC88rJsKMCdJ2dNbSCqfXxBZc
	KGL3Og2feC/IEBHBNtSuzwiq/g==
X-Google-Smtp-Source: APXvYqxozL/Wm8m1o3mNWfXUG33AekgQfeeTg1dtK9fDgLCdDksFZLUxapLsWSIiITS19WeM0vzF0A==
X-Received: by 2002:a1c:4602:: with SMTP id t2mr8564537wma.120.1554474573943; 
	Fri, 05 Apr 2019 07:29:33 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
	[213.175.37.10]) by smtp.gmail.com with ESMTPSA id
	t14sm2856296wmi.16.2019.04.05.07.29.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 07:29:32 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>
In-Reply-To: <20190405131923.GB20411@rkaganb.sw.ru>
References: <20190329141832.22882-1-vkuznets@redhat.com>
	<20190329141832.22882-4-vkuznets@redhat.com>
	<20190405131923.GB20411@rkaganb.sw.ru>
Date: Fri, 05 Apr 2019 16:29:22 +0200
Message-ID: <87sguwikzh.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 3/8] i386/kvm: document existing Hyper-V
 enlightenments
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405142922.RNLxzNECrd6LQkWNDWys91f1f3Sg938W4uO3MVw1K8E@z>

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Fri, Mar 29, 2019 at 03:18:27PM +0100, Vitaly Kuznetsov wrote:
>> Currently, there is no doc describing hv-* CPU flags, people are
>> encouraged to get the information from Microsoft Hyper-V Top Level
>> Functional specification (TLFS). There is, however, a bit of QEMU
>> specifics.
>
> This is appreciated a lot, thanks for doing this!
>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  docs/hyperv.txt | 180 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 180 insertions(+)
>>  create mode 100644 docs/hyperv.txt
>> 
>> diff --git a/docs/hyperv.txt b/docs/hyperv.txt
>> new file mode 100644
>> index 0000000000..397f2517b8
>> --- /dev/null
>> +++ b/docs/hyperv.txt
>> @@ -0,0 +1,180 @@
>> +Hyper-V Enlightenments
>> +======================
>> +
>> +
>> +1. Description
>> +===============
>> +In some cases when implementing a hardware interface in software is slow, KVM
>> +implements its own paravirtualized interfaces. This works well for Linux as
>> +guest support for such features is added simultaneously with the feature itself.
>> +It may, however, be hard-to-impossible to add support for these interfaces to
>> +proprietary OSes, namely, Microsoft Windows.
>> +
>> +KVM on x86 implements Hyper-V Enlightenments for Windows guests. These features
>> +make Windows and Hyper-V guests think they're running on top of a Hyper-V
>> +compatible hypervisor and use Hyper-V specific features.
>> +
>> +
>> +2. Setup
>> +=========
>> +No Hyper-V enlightenments are enabled by default by either KVM or QEMU. In
>> +QEMU, individual enlightenments can be enabled through CPU flags, e.g:
>> +
>> +  qemu-system-x86_64 --enable-kvm --cpu host,hv_relaxed,hv_vpindex,hv_time, ...
>> +
>> +Sometimes there are dependencies between enlightenments, QEMU is supposed to
>> +check that the supplied configuration is sane.
>> +
>> +When any set of the Hyper-V enlightenments is enabled, QEMU changes hypervisor
>> +identification (CPUID 0x40000000..0x4000000A) to Hyper-V. KVM identification
>> +and features are kept in leaves 0x40000100..0x40000101.
>> +
>> +
>> +3. Existing enlightenments
>> +===========================
>> +
>> +3.1. hv-relaxed
>> +================
>> +This feature tells guest OS to disable watchdog timeouts as it is running on a
>> +hypervisor. It is known that some Windows versions will do this even when they
>> +see 'hypervisor' CPU flag.
>> +
>> +3.2. hv-vapic
>> +==============
>> +Provides so-called VP Assist page MSR to guest allowing it to work with APIC
>> +more efficiently. In particular, this enlightenment allows paravirtualized
>> +(exit-less) EOI processing.
>> +
>> +3.3. hv-spinlocks=xxx
>> +======================
>> +Enables paravirtualized spinlocks. The parameter indicates how many times
>> +spinlock acquisition should be attempted before indicating the situation to the
>> +hypervisor. A special value 0xffffffff indicates "never to retry".
>> +
>> +3.4. hv-vpindex
>> +================
>> +Provides HV_X64_MSR_VP_INDEX (0x40000002) MSR to the guest which has Virtual
>> +processor index information. This enlightenment makes sense in conjunction with
>> +hv-synic, hv-stimer and other enlightenments which require the guest to know its
>> +Virtual Processor indices (e.g. when VP index needs to be passed in a
>> +hypercall).
>> +
>> +3.5. hv-runtime
>> +================
>> +Provides HV_X64_MSR_VP_RUNTIME (0x40000010) MSR to the guest. The MSR keeps the
>> +virtual processor run time in 100ns units. This gives guest operating system an
>> +idea of how much time was 'stolen' from it (when the virtual CPU was preempted
>> +to perform some other work).
>> +
>> +3.6. hv-crash
>> +==============
>> +Provides HV_X64_MSR_CRASH_P0..HV_X64_MSR_CRASH_P5 (0x40000100..0x40000105) and
>> +HV_X64_MSR_CRASH_CTL (0x40000105) MSRs to the guest. These MSRs are written to
>> +by the guest when it crashes, HV_X64_MSR_CRASH_P0..HV_X64_MSR_CRASH_P5 MSRs
>> +contain additional crash information. This information is outputted in QEMU log
>> +and through QAPI.
>> +Note: unlike under genuine Hyper-V, write to HV_X64_MSR_CRASH_CTL causes guest
>> +to shutdown. This effectively blocks crash dump generation by Windows.
>
> Hmm, why?
>

This was written completely out of top of my head but I was under an
impression that writing to HV_X64_MSR_CRASH_CTL causes Qemu to shutdown
the guest and Windows does this before it creates crash dump. Am I
mistaken? I can be)

>> +
>> +3.7. hv-time
>> +=============
>> +Enables two Hyper-V-specific clocksources available to the guest: MSR-based
>> +Hyper-V clocksource (HV_X64_MSR_TIME_REF_COUNT, 0x40000020) and Reference TSC
>> +page (enabled via MSR HV_X64_MSR_REFERENCE_TSC, 0x40000021). Both clocksources
>> +are per-guest, Reference TSC page clocksource allows for exit-less time stamp
>> +readings. Using this enlightenment leads to significant speedup of all timestamp
>> +related operations.
>> +
>> +3.8. hv-synic
>> +==============
>> +Enables Hyper-V Synthetic interrupt controller - an extension of a local APIC.
>> +When enabled, this enlightenment provides additional communication facilities
>> +to the guest: SynIC messages and Events. This is a pre-requisite for
>> +implementing VMBus devices (not yet in QEMU). Additionally, this enlightenment
>> +is needed to enable Hyper-V synthetic timers. SynIC is controlled through MSRs
>> +HV_X64_MSR_SCONTROL..HV_X64_MSR_EOM (0x40000080..0x40000084) and
>> +HV_X64_MSR_SINT0..HV_X64_MSR_SINT15 (0x40000090..0x4000009F)
>> +
>> +Requires: hv-vpindex
>> +
>> +3.9. hv-stimer
>> +===============
>> +Enables Hyper-V synthetic timers. There are four synthetic timers per virtual
>> +CPU controlled through HV_X64_MSR_STIMER0_CONFIG..HV_X64_MSR_STIMER3_COUNT
>> +(0x400000B0..0x400000B7) MSRs. These timers can work either in single-shot or
>> +periodic mode. It is known that certain Windows versions revert to using RTC
>> +extensively when this enlightenment is not provided; this leads to significant
>> +CPU consumption, even when virtual CPU is idle.
>
> I think it'll rather use HPET if available.  I'm also not sure the idle
> vCPU scenario was one that motivated for implementing paravirtualized
> timers.

Right but there was an "improvement" from MS in one of their Win10
updates which made things significantly worse so I thought it would be a
good idea to document this user-visible property.

>
>> +
>> +Requires: hv-vpindex, hv-synic, hv-time
>> +
>> +3.10. hv-tlbflush
>> +==================
>> +Enables paravirtualized TLB shoot-down mechanism. On x86 architecture, remote
>> +TLB flush procedure requires sending IPIs and waiting for other CPUs to perform
>> +local TLB flush. In virtualized environment some virtual CPUs may not even be
>> +scheduled at the time of the call and may not require flushing (or, flushing
>> +may be postponed until the virtual CPU is scheduled). hv-tlbflush enlightenment
>> +implements TLB shoot-down through hypervisor enabling the optimization.
>> +
>> +Requires: hv-vpindex
>> +
>> +3.11. hv-ipi
>> +=============
>> +Enables paravirtualized IPI send mechanism. HvCallSendSyntheticClusterIpi
>> +hypercall may target more than 64 virtual CPUs simultaneously, doing the same
>> +through APIC requires more than one access (and thus exit to the hypervisor).
>> +
>> +Requires: hv-vpindex
>> +
>> +3.12. hv-vendor-id=xxx
>> +=======================
>> +This changes Hyper-V identification in CPUID 0x40000000.EBX-EDX from the default
>> +"Microsoft Hv". The parameter should be no longer than 12 characters. According
>> +to the specification, guests shouldn't use this information and it is unknown
>> +if there is a Windows version which acts differently.
>> +Note: hv-vendor-id is not an enlightenment and thus doesn't enable Hyper-V
>> +identification when specified without some other enlightenment.
>> +
>> +3.13. hv-reset
>> +===============
>> +Provides HV_X64_MSR_RESET (0x40000003) MSR to the guest allowing it to reset
>> +itself by writing to it. Even when this MSR is enabled, it is not a recommended
>> +way for Windows to perform system reboot and thus it may not be used.
>> +
>> +3.14. hv-frequencies
>> +============================================
>> +Provides HV_X64_MSR_TSC_FREQUENCY (0x40000022) and HV_X64_MSR_APIC_FREQUENCY
>> +(0x40000023) allowing the guest to get its TSC/APIC frequencies without doing
>> +measurements.
>> +
>> +3.15 hv-reenlightenment
>> +========================
>> +The enlightenment is nested specific, it targets Hyper-V on KVM guests. When
>> +enabled, it provides HV_X64_MSR_REENLIGHTENMENT_CONTROL (0x40000106),
>> +HV_X64_MSR_TSC_EMULATION_CONTROL (0x40000107)and HV_X64_MSR_TSC_EMULATION_STATUS
>> +(0x40000108) MSRs allowing the guest to get notified when TSC frequency changes
>> +(only happens on migration) and keep using old frequency (through emulation in
>> +the hypervisor) until it is ready to switch to the new one. This, in conjunction
>> +with hv-frequencies, allows Hyper-V on KVM to pass stable clocksource (Reference
>> +TSC page) to its own guests.
>> +
>> +Recommended: hv-frequencies
>> +
>> +3.16. hv-evmcs
>> +===============
>> +The enlightenment is nested specific, it targets Hyper-V on KVM guests. When
>> +enabled, it provides Enlightened VMCS feature to the guest. The feature
>> +implements paravirtualized protocol between L0 (KVM) and L1 (Hyper-V)
>> +hypervisors making L2 exits to the hypervisor faster. The feature is Intel-only.
>> +Note: some virtualization features (e.g. Posted Interrupts) are disabled when
>> +hv-evmcs is enabled. It may make sense to measure your nested workload with and
>> +without the feature to find out if enabling it is beneficial.
>> +
>> +Requires: hv-vapic
>> +
>> +
>> +4. Useful links
>> +================
>> +Hyper-V Top Level Functional specification and other information:
>> +https://github.com/MicrosoftDocs/Virtualization-Documentation
>> -- 
>> 2.20.1
>> 
>
> Thanks,
> Roman.

-- 
Vitaly

