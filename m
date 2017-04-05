Received: from eggs.gnu.org ([2001:4830:134:3::10]:48366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cvdqs-0001i9-Ox
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 01:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cvdqr-0006J5-HX
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 01:51:30 -0400
Date: Wed, 5 Apr 2017 15:51:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170405055115.GC13614@umbus.fritz.box>
References: <1491205565-12831-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
In-Reply-To: <1491205565-12831-1-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 0/9] ppc/pnv: interrupt controller
 (POWER8)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 09:45:56AM +0200, C=E9dric Le Goater wrote:
> Hello,
>=20
> Here is a series adding support for the interrupt controller as found
> on a POWER8 system. POWER9 uses a different interrupt controller
> called XIVE, still to be worked on.
>=20
> The initial patches are more cleanups of the XICS layer which move the
> IRQ 'server' number mapping under the machine handlers.
>=20
> A new PnvICPState object based on MMIOs, which is specific to PowerNV,
> is introduced in XICS. These ICP objects are created for each thread
> of a core and linked to the associated PowerPCCPU object.
>=20
> Finally, to make use of the XICS layer, the PowerNV machine is
> extended with a QOM XICSFabric interface and with a global memory
> region acting as the Interrupt Management area.
>=20
>=20
> To test, grab a kernel and a rootfs image here :
>=20
>   https://openpower.xyz/job/openpower-op-build/distro=3Dubuntu,target=3Dp=
almetto/lastSuccessfulBuild/artifact/images/zImage.epapr
>   https://openpower.xyz/job/openpower-op-build/distro=3Dubuntu,target=3Dp=
almetto/lastSuccessfulBuild/artifact/images/rootfs.cpio.xz
>=20
> The full patchset is available here :
>=20
>    https://github.com/legoater/qemu/commits/powernv-ipmi-2.9
>=20
> Thanks,

I've applied the series to my ppc-for-2.10 branch.  A couple of things
to think about for follow up cleanups:

1) The spapr->nr_servers field has very little remaining use; can you
   go a bit further and remove it entirely?

2) At the moment you're creating (and realizing) the ICP objects just
before you realize the core objects.  I'm not entirely sure if
creating new objects at realize time is QOMishly correct.  Maybe do
some more enquiries to see if it is or not, and if not update.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY5IXRAAoJEGw4ysog2bOSP8kP/jEWBCHhtY0Lx7Nk4KPYMepI
tim6Bs4BuPfA/pOv6q97RbnnCYaW6jRBemKSX2E33McMMl0wZCLjN5fTDsE25273
mJnk8PCuw39o7pNXkPccmRpeY3/EDVD0jl2/yxKtklTsoRtgJjvH+xoCxr6N/Upu
zptN1YfFlL4uyaWKPKEHMjYiNy5iNp2xQYreRt6cti7Tl2e0UnXv50F+MBYB8J70
p/wr/VpJzXwycLpltiuqh9kTOa4SsQDIgMnEgxqX2kboP0cZyLz5onzjmUH2lHn0
exrSaYcQd8j2na6ZmrTqBqSJOEf67zerpCw+QXvSga1q6MU9peI2Pzbsq4aXMK98
jhyBVvqiBiAb9IKqZlOshpkQhJTD0QHgLPVGdsWQPrRzgkYu3EKK2BRc6aWU999/
ed+BqkU8DetehBQnQoYUs27A5lv4cX9QtrBYNoDmFQx6GxwC8yE6K3YEo52uFojV
FacAwheDSHH0fovS3Yl84RJsa7KXhG6x+0wc8vMBBTFuou8JvprTXutONZHFNIBA
CTvlcM7hM5D0K7fcD7vvxJZb6XvuwnBeMCq07w6Hzdjkp0fQhfhuLyAhLlhQRGXG
m51q96ePX01a0S0FSgqYTUQXa5lRVul4VqFavmHkZ1Drzx5gzJNIGEu70jVHF8aw
fuzWkgxbYR1aX+ShUN+s
=kTZh
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
