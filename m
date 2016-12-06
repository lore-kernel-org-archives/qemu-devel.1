Received: from eggs.gnu.org ([2001:4830:134:3::10]:36525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cENFw-00065Z-Mq
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 16:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cENFv-0006op-Uj
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 16:26:32 -0500
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-2-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5415aabc-86c7-f8ae-2ebb-32e5aa0785be@redhat.com>
Date: Tue, 6 Dec 2016 22:26:21 +0100
MIME-Version: 1.0
In-Reply-To: <20161202192223.15153-2-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SQgGvWKxEntwfj4bRmPP0QiLv90r8cDAM"
Subject: Re: [Qemu-devel] [PATCH v3 1/5] blkdebug: Sanity check block layer
 guarantees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SQgGvWKxEntwfj4bRmPP0QiLv90r8cDAM
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <5415aabc-86c7-f8ae-2ebb-32e5aa0785be@redhat.com>
Subject: Re: [PATCH v3 1/5] blkdebug: Sanity check block layer guarantees
References: <20161202192223.15153-1-eblake@redhat.com>
 <20161202192223.15153-2-eblake@redhat.com>
In-Reply-To: <20161202192223.15153-2-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 02.12.2016 20:22, Eric Blake wrote:
> Commits 04ed95f4 and 1a62d0ac updated the block layer to auto-fragment
> any I/O to fit within device boundaries. Additionally, when using a
> minimum alignment of 4k, we want to ensure the block layer does proper
> read-modify-write rather than requesting I/O on a slice of a sector.
> Let's enforce that the contract is obeyed when using blkdebug.  For
> now, blkdebug only allows alignment overrides, and just inherits other
> limits from whatever device it is wrapping, but a future patch will
> further enhance things.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v3: rebase to byte-based interfaces
> v2: new patch
> ---
>  block/blkdebug.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--SQgGvWKxEntwfj4bRmPP0QiLv90r8cDAM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhHLP0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ACZ4IAJGYaP3hVXN4K3bOmsuyGhWdZOZN18dd
M3EHhrbhpSEjvqNZ6tr/Wrgb0+fc/NlLum56CipiEgRJBc1e6KtHbXfjV7syC0pc
fxChqIbMkgJKL9CWTSxbVN/00jo7Y3qa8rC1vEq03XbBXobrPQHWnTZ591hIYxQR
zfuhYUhdUQMEa0wmfDfgrL5Ium3HYxkSunC8Cj54t8urE12gWNjJIW8tI61R1dwH
wSLGHDv2D21ZOYua49+buEORpRtLEqPLB+/UvhofJ/ngskEJmXN8Vwpv98UqAFZX
2RYHHM3s2pQFZIWW8KdluY7qLMD2cjWwoqRCa3752AMZyMcpmpJXo+M=
=xViY
-----END PGP SIGNATURE-----

--SQgGvWKxEntwfj4bRmPP0QiLv90r8cDAM--
