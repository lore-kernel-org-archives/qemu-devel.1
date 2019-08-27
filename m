Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246FFC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0CC214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 16:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0CC214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2eGm-0000kO-55
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 12:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i2eFZ-0000HU-3t
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i2eFX-00021t-OU
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:23:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58423)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1i2eFX-000218-GY
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 12:23:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0BF0118B3D85;
 Tue, 27 Aug 2019 16:23:14 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F21FD5D6B0;
 Tue, 27 Aug 2019 16:23:08 +0000 (UTC)
Date: Tue, 27 Aug 2019 18:23:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Message-ID: <20190827182307.0b5ce17b@redhat.com>
In-Reply-To: <ea0330f1-cb6a-2a45-f8e7-3de19b117e77@redhat.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F761B96@shsmsx102.ccr.corp.intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 27 Aug 2019 16:23:14 +0000 (UTC)
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

On Mon, 26 Aug 2019 17:30:43 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 08/23/19 17:25, Kinney, Michael D wrote:
> > Hi Jiewen,
> >=20
> > If a hot add CPU needs to run any code before the
> > first SMI, I would recommend is only executes code
> > from a write protected FLASH range without a stack
> > and then wait for the first SMI. =20
>=20
> "without a stack" looks very risky to me. Even if we manage to implement
> the guest code initially, we'll be trapped without a stack, should we
> ever need to add more complex stuff there.

Do we need anything complex in relocation handler, though?
=46rom what I'd imagine, minimum handler should
  1: get address of TSEG, possibly read it from chipset
  2: calculate its new SMBASE offset based on its APIC ID
  3: save new SMBASE

> > For this OVMF use case, is any CPU init required
> > before the first SMI? =20
>=20
> I expressed a preference for that too: "I wish we could simply wake the
> new CPU [...] with an SMI".
>=20
> http://mid.mail-archive.com/398b3327-0820-95af-a34d-1a4a1d50cf35@redhat.c=
om
>=20
>=20
> > From Paolo's list of steps are steps (8a) and (8b)=20
> > really required? =20

07b - implies 08b
   8b could be trivial hlt loop and we most likely could skip 08a and signa=
ling host CPU steps
   but we need INIT/SIPI/SIPI sequence to wake up AP so it could handle pen=
ding SMI
   before handling SIPI (so behavior would follow SDM).


> See again my message linked above -- just after the quoted sentence, I
> wrote, "IOW, if we could excise steps 07b, 08a, 08b".
>=20
> But, I obviously defer to Paolo and Igor on that.
>=20
> (I do believe we have a dilemma here. In QEMU, we probably prefer to
> emulate physical hardware as faithfully as possible. However, we do not
> have Cache-As-RAM (nor do we intend to, IIUC). Does that justify other
> divergences from physical hardware too, such as waking just by virtue of
> an SMI?)
So far we should be able to implement it per spec (at least SDM one),
but we would still need to invent chipset hardware
i.e. like adding to Q35 non exiting SMRAM and means to map/unmap it
to non-SMM address space.
(and I hope we could avoid adding "parked CPU" thingy)
=20
> > Can the SMI monarch use the Local
> > APIC to send a directed SMI to the hot added CPU?
> > The SMI monarch needs to know the APIC ID of the
> > hot added CPU.  Do we also need to handle the case
> > where multiple CPUs are added at once?  I think we
> > would need to serialize the use of 3000:8000 for the
> > SMM rebase operation on each hot added CPU. =20
>=20
> I agree this would be a huge help.

We can serialize it (for normal hotplug flow) from ACPI handler
in the guest (i.e. non enforced serialization).
The only reason for serialization I see is not to allow
a bunch of new CPU trample over default SMBASE save area
at the same time.

There is a consideration though, an OS level attacker
could send broadcast SMI and INIT-SIPI-SIPI sequences
to rigger race, but I don't see it as a threat since
attack shouldn't be able to exploit anything and in
worst case guest OS would crash (taking in account that
SMIs are privileged, OS attacker has a plenty of other
means to kill itself).

> > It would be simpler if we can guarantee that only
> > one CPU can be added or removed at a time and the=20
> > complete flow of adding a CPU to SMM and the OS
> > needs to be completed before another add/remove
> > event needs to be processed. =20
>=20
> I don't know if the QEMU monitor command in question can guarantee this
> serialization. I think such a request/response pattern is generally
> implementable between QEMU and guest code.
>=20
> But, AIUI, the "device-add" monitor command is quite generic, and used
> for hot-plugging a number of other (non-CPU) device models. I'm unsure
> if the pattern in question can be squeezed into "device-add". (It's not
> a dedicated command for CPU hotplug.)
>=20
> ... Apologies that I didn't add much information to the thread, just
> now. I'd like to keep the discussion going.
>=20
> Thanks
> Laszlo


