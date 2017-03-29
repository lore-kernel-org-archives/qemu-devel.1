Received: from eggs.gnu.org ([2001:4830:134:3::10]:42485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctJNh-0008TA-3G
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctJNg-0004ij-4b
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:35:45 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-6-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <974429e8-46ed-a329-92ea-aceb53e368c1@redhat.com>
Date: Wed, 29 Mar 2017 21:35:33 +0200
MIME-Version: 1.0
In-Reply-To: <1490805920-17029-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FrdEmCrSOxFlcmWQ6U2ahRiX2PHIrORE2"
Subject: Re: [Qemu-devel] [for-2.9 5/8] gluster: Prepare for
 SocketAddressFlat extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FrdEmCrSOxFlcmWQ6U2ahRiX2PHIrORE2
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com
Message-ID: <974429e8-46ed-a329-92ea-aceb53e368c1@redhat.com>
Subject: Re: [for-2.9 5/8] gluster: Prepare for SocketAddressFlat extension
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1490805920-17029-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 29.03.2017 18:45, Markus Armbruster wrote:
> qemu_gluster_glfs_init() and qemu_gluster_parse_json() rely on the
> fact that SocketAddressFlatType has only two members
> SOCKET_ADDRESS_FLAT_TYPE_INET and SOCKET_ADDRESS_FLAT_TYPE_UNIX.
> Correct, but won't stay correct.  Make them more robust.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/gluster.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--FrdEmCrSOxFlcmWQ6U2ahRiX2PHIrORE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljcDIUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AH+4H/je/yOKOJ6TXesjo9ZbU2OFwzwWiaNOP
ZposPXWiUNapzgsFRyTYGALeK5g+geqP2m9Ojq8mM1VZ/uK6KOwFX7aAAQgZsBqJ
uFBscHYGNbZAI0ZF/qp93QkfY2XX0C4w+h+dtvkUfEfiTsHqiBUwkz1kEUmu+Wpe
phDyPTmBk5IEDWyVtd1sMh83A6Gw2g4NfBWs/bQ3D3e2tsgx4YCSpvEk0s4pKnQ8
57364iI8yw8tVuidNkBFfnrg1W0voh2V8i2FQ6M776nn0/IDpq9wNdvw4OsX2ZUB
K51nP2Nr2wGxMIod+tyi9B0MJV4tFjTKw2tXFn75A+y2FSS3WqDzhMc=
=hUFm
-----END PGP SIGNATURE-----

--FrdEmCrSOxFlcmWQ6U2ahRiX2PHIrORE2--
