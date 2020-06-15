Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C79C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 06:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2F52067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 06:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2F52067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkj1z-00044M-VE
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 02:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1jkj1Q-0003Xd-9Z
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 02:55:08 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:59964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1jkj1N-0007gJ-T8
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 02:55:08 -0400
Received: from MUA
 by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.93.0.4) (envelope-from <mail@maciej.szmigiero.name>)
 id 1jkj1D-0005Mp-2C; Mon, 15 Jun 2020 08:54:55 +0200
Subject: Re: [PATCH v4 5/6] i386: Hyper-V VMBus ACPI DSDT entry
To: Jon Doron <arilou@gmail.com>
References: <20200505150637.7131e79b@redhat.com>
 <20200511182121.GA1307176@rvkaganb.lan> <20200513173414.62e3cb4e@redhat.com>
 <fb1661c0-7282-58b4-03b4-a77793cc8e97@redhat.com>
 <20200522104053.4e7834a8@nas.mammed.net> <20200528052642.GB3071@jondnuc>
 <20200528123700.0a364b0e@redhat.com> <20200528110247.GD3071@jondnuc>
 <20200614141144.GA8561@jondnuc>
 <7a3c068b-94d1-7af4-f3ea-94dadc2fad29@maciej.szmigiero.name>
 <20200615024048.GD8561@jondnuc>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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 mA==
