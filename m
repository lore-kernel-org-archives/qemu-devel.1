Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB586C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B513321881
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B513321881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5CUr-0005DG-UA
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 13:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1i5CTt-0004iP-Gd
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1i5CTs-0002Y9-6h
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:20:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1i5CTr-0002W4-UZ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:20:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 262A23C919;
 Tue,  3 Sep 2019 17:20:35 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-140.ams2.redhat.com
 [10.36.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6C5160126;
 Tue,  3 Sep 2019 17:20:26 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <b3907432-b149-3f96-6d93-f443f215e0f8@redhat.com>
 <2b4ba607-f0e3-efee-6712-6dcef129b310@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA209B@ORSMSX113.amr.corp.intel.com>
 <7f2d2f1e-2dd8-6914-c55e-61067e06b142@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA218F@ORSMSX113.amr.corp.intel.com>
 <3661c0c5-3da4-1453-a66a-3e4d4022e876@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA2346@ORSMSX113.amr.corp.intel.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F76FDAF@shsmsx102.ccr.corp.intel.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA25CC@ORSMSX113.amr.corp.intel.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7728AB@shsmsx102.ccr.corp.intel.com>
 <20190827203102.56d0d048@redhat.com>
 <033ced1a-1399-968e-cce6-6b15a20b0baf@redhat.com>
 <20190830164802.1b17ff26@redhat.com>
 <a43d47e0-6e99-ad42-77d4-638421e8768c@redhat.com>
 <20190902104534.46e58c95@redhat.com>
 <2ef1910e-8879-028a-4db6-97a0ecc64083@redhat.com>
 <20190903165355.27e1eee0@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <17985043-f16c-0ff4-6f60-b6762d72e848@redhat.com>
Date: Tue, 3 Sep 2019 19:20:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190903165355.27e1eee0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 03 Sep 2019 17:20:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [edk2-rfc] [edk2-devel] CPU hotplug using SMM with
 QEMU+OVMF
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Yao,
 Jiewen" <jiewen.yao@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
 "Kinney, Michael D" <michael.d.kinney@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/03/19 16:53, Igor Mammedov wrote:
> On Mon, 2 Sep 2019 21:09:58 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> On 09/02/19 10:45, Igor Mammedov wrote:
>>> On Fri, 30 Aug 2019 20:46:14 +0200
>>> Laszlo Ersek <lersek@redhat.com> wrote:
>>>   
>>>> On 08/30/19 16:48, Igor Mammedov wrote:
>>>>  
>>>>> (01) On boot firmware maps and initializes SMI handler at default SMBASE (30000)
>>>>>      (using dedicated SMRAM at 30000 would allow us to avoid save/restore
>>>>>       steps and make SMM handler pointer not vulnerable to DMA attacks)
>>>>>
>>>>> (02) QEMU hotplugs a new CPU in reset-ed state and sends SCI
>>>>>
>>>>> (03) on receiving SCI, host CPU calls GPE cpu hotplug handler
>>>>>       which writes to IO port 0xB2 (broadcast SMI)
>>>>>
>>>>> (04) firmware waits for all existing CPUs rendezvous in SMM mode,
>>>>>      new CPU(s) have SMI pending but does nothing yet
>>>>>
>>>>> (05) host CPU wakes up one new CPU (INIT-INIT-SIPI)
>>>>>      SIPI vector points to RO flash HLT loop.
>>>>>      (how host CPU will know which new CPUs to relocate?
>>>>>       possibly reuse QEMU CPU hotplug MMIO interface???)
>>>>>
>>>>> (06) new CPU does relocation.
>>>>>      (in case of attacker sends SIPI to several new CPUs,
>>>>>       open question how to detect collision of several CPUs at the same default SMBASE)
>>>>>
>>>>> (07) once new CPU relocated host CPU completes initialization, returns
>>>>>      from IO port write and executes the rest of GPE handler, telling OS
>>>>>      to online new CPU.    
>>>>
>>>> In step (03), it is the OS that handles the SCI; it transfers control to
>>>> ACPI. The AML can write to IO port 0xB2 only because the OS allows it.
>>>>
>>>> If the OS decides to omit that step, and sends an INIT-SIPI-SIPI
>>>> directly to the new CPU, can it steal the CPU?  
>>> It sure can but this way it won't get access to privileged SMRAM
>>> so OS can't subvert firmware.
>>> The next time SMI broadcast is sent the CPU will use SMI handler at
>>> default 30000 SMBASE. It's up to us to define behavior here (for example
>>> relocation handler can put such CPU in shutdown state).
>>>
>>> It's in the best interest of OS to cooperate and execute AML
>>> provided by firmware, if it does not follow proper cpu hotplug flow
>>> we can't guarantee that stolen CPU will work.  
>>
>> This sounds convincing enough, for the hotplugged CPU; thanks.
>>
>> So now my concern is with step (01). While preparing for the initial
>> relocation (of cold-plugged CPUs), the code assumes the memory at the
>> default SMBASE (0x30000) is normal RAM.
>>
>> Is it not a problem that the area is written initially while running in
>> normal 32-bit or 64-bit mode, but then executed (in response to the
>> first, synchronous, SMI) as SMRAM?
> 
> currently there is no SMRAM at 0x30000, so all access falls through
> into RAM address space and we are about to change that.
> 
> but firmware doesn't have to use it as RAM, it can check if QEMU
> supports SMRAM at 0x30000 and if supported map it to configure
> and then lock it down.

