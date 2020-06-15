Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22100C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 02:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA61C2063A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 02:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX5dFtjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA61C2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkf48-0002YI-4T
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 22:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jkf3P-00025z-Bj
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 22:40:55 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:38619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jkf3N-0006xQ-MJ
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 22:40:55 -0400
Received: by mail-ej1-x641.google.com with SMTP id w16so15201281ejj.5
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 19:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=4EuwGdSamo39v3CAIeEH49I1tw+FzDV97vW5fr6pwVo=;
 b=QX5dFtjNbSOb/0KXBmROewRipzcWJVOKUAL+N+PNSJ03UtMEeRqqbxQrTkc7i4+h9e
 HRaz1F2jJqXRFOL2yhBhrqz+0MDWJV49CWUc06JIrtjdps8pYsHDEuhm3a5t9xczemmn
 vh8j7tDizl0t/7r4uhpEgFxnFYM3VZrktd0KptZCwuWfGOR8Ovd3l4dfKbBnUX9O9ym7
 HJD2XAOp1k/kKLmbGvcM/9BmSU/RYeuDglKTLcRPqsjb3+nOCZ3nFl6BZJHlyM+9OR/5
 hNlBESykBA8CaCHIJcHfMmN5N2VURRbV5yVR8ALIfmVw/IM5tNExlH9vQQoI+AYM7cta
 dUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4EuwGdSamo39v3CAIeEH49I1tw+FzDV97vW5fr6pwVo=;
 b=J+LcWPV5UYIyt2BsFVQ9NSsYFLSeMR4WX6dfjGKJYkmNIE4TVOp5khK/CrkFebLsQn
 rtXN63fR5b9Y+P3LRQP9kK9yUtTTB8OwDm4sdFWGaC8WBNBi75Xtc5TrjR7apbWLIR0t
 H+E90aWAuCUYMjVovfWBwSqE7XRP6thL2GXci/ivc2zTkKsn8iGnUhxjIyoOu6SrSlBF
 fqO7jI5U5dIMZq/s7r8VgGagqs8kTz5i+zkq9FOaGRAfIgxzToZUwv/3iZ9N6Y8SqgBe
 89XnPqLnYb9SDPsWG1VyDFpxt4EKCQ69RAPmnVAzyPPDsn+cnFDjWWkfDb5M1mylKTIT
 Gvaw==
X-Gm-Message-State: AOAM5332bylDaHrtzoszJX5I5DvIBOo438XdNlothFQicQkK5JrAzJm4
 Lday8HVWBIerhkdnkaBoanc=
X-Google-Smtp-Source: ABdhPJyeukx28ZSoNHNORz0nVD40ghliu09Cy+ZVjn/9KtteMLH9JH++S+FvgzIpyyOLefc7DFioOg==
X-Received: by 2002:a17:906:d9cd:: with SMTP id
 qk13mr23221251ejb.268.1592188851348; 
 Sun, 14 Jun 2020 19:40:51 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id j2sm7545286edn.30.2020.06.14.19.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2020 19:40:50 -0700 (PDT)
Date: Mon, 15 Jun 2020 05:40:48 +0300
From: Jon Doron <arilou@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v4 5/6] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200615024048.GD8561@jondnuc>
References: <20200505150637.7131e79b@redhat.com>
 <20200511182121.GA1307176@rvkaganb.lan>
 <20200513173414.62e3cb4e@redhat.com>
 <fb1661c0-7282-58b4-03b4-a77793cc8e97@redhat.com>
 <20200522104053.4e7834a8@nas.mammed.net>
 <20200528052642.GB3071@jondnuc>
 <20200528123700.0a364b0e@redhat.com>
 <20200528110247.GD3071@jondnuc> <20200614141144.GA8561@jondnuc>
 <7a3c068b-94d1-7af4-f3ea-94dadc2fad29@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a3c068b-94d1-7af4-f3ea-94dadc2fad29@maciej.szmigiero.name>
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=arilou@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: eyakovlev@virtuozzo.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 Roman Kagan <rvkagan@yandex-team.ru>, liran.alon@oracle.com,
 Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/06/2020, Maciej S. Szmigiero wrote:
