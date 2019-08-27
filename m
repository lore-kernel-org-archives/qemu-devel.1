Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE6DC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92ECF21881
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92ECF21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2hpS-00037B-B3
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1i2hoS-0002b0-Sm
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1i2hoP-0004lA-4a
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:11:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1i2hoO-0004k5-QY
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:11:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A9CE89ACA;
 Tue, 27 Aug 2019 20:11:22 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE3895D6B0;
 Tue, 27 Aug 2019 20:11:16 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <35396800-32d2-c25f-b0d0-2d7cd8438687@redhat.com>
 <D2A45071-A097-4642-A34C-6B7C5D7D2466@intel.com>
 <E92EE9817A31E24EB0585FDF735412F5B9D9C671@ORSMSX113.amr.corp.intel.com>
 <a76014e2-2f0a-afce-6d15-1c45c5c1e467@redhat.com>
 <b3907432-b149-3f96-6d93-f443f215e0f8@redhat.com>
 <2b4ba607-f0e3-efee-6712-6dcef129b310@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA209B@ORSMSX113.amr.corp.intel.com>
 <7f2d2f1e-2dd8-6914-c55e-61067e06b142@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA218F@ORSMSX113.amr.corp.intel.com>
 <3661c0c5-3da4-1453-a66a-3e4d4022e876@redhat.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA2346@ORSMSX113.amr.corp.intel.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F76FDAF@shsmsx102.ccr.corp.intel.com>
 <E92EE9817A31E24EB0585FDF735412F5B9DA25CC@ORSMSX113.amr.corp.intel.com>
 <ea0330f1-cb6a-2a45-f8e7-3de19b117e77@redhat.com>
 <20190827182307.0b5ce17b@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <805ab9fc-2d51-8768-8a11-bfc90d77a29f@redhat.com>
Date: Tue, 27 Aug 2019 22:11:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190827182307.0b5ce17b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 27 Aug 2019 20:11:22 +0000 (UTC)
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

On 08/27/19 18:23, Igor Mammedov wrote:
> On Mon, 26 Aug 2019 17:30:43 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> On 08/23/19 17:25, Kinney, Michael D wrote:
>>> Hi Jiewen,
>>>
>>> If a hot add CPU needs to run any code before the
>>> first SMI, I would recommend is only executes code
>>> from a write protected FLASH range without a stack
>>> and then wait for the first SMI.  
>>
>> "without a stack" looks very risky to me. Even if we manage to implement
>> the guest code initially, we'll be trapped without a stack, should we
>> ever need to add more complex stuff there.
> 
> Do we need anything complex in relocation handler, though?
> From what I'd imagine, minimum handler should
>   1: get address of TSEG, possibly read it from chipset

The TSEG base calculation is not trivial in this environment. The 32-bit
RAM size needs to be read from the CMOS (IO port accesses). Then the
extended TSEG size (if any) needs to be detected from PCI config space
(IO port accesses). Both CMOS and PCI config space requires IO port
writes too (not just reads). Even if there are enough registers for the
calculations, can we rely on these unprotected IO ports?

Also, can we switch to 32-bit mode without a stack? I assume it would be
necessary to switch to 32-bit mode for 32-bit arithmetic.

Getting the initial APIC ID needs some CPUID instructions IIUC, which
clobber EAX through EDX, if I understand correctly. Given the register
pressure, CPUID might have to be one of the first instructions to call.

>   2: calculate its new SMBASE offset based on its APIC ID
>   3: save new SMBASE
> 
>>> For this OVMF use case, is any CPU init required
>>> before the first SMI?  
>>
>> I expressed a preference for that too: "I wish we could simply wake the
>> new CPU [...] with an SMI".
>>
>> http://mid.mail-archive.com/398b3327-0820-95af-a34d-1a4a1d50cf35@redhat.com
>>
>>
>>> From Paolo's list of steps are steps (8a) and (8b) 
>>> really required?  
> 
> 07b - implies 08b

I agree about that implication, yes. *If* we send an INIT/SIPI/SIPI to
the new CPU, then the new CPU needs a HLT loop, I think.

>    8b could be trivial hlt loop and we most likely could skip 08a and signaling host CPU steps
>    but we need INIT/SIPI/SIPI sequence to wake up AP so it could handle pending SMI
>    before handling SIPI (so behavior would follow SDM).
> 
> 
>> See again my message linked above -- just after the quoted sentence, I
>> wrote, "IOW, if we could excise steps 07b, 08a, 08b".
>>
>> But, I obviously defer to Paolo and Igor on that.
>>
>> (I do believe we have a dilemma here. In QEMU, we probably prefer to
>> emulate physical hardware as faithfully as possible. However, we do not
>> have Cache-As-RAM (nor do we intend to, IIUC). Does that justify other
>> divergences from physical hardware too, such as waking just by virtue of
>> an SMI?)
> So far we should be able to implement it per spec (at least SDM one),
> but we would still need to invent chipset hardware
> i.e. like adding to Q35 non exiting SMRAM and means to map/unmap it
> to non-SMM address space.
> (and I hope we could avoid adding "parked CPU" thingy)

I think we'll need a separate QEMU tree for this. I'm quite in the dark
-- I can't tell if I'll be able to do something in OVMF without actually
trying it. And for that, we'll need some proposed QEMU code that is
testable, but not upstream yet. (As I might realize that I'm unable to
make it work in OVMF.)

>>> Can the SMI monarch use the Local
>>> APIC to send a directed SMI to the hot added CPU?
>>> The SMI monarch needs to know the APIC ID of the
>>> hot added CPU.  Do we also need to handle the case
>>> where multiple CPUs are added at once?  I think we
>>> would need to serialize the use of 3000:8000 for the
>>> SMM rebase operation on each hot added CPU.  
>>
>> I agree this would be a huge help.
> 
> We can serialize it (for normal hotplug flow) from ACPI handler
> in the guest (i.e. non enforced serialization).
> The only reason for serialization I see is not to allow
> a bunch of new CPU trample over default SMBASE save area
> at the same time.

If the default SMBASE area is corrupted due to concurrent access, could
that lead to invalid relocated SMBASE values? Possibly pointing into
normal RAM?

Thanks
Laszlo