I'm sure you are *technically* right, but you seem to be assuming that I
can modify or rearrange anything I want in edk2. :)

If we can solve the above in OVMF platform code, that's great. If not
(e.g. UefiCpuPkg code needs to be updated), then things will get tricky.
If we can introduce another platform hook for this, that would help. I
can't say before I try.


> 
>  
>> Basically I'm confused by the alias.
>>
>> TSEG (and presumably, A/B seg) work like this:
>> - when open, looks like RAM to normal mode and SMM
>> - when closed, looks like black-hole to normal mode, and like RAM to SMM
>>
>> The generic edk2 code knows this, and manages the SMRAM areas accordingly.
>>
>> The area at 0x30000 is different:
>> - looks like RAM to both normal mode and SMM
>>
>> If we set up the alias at 0x30000 into A/B seg,
>> - will that *permanently* hide the normal RAM at 0x30000?
>> - will 0x30000 start behaving like A/B seg?
>>
>> Basically my concern is that the universal code in edk2 might or might
>> not keep A/B seg open while initially populating the area at the default
>> SMBASE. Specifically, I can imagine two issues:
>>
>> - if the alias into A/B seg is inactive during the initial population,
>> then the initial writes go to RAM, but the execution (the first SMBASE
>> relocation) will occur from A/B seg through the alias
>>
>> - alternatively, if the alias is always active, but A/B seg is closed
>> during initial population (which happens in normal mode), then the
>> initial writes go to the black hole, and execution will occur from a
>> "blank" A/B seg.
>>
>> Am I seeing things? (Sorry, I keep feeling dumber and dumber in this
>> thread.)
> 
> I don't really know how firmware uses A/B segments and I'm afraid that
> cannibalizing one for configuring 0x30000 might break something.
> 
> Since we are inventing something out of q35 spec anyway, How about
> leaving A/B/TSEG to be and using fwcfg to configure when/where
> SMRAM(0x30000+128K) should be mapped into RAM address space.
> 
> I see a couple of options:
>   1: use identity mapping where SMRAM(0x30000+128K) maps into the same
>      range in RAM address space when firmware writes into fwcfg
>      file and unmaps/locks on the second write (until HW reset)
>   2: let firmware choose where to map SMRAM(0x30000+128K) in RAM address
>      space, logic is essentially the same as above only firmware
>      picks and writes into fwcfg an address where SMRAM(0x30000+128K)
>      should be mapped.  

Option#1 would be similar to how TSEG works now, correct? IOW normal RAM
(from the QEMU perspective) is exposed as "SMRAM" to the guest, hidden
with a "black hole" overlay (outside of SMM) if SMRAM is closed.

If that's correct, then #1 looks more attractive to me than #2.

Thanks
Laszlo


