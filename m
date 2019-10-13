Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC02C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 08:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FFA2067B
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 08:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FFA2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJZaG-00039U-2w
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 04:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1iJZZL-0002bB-DF
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 04:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1iJZZI-0007pl-Rk
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 04:49:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1iJZZI-0007oZ-JK
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 04:49:36 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 912B83DE0C
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 08:49:33 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id k4so7009252wru.1
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 01:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=Ja9qbq8pwNINxaby4hLqVgL+JEeU/d+fL6MBhBXvMXU=;
 b=jN7a7r2RFfCba/Kh5DDtVpW3C5b0hb3v8DVTS1d1thOyHTVXkdQ0qYR6TqajKu/35g
 edyA93zJWpDJ3kyRFibCZUUbGqLS0uAoUtXtAZMCzVv/Uv2azVsNNhvzdhnMsytKIWue
 jKssIchIGP9yqqQ0H2/XqNHOZc51dztRVfIvhdPssyxa5njYgHjp8yzLA1a5qaeFnDdr
 GCxIhgoU96wWcv6M2PeQTBWIrsCNaA+rEGoVQitjsfZSiPKx0U5aSu2nfSWnJ6cwmu8e
 3VywXv18A1wkafFaqkw0ZueEIJ1eyXiB7J3/2j/KZ+x+IJZCfvkrYjQkqDoeJPTe8eB4
 R6ow==
X-Gm-Message-State: APjAAAUYDRqJMrux0J6L/PoBU4WBL3aLfmiCqrbLZGTc6UdPfAIjeGpR
 7aUwAHr/Z3dRNb+O6nWlpLXj+YWWc0vphQqSRufAh43McVA9gIaU9Lin/sfz/T7O1vrX0L3Z78M
 OVL6NmqJlHgNIN14=
X-Received: by 2002:a05:600c:2c2:: with SMTP id
 2mr10686813wmn.112.1570956572215; 
 Sun, 13 Oct 2019 01:49:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxo3H0voKcFIvJsSqXkvXStyxqzlu/VzQtkrGy4RT5JKhephQan3h6hxxgpNm1WZEyY9x3gyQ==
X-Received: by 2002:a05:600c:2c2:: with SMTP id
 2mr10686793wmn.112.1570956571896; 
 Sun, 13 Oct 2019 01:49:31 -0700 (PDT)
Received: from vitty.brq.redhat.com ([95.82.135.110])
 by smtp.gmail.com with ESMTPSA id u4sm27814969wmg.41.2019.10.13.01.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 01:49:31 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: lantianyu1986@gmail.com
Subject: Re: [PATCH] target/i386/kvm: Add Hyper-V direct tlb flush support
In-Reply-To: <20191012034153.31817-1-Tianyu.Lan@microsoft.com>
References: <20191012034153.31817-1-Tianyu.Lan@microsoft.com>
Date: Sun, 13 Oct 2019 10:49:30 +0200
Message-ID: <87r23h58th.fsf@vitty.brq.redhat.com>
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
 qemu-devel@nongnu.org, Roman Kagan <rkagan@virtuozzo.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

lantianyu1986@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>

(Please also Cc: Roman on you Hyper-V related submissions to QEMU who's
known to be a great reviewer)

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
>  docs/hyperv.txt           | 12 ++++++++++++
>  linux-headers/linux/kvm.h |  1 +
>  target/i386/cpu.c         |  2 ++
>  target/i386/cpu.h         |  1 +
>  target/i386/kvm.c         | 21 +++++++++++++++++++++
>  5 files changed, 37 insertions(+)
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
> +
> +Requires: hv-tlbflush, -kvm
>  
>  4. Development features
>  ========================
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 18892d6541..923fb33a01 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -995,6 +995,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_ARM_SVE 170
>  #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
>  #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
> +#define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 174

I was once told that scripts/update-linux-headers.sh script is supposed
to be used instead of cherry-picking stuff you need (adn this would be a
separate patch - update linux headers to smth).

>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
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
> index 11b9c854b5..8e999dbcf1 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1235,6 +1235,27 @@ static int hyperv_handle_properties(CPUState *cs,
>          r |= 1;
>      }
>  
> +    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_DIRECT_TLBFLUSH)) {
> +        if (!kvm_check_extension(cs->kvm_state,
> +            KVM_CAP_HYPERV_DIRECT_TLBFLUSH)) {
> +            fprintf(stderr,
> +                    "Kernel doesn't support Hyper-V direct tlbflush.\n");
> +            r = -ENOSYS;
> +            goto free;
> +        }
> +
> +        if (cpu->expose_kvm ||
> +            !hyperv_feat_enabled(cpu, HYPERV_FEAT_TLBFLUSH)) {
> +            fprintf(stderr, "Hyper-V direct tlbflush requires Hyper-V %s"
> +                    " and not expose KVM.\n",
> +                    kvm_hyperv_properties[HYPERV_FEAT_TLBFLUSH].desc);
> +            r = -ENOSYS;
> +            goto free;
> +        }
> +
> +        kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_DIRECT_TLBFLUSH, 0, 0);
> +    }

We also have hv-passthrough mode where all Hyper-V enlightenments are
supposed to be enabled; I'd suggest you do the same we currently do with
HYPERV_FEAT_EVMCS:

    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_DIRECT_TLBFLUSH) ||
        cpu->hyperv_passthrough) {

        r = kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_DIRECT_TLBFLUSH, 0, 0);

        if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) && r) {
            fprintf(stderr, "Hyper-V %s is not supported by kernel\n",
                    kvm_hyperv_properties[HYPERV_FEAT_DIRECT_TLBFLUSH].desc);
            return -ENOSYS;
        }

No need to check for a capability if you're going to enable it right
away (and btw - this can fail).

You also need to use kvm_hyperv_properties to track dependencies between
features and not do it manually here (like you required
HYPERV_FEAT_TLBFLUSH). This is going to be the first feature without its
own CPUID bits assigned so some tweaks to kvm_hyperv_properties handling
may be required. Or we can use HYPERV_FEAT_TLBFLUSH bits, I'm not sure
here.


> +
>      /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
>      env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;

-- 
Vitaly

