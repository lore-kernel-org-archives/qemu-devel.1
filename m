Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC299C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F0F20716
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="od8xxc3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F0F20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiTE0-0007Yh-Em
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 20:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iiTAT-0002da-8y
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iiTAR-00075r-F8
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:52 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:38911 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iiTAQ-0006n2-Bi; Fri, 20 Dec 2019 20:02:51 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47fnQs6BnDz9sPV; Sat, 21 Dec 2019 12:02:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576890165;
 bh=4vJT99mEOi9sWe7DZk243QBSzR3FSdxB9FjQhdw++1k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=od8xxc3ektkIYK4ZDKRda/TsVOisz42wO5B83iOmsgkxPPvJzTCBXiRqn0wF0ZsnM
 R0Jf6HDvDbU/wrOM6exrWG0PhSlYSLC2UN7futNwlMFXv1PLyHz5HUaZkFX0Fg3J59
 00XqBCM2Lm7WE/x3QsAX6VYYPKU7oVYrGvkLSX/s=
Date: Sat, 21 Dec 2019 11:39:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/2] ppc/pnv: Use the CPU topology to compute the default
 number of chips
Message-ID: <20191221003906.GC15511@umbus.fritz.box>
References: <157686069624.97184.12603452056634667288.stgit@bahia.lan>
 <157686070815.97184.16561911770080665569.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
In-Reply-To: <157686070815.97184.16561911770080665569.stgit@bahia.lan>
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


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2019 at 05:51:48PM +0100, Greg Kurz wrote:
> Multi TCG mandates the CPU topology to be dimensioned to the actual
> number of CPUs, depending on the number of chips the user asked for.
> That is, '-machine num-chips=3DN' should always have a '-smp' companion
> with a topology that meats the resulting number of CPUs, typically
> '-smp sockets=3DN'.
>=20
> Simplify the command line for these setups by computing the default
> number of chips based on the CPU topology, ie. no need to explicitely
> set "num-chips" anymore. This must be done at machine init because
> smp_parse() is called after instance init.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Is there actually any reason to retain num-chips at all?  Or could we
just set the number of chips equal to the number of sockets, which
seems to make sense to me.

> ---
>  hw/ppc/pnv.c |   23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index f8cf2b6d760f..9b777b7084a0 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -768,6 +768,19 @@ static void pnv_init(MachineState *machine)
>          exit(1);
>      }
> =20
> +    if (!pnv->num_chips) {
> +        uint32_t num_chips =3D
> +            machine->smp.max_cpus / (machine->smp.cores * machine->smp.t=
hreads);
> +        Error *local_err =3D NULL;
> +
> +        object_property_set_uint(OBJECT(pnv), num_chips, "num-chips",
> +                                 &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            exit(1);
> +        }
> +    }
> +
>      pnv->chips =3D g_new0(PnvChip *, pnv->num_chips);
>      for (i =3D 0; i < pnv->num_chips; i++) {
>          char chip_name[32];
> @@ -1722,6 +1735,9 @@ static void pnv_set_num_chips(Object *obj, Visitor =
*v, const char *name,
>       */
>      if (!is_power_of_2(num_chips) || num_chips > 4) {
>          error_setg(errp, "invalid number of chips: '%d'", num_chips);
> +        error_append_hint(errp,
> +                          "Set 'num-chips' implicitely with '-smp socket=
s=3DN'. "
> +                          "Valid values are : 1, 2 or 4.\n");
>          return;
>      }
> =20
> @@ -1735,12 +1751,6 @@ static void pnv_set_num_chips(Object *obj, Visitor=
 *v, const char *name,
>      pnv->num_chips =3D num_chips;
>  }
> =20
> -static void pnv_machine_instance_init(Object *obj)
> -{
> -    PnvMachineState *pnv =3D PNV_MACHINE(obj);
> -    pnv->num_chips =3D 1;
> -}
> -
>  static void pnv_machine_class_props_init(ObjectClass *oc)
>  {
>      object_class_property_add(oc, "num-chips", "uint32",
> @@ -1874,7 +1884,6 @@ static const TypeInfo types[] =3D {
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

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl39aaoACgkQbDjKyiDZ
s5IpKw/+MGOOE5pcsuiV1CSGr6Cx4FFtFJ/R5L7UX6xj+Z+ZJqvJwdoELCuEkpdL
qbjD5cMBDCulYZtNKZN1BYzyb6x+Qwi8hmLhv8hCxWN1LQe6UdyC24CTbk+uuTDR
XTa95kFSbaZ1rczpmADBWJxfHdHfJeCyJevZKw94kI8Ir04aO6IHKivlKQvy93HE
RLOJefs1HOaw1kTimz5VRJ1PuBnmu9ZjFuHIUw9zdzPga4ITC6kZCExObWSCYfWG
w+s3TKUSwS3qK0WzJppeW2JvOJYD4kIrzWeKGmhuEbpmBQWzGUdVJwepNtr4dE7y
GVWYtc5pDy6cNoG7MtULJCWaNNbs/93xl5R6DCNCCDE2/cUOpclaITq3t35OSgZ+
Etd1wbirzFJavhbZaNFuFwK2ybqWYRP89hXuC/7d5l14tvdFc3LqPo5IwY0nfwlz
eX4peW1arLN+rc+vBDfDmrF+ZB0Z6KGyJUu5ibG9keJL5onw6VeIG0L8AnEbGXYs
DuTJdvKVlO4wyVzQneTlM8H1KVgMAP8kBMEbPXDLu8ji5KkR2sp/imp08F97YWNX
TQzwzzRnsALKhTdwqNNhHQGs8Mw9zxqYmvXm72qjcf4mQGPf25Z2dGLv573Ete4I
pF9KA9PJAtNBzDBNNW5FDhz4xwiFUpSKvY3RhwtQEV24/fZqO14=
=rqJK
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--

