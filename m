Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2900C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9774620644
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9774620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIJQ-00052l-8O
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1hyIHx-0003iM-FP
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hyIHr-0005vC-4a
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:07:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45826)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hyIHq-0005tm-Sc
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:07:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 69FAE302C07C;
 Thu, 15 Aug 2019 16:07:37 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D8DB600CD;
 Thu, 15 Aug 2019 16:07:35 +0000 (UTC)
Date: Thu, 15 Aug 2019 18:07:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190815180733.4b396b5d@redhat.com>
In-Reply-To: <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 15 Aug 2019 16:07:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] CPU hotplug using SMM with QEMU+OVMF
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
Cc: "Chen,
 Yingwen" <yingwen.chen@intel.com>, edk2-devel-groups-io <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>, "Yao, Jiewen" <jiewen.yao@intel.com>,
 "Nakajima, Jun" <jun.nakajima@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>, Laszlo Ersek <lersek@redhat.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 14 Aug 2019 16:04:50 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 14/08/19 15:20, Yao, Jiewen wrote:
> >> - Does this part require a new branch somewhere in the OVMF SEC code?
> >>   How do we determine whether the CPU executing SEC is BSP or
> >>   hot-plugged AP? =20
> > [Jiewen] I think this is blocked from hardware perspective, since the f=
irst instruction.
> > There are some hardware specific registers can be used to determine if =
the CPU is new added.
> > I don=E2=80=99t think this must be same as the real hardware.
> > You are free to invent some registers in device model to be used in OVM=
F hot plug driver. =20
>=20
> Yes, this would be a new operation mode for QEMU, that only applies to
> hot-plugged CPUs.  In this mode the AP doesn't reply to INIT or SMI, in
> fact it doesn't reply to anything at all.
>=20
> >> - How do we tell the hot-plugged AP where to start execution? (I.e. th=
at
> >>   it should execute code at a particular pflash location.) =20
> > [Jiewen] Same real mode reset vector at FFFF:FFF0. =20
>=20
> You do not need a reset vector or INIT/SIPI/SIPI sequence at all in
> QEMU.  The AP does not start execution at all when it is unplugged, so
> no cache-as-RAM etc.
>=20
> We only need to modify QEMU so that hot-plugged APIs do not reply to
> INIT/SIPI/SMI.
>=20
> > I don=E2=80=99t think there is problem for real hardware, who always ha=
s CAR.
> > Can QEMU provide some CPU specific space, such as MMIO region? =20
>=20
> Why is a CPU-specific region needed if every other processor is in SMM
> and thus trusted.
>=20
> >>   Does CPU hotplug apply only at the socket level? If the CPU is
> >>   multi-core, what is responsible for hot-plugging all cores present in
> >>   the socket? =20
>=20
> I can answer this: the SMM handler would interact with the hotplug
> controller in the same way that ACPI DSDT does normally.  This supports
> multiple hotplugs already.
>=20
> Writes to the hotplug controller from outside SMM would be ignored.
>=20
> >>> (03) New CPU: (Flash) send board message to tell host CPU (GPIO->SCI)
> >>>      -- I am waiting for hot-add message. =20
> >>
> >> Maybe we can simplify this in QEMU by broadcasting an SMI to existent
> >> processors immediately upon plugging the new CPU. =20
>=20
> The QEMU DSDT could be modified (when secure boot is in effect) to OUT
> to 0xB2 when hotplug happens.  It could write a well-known value to
> 0xB2, to be read by an SMI handler in edk2.
>=20
>=20
> >> =20
> >>>                                        (NOTE: Host CPU can only =20
> >> send =20
> >>>      instruction in SMM mode. -- The register is SMM only) =20
> >>
> >> Sorry, I don't follow -- what register are we talking about here, and
> >> why is the BSP needed to send anything at all? What "instruction" do y=
ou
> >> have in mind? =20
> > [Jiewen] The new CPU does not enable SMI at reset.
> > At some point of time later, the CPU need enable SMI, right?
> > The "instruction" here means, the host CPUs need tell to CPU to enable =
SMI. =20
>=20
> Right, this would be a write to the CPU hotplug controller
>=20
> >>> (04) Host CPU: (OS) get message from board that a new CPU is added.
> >>>      (GPIO -> SCI)
> >>>
> >>> (05) Host CPU: (OS) All CPUs enter SMM (SCI->SWSMI) (NOTE: New CPU
> >>>      will not enter CPU because SMI is disabled) =20
> >>
> >> I don't understand the OS involvement here. But, again, perhaps QEMU c=
an
> >> force all existent CPUs into SMM immediately upon adding the new CPU. =
=20
> > [Jiewen] OS here means the Host CPU running code in OS environment, not=
 in SMM environment. =20
