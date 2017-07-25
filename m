Received: from eggs.gnu.org ([2001:4830:134:3::10]:51425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZsd5-0007ZU-53
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZsd2-00059O-3G
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 01:43:35 -0400
Date: Tue, 25 Jul 2017 14:20:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170725042027.GC8978@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-15-git-send-email-clg@kaod.org>
	<20170724063534.GM17228@umbus.fritz.box>
	<fa7a0b3f-89d5-b1ef-238d-0bda41beee9f@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <fa7a0b3f-89d5-b1ef-238d-0bda41beee9f@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 14/26] ppc/xive: add MMIO handlers to
 the XIVE interrupt presenter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 04:44:00PM +0200, C=E9dric Le Goater wrote:
> On 07/24/2017 08:35 AM, David Gibson wrote:
> > On Wed, Jul 05, 2017 at 07:13:27PM +0200, C=E9dric Le Goater wrote:
> >> The Thread Interrupt Management Area for the OS is mostly used to
> >> acknowledge interrupts and set the CPPR of the CPU.
> >>
> >> The TIMA is mapped at the same address for each CPU. 'current_cpu' is
> >> used to retrieve the targeted interrupt presenter object.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Am I right in thinking that this shoehorns the XIVE TIMA state into
> > the existing XICS ICP object.  That.. doesn't seem like a good idea.
>=20
> The TIMA memory region is under the XIVE object because it is=20
> unique for the system. The lookup of the ICP is simply done using=20
> 'current_cpu'. The TIMA state is under the ICPState, yes, but this=20
> model does not seem incorrect to me as this state contains the=20
> interrupt information presented to a CPU.

Yeah, that's not the point I'm making.  My point is that the TIMA
state isn't really the same as xics ICP state.  You're squeezing one
into the other in a pretty ugly way.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll2xwoACgkQbDjKyiDZ
s5JMPA/+ICrvNaaffRmAAAsM403WR2JbcZ7mRnymbkWasYtKpjTEXQN4wc52d3pn
K8p2uX9Q8d0MUlk79THnKCIUuOz/LGtS2k9zQRnxnycvWqOPqLGfSxkztwXOEt8N
ZYlCAbz9+WYG1zgA7Pq3YxdBeNLltgE+uhAMvFxpu6p5m+uQvR2k5sjHmeE9p6GL
sj+1BGCla7iPJUGfQ+sH+RS9C9uJtu7A9Yi5dmqoN/8H8ujcH77MJCjeRah4WIp5
KID+4IYOFxV/y+Vm1QrIyXCHBpm3/HOHAHUT9VqzHC1l5YYe++j5vo6sAPgwJBia
xWhDD3ki2mXV3/27HKSBiZoeRvrqgZGdlkx2/mUG5vWzCZfOZEDt9TZW5HDnYv8i
sg5F2Fs71kJMtwmuXHfbbEiooWI0nGf6JcoHriO4FHlPgFxpaWzqWy1wjUlpLpoN
HE8uo2pmQGPivoajXwM3bXN/5z44C4vgoMWZGckK1qvsvF+8kCjXaRQGHXnhZssU
v4fRoE2D0l3dxJpRoolH0+at13JLpCDN2jVKj7Q8xMsWqTsMmjevu6z+QVUMWA/R
3SwoW5FfJaHGjMgJhozani69l8s9NLhQgFqldaKyFT9SNIx+tUZlTjPKqHiUxfOt
APciP9Mwpv1x/tSi4ljFp4Fy+V23UahVvaiwR1enlK7L3p/a52Q=
=EfR+
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
