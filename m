Received: from eggs.gnu.org ([2001:4830:134:3::10]:54779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gNEyA-0007PC-T1
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gNEyA-0004eb-2H
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:33:54 -0500
Date: Thu, 15 Nov 2018 21:33:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181115103308.GI2547@umbus.fritz.box>
References: <20181115035659.85245-1-aik@ozlabs.ru>
	<20181115101112.GF10900@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/GPgYEyhnw15BExa"
Content-Disposition: inline
In-Reply-To: <20181115101112.GF10900@redhat.com>
Subject: Re: [Qemu-devel] [PATCH qemu] configure/fdt: Use more strict test
 for libfdt version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--/GPgYEyhnw15BExa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 10:11:12AM +0000, Daniel P. Berrang=E9 wrote:
> On Thu, Nov 15, 2018 at 02:56:59PM +1100, Alexey Kardashevskiy wrote:
> > The libfdt installed in the system is preferred to the dtc submodule by
> > default. The recent libfdt update added a new symbol - fdt_check_full -
> > and this breaks compile if there is an older libfdt installed in
> > the system.
>=20
> Unless I'm missing something, QEMU doesn't use the fdt_check_full symbol,
> so why would the lack of this symbol cause a compile failure.=20
>=20
> It should be fine if the dtc submodule contains a newer libfdt than the
> host system. As long as QEMU doesn't actually need any of the APIs in
> the newer libfdt we should be able to continue using the older system
> version if it is present.
>=20
> Could you elaborate on what build problems you are having.
>=20
> > This changes the test to force ./configure into using newer libfdt.
>=20
> I'm not convinced we want todo that.

So I think the point here is that Alexey has some other outstanding
patches that will use fdt_check_full().  The commit message needs to
make that clear though.  Or else include this patch in that series.

>=20
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  configure | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/configure b/configure
> > index 74e313a..7e16a6c 100755
> > --- a/configure
> > +++ b/configure
> > @@ -3826,7 +3826,7 @@ if test "$fdt" !=3D "no" ; then
> >    cat > $TMPC << EOF
> >  #include <libfdt.h>
> >  #include <libfdt_env.h>
> > -int main(void) { fdt_first_subnode(0, 0); return 0; }
> > +int main(void) { fdt_check_full(NULL, 0); return 0; }
> >  EOF
> >    if compile_prog "" "$fdt_libs" ; then
> >      # system DTC is good - use it
>=20
> Regards,
> Daniel

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/GPgYEyhnw15BExa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvtS2IACgkQbDjKyiDZ
s5K15A//bM2WtPteJCAWQo8J/0ePwipu0JcnH/oSNudWSgeHroHv+/eYvGBWuyKr
XzT4bIYiqOZbAHKGldc3gbsVoZi1x9jRn2yu6R5VaOkEarqZ9Gk/Nupc8NquoPVr
4vUZJdTERJ35EhWxzaIfPHLVrBPQlXew2Dituj7muhEVcyq+wputtejsUPFRzxR7
XNwdAt9FoFqAIF0axjEFY6fPv5LuRvvbdHxZLdWqzvpHMMnKCZBQz53LTXPvSW0z
YLbwVzU+OtNYALl7z9WggpA+uuqoclnBHBKy8gmPGsmQPXbFV2+Tn9hLKgv2aVtj
nbSvpAkGEDAESC+QcFY3yhWQRgwpBVpJqq43O6Xooo+cp0rItRa8yJ9WBs46JZav
LXiB0tyZtcFqsMhRodsK76vlhhDpxIiqCvQwGsatTQEaUw9Qhh/0yw6ifu5G2VlI
1WFkI5sPRyRfn+V+QuwTICnHibcZtUUs00Bu9CDUqy0BtswgVQNXb6zR5ilCr17g
EZ6O2FR3PHrRwKcg5qNOLbSY1SxkEJU2NzgD9uRgYRjkZqpXjN+5qNPv1Txm5gLk
trH2SUN4czv/TxQ+1pKBmAi2cG7vo1hno3v8s5lKsWUbAzFekZhfb3XoBhSb9zoW
wEoffgYeGpAIeWgjAv+jgO9qhJplDWdlYy+9RkChkXwniBtwoAo=
=ASMW
-----END PGP SIGNATURE-----

--/GPgYEyhnw15BExa--
