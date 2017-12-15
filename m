Received: from eggs.gnu.org ([2001:4830:134:3::10]:58179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePpac-0005hw-Nh
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePpaZ-0001st-M1
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:59:46 -0500
Date: Fri, 15 Dec 2017 23:56:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171215125640.GJ7753@umbus.fritz.box>
References: <20171215101651.13911-1-david@gibson.dropbear.id.au>
	<20171215101651.13911-4-david@gibson.dropbear.id.au>
	<e69f5264-9da3-2bbf-e0f9-3c1e989d7260@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x0KprKst+ZOYEj2z"
Content-Disposition: inline
In-Reply-To: <e69f5264-9da3-2bbf-e0f9-3c1e989d7260@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] tests/pxe-test: Test net booting over
 IPv6 in some cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: mst@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--x0KprKst+ZOYEj2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 12:10:56PM +0100, Thomas Huth wrote:
> On 15.12.2017 11:16, David Gibson wrote:
> > This adds IPv6 net boot testing (in addition to IPv4) when in slow test
> > mode on ppc64 or s390.  IPv6 PXE doesn't seem to work on x86, I'm guess=
ing
> > out BIOS image doesn't support it.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  tests/pxe-test.c | 26 ++++++++++++++++++++------
> >  1 file changed, 20 insertions(+), 6 deletions(-)
> [...]
> >      } else if (strcmp(arch, "ppc64") =3D=3D 0) {
> > -        test_batch(ppc64_tests);
> > +        test_batch(ppc64_tests, g_test_slow());
> >          if (g_test_slow()) {
> > -            test_batch(ppc64_tests_slow);
> > +            test_batch(ppc64_tests_slow, true);
> >          }
>=20
> The NICs from ppc64_tests_slow are now never exercised with IPv4 ...
> maybe it would be better to do both:

Yes they are: the ipv6 parameter to test_batch() makes it do IPv6
tests in addition to IPv4, unlike test_pxe_one() which just does one
or the other.

>             test_batch(ppc64_tests_slow, false);
>             test_batch(ppc64_tests_slow, true);



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--x0KprKst+ZOYEj2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlozxogACgkQbDjKyiDZ
s5LcQxAAkcM21jBC489zXopE4mRb20kr7rwsv35itb7hbrt1mr7Nu8oHmJyvLUlp
Qp0L0pk3aRtuyJPdaWjwZxxQW2LLPE1nQOVKIs91D8BN7O4v6V/mImH2P70qbz8o
bg7t3CmHLfdTbbSaDylidGXuISWFdV8EmrpkyuGrTNp63lbF1S5yjKOf3lXINdjk
wYqQtaS8iupSeXepsBTgOnukDZUw4Q6saOq3QVjygyCSbr/ODZzAi+bjBgoBv5WN
xHvD0JOxK4ApJMN1JxCiYWy2Et3XXJ16pSBbonsASlABoxfqfpkK/K9L7ect/U+B
TYPOoXB1nQz2VJ2GE2mlxSvuac+yH+taR0shwgo1ElNrshznPwEhB6BLu7mjhYzq
1RCHtKQdBF7iCrzhvUI1A278+cukjCrcLYzf0ymK3iAFTDjizSCVoiQ2aetQCjlA
fUzkADXhhel+LBydeBrI8l42bUgmE7Co94swCDtqoLLRzObAAEJKga60TZDa4lyf
l+cKFyK8dxreA+qGAR1DLFmSKy3yQBGF2CdT34QpSkSCaLbEBNARB9/ikNg3Ok08
daxv6g6LITlInqJGBh9wr4oPlHUtPSXJ9xQy207YzujdkxerXjcsso7m2UIU32F3
8ERWqEx5KhMyPe/N03A3PtRQNnIjZTFADykhXCfqmKOy+15R/5g=
=eHFz
-----END PGP SIGNATURE-----

--x0KprKst+ZOYEj2z--
