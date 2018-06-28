Received: from eggs.gnu.org ([2001:4830:134:3::10]:47434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYO0o-0004pr-I4
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYO0l-0006wd-H9
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:54:26 -0400
Date: Thu, 28 Jun 2018 13:46:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180628034605.GA23134@umbus.fritz.box>
References: <20180626161921.27941-1-richard.henderson@linaro.org>
	<20180626161921.27941-2-richard.henderson@linaro.org>
	<20180627090917.GI14434@umbus.fritz.box>
	<75d315ee-dd6e-e68d-68c1-ed30508dabab@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <75d315ee-dd6e-e68d-68c1-ed30508dabab@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 01/13] target/ppc: Add do_unaligned_access
 hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2018 at 06:52:49AM -0700, Richard Henderson wrote:
> On 06/27/2018 02:09 AM, David Gibson wrote:
> > On Tue, Jun 26, 2018 at 09:19:09AM -0700, Richard Henderson wrote:
> >> This allows faults from MO_ALIGN to have the same effect
> >> as from gen_check_align.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >=20
> > So, most powerpc cpus can handle most unaligned accesses without an
> > exception.  I'm assuming this series won't preclude that?
>=20
> Correct.  This hook will only fire when using MO_ALIGN to
> request an alignment check.

Thanks for the confirmation, first patch applied to ppc-for-3.0.
Continuing to look at the rest.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls0WfcACgkQbDjKyiDZ
s5JN7RAAn9T7OpzjrYwpSjYeUAiXCXFMBoB5hLc71DrwCjAl+YkwNAlKZXMHg142
wKj3wMGfvESBq9xzh6nK7cqGgwBaQ/CVeCa/D65Bj9qA25x+SocHG5OVrRtywKdq
zO9fzD/rJ/DzgLMmND81mtuf7deEeRbdwkM2jEHdL7UHLWPbLp+nWRTBm5HlfqJp
lHQc3R9xlKEiIL9LWG3MbjvNmwCWu4llCIHY6BFU2hjSefFi93OlFJ5YpsFVygwg
UjbD99ZuEnrKy88OUWd4lLtEKk+M2V3OJYkUsopOA+F2wbsjgVaw8jE2c1Uv4dpv
Iz5pOWqdZ49IphhfTtDojyBS8RtiYsRJ5xs6XT7M94rL7xfRrOokXOLdi+CkDbNx
ZHYjEekeJfi47/jvHxB+2cg3HEdPYBRklXr0SE4nRSBSUae4iA3xX7h8o8Y+/eHN
bg9PgM6ad1d78YNAG3xsVstwUg/ehFaPp6b2HbxTYFHQnmPSR3nS0EeqyrBxJ4dp
5X4L1mfiKhPsgMTYofd75qZjd7MSQYahCqKgyLppZJUzIZSescX0Hv8uXilC2e23
GNr357DrXT2NdPrcu9W/t36Ffm9fmsy+z1ExnCZhKFTh+nsJNoFnZPLJV/9Tv+sZ
0+QySzha4nKL7yfZlYR+Ph7W89vXg1BgcpY2NWihoqcUcs8WspY=
=PvuN
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
