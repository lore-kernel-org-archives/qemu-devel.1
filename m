Received: from eggs.gnu.org ([2001:4830:134:3::10]:57969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csW2R-00086t-VB
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csW2Q-0000P4-WE
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:54:32 -0400
References: <20170322210005.16533-1-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <79735a02-6794-365a-2ef2-68c60b6419cd@redhat.com>
Date: Mon, 27 Mar 2017 16:54:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170322210005.16533-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pmtfc4c4tAqAKdxWFbK17MBUipC1xB6Tt"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9?] file-posix: Make
 bdrv_flush() failure permanent without O_DIRECT
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
--pmtfc4c4tAqAKdxWFbK17MBUipC1xB6Tt
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <79735a02-6794-365a-2ef2-68c60b6419cd@redhat.com>
Subject: Re: [Qemu-block] [PATCH for-2.9?] file-posix: Make bdrv_flush()
 failure permanent without O_DIRECT
References: <20170322210005.16533-1-kwolf@redhat.com>
In-Reply-To: <20170322210005.16533-1-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22.03.2017 22:00, Kevin Wolf wrote:
> Success for bdrv_flush() means that all previously written data is safe=

> on disk. For fdatasync(), the best semantics we can hope for on Linux
> (without O_DIRECT) is that all data that was written since the last cal=
l
> was successfully written back. Therefore, and because we can't redo all=

> writes after a flush failure, we have to give up after a single
> fdatasync() failure. After this failure, we would never be able to make=

> the promise that a successful bdrv_flush() makes.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Thanks, applied to my block branch for 2.9:

https://github.com/XanClic/qemu/commits/block

Max


--pmtfc4c4tAqAKdxWFbK17MBUipC1xB6Tt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljZJ6ESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A3icIAKgfKHO/n8IrMdYZtyc+iD9VEXFdZ7sR
d3yH+nKlkDVbj5zHn9jkDrtEIgTryIiEiV3kdnCk3WiTj3rzJOungiC1YlimwogE
i0tD8Kd7wSlg+qVQpEgarkK7vioelfhK03ASi+mywHNkCUWzjzAayAbXRy7E8LKd
OQ1zwxi55c0wkPn83RAJGuBQJZu5SVB/S9UVpNoPaUBkWrRtqeDf5sD6CAlEEpmj
YJ66+CngCQmRE8b/qLY6InHsJz9LeqpjjnU8hkNva4R3z07cJUmvNju1yX5b4JVk
EsCBmwWMf96qtF7SHQNVNzX3jMBb5XnfhEa7/tpSS6oX57xff95+4ys=
=Ugvb
-----END PGP SIGNATURE-----

--pmtfc4c4tAqAKdxWFbK17MBUipC1xB6Tt--
