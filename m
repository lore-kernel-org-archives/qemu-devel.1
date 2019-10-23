Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609A2CA9EAE
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 07:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BA920684
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 07:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BA920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNAub-0004vx-SR
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 03:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iNAsy-0003lM-67
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 03:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iNAsw-0001Oy-65
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 03:16:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iNAsu-0001LW-6b
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 03:16:45 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFF3A7BDA1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 07:16:42 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id l184so5657209wmf.6
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 00:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jwOtyVgHh4fXErSSQOuM/kzsF9twK281dOW0D19R2iQ=;
 b=ihtvXBiZ/D0b+Crffk0oiejE2lWSUldJCI9R+rPU8Zpa+vy/afBSzhoL5Hq5D28W/j
 3lJCzxxL7MSvofmq9ge3jlRbzWNg2zkK1nLro/SEohkykgOfH17GXrlcc0z8mYisGNTt
 0Y767whiCZb2xZNjywnop8L6esim7peZUc9fylJ6pTkcrgTYyHSYvsYBeT3PbqvCYhe5
 Gj1BoIW0evdi98BzbyiVyRzRFj1AhBiVJB0vhuHt1wgQkuQ4IThn+gy7re13H4rvjuqI
 fxlYXRh7i/VrbxaImH3wiVHxQe0ffHqf1Q9Tkjsdf1LxYBaY8YZ8sK/mQygaCNshZJ5X
 f6cw==
X-Gm-Message-State: APjAAAWZexf0X5T4lACSD1rN8cRkLr1knE026x7uKIaQOAicm6TSbBy7
 5KM5r/XxtmkmnrVBERCyIblwjpeR9LQ4o61PPvAtQ/IN786hYwx/obCv1B6mYJJnX0wj+XXPqX9
 2piOiCrgpFV5qjQw=
X-Received: by 2002:a1c:f714:: with SMTP id v20mr6567456wmh.55.1571815001362; 
 Wed, 23 Oct 2019 00:16:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEL40+6DQtzEWcUPXQXJhcsOA/uesoowP/wdVrCFut/Org2lg1krqm2IDjGjwbNA1POOLjvA==
X-Received: by 2002:a1c:f714:: with SMTP id v20mr6567426wmh.55.1571815000912; 
 Wed, 23 Oct 2019 00:16:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:45c:4f58:5841:71b2?
 ([2001:b07:6468:f312:45c:4f58:5841:71b2])
 by smtp.gmail.com with ESMTPSA id d4sm28058276wrc.54.2019.10.23.00.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 00:16:40 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] target/i386/kvm: Add Hyper-V direct tlb flush
 support
To: Roman Kagan <rkagan@virtuozzo.com>, lantianyu1986@gmail.com,
 rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com,
 vkuznets@redhat.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20191016130725.5045-1-Tianyu.Lan@microsoft.com>
 <20191016130725.5045-3-Tianyu.Lan@microsoft.com>
 <7de12770-271e-d386-a105-d53b50aa731f@redhat.com>
 <20191022201418.GA22898@rkaganb.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <76c02274-a68f-65a8-aca9-963076db1557@redhat.com>
