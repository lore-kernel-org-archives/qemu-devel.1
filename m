Received: from eggs.gnu.org ([2001:4830:134:3::10]:35577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esf5I-000109-4D
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 20:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esf5H-0003i8-48
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 20:38:36 -0500
Date: Mon, 5 Mar 2018 12:38:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180305013824.GF2650@umbus.fritz.box>
References: <20180303130226.26906-1-nia.alarie@gmail.com>
	<20180304235152.GA2650@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oPmsXEqKQNHCSXW7"
Content-Disposition: inline
In-Reply-To: <20180304235152.GA2650@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH] PPC: e500: Add check for NULL return value
 from qemu_find_file.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nia Alarie <nia.alarie@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, agraf@suse.de, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au


--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 10:51:52AM +1100, David Gibson wrote:
> On Sat, Mar 03, 2018 at 01:02:26PM +0000, Nia Alarie wrote:
> > This prints a message and exits if the e500 BIOS firmware can't
> > be found, to avoid dereferencing a null pointer.
> >=20
> > Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
>=20
> Applied to ppc-for-2.12, thanks.

Sorry, I take that back.  This has been obsoleted by other changes to
the e500 image load path.
>=20
> > ---
> >  hw/ppc/e500.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> > index a40d3ec3e3..6ce03d6ff4 100644
> > --- a/hw/ppc/e500.c
> > +++ b/hw/ppc/e500.c
> > @@ -1005,6 +1005,10 @@ void ppce500_init(MachineState *machine, PPCE500=
Params *params)
> >          }
> >      }
> >      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> > +    if (!filename) {
> > +        error_report("Could not find firmware '%s'", bios_name);
> > +        exit(1);
> > +    }
> > =20
> >      bios_size =3D load_elf(filename, NULL, NULL, &bios_entry, &loadadd=
r, NULL,
> >                           1, PPC_ELF_MACHINE, 0, 0);
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqcn48ACgkQbDjKyiDZ
s5Jk9RAAz96bWOHTRw4Flbw2L1+++O1KkLmjkHOvadiy1tWaaUpyr5seiBcPjQo+
JiCbAYXkCUeQTxju2wfvxOgjU/fpDpFt7t+qB4IaylaBzCXdCqPYV6qJZmTmjwtL
QF/jBg3p9xkgMDk+0ypsloB2Au1djUb+ILGxDOfR/2Q8XhWfkgvGmChErPLUsiNl
wX6DIaa2glyUEF7HUmOZqKCViODgWSqXrTI2jgmtK4WT+yioZYlZJkX5H1E7XDyl
2MYjJ+0BfT9d+XNFbz0EWup1FHmzqnFUsXcm0lr9j2AgZesbh46dBBvR6DvVLLNi
65/lMhy/VK7wIm8nnc6693BpaMIOsrAjyXXE2fBvp/KSRVSRFiQRXnku/GfW8Bn0
LQBkLwMY3B9tFAaybBubiQvtc27SZmwWfngcci17uhtz2qTll13LStsuUNWvA3x0
PvsHR8+97tFocBVkUM3cWArIohkxRJIzmQfRttM7XGiOiWvVGTEmDaThHACIt31K
EiB0aouieHL3f0bFnZP1yOCfsCOb4W04OM01Px51xTDoiCcE9skJE6jt6cw5qDns
AJltlvRNSrCSuAXw7XYELA6iFPeRco6DFHDlyh0pipueNMLuyAdOaZEk4dBj9HrS
gbNHsPOubD/V2AlwpQMs+7h7EpDChrHtEn7WXLr9CxivppuV2Bo=
=IIQO
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--
