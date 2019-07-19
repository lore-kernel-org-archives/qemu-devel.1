Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142EBC76196
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D812B2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D812B2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoNyD-0002ZV-Pw
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 04:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45501)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hoNy1-0001wV-6d
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hoNy0-0006yl-2N
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:10:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33823)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hoNxz-0006xO-SP
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:10:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so31350739wrm.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 01:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hgZLtZRpvkdt3pIJFShsos2FHg+OhbWzcWJsi5TahPY=;
 b=lSQpqcGCErO0l/lBDYANKhCGJS14t+4QdUwGFpUU+WqvKzLqnaJ3wJ4+TdOq57xMhP
 97Lk8U7buWzvozua2ebmO0bGZ8cNJ2Yf5cmcJ4psQsP+qVJogu7XeOrwf5RY5TMTF2EJ
 40FE6BLJzFsssw4Tg+RxQ8ZSK5+p52o6d6mdFCVAS1glZxdejdiBSQbZXFRGoLBEeRFW
 xz/hYFEf9h4H+VkTCThi6sof9J/AtfISPMH5Ov5+xmjBP9q873/Bv0wOG+yyU3TV0/c2
 EMCgigE29lwt2MksGFb7OzRIYQu6g5amWxuohvRoUNYPQkhBmFODU6McyMd2WrbA1vbO
 ghEA==
X-Gm-Message-State: APjAAAXp7CekRIjRLNepGD6avaEJ3HcuoiF7dKe1B8FtujplPlMOOGub
 mvLU/ylalMLBVqsBUp2JzWXZjqjO5dc=
X-Google-Smtp-Source: APXvYqyIGXdo9ne+wetv+g5z140spaM8EvQsUMkdpS149C0klfe25/RgMfco/4/AviIsGwRwAYZeWA==
X-Received: by 2002:adf:f050:: with SMTP id t16mr51411357wro.99.1563523810632; 
 Fri, 19 Jul 2019 01:10:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8501:6b03:f18c:74f8?
 ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id v5sm31516611wre.50.2019.07.19.01.10.09
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 01:10:10 -0700 (PDT)
To: Jing Liu <jing2.liu@linux.intel.com>, qemu-devel@nongnu.org
References: <1562823509-13072-1-git-send-email-jing2.liu@linux.intel.com>
 <c572cdd2-d0f4-2e06-99f8-302b798a04dd@linux.intel.com>
 <0f9763fe-af69-e057-9fb1-00527e636fe4@redhat.com>
 <0ffa32db-3615-16e0-71bf-a8c552c2fcfb@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <757b193f-90c6-0516-9372-74463ec4d117@redhat.com>
Date: Fri, 19 Jul 2019 10:10:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0ffa32db-3615-16e0-71bf-a8c552c2fcfb@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v1] x86: Intel AVX512_BF16 feature enabling
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

On 19/07/19 09:20, Jing Liu wrote:
>> Then CPUID[7,0].EAX is set automatically to 0 or 1 depending on whether
>> BF16 is enabled or not.
> 
> Could I ask why don't we directly check BF16 enabling when
> cpu_x86_cpuid(env, 7, 0, ...) during kvm_arch_init_vcpu ?

Because the code for setting CPUID is common for all accelerators (there
are five supported: KVM, HAX, HVF, TCG, WHPX).

> What is the use of the two new properties? Are they used for users
> setting parameters when boot up guest, and why we need users setting
> func7 level?

For example to test guests with CPUID[7,0].EAX==1, even if the host does
not have BF16.

> I tried to implement the code as follows.
> 
> @@ -4293,13 +4313,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t
> index, uint32_t count,
>      case 7:
>          /* Structured Extended Feature Flags Enumeration Leaf */
>          if (count == 0) {
> -            *eax = 0; /* Maximum ECX value for sub-leaves */
> +            /* Maximum ECX value for sub-leaves */
> +            *eax = env->cpuid_level_func7;
> [...]
> +        } else if (count == 1) {
> +            *eax = env->features[FEAT_7_1_EAX];
> +            *ebx = 0;
> +            *ecx = 0;
> +            *edx = 0;

Looks good.

> @@ -5075,6 +5101,10 @@ static void x86_cpu_expand_features(X86CPU *cpu,
> Error **errp)
>          x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
>          x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
> 
> +       if ((env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_AVX512_BF16) &&
> +            kvm_enabled()) {

No need to check KVM.  You could also do just
x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX) and set
cpu->min_level_func7 in x86_cpu_adjust_feat_level with something like

    if (eax == 7) {
        x86_cpu_adjust_level(cpu, &env->cpu_min_level_func7,
                             fi->cpuid.ecx);
    }


> +            x86_cpu_adjust_level(cpu, &env->cpuid_min_level_func7, 1);
> +        }
>          /* Intel Processor Trace requires CPUID[0x14] */
>          if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
>               kvm_enabled() && cpu->intel_pt_auto_level) {
> @@ -5098,6 +5128,9 @@ static void x86_cpu_expand_features(X86CPU *cpu,
> Error **errp)
>      }
> 
>      /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly
> set */
> +    if (env->cpuid_level_func7 == UINT32_MAX) {
> +        env->cpuid_level_func7 = env->cpuid_min_level_func7;
> +    }

Looks good.

>      if (env->cpuid_level == UINT32_MAX) {
>          env->cpuid_level = env->cpuid_min_level;
>      }
> @@ -5869,9 +5902,11 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
>      DEFINE_PROP_UINT8("host-phys-bits-limit", X86CPU,
> host_phys_bits_limit, 0),
>      DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
> +    DEFINE_PROP_UINT32("level-func7", X86CPU, env.cpuid_level_func7,
> UINT32_MAX),

Looks good.

>      DEFINE_PROP_UINT32("level", X86CPU, env.cpuid_level, UINT32_MAX),
>      DEFINE_PROP_UINT32("xlevel", X86CPU, env.cpuid_xlevel, UINT32_MAX),
>      DEFINE_PROP_UINT32("xlevel2", X86CPU, env.cpuid_xlevel2, UINT32_MAX),
> +    DEFINE_PROP_UINT32("min-level-func7", X86CPU,
> env.cpuid_min_level_func7, 0),

No need for this property, just like there is no min-level property.

Thanks,

Paolo