Date: Wed, 23 Oct 2019 09:16:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191022201418.GA22898@rkaganb.lan>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/19 22:14, Roman Kagan wrote:
> On Tue, Oct 22, 2019 at 07:04:11PM +0200, Paolo Bonzini wrote:
>> On 16/10/19 15:07, lantianyu1986@gmail.com wrote:
> 
> Somehow this patch never got through to me so I'll reply here.
> 
>>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>>
>>> Hyper-V direct tlb flush targets KVM on Hyper-V guest.
>>> Enable direct TLB flush for its guests meaning that TLB
>>> flush hypercalls are handled by Level 0 hypervisor (Hyper-V)
>>> bypassing KVM in Level 1. Due to the different ABI for hypercall
>>> parameters between Hyper-V and KVM, KVM capabilities should be
>>> hidden when enable Hyper-V direct tlb flush otherwise KVM
>>> hypercalls may be intercepted by Hyper-V. Add new parameter
>>> "hv-direct-tlbflush". Check expose_kvm and Hyper-V tlb flush
>>> capability status before enabling the feature.
>>>
>>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>> ---
>>> Change sicne v2:
>>>        - Update new feature description and name.
>>>        - Change failure print log.
>>>
>>> Change since v1:
>>>        - Add direct tlb flush's Hyper-V property and use
>>>        hv_cpuid_check_and_set() to check the dependency of tlbflush
>>>        feature.
>>>        - Make new feature work with Hyper-V passthrough mode.
>>> ---
>>>  docs/hyperv.txt   | 10 ++++++++++
>>>  target/i386/cpu.c |  2 ++
>>>  target/i386/cpu.h |  1 +
>>>  target/i386/kvm.c | 24 ++++++++++++++++++++++++
>>>  4 files changed, 37 insertions(+)
>>>
>>> diff --git a/docs/hyperv.txt b/docs/hyperv.txt
>>> index 8fdf25c829..140a5c7e44 100644
>>> --- a/docs/hyperv.txt
>>> +++ b/docs/hyperv.txt
>>> @@ -184,6 +184,16 @@ enabled.
>>>  
>>>  Requires: hv-vpindex, hv-synic, hv-time, hv-stimer
>>>  
>>> +3.18. hv-direct-tlbflush
>>> +=======================
>>> +Enable direct TLB flush for KVM when it is running as a nested
>>> +hypervisor on top Hyper-V. When enabled, TLB flush hypercalls from L2
>>> +guests are being passed through to L0 (Hyper-V) for handling. Due to ABI
>>> +differences between Hyper-V and KVM hypercalls, L2 guests will not be
>>> +able to issue KVM hypercalls (as those could be mishanled by L0
>>> +Hyper-V), this requires KVM hypervisor signature to be hidden.
>>> +
>>> +Requires: hv-tlbflush, -kvm
>>>  
>>>  4. Development features
>>>  ========================
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 44f1bbdcac..7bc7fee512 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -6156,6 +6156,8 @@ static Property x86_cpu_properties[] = {
>>>                        HYPERV_FEAT_IPI, 0),
>>>      DEFINE_PROP_BIT64("hv-stimer-direct", X86CPU, hyperv_features,
>>>                        HYPERV_FEAT_STIMER_DIRECT, 0),
>>> +    DEFINE_PROP_BIT64("hv-direct-tlbflush", X86CPU, hyperv_features,
>>> +                      HYPERV_FEAT_DIRECT_TLBFLUSH, 0),
>>>      DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, false),
>>>  
>>>      DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
>>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>>> index eaa5395aa5..3cb105f7d6 100644
>>> --- a/target/i386/cpu.h
>>> +++ b/target/i386/cpu.h
>>> @@ -907,6 +907,7 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
>>>  #define HYPERV_FEAT_EVMCS               12
>>>  #define HYPERV_FEAT_IPI                 13
>>>  #define HYPERV_FEAT_STIMER_DIRECT       14
>>> +#define HYPERV_FEAT_DIRECT_TLBFLUSH     15
>>>  
>>>  #ifndef HYPERV_SPINLOCK_NEVER_RETRY
>>>  #define HYPERV_SPINLOCK_NEVER_RETRY             0xFFFFFFFF
>>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>>> index 11b9c854b5..043b66ab22 100644
>>> --- a/target/i386/kvm.c
>>> +++ b/target/i386/kvm.c
>>> @@ -900,6 +900,10 @@ static struct {
>>>          },
>>>          .dependencies = BIT(HYPERV_FEAT_STIMER)
>>>      },
>>> +    [HYPERV_FEAT_DIRECT_TLBFLUSH] = {
>>> +        .desc = "direct paravirtualized TLB flush (hv-direct-tlbflush)",
>>> +        .dependencies = BIT(HYPERV_FEAT_TLBFLUSH)
>>> +    },
>>>  };
>>>  
>>>  static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
>>> @@ -1224,6 +1228,7 @@ static int hyperv_handle_properties(CPUState *cs,
>>>      r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_EVMCS);
>>>      r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_IPI);
>>>      r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_STIMER_DIRECT);
>>> +    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_DIRECT_TLBFLUSH);
> 
> AFAICS this will turn HYPERV_FEAT_DIRECT_TLBFLUSH on if
> hyperv_passthrough is on, so ...
> 
>>>  
>>>      /* Additional dependencies not covered by kvm_hyperv_properties[] */
>>>      if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
>>> @@ -1243,6 +1248,25 @@ static int hyperv_handle_properties(CPUState *cs,
>>>          goto free;
>>>      }
>>>  
>>> +    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_DIRECT_TLBFLUSH) ||
>>> +        cpu->hyperv_passthrough) {
> 
> ... the test for ->hyperv_passthrough is redundant, and ...
> 
>>> +        if (!cpu->expose_kvm) {
>>> +            r = kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_DIRECT_TLBFLUSH, 0, 0);
>>> +            if (hyperv_feat_enabled(cpu, HYPERV_FEAT_DIRECT_TLBFLUSH) && r) {
> 
> ... , more importantly, this will abort QEMU if
> HYPERV_FEAT_DIRECT_TLBFLUSH wasn't requested explicitly, but was
> activated by ->hyperv_passthrough, and setting the capability failed.  I
> think the meaning of hyperv_passthrough is "enable all hyperv features
> supported by the KVM", so in this case it looks more correct to just
> clear the feature bit and go ahead.
> 
>>> +                fprintf(stderr,
>>> +                    "Hyper-V %s is not supported by kernel\n",
>>> +                    kvm_hyperv_properties[HYPERV_FEAT_DIRECT_TLBFLUSH].desc);
>>> +                return -ENOSYS;
>>> +            }
>>> +        } else if (!cpu->hyperv_passthrough) {
>>> +            fprintf(stderr,
>>> +                "Hyper-V %s requires KVM hypervisor signature "
>>> +                "to be hidden (-kvm).\n",
>>> +                kvm_hyperv_properties[HYPERV_FEAT_DIRECT_TLBFLUSH].desc);
>>> +            return -ENOSYS;
>>> +        }
> 
> You reach here if ->expose_kvm && ->hyperv_passthrough, and no
> capability is activated, and you go ahead with the feature bit set.
> This doesn't look right either.
> 
> So in general it should probably look like
> 
>     if (hyperv_feat_enabled(HYPERV_FEAT_DIRECT_TLBFLUSH)) {
>         if (kvm_vcpu_enable_cap(KVM_CAP_HYPERV_DIRECT_TLBFLUSH)) {
>             if (!cpu->hyperv_passthrough) {
>                 ... report feature unsupported by kernel ...
>                 return -ENOSYS;
>             }
>             cpu->hyperv_features &= ~BIT(HYPERV_FEAT_DIRECT_TLBFLUSH);
>         } else if (cpu->expose_kvm) {
>             ... report conflict ...
>             return -ENOSYS;
>         }
>     }
> 
> [Yes, hyperv_passthrough hurts, but you've been warned ;)]

Unqueued, thanks. :)

Paolo


