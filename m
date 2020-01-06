Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C0FC32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 11:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2974E2072C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 11:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2974E2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioQAO-0000Xm-9u
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 06:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ioQ89-0006o5-1N
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 06:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ioQ87-00026o-HA
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 06:01:04 -0500
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:56065)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ioQ87-00025b-BX
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 06:01:03 -0500
Received: from player799.ha.ovh.net (unknown [10.108.16.103])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id E14C021B69D
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 12:00:59 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id 4B9C9DE7ACDC;
 Mon,  6 Jan 2020 11:00:55 +0000 (UTC)
Subject: Re: [PATCH] ppc/pnv: Drop "num-chips" machine property
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157830658266.533764.2214183961444213947.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bc90a2a2-c3c2-d61e-f455-6e599b2df985@kaod.org>
Date: Mon, 6 Jan 2020 12:00:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157830658266.533764.2214183961444213947.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1399212111533345619
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.33.109
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/6/20 11:29 AM, Greg Kurz wrote:
> The number of CPU chips of the powernv machine is configurable through =
a
> "num-chips" property. This doesn't fit well with the CPU topology, eg.
> some configurations can come up with more CPUs than the maximum of CPUs
> set in the toplogy. This causes assertion to be hit with mttcg:
>=20
>    -machine powernv,num-chips=3D2 -smp cores=3D2 -accel tcg,thread=3Dmu=
lti
>=20
> ERROR:
> tcg/tcg.c:789:tcg_register_thread: assertion failed: (n < ms->smp.max_c=
pus)
> Aborted (core dumped)
>=20
> Mttcg mandates the CPU topology to be dimensioned to the actual number
> of CPUs, depending on the number of chips the user asked for. That is,
> '-machine num-chips=3DN' should always have a '-smp' companion with a
> topology that meats the resulting number of CPUs, typically
> '-smp sockets=3DN'.
>=20
> It thus seems that "num-chips" doesn't bring anything but forcing the u=
ser
> to specify the requested number of chips on the command line twice. Sim=
plify
> the command line by computing the number of chips based on the CPU topo=
logy
> exclusively. The powernv machine isn't a production thing ; it is mostl=
y
> used by developpers to prepare the bringup of real HW. Because of this =
and
> for simplicity, this deliberately ignores the official deprecation proc=
ess
> and dumps "num-chips" right away : '-smp sockets=3DN' is now the only w=
ay to
> control the number of CPU chips.
>=20
> This is done at machine init because smp_parse() is called after instan=
ce
> init.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/pnv.c |   62 +++++++++++---------------------------------------=
--------
>  1 file changed, 12 insertions(+), 50 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index f77e7ca84ede..b225ffbb2c41 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -768,6 +768,18 @@ static void pnv_init(MachineState *machine)
>          exit(1);
>      }
> =20
> +    pnv->num_chips =3D
> +        machine->smp.max_cpus / (machine->smp.cores * machine->smp.thr=
eads);
> +    /*
> +     * TODO: should we decide on how many chips we can create based
> +     * on #cores and Venice vs. Murano vs. Naples chip type etc...,
> +     */
> +    if (!is_power_of_2(pnv->num_chips) || pnv->num_chips > 4) {
> +        error_report("invalid number of chips: '%d'", pnv->num_chips);
> +        error_printf("Try '-smp sockets=3DN'. Valid values are : 1, 2 =
or 4.\n");
> +        exit(1);
> +    }
> +
>      pnv->chips =3D g_new0(PnvChip *, pnv->num_chips);
>      for (i =3D 0; i < pnv->num_chips; i++) {
>          char chip_name[32];
> @@ -1696,53 +1708,6 @@ PnvChip *pnv_get_chip(uint32_t chip_id)
>      return NULL;
>  }
> =20
> -static void pnv_get_num_chips(Object *obj, Visitor *v, const char *nam=
e,
> -                              void *opaque, Error **errp)
> -{
> -    visit_type_uint32(v, name, &PNV_MACHINE(obj)->num_chips, errp);
> -}
> -
> -static void pnv_set_num_chips(Object *obj, Visitor *v, const char *nam=
e,
> -                              void *opaque, Error **errp)
> -{
> -    PnvMachineState *pnv =3D PNV_MACHINE(obj);
> -    uint32_t num_chips;
> -    Error *local_err =3D NULL;
> -
> -    visit_type_uint32(v, name, &num_chips, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    /*
> -     * TODO: should we decide on how many chips we can create based
> -     * on #cores and Venice vs. Murano vs. Naples chip type etc...,
> -     */
> -    if (!is_power_of_2(num_chips) || num_chips > 4) {
> -        error_setg(errp, "invalid number of chips: '%d'", num_chips);
> -        return;
> -    }
> -
> -    pnv->num_chips =3D num_chips;
> -}
> -
> -static void pnv_machine_instance_init(Object *obj)
> -{
> -    PnvMachineState *pnv =3D PNV_MACHINE(obj);
> -    pnv->num_chips =3D 1;
> -}
> -
> -static void pnv_machine_class_props_init(ObjectClass *oc)
> -{
> -    object_class_property_add(oc, "num-chips", "uint32",
> -                              pnv_get_num_chips, pnv_set_num_chips,
> -                              NULL, NULL, NULL);
> -    object_class_property_set_description(oc, "num-chips",
> -                              "Specifies the number of processor chips=
",
> -                              NULL);
> -}
> -
>  static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -1812,8 +1777,6 @@ static void pnv_machine_class_init(ObjectClass *o=
c, void *data)
>       */
>      mc->default_ram_size =3D INITRD_LOAD_ADDR + INITRD_MAX_SIZE;
>      ispc->print_info =3D pnv_pic_print_info;
> -
> -    pnv_machine_class_props_init(oc);
>  }
> =20
>  #define DEFINE_PNV8_CHIP_TYPE(type, class_initfn) \
> @@ -1866,7 +1829,6 @@ static const TypeInfo types[] =3D {
>          .parent        =3D TYPE_MACHINE,
>          .abstract       =3D true,
>          .instance_size =3D sizeof(PnvMachineState),
> -        .instance_init =3D pnv_machine_instance_init,
>          .class_init    =3D pnv_machine_class_init,
>          .class_size    =3D sizeof(PnvMachineClass),
>          .interfaces =3D (InterfaceInfo[]) {
>=20


