Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B88C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CD22089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CD22089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIptU-0004CR-B2
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 04:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iIps7-0003UE-AH
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iIps1-00059O-IJ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:01:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iIps1-00058w-9g
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:01:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 42EEA3C919;
 Fri, 11 Oct 2019 08:01:52 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-177.rdu2.redhat.com
 [10.10.120.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15437196B2;
 Fri, 11 Oct 2019 08:01:42 +0000 (UTC)
Subject: Re: [RFC 0/3] acpi: cphp: add CPHP_GET_CPU_ID_CMD command to cpu
 hotplug MMIO interface
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191010055356-mutt-send-email-mst@kernel.org>
 <20191010153815.4f7a3fc9@redhat.com>
 <20191010095459-mutt-send-email-mst@kernel.org>
 <20191010175754.7c62cf8f@Igors-MacBook-Pro>
 <20191010192039.GE4084@habkost.net>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e17adca7-f5f4-3a28-a4a2-6b921c1c2e2f@redhat.com>
Date: Fri, 11 Oct 2019 10:01:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191010192039.GE4084@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 11 Oct 2019 08:01:52 +0000 (UTC)
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 21:20, Eduardo Habkost wrote:
> On Thu, Oct 10, 2019 at 05:57:54PM +0200, Igor Mammedov wrote:
>> On Thu, 10 Oct 2019 09:59:42 -0400
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> On Thu, Oct 10, 2019 at 03:39:12PM +0200, Igor Mammedov wrote:
>>>> On Thu, 10 Oct 2019 05:56:55 -0400
>>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>>
>>>>> On Wed, Oct 09, 2019 at 09:22:49AM -0400, Igor Mammedov wrote:
>>>>>> As an alternative to passing to firmware topology info via new fwcfg files
>>>>>> so it could recreate APIC IDs based on it and order CPUs are enumerated,
>>>>>>
>>>>>> extend CPU hotplug interface to return APIC ID as response to the new command
>>>>>> CPHP_GET_CPU_ID_CMD.  
>>>>>
>>>>> One big piece missing here is motivation:
>>>> I thought the only willing reader was Laszlo (who is aware of context)
>>>> so I skipped on details and confused others :/
>>>>
>>>>> Who's going to use this interface?
>>>> In current state it's for firmware, since ACPI tables can cheat
>>>> by having APIC IDs statically built in.
>>>>
>>>> If we were creating CPU objects in ACPI dynamically
>>>> we would be using this command as well.
>>>
>>> I'm not sure how it's even possible to create devices dynamically. Well
>>> I guess it's possible with LoadTable. Is this what you had in
>>> mind?
>>
>> Yep. I even played this shiny toy and I can say it's very tempting one.
>> On the  other side, even problem of legacy OSes not working with it aside,
>> it's hard to debug and reproduce compared to static tables.
>> So from maintaining pov I dislike it enough to be against it.
>>
>>
>>>> It would save
>>>> us quite a bit space in ACPI blob but it would be a pain
>>>> to debug and diagnose problems in ACPI tables, so I'd rather
>>>> stay with static CPU descriptions in ACPI tables for the sake
>>>> of maintenance.
>>>>> So far CPU hotplug was used by the ACPI, so we didn't
>>>>> really commit to a fixed interface too strongly.
>>>>>
>>>>> Is this a replacement to Laszlo's fw cfg interface?
>>>>> If yes is the idea that OVMF going to depend on CPU hotplug directly then?
>>>>> It does not depend on it now, does it?
>>>> It doesn't, but then it doesn't support cpu hotplug,
>>>> OVMF(SMM) needs to cooperate with QEMU "and" ACPI tables to perform
>>>> the task and using the same interface/code path between all involved
>>>> parties makes the task easier with the least amount of duplicated
>>>> interfaces and more robust.
>>>>
>>>> Re-implementing alternative interface for firmware (fwcfg or what not)
>>>> would work as well, but it's only question of time when ACPI and
>>>> this new interface disagree on how world works and process falls
>>>> apart.
>>>
>>> Then we should consider switching acpi to use fw cfg.
>>> Or build another interface that can scale.
>>
>> Could be an option, it would be a pain to write a driver in AML for fwcfg access though
>> (I've looked at possibility to access fwcfg from AML about a year ago and gave up.
>> I'm definitely not volunteering for the second attempt and can't even give an estimate
>> it it's viable approach).
>>
>> But what scaling issue you are talking about, exactly?
>> With current CPU hotplug interface we can handle upto UNIT32_MAX cpus, and extend
>> interface without need to increase IO window we are using now.
>>
>> Granted IO access it not fastest compared to fwcfg in DMA mode, but we already
>> doing stop machine when switching to SMM which is orders of magnitude slower.
>> Consensus was to compromise on speed of CPU hotplug versus more complex and more
>> problematic unicast SMM mode in OVMF (can't find a particular email but we have discussed
>> it with Laszlo already, when I considered ways to optimize hotplug speed)
> 
> If we were designing the interface from the ground up, I would
> agree with Michael.  But I don't see why we would reimplement
> everything from scratch now, if just providing the
> cpu_selector => cpu_hardware_id mapping to firmware is enough to
> make the existing interface work.
> 
> If somebody is really unhappy with the current interface and
> wants to implement a new purely fw_cfg-based one (and write the
> corresponding ACPI code), they would be welcome.

Let me re-iterate the difficulties quickly:

- DMA-based fw_cfg is troublesome in SEV guests (do you want to mess
with page table entries in AML methods? or pre-allocate an always
decrypted opregion? how large?)

- IO port based fw_cfg does not support writes (and I reckon that, when
the *OS* handles a hotplug event, it does have to talk back to QEMU)

- the CPU hotplug AML would have to arbitrate with Linux's own fw_cfg
driver (which exposes fw_cfg files to userspace, yay! /s)

In the phys world, CPU hotplug takes dedicated RAS hardware. Shoehorning
CPU hotplug into *firmware* config, when in two use cases [*], the
firmware shouldn't even know about CPU hotplug, feels messy.

[*] being (a) SeaBIOS, and (b) OVMF built without SMM

> I just don't see why we should spend our time doing that now.

I have to agree, we're already spread thin.

... I must admit: I didn't expect this, but now I've grown to *prefer*
the CPU hotplug register block!

Laszlo

