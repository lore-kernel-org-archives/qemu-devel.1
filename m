Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D44BC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5E32084B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5E32084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQDz-0002oC-Ik
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1iKQCR-0001ZJ-C3
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1iKQCP-0007GB-Rh
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:01:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36521)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1iKQCP-0007F2-Ja
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:01:29 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 78D08C0546D5
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 17:01:27 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id q9so8927196wmj.9
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 10:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=VGRbvJF6E2IH8bfXxTorreLtbiW/Eu+4508lD8RUR04=;
 b=Y6cdGi2pYapQiiFsSTreZ6dIw4+ptaexOXUbuWbbhqym4HNIUfwC6mv5rm/qo+av37
 NrEAqECIp4tTZI4/xuR/ei9FSwQELAfYpnAaJ6lWoiImWb3U2AmeT1wmxVcCgDBqHW6f
 uvQ6eDip0ZPQScRZrXjsE2UM8Y5NdmoEWPGX+CACsrdbdeDZRNRM2wJo49QgpmzCB3xb
 hXowx5p0KVsEdIK01Q0mWKQPdr+NooTVlUo81SMkCGbUaNXrHmFWRprGtbWVwvQg1jEs
 kfLG+r+1DkMb58mqPHR2BR9dFAn4kBEBf2QjY/7iNBBi3baJEN9ZwTgXygFLJQKyt3e0
 A3SA==
X-Gm-Message-State: APjAAAW6c/lblc//LYbvFDSRz2aF0m+N4cpDDm8EduKQ3qSX0OKqaAWa
 sq92Mal01bGy4yrIPnxVchvJObV6MQyKzfH6fyf/Z035ToZ6//UDasxvhARdDH1X18eHHKsWQNL
 eCK2HWsZ2shIXEVI=
X-Received: by 2002:adf:8385:: with SMTP id 5mr32476005wre.267.1571158886068; 
 Tue, 15 Oct 2019 10:01:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwky/GpobUXGsD/uJTzHRcZEX/xS3dGc+FuZhJ8nPAtP/NTMOLP9KwDXPdxfmX63NsDSbp5AA==
X-Received: by 2002:adf:8385:: with SMTP id 5mr32475968wre.267.1571158885676; 
 Tue, 15 Oct 2019 10:01:25 -0700 (PDT)
Received: from vitty.brq.redhat.com ([95.82.135.254])
 by smtp.gmail.com with ESMTPSA id r3sm13296316wre.29.2019.10.15.10.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 10:01:24 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: lantianyu1986@gmail.com
Subject: Re: [PATCH V2 2/2] target/i386/kvm: Add Hyper-V direct tlb flush
 support
In-Reply-To: <20191015143610.31857-3-Tianyu.Lan@microsoft.com>
References: <20191015143610.31857-1-Tianyu.Lan@microsoft.com>
 <20191015143610.31857-3-Tianyu.Lan@microsoft.com>
Date: Tue, 15 Oct 2019 19:01:23 +0200
Message-ID: <87ftju3puk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: mtosatti@redhat.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, rkagan@virtuozzo.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

lantianyu1986@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> Hyper-V direct tlb flush targets KVM on Hyper-V guest.
> Enable direct TLB flush for its guests meaning that TLB
> flush hypercalls are handled by Level 0 hypervisor (Hyper-V)
> bypassing KVM in Level 1. Due to the different ABI for hypercall
> parameters between Hyper-V and KVM, KVM capabilities should be
> hidden when enable Hyper-V direct tlb flush otherwise KVM
> hypercalls may be intercepted by Hyper-V. Add new parameter
> "hv-direct-tlbflush". Check expose_kvm and Hyper-V tlb flush
> capability status before enabling the feature.
>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since V1:
>        - Add direct tlb flush's Hyper-V property and use
>        hv_cpuid_check_and_set() to check the dependency of tlbflush
>        feature.
>        - Make new feature work with Hyper-V passthrough mode.
> ---
>  docs/hyperv.txt   | 12 ++++++++++++
>  target/i386/cpu.c |  2 ++
>  target/i386/cpu.h |  1 +
>  target/i386/kvm.c | 23 +++++++++++++++++++++++
>  4 files changed, 38 insertions(+)
>
> diff --git a/docs/hyperv.txt b/docs/hyperv.txt
> index 8fdf25c829..ceab8c21fe 100644
> --- a/docs/hyperv.txt
> +++ b/docs/hyperv.txt
> @@ -184,6 +184,18 @@ enabled.
>  
>  Requires: hv-vpindex, hv-synic, hv-time, hv-stimer
>  
> +3.18. hv-direct-tlbflush
> +=======================
> +The enlightenment targets KVM on Hyper-V guest. Enable direct TLB flush for
> +its guests meaning that TLB flush hypercalls are handled by Level 0 hypervisor
> +(Hyper-V) bypassing KVM in Level 1. Due to the different ABI for hypercall
> +parameters between Hyper-V and KVM, enabling this capability effectively
> +disables all hypercall handling by KVM (as some KVM hypercall may be mistakenly
> +treated as TLB flush hypercalls by Hyper-V). So kvm capability should not show
> +to guest when enable this capability. If not, user will fail to enable this
> +capability.


