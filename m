Received: from eggs.gnu.org ([2001:4830:134:3::10]:34975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fXPwQ-0003do-9F
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fXPwP-0002un-Dn
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:45:54 -0400
Date: Mon, 25 Jun 2018 13:45:28 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180625114528.GL16514@angien.pipo.sk>
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
	<20180622142513.GH4366@localhost.localdomain>
	<20180622143146.GQ23296@redhat.com>
	<20180625095322.GC18580@redhat.com>
	<20180625114106.GJ5024@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jdM5ZcN/ZcXXVwZs"
Content-Disposition: inline
In-Reply-To: <20180625114106.GJ5024@localhost.localdomain>
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>


--jdM5ZcN/ZcXXVwZs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 13:41:06 +0200, Kevin Wolf wrote:
> Am 25.06.2018 um 11:53 hat Daniel P. Berrang=E9 geschrieben:
> > On Fri, Jun 22, 2018 at 03:31:46PM +0100, Daniel P. Berrang=E9 wrote:
> > > On Fri, Jun 22, 2018 at 04:25:13PM +0200, Kevin Wolf wrote:
> > > > Am 22.06.2018 um 15:36 hat Christian Borntraeger geschrieben:

[...]

>=20
> Thanks!
>=20
> I'll look into werror/rerror support for usb-storage. It shouldn't be
> too hard, though it's strictly speaking a separate problem related to
> using -blockdev rather than option deprecation.
>=20
> If Peter wants to wait for QEMU support before converting werror/rerror

Definitely. I don't want to keep around yet another hack that will
satisfy one specific case and then add another capability for it. We
should then gate the moving of the feature based on the presence of
werror for usb-storage.

> to -device, maybe it would make sense to split your patch for v2 so that
> geometry and serial can get fixed right away?

Yes this can be done right away.

--jdM5ZcN/ZcXXVwZs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlsw1dMACgkQHGwCByjY
1GqqShAAjKG1SSQBEdyUhg6L9onixtW+uD2mtnqQ2FLtTcW9xAAd1TtJJbYSc94Y
DP9AVY/Pm1eGhrmDZEuWBvS28xLvhZAFCM+nTl33HVaVQaWz/8Aa20v90wkhguxX
eMH4T7ts3ki1wlir205SW+8/AdjRQ4wESb9DKYcqUDVk/R104Poe0YdPC3BQXJdF
a3GcpfeSAbri5EOx35t1fXLibqNkqB9ak71v0l2E/msF1QZsWIxouE6lwLMDFG56
W575wu42tZKDWqHLdNoWnokmnIVDQ228SPd1vDvXy6Q4gEZi+ZpBAfA93T1XNHy7
LPxUzAPvmp+L8pRuZqTC3Y2ClqmZLHOJxYnJplysuj+wzdlOWlGSRMUdhLx+A/65
NSQxp6VkT2FPBULQc7MtLBn3Qyr3SAzxEmR/lP4n4IzwZb6VCpYlzYXQi42siSsx
vYKHNKdnFH/cIPJK5Jfd4s7+MM61hBxoVg8dhdhF3V3VrRUw0umH0jlEsNy7ADft
iBZpQzE/vTKD+ep6LGSQarT1eZnLIdlgmY/fS3fy132dlK/w5BxYOpzqybZJA2ea
+GhqfQAwWb8XeicJjZR6h4d5i87kYh34x7ss9JWlV+tp/jzYKTUa7FOSlN4SWTAn
rgJgewbrfHN9mYcxVFwpzvv8jtq+FLnno5pt3WSINzPB5rjIl04=
=+2Jj
-----END PGP SIGNATURE-----

--jdM5ZcN/ZcXXVwZs--