>=20
> See above.
>=20
> >>> (06) Host CPU: (SMM) Save 38000, Update 38000 -- fill simple SMM
> >>>      rebase code.
> >>>
> >>> (07) Host CPU: (SMM) Send message to New CPU to Enable SMI. =20
> >>
> >> Aha, so this is the SMM-only register you mention in step (03). Is the
> >> register specified in the Intel SDM? =20
> > [Jiewen] Right. That is the register to let host CPU tell new CPU to en=
able SMI.
> > It is platform specific register. Not defined in SDM.
> > You may invent one in device model. =20
>=20
> See above.
>=20
> >>> (10) New CPU: (SMM) Response first SMI at 38000, and rebase SMBASE to
> >>>      TSEG. =20
> >>
> >> What code does the new CPU execute after it completes step (10)? Does =
it
> >> halt? =20
> >
> > [Jiewen] The new CPU exits SMM and return to original place - where it =
is
> > interrupted to enter SMM - running code on the flash. =20
>=20
> So in our case we'd need an INIT/SIPI/SIPI sequence between (06) and (07).

Looking at Q35 code and Seabios SMM relocation as example, if I see it
right QEMU has:
    - SMRAM is aliased from DRAM at 0xa0000
    - and TSEG steals from the top of low RAM when configured

Now problem is that default SMBASE at 0x30000 isn't backed by anything
in SMRAM address space and default SMI entry falls-through to the same
location in System address space.

The later is not trusted and entry into SMM mode will corrupt area + might
jump to 'random' SMI handler (hence save/restore code in Seabios).

Here is an idea, can we map a memory region at 0x30000 in SMRAM address
space with relocation space/code reserved. It could be a part of TSEG
(so we don't have to invent ABI to configure that)?

In that case we do not have to care about System address space content
anymore and un-trusted code shouldn't be able to supply rogue SMI handler.
(that would cross out one of the reasons for inventing disabled-INIT/SMI st=
ate)


> >>> (11) Host CPU: (SMM) Restore 38000. =20
> >>
> >> These steps (i.e., (06) through (11)) don't appear RAS-specific. The
> >> only platform-specific feature seems to be SMI masking register, which
> >> could be extracted into a new SmmCpuFeaturesLib API.
> >>
> >> Thus, would you please consider open sourcing firmware code for steps
> >> (06) through (11)?
> >>
> >> Alternatively -- and in particular because the stack for step (01)
> >> concerns me --, we could approach this from a high-level, functional
> >> perspective. The states that really matter are the relocated SMBASE for
> >> the new CPU, and the state of the full system, right at the end of step
> >> (11).
> >>
> >> When the SMM setup quiesces during normal firmware boot, OVMF could
> >> use
> >> existent (finalized) SMBASE infomation to *pre-program* some virtual
> >> QEMU hardware, with such state that would be expected, as "final" stat=
e,
> >> of any new hotplugged CPU. Afterwards, if / when the hotplug actually
> >> happens, QEMU could blanket-apply this state to the new CPU, and
> >> broadcast a hardware SMI to all CPUs except the new one. =20
>=20
> I'd rather avoid this and stay as close as possible to real hardware.
>=20
> Paolo