>Hi Jon,
>
>On 14.06.2020 16:11, Jon Doron wrote:
>> On 28/05/2020, Jon Doron wrote:
>>> On 28/05/2020, Igor Mammedov wrote:
>>>> On Thu, 28 May 2020 08:26:42 +0300
>>>> Jon Doron <arilou@gmail.com> wrote:
>>>>
>>>>> On 22/05/2020, Igor Mammedow wrote:
>>>>>> On Thu, 21 May 2020 18:02:07 +0200
>>>>>> Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>>>>
>>>>>>> On 13/05/20 17:34, Igor Mammedov wrote:
>>>>>>> > I'd rather avoid using random IRQ numbers (considering we are
>>>>>>> > dealing with black-box here). So if it's really necessary to have
>>>>>>> > IRQ described here, I'd suggest to implement them in device model
>>>>>>> > so they would be reserved and QEMU would error out in a sane way if
>>>>>>> > IRQ conflict is detected.
>>>>>>>
>>>>>>> We don't generally detect ISA IRQ conflicts though, do we?
>>>>>>
>>>>>> that I don't know that's why I'm not suggesting how to do it.
>>>>>> The point is hard-coding in AML random IRQs is not right thing to do,
>>>>>> (especially with the lack of 'any' spec), as minimum AML should pull
>>>>>> it from device model and that probably should be configurable and set
>>>>>> by board.
>>>>>>
>>>>>> Other thing is:
>>>>>> I haven't looked at VMBus device model in detail, but DSDT part aren't
>>>>>> matching device though (device model is not ISA device hence AML part
>>>>>> shouldn't be on in ISA scope), where to put it is open question.
>>>>>> There were other issues with AML code, I've commented on, so I was
>>>>>> waiting on respin with comments addressed.
>>>>>> I don't think that this patch is good enough for merging.
>>>>>>
>>>>>>
>>>>>
>>>>> But it seems like the current patch does match what's Microsoft HyperV
>>>>> is publishing in it's APCI tables.
>>>>>
>>>>> I dont think it's correct for us to "fix" Microsoft emulation even if
>>>>> it's wrong, since that's what Windows probably expects to see...
>>>>>
>>>>> I tried looking where Microsoft uses the ACPI tables to identify the
>>>>> VMBus but without much luck in order to understand how flexible a change
>>>>> would be for the OS to still detect the VMBus device, but in general
>>>>> I think "correcting" something that is emulated 1:1 because there is no
>>>>> spec is the right way.
>>>>
>>>> I'd agree, if removing nonsense would break VMBus detection (does it?).
>>>> if something is that doesn't make sense but has to stay because it is need
>>>> to make windows happy, that's fine , just add annotate is with comment,
>>>> so it won't confuse anyone why that code exists there later on.
>>>>
>>>> I suggest to:
>>>> 1. try dropping _PS* & _STA as it doesn't actually does anything and _PS3 is plain wrong
>>>> 2. drop one IRQ, newer hyper-v seems to be doing fine with only one
>>>> 3. it's not ISA device, I'd suggest to move into _SB scope
>>>> 4. I don't know much about IRQs but
>>>>      git grep DEFINE_PROP_ | grep -i iqr
>>>>   yields nothing so I'm not sure if it's acceptable. Typically it's board that assigns
>>>>   IRQ and not device, for Sysbus devices (see: sysbus_init_irq/sysbus_connect_irq).
>>>>   So I'd leave it upto Paolo or someone else to decide/comment on.
>>>>
>>>
>>> Sounds like a plan, I'll try to come up with the test results
>>> (at least for Windows 10 guest which is  what I have setup) and update
>>> this thread with the results.
>>>
>>> -- Jon.
>>>
>>>>>
>>>>>>>
>>>>>>> Paolo
>>>>>>>
>>>>>>
>>>>>
>>>>
>> Hi guys,
>>
>> Sorry for the delay...
>>
>> So first ill clarify what was the test, the test was to see the device
>> "Microsoft Hyper-V Virtual Machine Bus" in Windows Device Manager under
>> "System devices" with a state of "working properly".
>>
>> It seems like it's ok to drop all the _PS* and _STA.
>>
>> It seems to be functioning with single IRQ as well, it is worth noting that even when i dropped the entire _CRS (so no IRQs resources are required, the device was still showing that it's functioning, but I suspect this might affect the child devices like hv-net and hv-scsi).
>
>I guess you tested a single Windows version, correct?
>It may be that requirements differ between Windows versions, just as you
>say below about the required enlightenments.
>

Yes I have tested only a single version, but from the looks of it there 
is only a single IRQ in the HyperV APCI table that I have looked at, and 
I believe the one you have pasted as well in the past, so that change 
sounds reasonable to me.

As for the enlightenments dont you prefer to have all those as mandatory 
for VMBus in order not to run into the issue I have encountered?

>> With that said I did run into a small issue I set-up Win10 1903 (aka 19H1) and it seems like VMBus now requires to have the following features enabled:
>> HV_VP_RUNTIME_AVAILABLE
>> HV_TIME_REF_COUNT_AVAILABLE
>> HV_SYNIC_AVAILABLE
>> HV_SYNTIMERS_AVAILABLE
>> HV_APIC_ACCESS_AVAILABLE
>> HV_HYPERCALL_AVAILABLE
>> HV_VP_INDEX_AVAILABLE
>>
>> So notice that previously only SYNIC and VPINDEX was needed, now you need the whole thing so you need to run qemu with something like
>> -cpu host,hv-relaxed,hv_spinlocks=0x1fff,hv_time,hv-vapic,hv-vpindex,hv-synic,hv-runtime,hv-stimer
>>
>> The validation was done in winhv!WinHvpCheckPartitionPrivileges .
>>
>> Paolo I noticed you have done a PULL request, would you like to wait on it and we will submit a version with a single IRQ (selectable by user property) and go with Igor's suggestion dropping _PS* and _STA (though like I said before I prefer to mimic the original HyperV with it's bugs, but I'll leave this decision to you).
>
>The code is already in the upstream QEMU tree, it's a known-working code,
>so I think it is better to simply work incrementally on further improving
>the current version rather than backing it out and merging it again later.
>
>This way it will (hopefully) get some wider testing sooner.
>
>Not to mention that it is less likely for some other QEMU change to
>accidentally break it.
>

That's great I agree incrementally is the right way here, should we open 
another Thread to discuss all these changes or do you prefer we will 
keep going on this one?

>> Also today VMBus only verifies SYNIC is enabled I'm not sure how but I wonder if we want to some how exports from the CPU which other HV features are enabled so we can verify all the required ones are set, would appreciate if you have any suggestions here.
>>
>> Cheers,
>> -- Jon.
>
>Thanks,
>Maciej

Thanks,
-- Jon.

