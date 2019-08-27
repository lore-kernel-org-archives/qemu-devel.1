Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F61FC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 18:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB18220828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 18:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB18220828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2gRU-00045h-42
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 14:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i2gFO-0001Bh-VI
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i2gFM-0004E3-7x
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:31:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47662)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1i2gFL-0004CD-TS
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:31:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B2942308FC4E;
 Tue, 27 Aug 2019 18:31:09 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E1285DD6F;
 Tue, 27 Aug 2019 18:31:03 +0000 (UTC)
Date: Tue, 27 Aug 2019 20:31:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Yao, Jiewen" <jiewen.yao@intel.com>
Message-ID: <20190827203102.56d0d048@redhat.com>
In-Reply-To: <74D8A39837DF1E4DA445A8C0B3885C503F7728AB@shsmsx102.ccr.corp.intel.com>
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
 <74D8A39837DF1E4DA445A8C0B3885C503F7728AB@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 27 Aug 2019 18:31:09 +0000 (UTC)
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
 Alex Williamson <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, "Kinney,
 Michael D" <michael.d.kinney@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "rfc@edk2.groups.io" <rfc@edk2.groups.io>, Laszlo Ersek <lersek@redhat.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 24 Aug 2019 01:48:09 +0000
"Yao, Jiewen" <jiewen.yao@intel.com> wrote:

> I give my thought.
> Paolo may add more.
Here are some ideas I have on the topic.

>=20
> > -----Original Message-----
> > From: Kinney, Michael D
> > Sent: Friday, August 23, 2019 11:25 PM
> > To: Yao, Jiewen <jiewen.yao@intel.com>; Paolo Bonzini
> > <pbonzini@redhat.com>; Laszlo Ersek <lersek@redhat.com>;
> > rfc@edk2.groups.io; Kinney, Michael D <michael.d.kinney@intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>; devel@edk2.groups.io;
> > qemu devel list <qemu-devel@nongnu.org>; Igor Mammedov
> > <imammedo@redhat.com>; Chen, Yingwen <yingwen.chen@intel.com>;
> > Nakajima, Jun <jun.nakajima@intel.com>; Boris Ostrovsky
> > <boris.ostrovsky@oracle.com>; Joao Marcal Lemos Martins
> > <joao.m.martins@oracle.com>; Phillip Goerl <phillip.goerl@oracle.com>
> > Subject: RE: [edk2-rfc] [edk2-devel] CPU hotplug using SMM with
> > QEMU+OVMF
> >=20
> > Hi Jiewen,
> >=20
> > If a hot add CPU needs to run any code before the
> > first SMI, I would recommend is only executes code
> > from a write protected FLASH range without a stack
> > and then wait for the first SMI. =20
> [Jiewen] Right.
>=20
> Another option from Paolo, the new CPU will not run until 0x7b.
> To mitigate DMA threat, someone need guarantee the low memory SIPI vector=
 is DMA protected.
>=20
> NOTE: The LOW memory *could* be mapped to write protected FLASH AREA via =
PAM register. The Host CPU may setup that in SMM.
> If that is the case, we don=E2=80=99t need worry DMA.
>=20
> I copied the detail step here, because I found it is hard to dig them out=
 again.

*) In light of using dedicated SMRAM at 30000 with pre-configured
relocation vector for initial relocation which is not reachable from
non-SMM mode:

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (01a) QEMU: create new CPU.  The CPU already exists, but it does not
>      start running code until unparked by the CPU hotplug controller.
we might not need parked CPU (if we ignore attacker's attempt to send
SMI to several new CPUs, see below for issue it causes)

> (01b) QEMU: trigger SCI
>=20
> (02-03) no equivalent
>=20
> (04) Host CPU: (OS) execute GPE handler from DSDT
>=20
> (05) Host CPU: (OS) Port 0xB2 write, all CPUs enter SMM (NOTE: New CPU
>      will not enter CPU because SMI is disabled)
I think only CPU that does the write will enter SMM
and we might not need to pull in all already initialized CPUs into SMM.

At this step we could also send a directed SMI to a new CPU from host
CPU that entered SMM on write.

