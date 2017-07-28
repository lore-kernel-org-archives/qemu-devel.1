Received: from eggs.gnu.org ([2001:4830:134:3::10]:50376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbAvg-0000Av-V6
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbAvg-0003Pu-4a
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:28:08 -0400
References: <20170728131452.15316-1-kwolf@redhat.com>
	<20170728131452.15316-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8131dee0-5ed5-4896-abee-b1e6909403be@redhat.com>
Date: Fri, 28 Jul 2017 14:28:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170728131452.15316-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h4Ce0eC3leSI1ol1Oj3d5lQHoskw32F0S"
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/7] qemu-iotests/041: Fix leaked
 scratch images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h4Ce0eC3leSI1ol1Oj3d5lQHoskw32F0S
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <8131dee0-5ed5-4896-abee-b1e6909403be@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/7] qemu-iotests/041: Fix leaked
 scratch images
References: <20170728131452.15316-1-kwolf@redhat.com>
 <20170728131452.15316-2-kwolf@redhat.com>
In-Reply-To: <20170728131452.15316-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 08:14 AM, Kevin Wolf wrote:
> qemu-iotests 041 left quorum_snapshot.img and target.img behind in the
> scratch directory. Make sure to clean up after completing the tests.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/041 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--h4Ce0eC3leSI1ol1Oj3d5lQHoskw32F0S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7kEEACgkQp6FrSiUn
Q2pJHQf/TaQK18KeNOQIefb4MacK53CpUsqKErBBbf2fpvkhpoOk1c0Y5U7Oo5oq
GLDiliGWuAU4FBvHf6CvBEZ8wJOgDHU5ovVqcUdxOxY8X8KBiSF96cRc0hC8DIgI
5emYztVi49e0y8ngAWx1mpjtoEOKpqFODMZV8L4ppmSH9Tj+YmHpIN5REHmQ1e6b
HWOzpnxV2x+zWO0dUrUZ9b4v/TwYIlqfaSXh2G3ca8bArGuWkWG1p5BXkyIDwZgQ
JzixH5CIv6sX/S/qO/kQNRilq82xLasGeGiWItiRxngBIAtGgIi44poK/vChZs82
RQsvs2Q4eym0F0+mmso6MgxCAQCmjA==
=ARTx
-----END PGP SIGNATURE-----

--h4Ce0eC3leSI1ol1Oj3d5lQHoskw32F0S--
