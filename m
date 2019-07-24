Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AE7C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A4121951
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A4121951
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqBRn-00036f-0F
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 03:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38863)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hqBRb-0002cU-NY
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hqBRa-00043m-Fr
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:12:11 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:35971)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hqBRa-0003p6-9t
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:12:10 -0400
Received: from player796.ha.ovh.net (unknown [10.108.42.215])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id E21D713C893
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 09:12:00 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player796.ha.ovh.net (Postfix) with ESMTPSA id C7BA78260749;
 Wed, 24 Jul 2019 07:11:54 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190723090138.30623-1-clg@kaod.org>
 <20190724032308.GV25073@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0b80925b-c25b-04ee-2875-cbd155497a55@kaod.org>
Date: Wed, 24 Jul 2019 09:11:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724032308.GV25073@umbus.fritz.box>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
X-Ovh-Tracer-Id: 342273573186341843
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -77
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrjeelgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlvdefmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.75.26
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Generate phandle for the
 "interrupt-parent" property
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
Cc: Joel Stanley <joel@jms.id.au>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/07/2019 05:23, David Gibson wrote:
> On Tue, Jul 23, 2019 at 11:01:38AM +0200, C=C3=A9dric Le Goater wrote:
>> Devices such as the BT or serial devices require a valid
>> "interrupt-parent" phandle in the device tree and it is currently
>> empty (0x0). It was not a problem until now but since OpenFirmare
>> started using a recent libdft (>=3D 1.4.7), petitboot fails to boot th=
e
>> system image with error :
>>
>>    dtc_resize: fdt_open_into returned FDT_ERR_BADMAGIC
>>
>> Provide a phandle for the LPC bus.
>>
>> Suggested-by: Greg Kurz <groug@kaod.org>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> I've applied this, since it looks to be correct.
>=20
> But.. can you connect the dots for me in how this being missing
> results in a BADMAGIC error??

Some binary called by petitboot segfaults when trying to kexec an image o=
n=20
a system with a bogus DT (generated by QEMU). I don't know exactly which =
one=20
as I only see the error message above and the segv message in dmesg

I didn't notice before because I was using an old open-power-v2.1 image. =
I have
switched to more recent ones now :

  https://openpower.xyz/job/openpower/job/openpower-op-build/label=3Dslav=
e,target=3Dwitherspoon/lastSuccessfulBuild/
  https://openpower.xyz/job/openpower/job/openpower-op-build/label=3Dslav=
e,target=3Dpalmetto/lastSuccessfulBuild/

Btw, where could we keep some images of reference ? I have a couple of pa=
tches=20
which enables the QEMU PowerNV machine to boot directly from the PNOR usi=
ng :
=20
  -drive file=3D./witherspoon.pnor,format=3Draw,if=3Dmtd

Thanks,

C.=20

>=20
>> ---
>>  hw/ppc/pnv.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 36f57479a1f5..2deceecdccb5 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -431,9 +431,14 @@ static void pnv_dt_isa(PnvMachineState *pnv, void=
 *fdt)
>>          .fdt =3D fdt,
>>          .offset =3D isa_offset,
>>      };
>> +    uint32_t phandle;
>> =20
>>      _FDT((fdt_setprop(fdt, isa_offset, "primary", NULL, 0)));
>> =20
>> +    phandle =3D qemu_fdt_alloc_phandle(fdt);
>> +    assert(phandle > 0);
>> +    _FDT((fdt_setprop_cell(fdt, isa_offset, "phandle", phandle)));
>> +
>>      /* ISA devices are not necessarily parented to the ISA bus so we
>>       * can not use object_child_foreach() */
>>      qbus_walk_children(BUS(pnv->isa_bus), pnv_dt_isa_device, NULL, NU=
LL, NULL,
>=20


