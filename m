Received: from eggs.gnu.org ([2001:4830:134:3::10]:58178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePpac-0005hu-NK
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePpaZ-0001sz-MD
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:59:46 -0500
Date: Fri, 15 Dec 2017 23:59:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171215125934.GK7753@umbus.fritz.box>
References: <20171215101651.13911-1-david@gibson.dropbear.id.au>
	<20171215101651.13911-5-david@gibson.dropbear.id.au>
	<8c3ee849-7c3c-9afd-8906-5c3712323fbd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="huBJOJF9BsF479P6"
Content-Disposition: inline
In-Reply-To: <8c3ee849-7c3c-9afd-8906-5c3712323fbd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] tests/pxe-test: Add some extra tests
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


--huBJOJF9BsF479P6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 11:51:18AM +0100, Thomas Huth wrote:
> On 15.12.2017 11:16, David Gibson wrote:
> > Previously virtio-net was only tested for ppc64 in "slow" mode.  That
> > doesn't make much sense since virtio-net is used much more often in
> > practice than the spapr-vlan device which was tested always.  So, move
> > virtio-net to always be tested on ppc64.
>=20
> Actually, I just moved virtio-net on ppc64 to the slow category a couple
> of months ago:
>=20
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dab06ec43577177a442e=
8e5
>=20
> This has been done since some people complained that SLOF is incredibly
> slow in in TCG mode and thus there is the risk of hitting the timeout on
> slow systems if they are overloaded.

Hm.  If we're really concerned about the speed, I'm more inclined to
move spapr-vlan to slow than virtio-net.  virtio-net is now a much
more common case.

> Things will hopefully get a little bit better with the "Use
> tcg_gen_lookup_and_goto_ptr" patch that you've queued in your
> ppc-for-2.12 branch,

Just now merged, as it happens.

> but still, the test is very slow on ppc64, so I'd
> rather keep it in the "slow" category. (virtio-net is already tested in
> big endian mode on s390x anyway, so we at least got some endianess test
> coverage for that NIC already).

TBH, I see this as exercising the firmware netboot features more than
the device model.

>=20
> > We had no tests at all for the q35 machine, which doesn't seem wise giv=
en
> > it's increasing prominence.  Add a couple of tests for it, including
> > testing the newer e1000e adapter.
>=20
> That sounds like a good idea! I wonder whether we should also test some
> "old" machine versions (in "slow" mode only, of course), like "pc-0.12"
> for example, to make sure that there are no regressions with old
> machines?

Maybe.  Not really my department.
--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--huBJOJF9BsF479P6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlozxzYACgkQbDjKyiDZ
s5JvzA/+Iv+ASJpQwMOulL2z9A8MFecUCUQ6GcUeanvNmhzCCmcsd0PSmEWzVtHH
zJYd91VQ6Jgs5hgx3VAJYTxICpCDhE/+I2lox1/e17XAkfrW4zqwRZN0qNxakNzv
5HWre9e7u8lZREk4lnTMz+q8dbWb/h+aM3z1XJHZgD+jl/DwyrVcOFNJVf6hhXdv
cin86ru0VDayw8A6h6O1AQXigKEWQ/j/qF3hlxAN+D15GnSajo+/P8QleuXARj4+
rZ2lkIfcPELj03xwEtUbF9zX1UvyR97lSBSCxpVrljsTsjlruIlPo+7Sl9H5Rlwq
bklqyESh9yAUReI+UN6WWiphr6darCQTxJ6Ybb+ScXllmoWaIrTzk/87Z2Wg1gP2
5z9eJoix9uriV7GoRgM3K91unj/gTEVxARdadZUVej+bKioQdfVSOlIJkO0z7h2b
UvFSVr1G+QS4x+ACAlieEjQfNk2eelRB4mDyqLt4ngMif71nPoJqcb/whAnoot2A
WA3QwO+pQ/8wFHqvFVOFqXTtwn0EdLpQcZUrmt/WiNu8ZuYjPtACtjUXtsipJFmR
iGVDLDjb/6/yubB8X9VrgCd8l902NYECIpZ1yTBCXNRpgDSn5UAL3ylpXOtAV1h1
62+XVBslmj2HX+mFtox1iuucn9Co5qICzfntKAcInitSHSTMVhg=
=0BDY
-----END PGP SIGNATURE-----

--huBJOJF9BsF479P6--
