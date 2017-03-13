Received: from eggs.gnu.org ([2001:4830:134:3::10]:54342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnYM2-0008O0-E3
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnYM1-0003Bo-J6
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:22:14 -0400
References: <20170308025428.1037-1-eblake@redhat.com>
	<20170308025428.1037-10-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3ab9e161-d82f-d5bb-9122-5173a91a8f95@redhat.com>
Date: Mon, 13 Mar 2017 23:22:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170308025428.1037-10-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PPlM9H07GRt7aVxKS46ctGKBf4LT2oWFB"
Subject: Re: [Qemu-devel] [PATCH v6 09/10] blkdebug: Add ability to override
 unmap geometries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PPlM9H07GRt7aVxKS46ctGKBf4LT2oWFB
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <3ab9e161-d82f-d5bb-9122-5173a91a8f95@redhat.com>
Subject: Re: [PATCH v6 09/10] blkdebug: Add ability to override unmap
 geometries
References: <20170308025428.1037-1-eblake@redhat.com>
 <20170308025428.1037-10-eblake@redhat.com>
In-Reply-To: <20170308025428.1037-10-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 08.03.2017 03:54, Eric Blake wrote:
> Make it easier to simulate various unusual hardware setups (for
> example, recent commits 3482b9b and b8d0a98 affect the Dell
> Equallogic iSCSI with its 15M preferred and maximum unmap and
> write zero sizing, or b2f95fe deals with the Linux loopback
> block device having a max_transfer of 64k), by allowing blkdebug
> to wrap any other device with further restrictions on various
> alignments.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v6: more tweaks in docs and error messages
> v5: tweak docs regarding max-transfer minimum
> v4: relax 512 byte minimum now that blkdebug is byte-based, fix doc typ=
o
> v3: improve legibility of bounds checking, improve docs
> v2: new patch
> ---
>  qapi/block-core.json | 31 +++++++++++++++--
>  block/blkdebug.c     | 96 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  2 files changed, 124 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--PPlM9H07GRt7aVxKS46ctGKBf4LT2oWFB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljHG40SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9An4kH/3yCF9u6rH2SUIPmxB8vFCIimQJTWxh3
FJk0AXLm03c/D1BBxSu7m+UvOWllpNJVsg7AeinAdoehycLB07kJVY2jU+nw6Dmm
y+kODvi28B5lf3DQXUFtJv8m6hZQ1GfZ/BYiYEhIG6oXOWEyYpGG3gHIcwhoOkUg
BnrBU/t0xUa6qPKwXiefazw6eJjn6qxDgdAosPoTnimSx1IL3p+xRzdOJ0eQ6JZs
ISWgEZKUBagVt6yUemlQb726h39hPEwxAOzjumNtJPIfz3Ji0Rg9sbejcEsGcxkb
6Q3yp6w+iEBZE8Zaxx9Mkrz3Iw8b7ylCLEXjSFAngOUTysIF8skunbQ=
=EGcI
-----END PGP SIGNATURE-----

--PPlM9H07GRt7aVxKS46ctGKBf4LT2oWFB--
