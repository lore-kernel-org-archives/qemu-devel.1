Received: from eggs.gnu.org ([2001:4830:134:3::10]:34223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWBna-0004oM-3h
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 21:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWBnY-00059Q-Va
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 21:59:58 -0500
Date: Mon, 10 Dec 2018 13:59:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181210025943.GE4261@umbus.fritz.box>
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.9999.1812100112050.45639@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1812100112050.45639@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 0/6] target/ppc: convert VMX
 instructions to use TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 01:33:53AM +0100, BALATON Zoltan wrote:
> On Fri, 7 Dec 2018, Mark Cave-Ayland wrote:
> > This patchset is an attempt at trying to improve the VMX (Altivec) inst=
ruction
> > performance by making use of the new TCG vector operations where possib=
le.
>=20
> This is very welcome, thanks for doing this.
>=20
> > In order to use TCG vector operations, the registers must be accessible=
 from cpu_env
> > whilst currently they are accessed via arrays of static TCG globals. Pa=
tches 1-3
> > are therefore mechanical patches which introduce access helpers for FPR=
, AVR and VSR
> > registers using the supplied TCGv_i64 parameter.
>=20
> Have you tried some benchmarks or tests to measure the impact of these
> changes? I've tried the (very unscientific) benchmarks I've written about
> before here:
>=20
> http://lists.nongnu.org/archive/html/qemu-ppc/2018-07/msg00261.html
>=20
> (which seem to use AltiVec/VMX instructions but not sure which) on mac99
> with MorphOS and I could not see any performance increase. I haven't run
> enough tests but results with or without this series on master were mostly
> the same within a few percents, and sometimes even seen lower performance
> with these patches than without. I haven't tried to find out why (no time
> for that now) so can't really draw any conclusions from this. I'm also not
> sure if I've actually tested what you've changed or these use instructions
> that your patches don't optimise yet, or the changes I've seen were just
> normal changes between runs; but I wonder if the increased number of
> temporaries could result in lower performance in some cases?

What was your host machine.  IIUC this change will only improve
performance if the host tcg backend is able to implement TCG vector
ops in terms of vector ops on the host.

In addition, this series only converts a subset of the integer and
logical vector instructions.  If your testcase is mostly floating
point (vectored or otherwise), it will still be softfloat and so not
see any speedup.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwN1pwACgkQbDjKyiDZ
s5K87A/+LNkEkCr3Y/KHxubP0s/Osv7XifTZ6NuJlPjd+8OAkVjBxqCb6x6i1N5L
bqGfyzPp249VlT8UAHD7ydmrvnZThnuYfxXG0iQ0DZI6JV0y+tOUCQaFeRFjsyYc
HWaWm0Phf95GR7l1Xt1ttgBTUR7/LEIBhUEeEV18XLN0bGJxVHd7ln2DaIDPH9Wr
zjyclrmrO26ddWPqiVYENeaBWB8GCLUbzfr1Zqg+bnSwCF72Ch8R/HFEthBUexXB
+kqDyDjcUv0AvcPmVkhxPvQo5eiQzkCaRkwQv8siaAz1JmnpYmf9NwC1pcTGLGOk
nxWSn/4xBx3zJXf+8BofB0KEgxuqcAjCMO43OIKGBP0K6P9cLV66X0XwrFPepGVd
r+VTLozGQH3JVdXuup8RSUxFO5OM6Nh/quR7Lt8f/vnOGZq6hlC2X2a12BITIzak
Jb3zIseBngMRWjBkr1wvuyy6xhcCmeu1o4/FcVHfVqH984BkIZDmM/Cdfe61m5+o
H6lg3mfiCIrhE7k2uxt1yiBGu+XL0lRu5vU5JKzzwjG4vTTZsOlPfX6o375DAzOR
RzAa7wT+ACBO0kHtWZSYmdIHLSlCLdr6eEfBjD/cfNtvvP4R1ICcVInRF+6l2v9h
aMJ6ZlMkn/C4svphE7dU/SvcuTJLCdNvUfaouphHrrXgB2zdsNk=
=nskG
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
