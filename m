Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45D4C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B985620673
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B985620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3NFa-0006YW-RT
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1i3NEn-00062Y-SV
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1i3NEk-0001mv-KD
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:25:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1i3NEk-0001lj-CB
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:25:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D4AEB2BE94;
 Thu, 29 Aug 2019 16:25:23 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-174.ams2.redhat.com
 [10.36.117.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 523815C207;
 Thu, 29 Aug 2019 16:25:18 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
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
 <805ab9fc-2d51-8768-8a11-bfc90d77a29f@redhat.com>
 <20190828140121.6dba213c@Igors-MacBook-Pro>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8b336df6-3567-55ee-c77a-9f2048cc57df@redhat.com>
Date: Thu, 29 Aug 2019 18:25:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190828140121.6dba213c@Igors-MacBook-Pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 29 Aug 2019 16:25:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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

On 08/28/19 14:01, Igor Mammedov wrote:
> On Tue, 27 Aug 2019 22:11:15 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
>=20
>> On 08/27/19 18:23, Igor Mammedov wrote:
>>> On Mon, 26 Aug 2019 17:30:43 +0200
>>> Laszlo Ersek <lersek@redhat.com> wrote:
>>>
>>>> On 08/23/19 17:25, Kinney, Michael D wrote:
>>>>> Hi Jiewen,
>>>>>
>>>>> If a hot add CPU needs to run any code before the
>>>>> first SMI, I would recommend is only executes code
>>>>> from a write protected FLASH range without a stack
>>>>> and then wait for the first SMI. =20
>>>>
>>>> "without a stack" looks very risky to me. Even if we manage to imple=
ment
>>>> the guest code initially, we'll be trapped without a stack, should w=
e
>>>> ever need to add more complex stuff there.
>>>
>>> Do we need anything complex in relocation handler, though?
>>> From what I'd imagine, minimum handler should
>>>   1: get address of TSEG, possibly read it from chipset
>>
>> The TSEG base calculation is not trivial in this environment. The 32-b=
it
>> RAM size needs to be read from the CMOS (IO port accesses). Then the
>> extended TSEG size (if any) needs to be detected from PCI config space
>> (IO port accesses). Both CMOS and PCI config space requires IO port
>> writes too (not just reads). Even if there are enough registers for th=
e
>> calculations, can we rely on these unprotected IO ports?
>>
>> Also, can we switch to 32-bit mode without a stack? I assume it would =
be
>> necessary to switch to 32-bit mode for 32-bit arithmetic.
> from SDM vol 3:
> "
> 34.5.1 Initial SMM Execution Environment
> After saving the current context of the processor, the processor initia=
lizes its core registers to the values shown in Table 34-4. Upon entering=
 SMM, the PE and PG flags in control register CR0 are cleared, which plac=
es the processor in an environment similar to real-address mode. The diff=
erences between the SMM execution environment and the real-address mode e=
xecution environment are as follows:
> =E2=80=A2 The addressable address space ranges from 0 to FFFFFFFFH (4 G=
Bytes).
> =E2=80=A2 The normal 64-KByte segment limit for real-address mode is in=
creased to 4 GBytes.
> =E2=80=A2 The default operand and address sizes are set to 16 bits, whi=
ch restricts the addressable SMRAM address space to the 1-MByte real-addr=
ess mode limit for native real-address-mode code. However, operand-size a=
nd address-size override prefixes can be used to access the address space=
 beyond
>                                          ^^^^^^^^
> the 1-MByte.
> "

That helps. Thanks for the quote!

>> Getting the initial APIC ID needs some CPUID instructions IIUC, which
>> clobber EAX through EDX, if I understand correctly. Given the register
>> pressure, CPUID might have to be one of the first instructions to call=
.
>=20
> we could map at 30000 not 64K required for save area but 128K and use
> 2nd half as secure RAM for stack and intermediate data.
>=20
> Firmware could put there pre-calculated pointer to TSEG after it's conf=
igured and locked down,
> this way relocation handler won't have to figure out TSEG address on it=
s own.

Sounds like a great idea.

>>>   2: calculate its new SMBASE offset based on its APIC ID
>>>   3: save new SMBASE
>>>
>>>>> For this OVMF use case, is any CPU init required
>>>>> before the first SMI? =20
>>>>
>>>> I expressed a preference for that too: "I wish we could simply wake =
the
>>>> new CPU [...] with an SMI".
>>>>
>>>> http://mid.mail-archive.com/398b3327-0820-95af-a34d-1a4a1d50cf35@red=
hat.com
>>>>
>>>>
>>>>> From Paolo's list of steps are steps (8a) and (8b)=20
>>>>> really required? =20
>>>
>>> 07b - implies 08b
>>
>> I agree about that implication, yes. *If* we send an INIT/SIPI/SIPI to
>> the new CPU, then the new CPU needs a HLT loop, I think.
> It also could execute INIT reset, which leaves initialized SMM untouche=
d
> but otherwise CPU would be inactive.
> =20
>>
>>>    8b could be trivial hlt loop and we most likely could skip 08a and=
 signaling host CPU steps
>>>    but we need INIT/SIPI/SIPI sequence to wake up AP so it could hand=
le pending SMI
>>>    before handling SIPI (so behavior would follow SDM).
>>>
>>>
>>>> See again my message linked above -- just after the quoted sentence,=
 I
>>>> wrote, "IOW, if we could excise steps 07b, 08a, 08b".
>>>>
>>>> But, I obviously defer to Paolo and Igor on that.
>>>>
>>>> (I do believe we have a dilemma here. In QEMU, we probably prefer to
>>>> emulate physical hardware as faithfully as possible. However, we do =
not
>>>> have Cache-As-RAM (nor do we intend to, IIUC). Does that justify oth=
er
>>>> divergences from physical hardware too, such as waking just by virtu=
e of
>>>> an SMI?)
>>> So far we should be able to implement it per spec (at least SDM one),
>>> but we would still need to invent chipset hardware
>>> i.e. like adding to Q35 non exiting SMRAM and means to map/unmap it
>>> to non-SMM address space.
>>> (and I hope we could avoid adding "parked CPU" thingy)
>>
>> I think we'll need a separate QEMU tree for this. I'm quite in the dar=
k
>> -- I can't tell if I'll be able to do something in OVMF without actual=
ly
>> trying it. And for that, we'll need some proposed QEMU code that is
>> testable, but not upstream yet. (As I might realize that I'm unable to
>> make it work in OVMF.)
>=20
> Let me prepare a QEMU branch with something usable for you.
>=20
> To avoid inventing mgmt API for configuring SMRAM at 30000,
> I'm suggesting to steal/alias top or bottom 128K of TSEG window to 3000=
0.
> This way OVMF would be able to set SMI relocation handler modifying
> TSEG and pass TSEG base/other data to it as well.
> Would it work for you or should we try more elaborate approach?

I believe this this change may not be cross-compatible between QEMU and
OVMF. OVMF platform code would have to hide the stolen part of the TSEG
from core edk2 SMM code.

If old OVMF were booted on new QEMU, I believe things could break -- the
SMM core would be at liberty to use any part of the TSEG (advertized by
OVMF platform code to the full extent), and the SMM core would continue
expecting 0x30000 to be normal (and distinct) RAM. If QEMU suddenly
aliased both ranges to the same contents (in System Management Mode), I
think that would confuse the SMM core.

We already negotiate (or at least, detect) two features in this area;
"extended TSEG" and "broadcast SMI". I believe we need a CPU hotplug
controller anyway -- is that still the case? If it is, we could use
registers on that device, for managing the alias.

>> If the default SMBASE area is corrupted due to concurrent access, coul=
d
>> that lead to invalid relocated SMBASE values? Possibly pointing into
>> normal RAM?
>=20
> in case of broadcast SMI (btw does OVMF use broadcast SMIs?) several CP=
Us could end up

Broadcast SMI is very important for OVMF.

The Platform Init spec basically defines an abstract interface for
runtime UEFI drivers for submitting an "SMM request". Part of that is
raising an SMI (also abstracted).

*How* an SMI is raised is platform-dependent, and edk2 provides two
implementations for synching APs in SMM (broadcast ("traditional") and
relaxed).

In our testing on QEMU/KVM, the broadcast/traditional sync mode worked
very robustly (with QEMU actually broadcasting the SMI in response to IO
port 0xB2 writes), but the relaxed synch mode was unstable / brittle (in
particular during S3 resume). Therefore broadcast SMI is negotiated by
OVMF whenever it is available -- it makes a big difference in stability.

Now, whether broadcast SMI needs to be part of CPU hotplug specifically,
that's a different question. The CPU hotplug logic may not necessarily
have to go through the same (standardized) interfaces that runtime UEFI
drivers do.

> with the same SMBASE within SMRAM
>   1: default one: in case the 2nd CPU enters SMM after the 1st CPU save=
d new SMBASE but before it's called RSM
>   2: duplicated SMBASE: where the 2nd CPU saves its new SMBASE before t=
he 1st calls RSM
>=20
> while the 2nd could be counteracted with using locks, I don't see how 1=
st one could be avoided.
> May be host CPU can send 2nd SMI so just relocated CPU could send an AC=
K from relocated SMBASE/with new SMI handler?

I don't have any better idea. We could protect the default SMBASE with a
semaphore (spinlock?) in SMRAM, but that would have to be released with
the owning CPU executing code at the new SMBASE. Basically, what you
say, just "ACK" meaning "release the spinlock".

Thanks,
Laszlo

