Received: from eggs.gnu.org ([2001:4830:134:3::10]:35941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fbFOo-0002Ak-KA
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 21:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fbFOk-0003RB-Ln
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 21:19:02 -0400
Date: Fri, 6 Jul 2018 11:18:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180706011849.GK3450@umbus.fritz.box>
References: <1530798684-23009-1-git-send-email-linux@roeck-us.net>
	<eb53939b-4a90-2e7b-32df-3dbe75169d3b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g4MvFqI7wmANiPDo"
Content-Disposition: inline
In-Reply-To: <eb53939b-4a90-2e7b-32df-3dbe75169d3b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Add comment explaining ignored
 errors from fdt operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, Pilippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--g4MvFqI7wmANiPDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 04:06:28PM +0200, Paolo Bonzini wrote:
> On 05/07/2018 15:51, Guenter Roeck wrote:
> > +        /* Failure to set serial port clocks is not fatal, so just ign=
ore
> > +         * errors when trying to do so.
> > +         */
> > +        (void)fdt_setprop_cell(fdt, offset, "clock-frequency", UART_FR=
EQ);
> >          offset =3D fdt_node_offset_by_compatible(fdt, offset, "ns16550=
");
>=20
> Ok, but why would it even fail?  Maybe it's not this case, but even if
> it's not fatal for the OS, generating different device trees silently
> seems like a recipe for Heisenbugs.

Yes, quite.  Especially since the most likely errors I can see here
would actually indicate something has already gone horribly wrong with
the device tree construction, so a missing clock-frequency is the
least of our troubles.

I think using _FDT() here would be a better approach.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--g4MvFqI7wmANiPDo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls+w3kACgkQbDjKyiDZ
s5KwnA/+PCwZQK5KLxw0KxXsBkH4+IPTo9NkpAVnxrZqB8cgxWIMXlSfmB180Svt
Mw9Ot2BSJQupJ2bkDoeu0vugwLhhm6+qlmBQ0LaXmCZW43TvYU2dFuyPqScjRg1l
i6sPscTvFY/n2+orPmsR7Gin4jHsQxsKvegs5M9gNl2sgQo8Kk0tYq721SE59EJD
j5GNOnWeZEh1wUFmNc9KCLg/O4yAWY90fzirmk24MdTk0pxmKolPA+NOzVu6dDll
FT52QvPJUDbR0RlPWzVkhzJqb3vdZNcE/WYmxsgZ9TFZS8bQz/pN9lKy1HidETQj
72b5OskM2hAx8utGa7T8oPt8UUlkHtNEVZ4iNaWUJsgp7cxgzh3/S5N2c80Gz9JN
7cF2U6FTnafKMC94oYiO7ieTIpTr0Vm6D8bucMKgxJMarGcLOMT9pIuiabUwZPEK
6gaWyOFyPXy41hdE8xuVxzsl6mq15df0/tj2qW6Qj94wund9pxgkzOSnEGl4YL2f
p9WGxJvMwobnS9dijKj5GJLVJiS0xXp4mz6l3vflglLSkUt7dM8N+tt8+v1dIEqT
/ZFwhlCiQljTWPS4/aCSvFzoTW59SwOaG4zev48rkY/Alk/l3mO+wV7g04Vqw7a1
BhdpQe3NaECcDPafDnAk/z6SC45cZuEpEKMPihm67Bxp5A6N0Xs=
=tWeS
-----END PGP SIGNATURE-----

--g4MvFqI7wmANiPDo--
