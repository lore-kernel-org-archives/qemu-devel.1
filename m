Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620F4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373FD20684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373FD20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxj3-0007dW-AE
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iMxZx-0005WQ-RI
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iMxZv-0001SD-Uc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:04:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iMxZv-0001Rq-MR
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 13:04:15 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 588B54E92A
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 17:04:14 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id v26so4451962wmh.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 10:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0NEhBoFQokh3U/F7hNVxe9sOLNn7d5EW0/bTrybnHeQ=;
 b=JszdGRiZiCyHIKw6I2L2OTt07MH3kjCzj15L/DWBCP5hEjQRIUxIMeywV7poZcHqOu
 sA3m3xWJyREGhOtvWAmVRyuhJWIpP5/KyQpHZF+Pi9QzokmawT4khRB/LcNbrHwgf8AW
 pWVq3nEisdvtk8bXatRbHCzTRwHw8+YsV7jw+4l6iO0mx2VhWal3GrpeAvXhgT7VGbjA
 m0WvSI8j06s79Edg23d0yO7pkn7epOoAjW+X9kWG2CWrbx8ytbu2N2ryXjNrBy796OdA
 1sYbHcD9Jyl6fRszfdRMgsSeDokBkEeogazw8fmZ1mHF3U7OTYUj3SjKbefsqpQISChL
 paIA==
X-Gm-Message-State: APjAAAXQcWZ+wAZ2d0zRl60VsST9chB1b3ZAUp1LstaFgRm5ihwFjqwj
 F8dnjJ+UxTV+IkRfCkB4qLnO1Jr+dDiaDmVkEo/uqOtkAyjMzlxfI606OBCQDYRk/mGNV5omm1k
 X055opr2qnYyTn9Y=
X-Received: by 2002:adf:ef83:: with SMTP id d3mr4006625wro.299.1571763852787; 
 Tue, 22 Oct 2019 10:04:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzMBmpDaHqVcBvasZq/rspcGCZmV3reipzfYXuv+HEgy3YzczYUN9Jn864xlfc7aFDK1y8p8A==
X-Received: by 2002:adf:ef83:: with SMTP id d3mr4006598wro.299.1571763852380; 
 Tue, 22 Oct 2019 10:04:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c0e4:dcf4:b543:ce19?
 ([2001:b07:6468:f312:c0e4:dcf4:b543:ce19])
 by smtp.gmail.com with ESMTPSA id t16sm18962170wrq.52.2019.10.22.10.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 10:04:11 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] target/i386/kvm: Add Hyper-V direct tlb flush
 support
To: lantianyu1986@gmail.com, rth@twiddle.net, ehabkost@redhat.com,
 mtosatti@redhat.com, vkuznets@redhat.com, Roman Kagan <rkagan@virtuozzo.com>
References: <20191016130725.5045-1-Tianyu.Lan@microsoft.com>
 <20191016130725.5045-3-Tianyu.Lan@microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7de12770-271e-d386-a105-d53b50aa731f@redhat.com>
Date: Tue, 22 Oct 2019 19:04:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191016130725.5045-3-Tianyu.Lan@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/10/19 15:07, lantianyu1986@gmail.com wrote:
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
> Change sicne v2:
>        - Update new feature description and name.
>        - Change failure print log.
> 
> Change since v1:
>        - Add direct tlb flush's Hyper-V property and use
>        hv_cpuid_check_and_set() to check the dependency of tlbflush
>        feature.
>        - Make new feature work with Hyper-V passthrough mode.
> ---
>  docs/hyperv.txt   | 10 ++++++++++
>  target/i386/cpu.c |  2 ++
>  target/i386/cpu.h |  1 +
>  target/i386/kvm.c | 24 ++++++++++++++++++++++++
>  4 files changed, 37 insertions(+)
> 
> diff --git a/docs/hyperv.txt b/docs/hyperv.txt
> index 8fdf25c829..140a5c7e44 100644
> --- a/docs/hyperv.txt
> +++ b/docs/hyperv.txt
> @@ -184,6 +184,16 @@ enabled.
>  
>  Requires: hv-vpindex, hv-synic, hv-time, hv-stimer
>  
> +3.18. hv-direct-tlbflush
> +=======================
> +Enable direct TLB flush for KVM when it is running as a nested
> +hypervisor on top Hyper-V. When enabled, TLB flush hypercalls from L2
> +guests are being passed through to L0 (Hyper-V) for handling. Due to ABI
> +differences between Hyper-V and KVM hypercalls, L2 guests will not be
> +able to issue KVM hypercalls (as those could be mishanled by L0
> +Hyper-V), this requires KVM hypervisor signature to be hidden.
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
> index 11b9c854b5..043b66ab22 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -900,6 +900,10 @@ static struct {
>          },
>          .dependencies = BIT(HYPERV_FEAT_STIMER)
>      },
> +    [HYPERV_FEAT_DIRECT_TLBFLUSH] = {
> +        .desc = "direct paravirtualized TLB flush (hv-direct-tlbflush)",
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
> @@ -1243,6 +1248,25 @@ static int hyperv_handle_properties(CPUState *cs,
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
> +                "Hyper-V %s requires KVM hypervisor signature "
> +                "to be hidden (-kvm).\n",
> +                kvm_hyperv_properties[HYPERV_FEAT_DIRECT_TLBFLUSH].desc);
> +            return -ENOSYS;
> +        }
> +    }
> +
>      if (cpu->hyperv_passthrough) {
>          /* We already copied all feature words from KVM as is */
>          r = cpuid->nent;
> 

Queued, thanks.  Patch 1 is not needed anymore.

Paolo

