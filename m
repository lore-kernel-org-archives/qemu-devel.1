Received: from eggs.gnu.org ([209.51.188.92]:56737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu7p2-0008C9-49
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu7jn-0003d3-HC
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:31:01 -0500
Date: Thu, 14 Feb 2019 14:30:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190214033040.GZ1884@umbus.fritz.box>
References: <20190201004012.13237-1-aik@ozlabs.ru>
	<b799d329-3336-715f-bf03-776856ecb1bf@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fzoBs0edN2XpEQF6"
Content-Disposition: inline
In-Reply-To: <b799d329-3336-715f-bf03-776856ecb1bf@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] spapr/rtas: Force big endian compile
 for rtas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>


--fzoBs0edN2XpEQF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 05:00:50PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 01/02/2019 11:40, Alexey Kardashevskiy wrote:
> > At the moment the rtas's Makefile uses generic QEMU rules which means
> > that when QEMU is compiled on a little endian system, the spapr-rtas.bin
> > is compiled as little endian too which is incorrect as it is always
> > executed in big endian mode.
> >=20
> > This enforces -mbig by defining %.o:%.S rule as spapr-rtas.bin is
> > a standalone guest binary which should not depend on QEMU flags anyway.
>=20
> Bag? Good? Useless? :)

I missed the original send of this, I'm afraid.  Looks like a good
idea.


>=20
>=20
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  pc-bios/spapr-rtas/Makefile | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/pc-bios/spapr-rtas/Makefile b/pc-bios/spapr-rtas/Makefile
> > index f26dd42..4b9bb12 100644
> > --- a/pc-bios/spapr-rtas/Makefile
> > +++ b/pc-bios/spapr-rtas/Makefile
> > @@ -14,8 +14,11 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/spapr-rtas)
> > =20
> >  build-all: spapr-rtas.bin
> > =20
> > +%.o: %.S
> > +	$(call quiet-command,$(CCAS) -mbig -c -o $@ $<,"CCAS","$(TARGET_DIR)$=
@")
> > +
> >  %.img: %.o
> > -	$(call quiet-command,$(CC) -nostdlib -o $@ $<,"Building","$(TARGET_DI=
R)$@")
> > +	$(call quiet-command,$(CC) -nostdlib -mbig -o $@ $<,"Building","$(TAR=
GET_DIR)$@")
> > =20
> >  %.bin: %.img
> >  	$(call quiet-command,$(OBJCOPY) -O binary -j .text $< $@,"Building","=
$(TARGET_DIR)$@")
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fzoBs0edN2XpEQF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxk4OAACgkQbDjKyiDZ
s5Jd2hAAvk0sAaaD9Jfon3PJoPrsJVyJFLsdaUU4FnMMXX/Y5fwahQWT9xgwyA8e
XKsL9YN6EbN2Ukz5InjEx2dt4Tw+uFlIBqmEX9q7pT/07bcyO3uibO1h3eefpj1w
Ork+k7P853Ak4FjOF+vr60htJV9Ihy5qyv44WxTNZNcKcZ/wIzViviRPr5sUvybz
uk0bDU8ZScJTyN96zD1JCC3h0FerUc/kZmaNEvf8sGCV5+rgyWWrVuBb149qwnMN
FlGjmWf4ejOGVry0tgB+92M2/514Cv2QlwhdHZZ+pGs5CJ1zARawYcdQ88xgKX0H
cZWZs00IWD+Yc8hNGCVBCPSM7yjCkz0iSre8sMhUviDBi2BiWnm6E+39+r6BTb1h
71faRgXk0U6RVlu8LcWQdDmZbJqF/wmXGkujvTRr6eoUwVzqqDEZ+OE2552rsgDW
v1bI5RrTrjBkk8xCfCO66lTlrA0OkcXRyF58F4dttgRzFA9Rdl2sSdvQkm9qb9tU
mUsC+EDDi4ZuwE0SKVYG/YVIQYQDvyPA6LmE32IybmKmZ4kh3atf4cddc+mysPCF
X8vj5wu361RJCOGiKkkFuCClQto3u90W0aZizT2Cu6dAJUQxiRO+KekaQmmvOmge
52nB4sLEyb8oAll2kPp8+4/FCYjy8wnSjmov/g0plkHU60xmDrg=
=Q7FN
-----END PGP SIGNATURE-----

--fzoBs0edN2XpEQF6--
