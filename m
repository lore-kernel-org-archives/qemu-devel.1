Received: from eggs.gnu.org ([2001:4830:134:3::10]:34984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMVov-0004zS-Pw
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMVou-0007Oq-Ej
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:16:49 -0500
Date: Wed, 6 Dec 2017 19:47:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171206084709.GV3057@umbus.fritz.box>
References: <151254821213.27903.10774600450833875601.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ln+iIw7POnzHEEo5"
Content-Disposition: inline
In-Reply-To: <151254821213.27903.10774600450833875601.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr_events: drop bogus cell from
 "interrupt-ranges" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>


--Ln+iIw7POnzHEEo5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 09:16:52AM +0100, Greg Kurz wrote:
1;5002;0c> According to LoPAPR 1.1 B.6.12, the "/event-sources" node has an=
 "interrupt-
> ranges" property, the format of which is described in B.6.9.1.2 as follow=
s:
>=20
> =E2=80=9Cinterrupt-ranges=E2=80=9D
>  Standard property name that defines the interrupt number(s) and range(s)
>  handled by this unit.
>=20
>  prop-encoded-array: List of (int-number, range) specifications.
>=20
>  Int-number is encoded as with encode-int.
>  Range is encoded as with encode-int.
>=20
>  The first entry in this list shall contain the int-number associated with
>  the first =E2=80=9Creg=E2=80=9D property entry. The int-num-ber is the v=
alue representing
>  the interrupt source as would appear in the PowerPC External Interrupt
>  Architecture XISR. The range shall be the number of sequential interrupt
>  numbers which this unit can generate.
>=20
> There's no such thing as a cell count at the end of the array, like the
> one introduced by commit ffbb1705a33d in QEMU 2.8. It doesn't seem it had
> any impact on existing guests and I couldn't find any related workaround
> in linux. So, let's just drop the bogus lines.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

That does indeed seem bogus.  Applied to ppc-for-2.12.

> ---
>  hw/ppc/spapr_events.c |    3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index c7a64e6b8dd3..86836f0626dc 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -292,9 +292,6 @@ void spapr_dt_events(sPAPRMachineState *spapr, void *=
fdt)
>          irq_ranges[count++] =3D cpu_to_be32(1);
>      }
> =20
> -    irq_ranges[count] =3D cpu_to_be32(count);
> -    count++;
> -
>      _FDT((fdt_setprop(fdt, event_sources, "interrupt-controller", NULL, =
0)));
>      _FDT((fdt_setprop_cell(fdt, event_sources, "#interrupt-cells", 2)));
>      _FDT((fdt_setprop(fdt, event_sources, "interrupt-ranges",
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ln+iIw7POnzHEEo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlonro0ACgkQbDjKyiDZ
s5K5RhAAkkehIIGrld+WMW316hcoBoSjuTus4gmDpm0etFolEPbiWlSbABIS16ZD
7WdDs9xPB+QnK4RyRDyqS8CtCQ7WrvCaUbk3SFqt/l6lw+8yJBXtP4Rb9svnp4+2
KgA4w7lQuNjLLByO4LJ0lxOeHnSB+bLcJVt9pJD8jg+pOdY398VdgatQq5WLm4b9
qybonTPAs5QAHReowe4UWBM6SPWYACgeDoW6DekbhyPD5Fl2RjioQQrcoSNs9unX
Q1DRHgEDEmMn6WuZU2WVNyhM3Uc38yzAt5Jh5O1I7s4tB1pfRfgWHbSu3fwIj6nF
aID1XeZTF7kbKd3s4UQ5OJ+unGFWSnQw+O9BvJkpPhxqU4gL3aNiy3TyCHKuD85G
Z/Z8C82F3TANeswPcfWjY5YRproqKd7iGWtNEh+N5Dj/cbUr0WCdZRhXvEJSVai6
6/Kr1yYJF3z3tCuk2coLzLRl5mbu6lLk5mJewDuzR3j7yQeHsLYPOlGJXvAWSHFs
3t3AqYIQ+vNhjQvdHsutAfqc6XktP9Cn0vhkpuQt7LlukH8YFO1OKv4pg5NTR1EP
1aqHgLiZhB2M+Jx+Ql3C5PHBlW4Ai3sWGgNtpMKtXcTvTc1qnhFupPDjnF/QHzT/
Clcxlb72QGlvyNMXvwIOHwY9rViuCZ0FTxxDHEDtlZOH0ZHDKsQ=
=lm8z
-----END PGP SIGNATURE-----

--Ln+iIw7POnzHEEo5--
