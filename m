Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01B5C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C1E2184E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C1E2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpWpu-0007h6-1M
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 07:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54571)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hpWpj-0007IV-5I
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hpWpi-0004Q4-3c
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:50:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46551)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hpWph-0004PN-UM
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:50:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so39060703wru.13
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 04:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vuz/ZbVrhYCC7LwjypJVIOf6ihXr7hYXyihL+/vU5fw=;
 b=kyHE+cSpmWaa7wqeHFDXW0qxjouWnKZYhQRX0R0UQBi35gGCg6ykj4QBHsNKeGAHVN
 Tzsvyq7FSgSoPm9tmsN31+aV34rr+tO9p86kCOqHINzX5zqwuwYLyW0AKPoMN3mG5Qlc
 UBbvSJi0sxcJ6uDBk5/eh4RWHAR80ObOorJ4NCx4hQIipiSya5mCluDICUxh1RHIPvTT
 dAljNG/Gu+VytNAVEDT21noE44ErJjh8IQfG/uN4zcALOJ+dZoiJuNao6zs8K96ZbHEy
 iiRmILUJecAuflbhkKhGvfzl2kT/AE3EJ7Lq+Dem6BF28P3rNmEY2sLtj3af0wYffh85
 pwbA==
X-Gm-Message-State: APjAAAVI31f1/aWjfUngjNFw1Ya5734g4H+akmxD2lSOMnVYtw0/AjIl
 crvGDyzt9eNrt0pMGPuz9GQv6eLqpUI=
X-Google-Smtp-Source: APXvYqxTx4+NuQuP8jNIeI5r9ivmuqevA1isuK7GjgLHfijvVlOCX43mVMmjKTmPP4WFccqKEYFcFA==
X-Received: by 2002:adf:eb4e:: with SMTP id u14mr74731190wrn.168.1563796220831; 
 Mon, 22 Jul 2019 04:50:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512?
 ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id g11sm38843114wru.24.2019.07.22.04.50.20
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 04:50:20 -0700 (PDT)
To: Jing Liu <jing2.liu@linux.intel.com>, qemu-devel@nongnu.org
References: <1562823509-13072-1-git-send-email-jing2.liu@linux.intel.com>
 <c572cdd2-d0f4-2e06-99f8-302b798a04dd@linux.intel.com>
 <0f9763fe-af69-e057-9fb1-00527e636fe4@redhat.com>
 <0ffa32db-3615-16e0-71bf-a8c552c2fcfb@linux.intel.com>
 <757b193f-90c6-0516-9372-74463ec4d117@redhat.com>
 <4e381ae0-78d5-afb6-9a4d-b58d0daa60ba@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3bc3b6f0-a6f8-39a7-b7d4-39b18916cc44@redhat.com>
Date: Mon, 22 Jul 2019 13:50:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4e381ae0-78d5-afb6-9a4d-b58d0daa60ba@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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

On 22/07/19 04:59, Jing Liu wrote:
> 
> 
> On 7/19/2019 4:10 PM, Paolo Bonzini wrote:
>> On 19/07/19 09:20, Jing Liu wrote:
>>>> Then CPUID[7,0].EAX is set automatically to 0 or 1 depending on whether
>>>> BF16 is enabled or not.
>>>
>>> Could I ask why don't we directly check BF16 enabling when
>>> cpu_x86_cpuid(env, 7, 0, ...) during kvm_arch_init_vcpu ?
>>
>> Because the code for setting CPUID is common for all accelerators (there
>> are five supported: KVM, HAX, HVF, TCG, WHPX).
>>
>>> What is the use of the two new properties? Are they used for users
>>> setting parameters when boot up guest, and why we need users setting
>>> func7 level?
>>
>> For example to test guests with CPUID[7,0].EAX==1, even if the host does
>> not have BF16.
> 
> Thanks. :)
>>
>>
>>> @@ -5075,6 +5101,10 @@ static void x86_cpu_expand_features(X86CPU *cpu,
>>> Error **errp)
>>>           x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
>>>           x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
>>>
>>> +       if ((env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_AVX512_BF16) &&
>>> +            kvm_enabled()) {
>>
>> No need to check KVM.  You could also do just
>> x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX) and set
>> cpu->min_level_func7 in x86_cpu_adjust_feat_level with something like
>>
>>      if (eax == 7) {
>>          x86_cpu_adjust_level(cpu, &env->cpu_min_level_func7,
>>                               fi->cpuid.ecx);
>>      }
>>
> 
> Got it. One question I'm wondering is, is it possible for users setting
> an invalid property like level-func7=2? Do we need some protection?

No, it's still not found in Intel silicon, but in principle you could
have higher indices than 1.  So it's okay, if something breaks it's the
fault of whoever set the option!

Paolo



