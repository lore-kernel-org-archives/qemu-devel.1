Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F83C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 20:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434362077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 20:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434362077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyiQ4-0004Ac-53
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 16:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1hyiOv-0003c6-J4
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 16:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hyiOs-0007AT-VH
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 16:00:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25613)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hyiOs-00077J-NR
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 16:00:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B78C30821A1;
 Fri, 16 Aug 2019 20:00:36 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-63.ams2.redhat.com
 [10.36.116.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFAC517C2A;
 Fri, 16 Aug 2019 20:00:33 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>, devel@edk2.groups.io,
 "Yao, Jiewen" <jiewen.yao@intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
 <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <398b3327-0820-95af-a34d-1a4a1d50cf35@redhat.com>
Date: Fri, 16 Aug 2019 22:00:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 16 Aug 2019 20:00:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
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
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/15/19 18:21, Paolo Bonzini wrote:
> On 15/08/19 17:00, Laszlo Ersek wrote:
>> On 08/14/19 16:04, Paolo Bonzini wrote:
>>> On 14/08/19 15:20, Yao, Jiewen wrote:
>>>>> - Does this part require a new branch somewhere in the OVMF SEC cod=
e?
>>>>>   How do we determine whether the CPU executing SEC is BSP or
>>>>>   hot-plugged AP?
>>>> [Jiewen] I think this is blocked from hardware perspective, since th=
e first instruction.
>>>> There are some hardware specific registers can be used to determine =
if the CPU is new added.
>>>> I don=E2=80=99t think this must be same as the real hardware.
>>>> You are free to invent some registers in device model to be used in =
OVMF hot plug driver.
>>>
>>> Yes, this would be a new operation mode for QEMU, that only applies t=
o
>>> hot-plugged CPUs.  In this mode the AP doesn't reply to INIT or SMI, =
in
>>> fact it doesn't reply to anything at all.
>>>
>>>>> - How do we tell the hot-plugged AP where to start execution? (I.e.=
 that
>>>>>   it should execute code at a particular pflash location.)
>>>> [Jiewen] Same real mode reset vector at FFFF:FFF0.
>>>
>>> You do not need a reset vector or INIT/SIPI/SIPI sequence at all in
>>> QEMU.  The AP does not start execution at all when it is unplugged, s=
o
>>> no cache-as-RAM etc.
>>>
>>> We only need to modify QEMU so that hot-plugged APIs do not reply to
>>> INIT/SIPI/SMI.
>>>
>>>> I don=E2=80=99t think there is problem for real hardware, who always=
 has CAR.
>>>> Can QEMU provide some CPU specific space, such as MMIO region?
>>>
>>> Why is a CPU-specific region needed if every other processor is in SM=
M
>>> and thus trusted.
>>
>> I was going through the steps Jiewen and Yingwen recommended.
>>
>> In step (02), the new CPU is expected to set up RAM access. In step
>> (03), the new CPU, executing code from flash, is expected to "send boa=
rd
>> message to tell host CPU (GPIO->SCI) -- I am waiting for hot-add
>> message." For that action, the new CPU may need a stack (minimally if =
we
>> want to use C function calls).
>>
>> Until step (03), there had been no word about any other (=3D pre-plugg=
ed)
>> CPUs (more precisely, Jiewen even confirmed "No impact to other
>> processors"), so I didn't assume that other CPUs had entered SMM.
>>
>> Paolo, I've attempted to read Jiewen's response, and yours, as careful=
ly
>> as I can. I'm still very confused. If you have a better understanding,
>> could you please write up the 15-step process from the thread starter
>> again, with all QEMU customizations applied? Such as, unnecessary step=
s
>> removed, and platform specifics filled in.
>=20
> Sure.
>=20
> (01a) QEMU: create new CPU.  The CPU already exists, but it does not
>      start running code until unparked by the CPU hotplug controller.
>=20
> (01b) QEMU: trigger SCI
>=20
> (02-03) no equivalent
>=20
> (04) Host CPU: (OS) execute GPE handler from DSDT
>=20
> (05) Host CPU: (OS) Port 0xB2 write, all CPUs enter SMM (NOTE: New CPU
>      will not enter CPU because SMI is disabled)
>=20
> (06) Host CPU: (SMM) Save 38000, Update 38000 -- fill simple SMM
>      rebase code.

(Could Intel open source code for this?)

> (07a) Host CPU: (SMM) Write to CPU hotplug controller to enable
>      new CPU
>=20
> (07b) Host CPU: (SMM) Send INIT/SIPI/SIPI to new CPU.
>=20
> (08a) New CPU: (Low RAM) Enter protected mode.

PCI DMA attack might be relevant (but yes, I see you've mentioned that
too, down-thread)

>=20
> (08b) New CPU: (Flash) Signals host CPU to proceed and enter cli;hlt lo=
op.
>=20
> (09) Host CPU: (SMM) Send SMI to the new CPU only.
>=20
> (10) New CPU: (SMM) Run SMM code at 38000, and rebase SMBASE to
>      TSEG.

I wish we could simply wake the new CPU -- after step 07a -- with an
SMI. IOW, if we could excise steps 07b, 08a, 08b.

Our CPU hotplug controller, and the initial parked state in 01a for the
new CPU, are going to be home-brewed anyway.

On the other hand...

> (11) Host CPU: (SMM) Restore 38000.
>=20
> (12) Host CPU: (SMM) Update located data structure to add the new CPU
>      information. (This step will involve CPU_SERVICE protocol)
>=20
> (13) New CPU: (Flash) do whatever other initialization is needed
>=20
> (14) New CPU: (Flash) Deadloop, and wait for INIT-SIPI-SIPI.

basically step 08b is the environment to which the new CPU returns in
13/14, after the RSM.

Do we absolutely need low RAM for 08a (for entering protected mode)? we
could execute from pflash, no? OTOH we'd still need RAM for the stack,
and that could be attacked with PCI DMA similarly. I believe.

> (15) Host CPU: (OS) Send INIT-SIPI-SIPI to pull new CPU in..
>=20
>=20
> In other words, the cache-as-RAM phase of 02-03 is replaced by the
> INIT-SIPI-SIPI sequence of 07b-08a-08b.
>=20
>=20
>>> The QEMU DSDT could be modified (when secure boot is in effect) to OU=
T
>>> to 0xB2 when hotplug happens.  It could write a well-known value to
>>> 0xB2, to be read by an SMI handler in edk2.
>>
>> I dislike involving QEMU's generated DSDT in anything SMM (even
>> injecting the SMI), because the AML interpreter runs in the OS.
>>
>> If a malicious OS kernel is a bit too enlightened about the DSDT, it
>> could willfully diverge from the process that we design. If QEMU
>> broadcast the SMI internally, the guest OS could not interfere with th=
at.
>>
>> If the purpose of the SMI is specifically to force all CPUs into SMM
>> (and thereby force them into trusted state), then the OS would be
>> explicitly counter-interested in carrying out the AML operations from
>> QEMU's DSDT.
>=20
> But since the hotplug controller would only be accessible from SMM,
> there would be no other way to invoke it than to follow the DSDT's
> instruction and write to 0xB2.

Right.

> FWIW, real hardware also has plenty of
> 0xB2 writes in the DSDT or in APEI tables (e.g. for persistent store
> access).

Thanks
Laszlo

