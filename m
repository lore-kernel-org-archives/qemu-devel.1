Received: from eggs.gnu.org ([2001:4830:134:3::10]:40650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZT4o-0000za-RG
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZT4l-00059R-QV
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:58:46 -0500
Date: Thu, 11 Jan 2018 13:47:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180111024711.GF24770@umbus.fritz.box>
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
	<CAFEAcA_vmTqHdjL6QfKtn-Khg2RHBA7Vs3QxreXwe2J_7mhGAQ@mail.gmail.com>
	<20180109121653.GN2131@umbus.fritz.box>
	<CAFEAcA-Mzyf2S3yW04LNVy7pAZ6gmzXo3aiFdPxrbWAAAX7N0Q@mail.gmail.com>
	<20180110015506.GO2131@umbus.fritz.box>
	<0b3ef6d4-0e2f-686a-a1ce-8f71ab1e10d4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f61P+fpdnY2FZS1u"
Content-Disposition: inline
In-Reply-To: <0b3ef6d4-0e2f-686a-a1ce-8f71ab1e10d4@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, surajjs@au1.ibm.com, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>


--f61P+fpdnY2FZS1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2018 at 02:33:41PM +0100, Paolo Bonzini wrote:
> On 10/01/2018 02:55, David Gibson wrote:
> > On Tue, Jan 09, 2018 at 03:15:25PM +0000, Peter Maydell wrote:
> >> On 9 January 2018 at 12:16, David Gibson <david@gibson.dropbear.id.au>=
 wrote:
> >>> Thanks.  Even if you can identify which patch it is and we can
> >>> postpone that one would be a bug help.
> >>
> >> Bisection blames this one:
> >>
> >> pbonzini@redhat.com (1):
> >>       target-ppc: optimize cmp translation
> >=20
> > Aha!  Ok, I'll pull that one out until we find a fix.
>=20
> Richard posted one, it's an ARM32 backend bug.
>=20
> > [snip]
> >> (This is a build for arm32, running in a chroot on an aarch64
> >> box, non-debug build.)
> >=20
> > Ah.. but since it's a chroot, still an aarch64 cpu behind it all.
>=20
> No, it's running 32-bit ARM code.

Ah.  But maybe a different version to older ARM32s?

I'm trying to figure out why I entirely failed to reproduce this on a
Raspberry Pi 1 (and a couple of other arm32 machines, but I forget the
details of them).

>   I
> > think the machines I managed to borrow were all much older slower
> > really truly arm32 machines, which I guess didn't show the problem.
> >=20
> > Oh.. and probably a debug (default) build as well.
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f61P+fpdnY2FZS1u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpW0C8ACgkQbDjKyiDZ
s5LygQ/+Nzye+IUW6SKFghWGQEwueQ+bXtZX/iyLbI9sBiRJxBBrxTDn4aUKF026
HabqCeY24OjJW6SRv5o9GxFyy8nyj++8prmM50/TYK2zCNaxUyhTu9nam+VDje9O
bWQsmrISU3j540uBGaLPQaG5nc0af+qHVfm0s63tqOMQPiuEYSGClna5c3crywks
bGywWERNdO8SCPhnFBdXZVD7jWYr17KOY2cqCERn6FxbSc66tTQSWw+MVEHAfvK/
sCm/MBcNDJHWJ3+5BMHNmtzSsjhL6ugxdwVILeW0PGErCq+dqFk3ckhUrYPMFbpt
fyThI4Mo5Sd2Wl2W3KK/igrT2UNyoqy9FSG93lbYmQaY67m8cCNNNI3IlaLnk3H8
+zY5giMwCmzwfobj+u62gvrfCFIGRR+57y45XZAUl6gJ7tIHb/1S6PoCCkAJjERl
GtFVhvs0V6ITLvp9IVApIcjb0rSiNiYZVj3GUUhLDHac8fXHipAXkdl2GXh9c4X/
X/lpC3GeECxxfH2BxpKwgZa6/g7EeqCv/LEeS3NM4cJh6+jhwr2UopIMxNuDGC4A
ZmIbm1kjQnelVf75qOgR/V4el7HGeVBM1a4RROg/xyn/+XoSPnObiw2lXlk0zQUz
ltr3TstbVvorIHUfI/c1hBrcxu8PGIb0YL8rLPwX6LSUq0XvRS8=
=ffHs
-----END PGP SIGNATURE-----

--f61P+fpdnY2FZS1u--