> (06) Host CPU: (SMM) Save 38000, Update 38000 -- fill simple SMM
>      rebase code.
could skip this step as well (*)


> (07a) Host CPU: (SMM) Write to CPU hotplug controller to enable
>      new CPU
ditto
=20
> (07b) Host CPU: (SMM) Send INIT/SIPI/SIPI to new CPU.
we need to wake up new CPU somehow so it would process (09) pending (05) SMI
before jumping to SIPI vector

> (08a) New CPU: (Low RAM) Enter protected mode.
>=20
> (08b) New CPU: (Flash) Signals host CPU to proceed and enter cli;hlt loop.

these both steps could be changed to to just cli;hlt loop or do INIT reset.
if SMI relocation handler and/or host CPU will pull in the new CPU into OVM=
F,
we actually don't care about SIPI vector as all firmware initialization
for the new CPU is done in SMM mode (07b triggers 10).
Thus eliminating one attack vector to protect from.

> (09) Host CPU: (SMM) Send SMI to the new CPU only.
could be done at (05)
=20
> (10) New CPU: (SMM) Run SMM code at 38000, and rebase SMBASE to
>      TSEG.
it could also pull in itself into other OVMF structures
(assuming it can TSEG as stack as that's rather complex) or
just do relocation and let host CPU to fill in OVMF structures for the new =
CPU (12).

> (11) Host CPU: (SMM) Restore 38000.
could skip this step as well (*)

> (12) Host CPU: (SMM) Update located data structure to add the new CPU
>      information. (This step will involve CPU_SERVICE protocol)
>=20
> (13) New CPU: (Flash) do whatever other initialization is needed
do we actually need it?

> (14) New CPU: (Flash) Deadloop, and wait for INIT-SIPI-SIPI.
>=20
> (15) Host CPU: (OS) Send INIT-SIPI-SIPI to pull new CPU in..
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> >=20
> > For this OVMF use case, is any CPU init required
> > before the first SMI? =20
> [Jiewen] I am sure what is the detail action in 08b.
> And I am not sure what your "init" means here?
> Personally, I don=E2=80=99t think we need too much init work, such as Mic=
rocode or MTRR.
> But we need detail info.
Wouldn't it be preferable to do in SMM mode?

> > From Paolo's list of steps are steps (8a) and (8b)
> > really required?  Can the SMI monarch use the Local
> > APIC to send a directed SMI to the hot added CPU?
> > The SMI monarch needs to know the APIC ID of the
> > hot added CPU.   =20
> [Jiewen] I think it depend upon virtual hardware design.
> Leave question to Paolo.

it's not really needed as described in (8x), it could be just
cli;hlt loop so that our SIPI could land at sensible code and stop the new =
CPU,
it even could be an attacker's code if we do all initialization in SMM mode.

> Do we also need to handle the case
> > where multiple CPUs are added at once?  I think we
> > would need to serialize the use of 3000:8000 for the
> > SMM rebase operation on each hot added CPU.
> > It would be simpler if we can guarantee that only
> > one CPU can be added or removed at a time and the
> > complete flow of adding a CPU to SMM and the OS
> > needs to be completed before another add/remove
> > event needs to be processed. =20
> [Jiewen] Right.
> I treat the multiple CPU hot-add at same time as a potential threat.

the problem I see here is the race of saving/restoring to/from SMBASE at 30=
000,
so a CPU exiting SMM can't be sure if it restores its own saved area
or it's another CPU saved state. (I couldn't find in SDM what would
happen in this case)

If we consider non-attack flow, then we can serialize sending SMIs
to new CPUs (one at a time) from GPE handler and ensure that
only one CPU can do relocation at a time (i.e. non enforced serialization).

In attack case, attacker would only be able to trigger above race.

> We don=E2=80=99t want to trust end user.
> The solution could be:
> 1) Let trusted hardware guarantee hot-add one by one.
so far in QEMU it's not possible. We might be able to implement
"parking/unparking" chipset feature, but that would mean inventing
and maintaining ABI for it, which I'd like to avoid if possible.

