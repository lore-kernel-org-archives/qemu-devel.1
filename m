Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B5AC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6F4216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6F4216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjWSm-00065p-2M
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 18:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54357)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hjWRp-0005eW-TR
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hjWRo-0001ot-OK
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:12:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hjWRo-0001oS-Gf
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:12:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so4891008wrl.7
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 15:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n2IJlSh9VQsCDYj93z1bizHu6SdHifxTbHs9hM9aYp0=;
 b=B8mx6LF/4PbBs3Nv72qd8w6lT9HpZ2Eh+Wb8ANa9uvSver3NCBuWx54ngewBL52csZ
 AeKqR0nbnqNqE0aJNaxmRDdsF78SrQmb3wH7loj6vfAnGZIoFoBbzdwx6yEuVGDfJG6j
 CofmLts7qd0Uz1gtGQuTsibxNmUOko57kRimnB3YjKI48Dr8+cCyaLnjTj2SVBEFrwdl
 lkMHKY+n5v+SWizni+SnZzgx1BjnM780iEsz40RZ4V2jTpWdGXcj5fRDkRPahOWLbl9O
 2mE4/SOgBNz1H75vLk0Zt3xkZaVFuQTundAK/64u6RfvzKR6VfYJ7ORxbJZ/+I1S54Cv
 aT+A==
X-Gm-Message-State: APjAAAVnmX47e1O+qenuEFCfEK654Ve7ROh73cedVtTyrbWCn8LiDvcE
 iXSJ63dl/HJxnCDV6CkNi3pWcw==
X-Google-Smtp-Source: APXvYqyCSAi6Qdav2QOhDl7jVxQ4waUvd3MBgyAJu3+NKtHp/R0So1R11sivsKAe6f8RUadUIIR+7g==
X-Received: by 2002:adf:aad1:: with SMTP id i17mr5837196wrc.63.1562364771173; 
 Fri, 05 Jul 2019 15:12:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423?
 ([2001:b07:6468:f312:19db:ad53:90ea:9423])
 by smtp.gmail.com with ESMTPSA id u25sm12273195wmc.3.2019.07.05.15.12.50
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 15:12:50 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
 <1562079681-19204-7-git-send-email-pbonzini@redhat.com>
 <20190705212249.GG5198@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6262c798-fc94-5100-8836-e3cbea306282@redhat.com>
Date: Sat, 6 Jul 2019 00:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705212249.GG5198@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 6/7] target/i386: add VMX features
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
Cc: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/07/19 23:22, Eduardo Habkost wrote:
>> +    switch (index) {
>> +    case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
>> +        default1 = 0x00000016;
>> +        break;
>> +    case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
>> +        default1 = 0x0401e172;
>> +        break;
>> +    case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
>> +        default1 = 0x000011ff;
>> +        break;
>> +    case MSR_IA32_VMX_TRUE_EXIT_CTLS:
>> +        default1 = 0x00036dff;
>> +        break;
>> +    case MSR_IA32_VMX_PROCBASED_CTLS2:
>> +        default1 = 0;
>> +        break;
> How do you plan to implement backwards compatibility if these
> defaults ever change?  Shouldn't these values be part of the CPU
> model definitions so we can update them in the future?

These are not defaults, they are "default-1 bits": if a feature is
disabled, these bits are 1 in both halves of the MSR rather than zero.
The set of default-1 bits is documented and is not going to change in
the future.

Some default-1 bits *could* however become features in the future, and
four of these already have features associated to them:
vmx-cr3-load-noexit, vmx-cr3-store-noexit, vmx-exit-nosave-debugctl,
vmx-entry-noload-debugctl.  You can see that they have "no" in their
name because the feature is about the ability to "do less" rather than
"do more".

>> +    uint64_t kvm_vmx_basic =
>> +        kvm_arch_get_supported_msr_feature(kvm_state,
>> +                                           MSR_IA32_VMX_BASIC);
>> +    uint64_t kvm_vmx_misc =
>> +        kvm_arch_get_supported_msr_feature(kvm_state,
>> +                                           MSR_IA32_VMX_MISC);
>> +    uint64_t kvm_vmx_ept_vpid =
>> +        kvm_arch_get_supported_msr_feature(kvm_state,
>> +                                           MSR_IA32_VMX_EPT_VPID_CAP);
> 
> If the MSR value we're exposing to the guest depends on
> kvm_arch_get_supported_msr_feature(), how will we ensure this
> will be safe for live migration?

Because KVM guarantees that this part of the guest ABI will never
change.  These values do not come from the host values of the MSRs, they
are fixed by KVM.  More details below.

> If we really need to tweak the MSR values based on the host for
> some reason (which is not clear to me yet), why don't we update
> env->features[...] at x86_cpu_expand_features() to reflect what
> the guest is really seeing?
> 
> 
>> +    /*
>> +     * Bits 0-30, 32-44 and 50-53 come from the host.  KVM should
>> +     * not change them for backwards compatibility.
> 
> Backwards compatibility with what?
> 
> Don't we want the MSR values to depend solely on the QEMU command
> line in the future?

These bits are: VMCS revision, VMCS size and VMCS memory type.  QEMU
cannot know them, as they depend on the internal implementation details
of KVM.

Now that KVM supports nested virt live migration they cannot change
anymore---otherwise KVM would break KVM live migration compatibility.
However, theoretically in the future KVM could add some capability
(which userspace would have to manually enable) and when the capability
is enabled the values can change.

> +    /*
> +     * Same for bits 0-4 and 25-27.  Bits 16-24 (CR3 target count) can
> +     * change in the future but are always zero for now, clear them to be
> +     * future proof.  Bits 32-63 in theory could change, though KVM does
> +     * not support dual-monitor treatment and probably never will; mask
> +     * them out as well.
> +     */

The reasoning is more or less the same here.  These bits are part of the
guest ABI (preemption timer scaling, CR3 target count, MSR count, MSEG
revision).  Right now bits 0-4 are 5 and the others are 0; in the future:

- KVM cannot change bits 0-4 and 32-63 them without breaking guest ABI
(the values must match between what you read and what you set)

- KVM could change bits 16-24, but it always allows writing a value that
is _smaller_ than the one you read.  So I'm zeroing those, ensuring no
future ABI changes.

- KVM could in theory change bits 25-27: here it also allows writing a
value that is smaller than the one you read, so guest ABI is preserved.
 Such a change is very unlikely, all Intel silicon has always had 0
here.  But I can change the code to zero these three bits just like bits
16-24.

Paolo

