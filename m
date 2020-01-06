Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FC9C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 00:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516AF206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 00:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eDiaHgoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516AF206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iocMk-0002Ke-Jv
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 19:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iocJk-0007rD-Of
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 19:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iocJi-0005Wl-Vy
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 19:01:52 -0500
Received: from ozlabs.org ([203.11.71.1]:36621)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iocJh-0005Q8-Ux; Mon, 06 Jan 2020 19:01:50 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47sCGf0C4Bz9sR0; Tue,  7 Jan 2020 11:01:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578355306;
 bh=lkrlRZ5SlIUul+FOscb0CcMcr9xArGnyW56ubkLf0m0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eDiaHgoygQR0bzVP8BvHXzRXgDkEY/xo8DMaHGm76d6acdUp/Fo090pPMPlyQdDqZ
 GLxESO2enWxianALR4j+67xWLEjjbzXbNHOq5kPAWH2PnkNakDrPuovSeNRlF0ss0M
 AhKhtO5nSHKV5hMWcxnif4Ft0BwwXyggOnmt+X1Y=
Date: Tue, 7 Jan 2020 10:49:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Drop "num-chips" machine property
Message-ID: <20200106234919.GZ2098@umbus>
References: <157830658266.533764.2214183961444213947.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TXtETX/xrt1zdi6e"
Content-Disposition: inline
In-Reply-To: <157830658266.533764.2214183961444213947.stgit@bahia.lan>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TXtETX/xrt1zdi6e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2020 at 11:29:42AM +0100, Greg Kurz wrote:
> The number of CPU chips of the powernv machine is configurable through a
> "num-chips" property. This doesn't fit well with the CPU topology, eg.
> some configurations can come up with more CPUs than the maximum of CPUs
> set in the toplogy. This causes assertion to be hit with mttcg:
>=20
>    -machine powernv,num-chips=3D2 -smp cores=3D2 -accel tcg,thread=3Dmulti
>=20
> ERROR:
> tcg/tcg.c:789:tcg_register_thread: assertion failed: (n < ms->smp.max_cpu=
s)
> Aborted (core dumped)
>=20
> Mttcg mandates the CPU topology to be dimensioned to the actual number
> of CPUs, depending on the number of chips the user asked for. That is,
> '-machine num-chips=3DN' should always have a '-smp' companion with a
> topology that meats the resulting number of CPUs, typically
> '-smp sockets=3DN'.
>=20
> It thus seems that "num-chips" doesn't bring anything but forcing the user
> to specify the requested number of chips on the command line twice. Simpl=
ify
> the command line by computing the number of chips based on the CPU topolo=
gy
> exclusively. The powernv machine isn't a production thing ; it is mostly
> used by developpers to prepare the bringup of real HW. Because of this and
> for simplicity, this deliberately ignores the official deprecation process
> and dumps "num-chips" right away : '-smp sockets=3DN' is now the only way=
 to
> control the number of CPU chips.
>=20
> This is done at machine init because smp_parse() is called after instance
> init.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.0, thanks.

> ---
>  hw/ppc/pnv.c |   62 +++++++++++-----------------------------------------=
------
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
> +        machine->smp.max_cpus / (machine->smp.cores * machine->smp.threa=
ds);
> +    /*
> +     * TODO: should we decide on how many chips we can create based
> +     * on #cores and Venice vs. Murano vs. Naples chip type etc...,
> +     */
> +    if (!is_power_of_2(pnv->num_chips) || pnv->num_chips > 4) {
> +        error_report("invalid number of chips: '%d'", pnv->num_chips);
> +        error_printf("Try '-smp sockets=3DN'. Valid values are : 1, 2 or=
 4.\n");
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
> -static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
> -                              void *opaque, Error **errp)
> -{
> -    visit_type_uint32(v, name, &PNV_MACHINE(obj)->num_chips, errp);
> -}
> -
> -static void pnv_set_num_chips(Object *obj, Visitor *v, const char *name,
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
> -                              "Specifies the number of processor chips",
> -                              NULL);
> -}
> -
>  static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -1812,8 +1777,6 @@ static void pnv_machine_class_init(ObjectClass *oc,=
 void *data)
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TXtETX/xrt1zdi6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4Tx38ACgkQbDjKyiDZ
s5J4Ug/+Ib+kZS8JCmuZPtM6UDTirq8u93GDj3CXFD7xud2LD7rmIA7apRNq9Jxo
AmM1Z3XSINcoS5dED7JOMvgmICt8BcNGQd7DSBHQW3x73QNgsCF9p0Ap7isggLnR
1HZDfcqp/PfjVLSydOW5ADIItpNx2HtQkMUJUHn2i934FSycc0GawiR8u5Bk5O1k
cbS7RE/jWOLimTzUwofgreza5X6MIl1ls3pxGXlnwIYJo3Z7svNBh7VFxqnwUzhH
ZJYNTcDyp+YWxWA4udxUagL6adbtMLYe1MpBAuWXs/sHN7YX0P0Vr1RXMyV3bMM2
al9T95VXaFdU+kMCgZtsjCj42QJK1dwOqd1V2Er2ETD4M+lX31H2R97K+HSjZI+9
Em3bgRnwOaOaZK2Br91brjJzZhPSjlDZZjct9UE9FitvgP3P1CsCNLiL8s06cjJG
+kmzyChx7PNMw1vdPZqvemfSeb6yY15Hh26GVoNv6d8gL4wnd+zCWa70Lqi+69SV
VqBPY7BZ/wLu6K4BSUDEKsWq8nikykiMcze7Yja6xJ67JBaXhlhZk7A2feyF6MhT
IpqudmgRV0RO9F5tAWbsvyZrL2nbgQfDltgJxLl+AARWwYTiAhtBtFKs7hLMO0ve
0NQmqWXvVDhEjcuz0Nnll7DwBkG20PJnCF90wPfqsB4TpSSv774=
=56io
-----END PGP SIGNATURE-----

--TXtETX/xrt1zdi6e--