That's why I'm curious about what happens if CPU exits SMM mode with
another CPU saved registers state in case of the race and if we could
ignore consequences of it. (it's fine for guest OS to crash or new CPU
do not work, attacker would only affect itself)

> 2) Let trusted software (SMM and init code) guarantee SMREBASE one by one=
 (include any code runs before SMREBASE)
that would mean pulling all present CPUs into SMM mode so no attack
code could be executing before doing hotplug. With a lot of present CPUs
it could be quite expensive and unlike physical hardware, guest's CPUs
could be preempted arbitrarily long causing long delays.

> 3) Let trusted software (SMM and init code) support SMREBASE simultaneous=
ly (include any code runs before SMREBASE).
Is it really possible to do in software?
Potentially it could be done in hardware (QEMU/KVM) if each CPU will have i=
ts
own SMRAM at 30000, so parallely relocated CPUs won't trample over each oth=
er.

But KVM has only 2 address spaces (normal RAM and SMM) so it won't just
work of the box (and I recall that Paolo had some reservation versus adding=
 more).
Also it would mean adding ABI for initializing that SMRAM blocks from
another CPU which could be complicated.

> Solution #1 or #2 are simple solution.
lets first see if if we can ignore race and if it's not then
we probably end up with implementing some form of #1


>=20
> > Mike
> >  =20
> > > -----Original Message-----
> > > From: Yao, Jiewen
> > > Sent: Thursday, August 22, 2019 10:00 PM
> > > To: Kinney, Michael D <michael.d.kinney@intel.com>;
> > > Paolo Bonzini <pbonzini@redhat.com>; Laszlo Ersek
> > > <lersek@redhat.com>; rfc@edk2.groups.io
> > > Cc: Alex Williamson <alex.williamson@redhat.com>;
> > > devel@edk2.groups.io; qemu devel list <qemu- =20
> > > devel@nongnu.org>; Igor Mammedov <imammedo@redhat.com>; =20
> > > Chen, Yingwen <yingwen.chen@intel.com>; Nakajima, Jun
> > > <jun.nakajima@intel.com>; Boris Ostrovsky
> > > <boris.ostrovsky@oracle.com>; Joao Marcal Lemos Martins
> > > <joao.m.martins@oracle.com>; Phillip Goerl
> > > <phillip.goerl@oracle.com>
> > > Subject: RE: [edk2-rfc] [edk2-devel] CPU hotplug using
> > > SMM with QEMU+OVMF
> > >
> > > Thank you Mike!
> > >
> > > That is good reference on the real hardware behavior.
> > > (Glad it is public.)
> > >
> > > For threat model, the unique part in virtual environment
> > > is temp RAM.
> > > The temp RAM in real platform is per CPU cache, while
> > > the temp RAM in virtual platform is global memory.
> > > That brings one more potential attack surface in virtual
> > > environment, if hot-added CPU need run code with stack
> > > or heap before SMI rebase.
> > >
> > > Other threats, such as SMRAM or DMA, are same.
> > >
> > > Thank you
> > > Yao Jiewen
> > >
> > > =20
> > > > -----Original Message-----
> > > > From: Kinney, Michael D
> > > > Sent: Friday, August 23, 2019 9:03 AM
> > > > To: Paolo Bonzini <pbonzini@redhat.com>; Laszlo Ersek
> > > > <lersek@redhat.com>; rfc@edk2.groups.io; Yao, Jiewen
> > > > <jiewen.yao@intel.com>; Kinney, Michael D =20
> > > <michael.d.kinney@intel.com> =20
> > > > Cc: Alex Williamson <alex.williamson@redhat.com>;
> > > > devel@edk2.groups.io; qemu devel list <qemu-
> > > devel@nongnu.org>; Igor
> > > > Mammedov <imammedo@redhat.com>; Chen, Yingwen
> > > > <yingwen.chen@intel.com>; Nakajima, Jun =20
> > > <jun.nakajima@intel.com>; =20
> > > > Boris Ostrovsky <boris.ostrovsky@oracle.com>; Joao =20
> > > Marcal Lemos =20
> > > > Martins <joao.m.martins@oracle.com>; Phillip Goerl
> > > > <phillip.goerl@oracle.com>
> > > > Subject: RE: [edk2-rfc] [edk2-devel] CPU hotplug using =20
> > > SMM with =20
> > > > QEMU+OVMF
> > > >
> > > > Paolo,
> > > >
> > > > I find the following links related to the discussions =20
> > > here along with =20
> > > > one example feature called GENPROTRANGE.
> > > >
> > > > https://csrc.nist.gov/CSRC/media/Presentations/The- =20
> > > Whole-is-Greater/im =20
> > > > a ges-media/day1_trusted-computing_200-250.pdf
> > > > https://cansecwest.com/slides/2017/CSW2017_Cuauhtemoc- =20
> > > Rene_CPU_Ho =20
> > > > t-Add_flow.pdf
> > > > https://www.mouser.com/ds/2/612/5520-5500-chipset-ioh- =20
> > > datasheet-1131 =20
> > > > 292.pdf
> > > >
> > > > Best regards,
> > > >
> > > > Mike
> > > > =20
> > > > > -----Original Message-----
> > > > > From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> > > > > Sent: Thursday, August 22, 2019 4:12 PM
> > > > > To: Kinney, Michael D <michael.d.kinney@intel.com>; =20
> > > Laszlo Ersek =20
> > > > > <lersek@redhat.com>; rfc@edk2.groups.io; Yao, Jiewen
> > > > > <jiewen.yao@intel.com>
> > > > > Cc: Alex Williamson <alex.williamson@redhat.com>;
> > > > > devel@edk2.groups.io; qemu devel list <qemu- =20
> > > devel@nongnu.org>; Igor =20
> > > > > Mammedov <imammedo@redhat.com>; Chen, Yingwen
> > > > > <yingwen.chen@intel.com>; Nakajima, Jun =20
> > > <jun.nakajima@intel.com>; =20
> > > > > Boris Ostrovsky <boris.ostrovsky@oracle.com>; Joao =20
> > > Marcal Lemos =20
> > > > > Martins <joao.m.martins@oracle.com>; Phillip Goerl
> > > > > <phillip.goerl@oracle.com>
> > > > > Subject: Re: [edk2-rfc] [edk2-devel] CPU hotplug =20
> > > using SMM with =20
> > > > > QEMU+OVMF
> > > > >
> > > > > On 23/08/19 00:32, Kinney, Michael D wrote: =20
> > > > > > Paolo,
> > > > > >
> > > > > > It is my understanding that real HW hot plug uses =20
> > > the =20
> > > > > SDM defined =20
> > > > > > methods.  Meaning the initial SMI is to 3000:8000 =20
> > > and =20
> > > > > they rebase to =20
> > > > > > TSEG in the first SMI.  They must have chipset =20
> > > specific =20
> > > > > methods to =20
> > > > > > protect 3000:8000 from DMA. =20
> > > > >
> > > > > It would be great if you could check.
> > > > > =20
> > > > > > Can we add a chipset feature to prevent DMA to =20
> > > 64KB =20
> > > > > range from =20
> > > > > > 0x30000-0x3FFFF and the UEFI Memory Map and ACPI =20
> > > > > content can be =20
> > > > > > updated so the Guest OS knows to not use that =20
> > > range for =20
> > > > > DMA?
> > > > >
> > > > > If real hardware does it at the chipset level, we =20
> > > will probably use =20
> > > > > Igor's suggestion of aliasing A-seg to 3000:0000. =20
> > > Before starting =20
> > > > > the new CPU, the SMI handler can prepare the SMBASE =20
> > > relocation =20
> > > > > trampoline at
> > > > > A000:8000 and the hot-plugged CPU will find it at
> > > > > 3000:8000 when it receives the initial SMI.  Because =20
> > > this is backed =20
> > > > > by RAM at 0xA0000-0xAFFFF, DMA cannot access it and =20
> > > would still go =20
> > > > > through to RAM at 0x30000.
> > > > >
> > > > > Paolo =20


