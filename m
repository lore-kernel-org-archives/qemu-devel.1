Received: from eggs.gnu.org ([2001:4830:134:3::10]:52660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUMWe-0003cw-GX
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 21:02:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUMWc-0004mu-TH
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 21:02:56 -0500
Date: Wed, 5 Dec 2018 12:41:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181205014134.GC28910@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-11-clg@kaod.org>
	<20181128005255.GT2251@umbus.fritz.box>
	<64aef78f-e374-9c6d-1a1f-892c4e3b0677@kaod.org>
	<42cb5e91-0006-3b63-5240-5f09b275c04a@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <42cb5e91-0006-3b63-5240-5f09b275c04a@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 10/36] spapr/xive: introduce a XIVE
 interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 06:12:11PM +0100, C=E9dric Le Goater wrote:
> [ ... ]
>=20
> >>> +void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon)
> >>> +{
> >>> +    int i;
> >>> +    uint32_t offset =3D 0;
> >>> +
> >>> +    monitor_printf(mon, "XIVE Source %08x .. %08x\n", offset,
> >>> +                   offset + xive->source.nr_irqs - 1);
> >>> +    xive_source_pic_print_info(&xive->source, offset, mon);
> >>> +
> >>> +    monitor_printf(mon, "XIVE EAT %08x .. %08x\n", 0, xive->nr_irqs =
- 1);
> >>> +    for (i =3D 0; i < xive->nr_irqs; i++) {
> >>> +        xive_eas_pic_print_info(&xive->eat[i], i, mon);
> >>> +    }
> >>> +
> >>> +    monitor_printf(mon, "XIVE ENDT %08x .. %08x\n", 0, xive->nr_ends=
 - 1);
> >>> +    for (i =3D 0; i < xive->nr_ends; i++) {
> >>> +        xive_end_pic_print_info(&xive->endt[i], i, mon);
> >>> +    }
> >>
> >> AIUI the PAPR model hides the details of ENDs, EQs and NVTs - instead
> >> each logical EAS just points at a (thread, priority) pair, which under
> >> the hood has exactly one END and one NVT bound to it.
> >>
> >> Given that, would it make more sense to reformat the info here to show
> >> things in terms of those (thread, priority) pairs, rather than the
> >> internal EAS and END details?
> >=20
> > Yes. I had a version doing something like that before. I will rework
> > the ouput a little for sPAPR. =20
>=20
> I would like to keep the 'advanced' monitor output in some ways and have
> two possible outputs : simple and long.
>=20
> Is it possible to add command line options or arguments to the Monitor=20
> interface ?

Not to the "info pic" command specifically, no.  Or at least, not
without a lot of work.

>=20
> Thanks,
>=20
> C.=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwHLM4ACgkQbDjKyiDZ
s5JYBhAAqxbKwK440rSjwQGYNhMYOLtLTRYeUaXF1MD5GIHRF0wPVPGoAgfLu8ql
HxWmL12KzzR76cm07ePXZMonowo7QpsFBGU6UFHcpZI6n4XhS9r1DBuA1Dl4eJQQ
qruaVXUygQMe6d2QseeYXBZ2aZuDsadpTIHMQbUhukEwJMWzNlK4uC+ChwQz6IJp
Gt7QVpKI3sR+a/05irEUMXG7sbxptK2x+pH2nzSturoPMwwl9W+mJDVux53Okbjx
+k/aqeO9YWDD4ccXeo9hg3DKPhKSriXUCwaINw+ihjubkbMYYessmyr9gAre4Sup
JHvlWwTZGaGJATXZXWXZtPbT61vKSEh8SdQmUU+2T2O1p9rQeu35DJ9wDgpqQCSZ
T8tZHbcYlr+HI2QpqpOlcaP9d0yZOnPMsE1Lkayf5ItaW/F7ic4LnCtuiKRUSo7V
a5ctcL7/SctMaZS+ZPOuBOttrYD1N8HAkrJrRkS+iG0l/aMiLwiQIc9ghIqqNZz3
aBRBJaeLWqCLK9PBIHYPwPebcLPBft+T1HhEHpg6k5IoSF6wYiUE0KwLEHO2n/27
8O9HfzTxfzccdEhDQ9nz8XxZOqyS3ode0sYzyLgx30pJt7qtYx1NiA6qbbALMFYv
jIvGjtqLOi6HiSN7PiEqg8zb8+3VABfXhlAXa4p8aH/B2RvHhZc=
=c0zf
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