Message-ID: <af60379b-9254-f055-915f-94e6f5800ca0@maciej.szmigiero.name>
Date: Mon, 15 Jun 2020 08:54:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200615024048.GD8561@jondnuc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 02:55:03
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On 15.06.2020 04:40, Jon Doron wrote:
> On 14/06/2020, Maciej S. Szmigiero wrote:
>> Hi Jon,
>>
>> On 14.06.2020 16:11, Jon Doron wrote:
>>> On 28/05/2020, Jon Doron wrote:
>>>> On 28/05/2020, Igor Mammedov wrote:
>>>>> On Thu, 28 May 2020 08:26:42 +0300
>>>>> Jon Doron <arilou@gmail.com> wrote:
>>>>>
>>>>>> On 22/05/2020, Igor Mammedow wrote:
>>>>>>> On Thu, 21 May 2020 18:02:07 +0200
>>>>>>> Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>>>>>
>>>>>>>> On 13/05/20 17:34, Igor Mammedov wrote:
>>>>>>>> > I'd rather avoid using random IRQ numbers (considering we are
>>>>>>>> > dealing with black-box here). So if it's really necessary to have
>>>>>>>> > IRQ described here, I'd suggest to implement them in device model
>>>>>>>> > so they would be reserved and QEMU would error out in a sane way if
>>>>>>>> > IRQ conflict is detected.
>>>>>>>>
>>>>>>>> We don't generally detect ISA IRQ conflicts though, do we?
>>>>>>>
>>>>>>> that I don't know that's why I'm not suggesting how to do it.
>>>>>>> The point is hard-coding in AML random IRQs is not right thing to do,
>>>>>>> (especially with the lack of 'any' spec), as minimum AML should pull
>>>>>>> it from device model and that probably should be configurable and set
>>>>>>> by board.
>>>>>>>
>>>>>>> Other thing is:
>>>>>>> I haven't looked at VMBus device model in detail, but DSDT part aren't
>>>>>>> matching device though (device model is not ISA device hence AML part
>>>>>>> shouldn't be on in ISA scope), where to put it is open question.
>>>>>>> There were other issues with AML code, I've commented on, so I was
>>>>>>> waiting on respin with comments addressed.
>>>>>>> I don't think that this patch is good enough for merging.
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> But it seems like the current patch does match what's Microsoft HyperV
>>>>>> is publishing in it's APCI tables.
>>>>>>
>>>>>> I dont think it's correct for us to "fix" Microsoft emulation even if
>>>>>> it's wrong, since that's what Windows probably expects to see...
>>>>>>
>>>>>> I tried looking where Microsoft uses the ACPI tables to identify the
>>>>>> VMBus but without much luck in order to understand how flexible a change
>>>>>> would be for the OS to still detect the VMBus device, but in general
>>>>>> I think "correcting" something that is emulated 1:1 because there is no
>>>>>> spec is the right way.
>>>>>
>>>>> I'd agree, if removing nonsense would break VMBus detection (does it?).
>>>>> if something is that doesn't make sense but has to stay because it is need
>>>>> to make windows happy, that's fine , just add annotate is with comment,
>>>>> so it won't confuse anyone why that code exists there later on.
>>>>>
>>>>> I suggest to:
>>>>> 1. try dropping _PS* & _STA as it doesn't actually does anything and _PS3 is plain wrong
>>>>> 2. drop one IRQ, newer hyper-v seems to be doing fine with only one
>>>>> 3. it's not ISA device, I'd suggest to move into _SB scope
>>>>> 4. I don't know much about IRQs but
>>>>>      git grep DEFINE_PROP_ | grep -i iqr
>>>>>   yields nothing so I'm not sure if it's acceptable. Typically it's board that assigns
>>>>>   IRQ and not device, for Sysbus devices (see: sysbus_init_irq/sysbus_connect_irq).
>>>>>   So I'd leave it upto Paolo or someone else to decide/comment on.
>>>>>
>>>>
>>>> Sounds like a plan, I'll try to come up with the test results
>>>> (at least for Windows 10 guest which is  what I have setup) and update
>>>> this thread with the results.
>>>>
>>>> -- Jon.
>>>>
>>>>>>
>>>>>>>>
>>>>>>>> Paolo
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>> Hi guys,
>>>
>>> Sorry for the delay...
>>>
>>> So first ill clarify what was the test, the test was to see the device
>>> "Microsoft Hyper-V Virtual Machine Bus" in Windows Device Manager under
>>> "System devices" with a state of "working properly".
>>>
>>> It seems like it's ok to drop all the _PS* and _STA.
>>>
>>> It seems to be functioning with single IRQ as well, it is worth noting that even when i dropped the entire _CRS (so no IRQs resources are required, the device was still showing that it's functioning, but I suspect this might affect the child devices like hv-net and hv-scsi).
>>
>> I guess you tested a single Windows version, correct?
>> It may be that requirements differ between Windows versions, just as you
>> say below about the required enlightenments.
>>
> 
> Yes I have tested only a single version, but from the looks of it there is only a single IRQ in the HyperV APCI table that I have looked at, and I believe the one you have pasted as well in the past, so that change sounds reasonable to me.

I meant also other changes, like dropping of some ACPI methods.

> As for the enlightenments dont you prefer to have all those as mandatory for VMBus in order not to run into the issue I have encountered?

Well, if somebody wants to run only older guests they will be content with
just a limited set of enlightenments, right?

But I don't know what's the QEMU project policy is here.

>>> With that said I did run into a small issue I set-up Win10 1903 (aka 19H1) and it seems like VMBus now requires to have the following features enabled:
>>> HV_VP_RUNTIME_AVAILABLE
>>> HV_TIME_REF_COUNT_AVAILABLE
>>> HV_SYNIC_AVAILABLE
>>> HV_SYNTIMERS_AVAILABLE
>>> HV_APIC_ACCESS_AVAILABLE
>>> HV_HYPERCALL_AVAILABLE
>>> HV_VP_INDEX_AVAILABLE
>>>
>>> So notice that previously only SYNIC and VPINDEX was needed, now you need the whole thing so you need to run qemu with something like
>>> -cpu host,hv-relaxed,hv_spinlocks=0x1fff,hv_time,hv-vapic,hv-vpindex,hv-synic,hv-runtime,hv-stimer
>>>
>>> The validation was done in winhv!WinHvpCheckPartitionPrivileges .
>>>
>>> Paolo I noticed you have done a PULL request, would you like to wait on it and we will submit a version with a single IRQ (selectable by user property) and go with Igor's suggestion dropping _PS* and _STA (though like I said before I prefer to mimic the original HyperV with it's bugs, but I'll leave this decision to you).
>>
>> The code is already in the upstream QEMU tree, it's a known-working code,
>> so I think it is better to simply work incrementally on further improving
>> the current version rather than backing it out and merging it again later.
>>
>> This way it will (hopefully) get some wider testing sooner.
>>
>> Not to mention that it is less likely for some other QEMU change to
>> accidentally break it.
>>
> 
> That's great I agree incrementally is the right way here, should we open another Thread to discuss all these changes or do you prefer we will keep going on this one?

If that's going to be an incremental change it is probably worth its
own email thread.
Otherwise the existing one will grow without bounds.

>>> Also today VMBus only verifies SYNIC is enabled I'm not sure how but I wonder if we want to some how exports from the CPU which other HV features are enabled so we can verify all the required ones are set, would appreciate if you have any suggestions here.
>>>
> 
> Thanks,
> -- Jon.

Thanks,
Maciej

