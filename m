Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63298C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 22:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FC02086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 22:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FC02086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hykaF-0007Ou-U4
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 18:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1hykZP-0006r9-Kd
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 18:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hykZN-0001c1-B6
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 18:19:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54514)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hykZN-0001b8-3a
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 18:19:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 688FC8AC6F2;
 Fri, 16 Aug 2019 22:19:35 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32BEA1F8;
 Fri, 16 Aug 2019 22:19:34 +0000 (UTC)
Date: Fri, 16 Aug 2019 16:19:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Message-ID: <20190816161933.7d30a881@x1.home>
In-Reply-To: <bb6fdbe0-2a3b-e586-e9a5-93e1ac0803ec@redhat.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
 <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75FAD3@shsmsx102.ccr.corp.intel.com>
 <7cb458ea-956e-c1df-33f7-025e4f0f22df@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7600B9@shsmsx102.ccr.corp.intel.com>
 <bb6fdbe0-2a3b-e586-e9a5-93e1ac0803ec@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 16 Aug 2019 22:19:35 +0000 (UTC)
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
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>, "Yao, Jiewen" <jiewen.yao@intel.com>,
 "Nakajima, Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Aug 2019 22:15:15 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> +Alex (direct question at the bottom)
>=20
> On 08/16/19 09:49, Yao, Jiewen wrote:
> > below
> >  =20
> >> -----Original Message-----
> >> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> >> Sent: Friday, August 16, 2019 3:20 PM
> >> To: Yao, Jiewen <jiewen.yao@intel.com>; Laszlo Ersek
> >> <lersek@redhat.com>; devel@edk2.groups.io
> >> Cc: edk2-rfc-groups-io <rfc@edk2.groups.io>; qemu devel list
> >> <qemu-devel@nongnu.org>; Igor Mammedov <imammedo@redhat.com>;
> >> Chen, Yingwen <yingwen.chen@intel.com>; Nakajima, Jun
> >> <jun.nakajima@intel.com>; Boris Ostrovsky <boris.ostrovsky@oracle.com>;
> >> Joao Marcal Lemos Martins <joao.m.martins@oracle.com>; Phillip Goerl
> >> <phillip.goerl@oracle.com>
> >> Subject: Re: [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
> >>
> >> On 16/08/19 04:46, Yao, Jiewen wrote: =20
> >>> Comment below:
> >>>
> >>> =20
> >>>> -----Original Message-----
> >>>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> >>>> Sent: Friday, August 16, 2019 12:21 AM
> >>>> To: Laszlo Ersek <lersek@redhat.com>; devel@edk2.groups.io; Yao, =20
> >> Jiewen =20
> >>>> <jiewen.yao@intel.com>
> >>>> Cc: edk2-rfc-groups-io <rfc@edk2.groups.io>; qemu devel list
> >>>> <qemu-devel@nongnu.org>; Igor Mammedov =20
> >> <imammedo@redhat.com>; =20
> >>>> Chen, Yingwen <yingwen.chen@intel.com>; Nakajima, Jun
> >>>> <jun.nakajima@intel.com>; Boris Ostrovsky =20
> >> <boris.ostrovsky@oracle.com>; =20
> >>>> Joao Marcal Lemos Martins <joao.m.martins@oracle.com>; Phillip Goerl
> >>>> <phillip.goerl@oracle.com>
> >>>> Subject: Re: [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
> >>>>
> >>>> On 15/08/19 17:00, Laszlo Ersek wrote: =20
> >>>>> On 08/14/19 16:04, Paolo Bonzini wrote: =20
> >>>>>> On 14/08/19 15:20, Yao, Jiewen wrote: =20
> >>>>>>>> - Does this part require a new branch somewhere in the OVMF SEC =
=20
> >>>> code? =20
> >>>>>>>>   How do we determine whether the CPU executing SEC is BSP or
> >>>>>>>>   hot-plugged AP? =20
> >>>>>>> [Jiewen] I think this is blocked from hardware perspective, since=
 the =20
> >> first =20
> >>>> instruction. =20
> >>>>>>> There are some hardware specific registers can be used to determi=
ne =20
> >> if =20
> >>>> the CPU is new added. =20
> >>>>>>> I don=E2=80=99t think this must be same as the real hardware.
> >>>>>>> You are free to invent some registers in device model to be used =
in =20
> >>>> OVMF hot plug driver. =20
> >>>>>>
> >>>>>> Yes, this would be a new operation mode for QEMU, that only applie=
s =20
> >> to =20
> >>>>>> hot-plugged CPUs.  In this mode the AP doesn't reply to INIT or SM=
I, =20
> >> in =20
> >>>>>> fact it doesn't reply to anything at all.
> >>>>>> =20
> >>>>>>>> - How do we tell the hot-plugged AP where to start execution? (I=
.e. =20
> >>>> that =20
> >>>>>>>>   it should execute code at a particular pflash location.) =20
> >>>>>>> [Jiewen] Same real mode reset vector at FFFF:FFF0. =20
> >>>>>>
> >>>>>> You do not need a reset vector or INIT/SIPI/SIPI sequence at all in
> >>>>>> QEMU.  The AP does not start execution at all when it is unplugged=
, =20
> >> so =20
> >>>>>> no cache-as-RAM etc.
> >>>>>>
> >>>>>> We only need to modify QEMU so that hot-plugged APIs do not reply =
=20
> >> to =20
> >>>>>> INIT/SIPI/SMI.
> >>>>>> =20
> >>>>>>> I don=E2=80=99t think there is problem for real hardware, who alw=
ays has CAR.
> >>>>>>> Can QEMU provide some CPU specific space, such as MMIO region? =20
> >>>>>>
> >>>>>> Why is a CPU-specific region needed if every other processor is in=
 SMM
> >>>>>> and thus trusted. =20
> >>>>>
> >>>>> I was going through the steps Jiewen and Yingwen recommended.
> >>>>>
> >>>>> In step (02), the new CPU is expected to set up RAM access. In step
> >>>>> (03), the new CPU, executing code from flash, is expected to "send =
=20
> >> board =20
> >>>>> message to tell host CPU (GPIO->SCI) -- I am waiting for hot-add
> >>>>> message." For that action, the new CPU may need a stack (minimally =
if =20
> >> we =20
> >>>>> want to use C function calls).
> >>>>>
> >>>>> Until step (03), there had been no word about any other (=3D pre-pl=
ugged)
> >>>>> CPUs (more precisely, Jiewen even confirmed "No impact to other
> >>>>> processors"), so I didn't assume that other CPUs had entered SMM.
> >>>>>
> >>>>> Paolo, I've attempted to read Jiewen's response, and yours, as care=
fully
> >>>>> as I can. I'm still very confused. If you have a better understandi=
ng,
> >>>>> could you please write up the 15-step process from the thread start=
er
> >>>>> again, with all QEMU customizations applied? Such as, unnecessary =
=20
> >> steps =20
> >>>>> removed, and platform specifics filled in. =20
> >>>>
> >>>> Sure.
> >>>>
> >>>> (01a) QEMU: create new CPU.  The CPU already exists, but it does not
> >>>>      start running code until unparked by the CPU hotplug controller.
> >>>>
> >>>> (01b) QEMU: trigger SCI
> >>>>
> >>>> (02-03) no equivalent
> >>>>
> >>>> (04) Host CPU: (OS) execute GPE handler from DSDT
> >>>>
> >>>> (05) Host CPU: (OS) Port 0xB2 write, all CPUs enter SMM (NOTE: New C=
PU
> >>>>      will not enter CPU because SMI is disabled)
> >>>>
> >>>> (06) Host CPU: (SMM) Save 38000, Update 38000 -- fill simple SMM
> >>>>      rebase code.
> >>>>
> >>>> (07a) Host CPU: (SMM) Write to CPU hotplug controller to enable
> >>>>      new CPU
> >>>>
> >>>> (07b) Host CPU: (SMM) Send INIT/SIPI/SIPI to new CPU. =20
> >>> [Jiewen] NOTE: INIT/SIPI/SIPI can be sent by a malicious CPU. There i=
s no
> >>> restriction that INIT/SIPI/SIPI can only be sent in SMM. =20
> >>
> >> All of the CPUs are now in SMM, and INIT/SIPI/SIPI will be discarded
> >> before 07a, so this is okay. =20
> > [Jiewen] May I know why INIT/SIPI/SIPI is discarded before 07a but is d=
elivered at 07a?
> > I don=E2=80=99t see any extra step between 06 and 07a.
> > What is the magic here? =20
>=20
> The magic is 07a itself, IIUC. The CPU hotplug controller would be
> accessible only in SMM. And until 07a happens, the new CPU ignores
> INIT/SIPI/SIPI even if another CPU sends it those, simply because QEMU
> would implement the new CPU's behavior like that.
>=20
> >=20
> >=20
> >  =20
> >> However I do see a problem, because a PCI device's DMA could overwrite
> >> 0x38000 between (06) and (10) and hijack the code that is executed in
> >> SMM.  How is this avoided on real hardware?  By the time the new CPU
> >> enters SMM, it doesn't run off cache-as-RAM anymore. =20
> > [Jiewen] Interesting question.
> > I don=E2=80=99t think the DMA attack is considered in threat model for =
the virtual environment. We only list adversary below:
> > -- Adversary: System Software Attacker, who can control any OS memory o=
r silicon register from OS level, or read write BIOS data.
> > -- Adversary: Simple hardware attacker, who can hot add or hot remove a=
 CPU. =20
>=20
> We do have physical PCI(e) device assignment; sorry for not highlighting
> that earlier. That feature (VFIO) does rely on the (physical) IOMMU, and
> it makes sure that the assigned device can only access physical frames
> that belong to the virtual machine that the device is assigned to.
>=20
> However, as far as I know, VFIO doesn't try to restrict PCI DMA to
> subsets of guest RAM... I could be wrong about that, I vaguely recall
> RMRR support, which seems somewhat related.
>=20
> > I agree it is a threat from real hardware perspective. SMM may check VT=
d to make sure the 38000 is blocked.
> > I doubt if it is a threat in virtual environment. Do we have a way to b=
lock DMA in virtual environment? =20
>=20
> I think that would be a VFIO feature.
>=20
> Alex: if we wanted to block PCI(e) DMA to a specific part of guest RAM
> (expressed with guest-physical RAM addresses), perhaps permanently,
> perhaps just for a while -- not sure about coordination though --, could
> VFIO accommodate that (I guess by "punching holes" in the IOMMU page
> tables)?

It depends.  For starters, the vfio mapping API does not allow
unmapping arbitrary sub-ranges of previous mappings.  So the hole you
want to punch would need to be independently mapped.  From there you
get into the issue of whether this range is a potential DMA target.  If
it is, then this is the path to data corruption.  We cannot interfere
with the operation of the device and we have little to no visibility of
active DMA targets.

If we're talking about RAM that is never a DMA target, perhaps e820
reserved memory, then we can make sure certainly MemoryRegions are
skipped when mapped by QEMU and would expect the guest to never map
them through a vIOMMU as well.  Maybe then it's a question of where
we're trying to provide security (it might be more difficult if QEMU
needs to sanitize vIOMMU mappings to actively prevent mapping
reserved areas).

Is there anything unique about the VM case here?  Bare metal SMM needs
to be concerned about protecting itself from I/O devices that operate
outside of the realm of SMM mode as well, right?  Is something "simple"
like an AddressSpace switch necessary here, such that an I/O device
always has a mapping to a safe guest RAM page while the vCPU
AddressSpace can switch to some protected page?  The IOMMU and vCPU
mappings don't need to be the same.  The vCPU is more under our control
than the assigned device.

FWIW, RMRRs are a VT-d specific mechanism to define an address range as
persistently, identity mapped for one or more devices.  IOW, the device
would always map that range.  I don't think that's what you're after
here.  RMRRs are also an abomination that I hope we never find a
requirement for in a VM.  Thanks,

Alex