My take:

"Enable direct TLB flush for KVM when it is running as a nested
hypervisor on top Hyper-V. When enabled, TLB flush hypercalls from L2
guests are being passed through to L0 (Hyper-V) for handling. Due to ABI
differences between Hyper-V and KVM hypercalls, L2 guests will not be
able to issue KVM hypercalls (as those could be mishanled by L0
Hyper-V), this requires KVM hypervisor signature to be hidden."

It would be great if someone who doesn't know that the feature is would
read these two paragraphs and tell us how they sound :-)

> +
> +Requires: hv-tlbflush, -kvm
>  
>  4. Development features
>  ========================
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 44f1bbdcac..7bc7fee512 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6156,6 +6156,8 @@ static Property x86_cpu_properties[] = {
>                        HYPERV_FEAT_IPI, 0),
>      DEFINE_PROP_BIT64("hv-stimer-direct", X86CPU, hyperv_features,
>                        HYPERV_FEAT_STIMER_DIRECT, 0),
> +    DEFINE_PROP_BIT64("hv-direct-tlbflush", X86CPU, hyperv_features,
> +                      HYPERV_FEAT_DIRECT_TLBFLUSH, 0),
>      DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, false),
>  
>      DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index eaa5395aa5..3cb105f7d6 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -907,6 +907,7 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
>  #define HYPERV_FEAT_EVMCS               12
>  #define HYPERV_FEAT_IPI                 13
>  #define HYPERV_FEAT_STIMER_DIRECT       14
> +#define HYPERV_FEAT_DIRECT_TLBFLUSH     15
>  
>  #ifndef HYPERV_SPINLOCK_NEVER_RETRY
>  #define HYPERV_SPINLOCK_NEVER_RETRY             0xFFFFFFFF
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 11b9c854b5..7e0fbc730e 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -900,6 +900,10 @@ static struct {
>          },
>          .dependencies = BIT(HYPERV_FEAT_STIMER)
>      },
> +    [HYPERV_FEAT_DIRECT_TLBFLUSH] = {
> +        .desc = "direct tlbflush (hv-direct-tlbflush)",

"direct TLB flush" (to be consistent with "paravirtualized TLB flush" above

> +        .dependencies = BIT(HYPERV_FEAT_TLBFLUSH)
> +    },
>  };
>  
>  static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
> @@ -1224,6 +1228,7 @@ static int hyperv_handle_properties(CPUState *cs,
>      r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_EVMCS);
>      r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_IPI);
>      r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_STIMER_DIRECT);
> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_DIRECT_TLBFLUSH);
>  
>      /* Additional dependencies not covered by kvm_hyperv_properties[] */
>      if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
> @@ -1243,6 +1248,24 @@ static int hyperv_handle_properties(CPUState *cs,
>          goto free;
>      }
>  
> +    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_DIRECT_TLBFLUSH) ||
> +        cpu->hyperv_passthrough) {
> +        if (!cpu->expose_kvm) {
> +            r = kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_DIRECT_TLBFLUSH, 0, 0);
> +            if (hyperv_feat_enabled(cpu, HYPERV_FEAT_DIRECT_TLBFLUSH) && r) {
> +                fprintf(stderr,
> +                    "Hyper-V %s is not supported by kernel\n",
> +                    kvm_hyperv_properties[HYPERV_FEAT_DIRECT_TLBFLUSH].desc);
> +                return -ENOSYS;
> +            }
> +        } else if (!cpu->hyperv_passthrough) {
> +            fprintf(stderr,
> +                "Hyper-V %s requires not to expose KVM capabilities.\n",

My take:
"... requires KVM hypervisor signature to be hidden (-kvm)."

> +                kvm_hyperv_properties[HYPERV_FEAT_DIRECT_TLBFLUSH].desc);
> +            return -ENOSYS;
> +        }
> +    }

Thanks, the check looks correct to me now.

> +
>      if (cpu->hyperv_passthrough) {
>          /* We already copied all feature words from KVM as is */
>          r = cpuid->nent;

-- 
Vitaly

