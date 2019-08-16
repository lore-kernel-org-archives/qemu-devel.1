Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6860DC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 20:16:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2372133F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 20:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2372133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyidq-000828-BX
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 16:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1hyidA-0007bw-Aq
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 16:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hyid8-0004dW-5J
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 16:15:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33690)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hyid7-0004dC-U3
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 16:15:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0861E309DEE3;
 Fri, 16 Aug 2019 20:15:21 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-63.ams2.redhat.com
 [10.36.116.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 241F21F8;
 Fri, 16 Aug 2019 20:15:15 +0000 (UTC)
To: "Yao, Jiewen" <jiewen.yao@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "devel@edk2.groups.io" <devel@edk2.groups.io>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
 <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75FAD3@shsmsx102.ccr.corp.intel.com>
 <7cb458ea-956e-c1df-33f7-025e4f0f22df@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7600B9@shsmsx102.ccr.corp.intel.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <bb6fdbe0-2a3b-e586-e9a5-93e1ac0803ec@redhat.com>
Date: Fri, 16 Aug 2019 22:15:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <74D8A39837DF1E4DA445A8C0B3885C503F7600B9@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 16 Aug 2019 20:15:21 +0000 (UTC)
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
 qemu devel list <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Alex (direct question at the bottom)

On 08/16/19 09:49, Yao, Jiewen wrote:
> below
>=20
>> -----Original Message-----
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> Sent: Friday, August 16, 2019 3:20 PM
>> To: Yao, Jiewen <jiewen.yao@intel.com>; Laszlo Ersek
>> <lersek@redhat.com>; devel@edk2.groups.io
>> Cc: edk2-rfc-groups-io <rfc@edk2.groups.io>; qemu devel list
>> <qemu-devel@nongnu.org>; Igor Mammedov <imammedo@redhat.com>;
>> Chen, Yingwen <yingwen.chen@intel.com>; Nakajima, Jun
>> <jun.nakajima@intel.com>; Boris Ostrovsky <boris.ostrovsky@oracle.com>=
;
>> Joao Marcal Lemos Martins <joao.m.martins@oracle.com>; Phillip Goerl
>> <phillip.goerl@oracle.com>
>> Subject: Re: [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
>>
>> On 16/08/19 04:46, Yao, Jiewen wrote:
>>> Comment below:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>>>> Sent: Friday, August 16, 2019 12:21 AM
>>>> To: Laszlo Ersek <lersek@redhat.com>; devel@edk2.groups.io; Yao,
>> Jiewen
>>>> <jiewen.yao@intel.com>
>>>> Cc: edk2-rfc-groups-io <rfc@edk2.groups.io>; qemu devel list
>>>> <qemu-devel@nongnu.org>; Igor Mammedov
>> <imammedo@redhat.com>;
>>>> Chen, Yingwen <yingwen.chen@intel.com>; Nakajima, Jun
>>>> <jun.nakajima@intel.com>; Boris Ostrovsky
>> <boris.ostrovsky@oracle.com>;
>>>> Joao Marcal Lemos Martins <joao.m.martins@oracle.com>; Phillip Goerl
>>>> <phillip.goerl@oracle.com>
>>>> Subject: Re: [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
>>>>
>>>> On 15/08/19 17:00, Laszlo Ersek wrote:
>>>>> On 08/14/19 16:04, Paolo Bonzini wrote:
>>>>>> On 14/08/19 15:20, Yao, Jiewen wrote:
>>>>>>>> - Does this part require a new branch somewhere in the OVMF SEC
>>>> code?
>>>>>>>>   How do we determine whether the CPU executing SEC is BSP or
>>>>>>>>   hot-plugged AP?
>>>>>>> [Jiewen] I think this is blocked from hardware perspective, since=
 the
>> first
>>>> instruction.
>>>>>>> There are some hardware specific registers can be used to determi=
ne
>> if
>>>> the CPU is new added.
>>>>>>> I don=E2=80=99t think this must be same as the real hardware.
>>>>>>> You are free to invent some registers in device model to be used =
in
>>>> OVMF hot plug driver.
>>>>>>
>>>>>> Yes, this would be a new operation mode for QEMU, that only applie=
s
>> to
>>>>>> hot-plugged CPUs.  In this mode the AP doesn't reply to INIT or SM=
I,
>> in
>>>>>> fact it doesn't reply to anything at all.
>>>>>>
>>>>>>>> - How do we tell the hot-plugged AP where to start execution? (I=
.e.
>>>> that
>>>>>>>>   it should execute code at a particular pflash location.)
>>>>>>> [Jiewen] Same real mode reset vector at FFFF:FFF0.
>>>>>>
>>>>>> You do not need a reset vector or INIT/SIPI/SIPI sequence at all i=
n
>>>>>> QEMU.  The AP does not start execution at all when it is unplugged=
,
>> so
>>>>>> no cache-as-RAM etc.
>>>>>>
>>>>>> We only need to modify QEMU so that hot-plugged APIs do not reply
>> to
>>>>>> INIT/SIPI/SMI.
>>>>>>
>>>>>>> I don=E2=80=99t think there is problem for real hardware, who alw=
ays has CAR.
>>>>>>> Can QEMU provide some CPU specific space, such as MMIO region?
>>>>>>
>>>>>> Why is a CPU-specific region needed if every other processor is in=
 SMM
>>>>>> and thus trusted.
>>>>>
>>>>> I was going through the steps Jiewen and Yingwen recommended.
>>>>>
>>>>> In step (02), the new CPU is expected to set up RAM access. In step
>>>>> (03), the new CPU, executing code from flash, is expected to "send
>> board
>>>>> message to tell host CPU (GPIO->SCI) -- I am waiting for hot-add
>>>>> message." For that action, the new CPU may need a stack (minimally =
if
>> we
>>>>> want to use C function calls).
>>>>>
>>>>> Until step (03), there had been no word about any other (=3D pre-pl=
ugged)
>>>>> CPUs (more precisely, Jiewen even confirmed "No impact to other
>>>>> processors"), so I didn't assume that other CPUs had entered SMM.
>>>>>
>>>>> Paolo, I've attempted to read Jiewen's response, and yours, as care=
fully
>>>>> as I can. I'm still very confused. If you have a better understandi=
ng,
>>>>> could you please write up the 15-step process from the thread start=
er
>>>>> again, with all QEMU customizations applied? Such as, unnecessary
>> steps
>>>>> removed, and platform specifics filled in.
>>>>
>>>> Sure.
>>>>
>>>> (01a) QEMU: create new CPU.  The CPU already exists, but it does not
>>>>      start running code until unparked by the CPU hotplug controller=
.
>>>>
>>>> (01b) QEMU: trigger SCI
>>>>
>>>> (02-03) no equivalent
>>>>
>>>> (04) Host CPU: (OS) execute GPE handler from DSDT
>>>>
>>>> (05) Host CPU: (OS) Port 0xB2 write, all CPUs enter SMM (NOTE: New C=
PU
>>>>      will not enter CPU because SMI is disabled)
>>>>
>>>> (06) Host CPU: (SMM) Save 38000, Update 38000 -- fill simple SMM
>>>>      rebase code.
>>>>
>>>> (07a) Host CPU: (SMM) Write to CPU hotplug controller to enable
>>>>      new CPU
>>>>
>>>> (07b) Host CPU: (SMM) Send INIT/SIPI/SIPI to new CPU.
>>> [Jiewen] NOTE: INIT/SIPI/SIPI can be sent by a malicious CPU. There i=
s no
>>> restriction that INIT/SIPI/SIPI can only be sent in SMM.
>>
>> All of the CPUs are now in SMM, and INIT/SIPI/SIPI will be discarded
>> before 07a, so this is okay.
> [Jiewen] May I know why INIT/SIPI/SIPI is discarded before 07a but is d=
elivered at 07a?
> I don=E2=80=99t see any extra step between 06 and 07a.
> What is the magic here?

The magic is 07a itself, IIUC. The CPU hotplug controller would be
accessible only in SMM. And until 07a happens, the new CPU ignores
INIT/SIPI/SIPI even if another CPU sends it those, simply because QEMU
would implement the new CPU's behavior like that.

>=20
>=20
>=20
>> However I do see a problem, because a PCI device's DMA could overwrite
>> 0x38000 between (06) and (10) and hijack the code that is executed in
>> SMM.  How is this avoided on real hardware?  By the time the new CPU
>> enters SMM, it doesn't run off cache-as-RAM anymore.
> [Jiewen] Interesting question.
> I don=E2=80=99t think the DMA attack is considered in threat model for =
the virtual environment. We only list adversary below:
> -- Adversary: System Software Attacker, who can control any OS memory o=
r silicon register from OS level, or read write BIOS data.
> -- Adversary: Simple hardware attacker, who can hot add or hot remove a=
 CPU.

We do have physical PCI(e) device assignment; sorry for not highlighting
that earlier. That feature (VFIO) does rely on the (physical) IOMMU, and
it makes sure that the assigned device can only access physical frames
that belong to the virtual machine that the device is assigned to.

However, as far as I know, VFIO doesn't try to restrict PCI DMA to
subsets of guest RAM... I could be wrong about that, I vaguely recall
RMRR support, which seems somewhat related.

> I agree it is a threat from real hardware perspective. SMM may check VT=
d to make sure the 38000 is blocked.
> I doubt if it is a threat in virtual environment. Do we have a way to b=
lock DMA in virtual environment?

I think that would be a VFIO feature.

Alex: if we wanted to block PCI(e) DMA to a specific part of guest RAM
(expressed with guest-physical RAM addresses), perhaps permanently,
perhaps just for a while -- not sure about coordination though --, could
VFIO accommodate that (I guess by "punching holes" in the IOMMU page
tables)?

Thanks
Laszlo

>=20
>=20
>=20
>> Paolo
>>
>>>> (08a) New CPU: (Low RAM) Enter protected mode.
>>>
>>> [Jiewen] NOTE: The new CPU still cannot use any physical memory,
>> because
>>> the INIT/SIPI/SIPI may be sent by malicious CPU in non-SMM environmen=
t.
>>>
>>>> (08b) New CPU: (Flash) Signals host CPU to proceed and enter cli;hlt=
 loop.
>>>>
>>>> (09) Host CPU: (SMM) Send SMI to the new CPU only.
>>>>
>>>> (10) New CPU: (SMM) Run SMM code at 38000, and rebase SMBASE to
>>>>      TSEG.
>>>>
>>>> (11) Host CPU: (SMM) Restore 38000.
>>>>
>>>> (12) Host CPU: (SMM) Update located data structure to add the new CP=
U
>>>>      information. (This step will involve CPU_SERVICE protocol)
>>>>
>>>> (13) New CPU: (Flash) do whatever other initialization is needed
>>>>
>>>> (14) New CPU: (Flash) Deadloop, and wait for INIT-SIPI-SIPI.
>>>>
>>>> (15) Host CPU: (OS) Send INIT-SIPI-SIPI to pull new CPU in..
>>>>
>>>>
>>>> In other words, the cache-as-RAM phase of 02-03 is replaced by the
>>>> INIT-SIPI-SIPI sequence of 07b-08a-08b.
>>> [Jiewen] I am OK with this proposal.
>>> I think the rule is same - the new CPU CANNOT touch any system memory=
,
>>> no matter it is from reset-vector or from INIT/SIPI/SIPI.
>>> Or I would say: if the new CPU want to touch some memory before first
>> SMI, the memory should be
>>> CPU specific or on the flash.
>>>
>>>
>>>
>>>>>> The QEMU DSDT could be modified (when secure boot is in effect) to
>> OUT
>>>>>> to 0xB2 when hotplug happens.  It could write a well-known value t=
o
>>>>>> 0xB2, to be read by an SMI handler in edk2.
>>>>>
>>>>> I dislike involving QEMU's generated DSDT in anything SMM (even
>>>>> injecting the SMI), because the AML interpreter runs in the OS.
>>>>>
>>>>> If a malicious OS kernel is a bit too enlightened about the DSDT, i=
t
>>>>> could willfully diverge from the process that we design. If QEMU
>>>>> broadcast the SMI internally, the guest OS could not interfere with=
 that.
>>>>>
>>>>> If the purpose of the SMI is specifically to force all CPUs into SM=
M
>>>>> (and thereby force them into trusted state), then the OS would be
>>>>> explicitly counter-interested in carrying out the AML operations fr=
om
>>>>> QEMU's DSDT.
>>>>
>>>> But since the hotplug controller would only be accessible from SMM,
>>>> there would be no other way to invoke it than to follow the DSDT's
>>>> instruction and write to 0xB2.  FWIW, real hardware also has plenty =
of
>>>> 0xB2 writes in the DSDT or in APEI tables (e.g. for persistent store
>>>> access).
>>>>
>>>> Paolo
>=20


