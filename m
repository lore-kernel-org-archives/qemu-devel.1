Received: from eggs.gnu.org ([2001:4830:134:3::10]:57702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtyEV-0008Hv-Tj
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtyEV-00077F-1j
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:45:15 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <202ff1d3-f877-ad4a-19e1-15d8f6e6721f@redhat.com>
Date: Mon, 18 Sep 2017 10:45:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170918135935.255591-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wf7I5uavWQhV1L0TUQ6phNr3pLgt1SAUa"
Subject: Re: [Qemu-devel] [PATCH v2 2/7] block/nbd-client: exit
 reply-reading coroutine on incorrect handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wf7I5uavWQhV1L0TUQ6phNr3pLgt1SAUa
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <202ff1d3-f877-ad4a-19e1-15d8f6e6721f@redhat.com>
Subject: Re: [PATCH v2 2/7] block/nbd-client: exit reply-reading coroutine on
 incorrect handle
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
 <20170918135935.255591-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170918135935.255591-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2017 08:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> Check reply-handle =3D=3D request-handle in the same place, where

s/,//

> recv coroutine number is calculated from reply->handle and it's
> correctness checked - in nbd_read_reply_entry.
>=20
> Also finish nbd_read_reply_entry in case of reply-handle !=3D
> request-handle in the same way as in case of incorrect reply-handle.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.h | 1 +
>  block/nbd-client.c | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wf7I5uavWQhV1L0TUQ6phNr3pLgt1SAUa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/6gIACgkQp6FrSiUn
Q2q7owgAkja3yI4kkY3FUyOqF56xxL5D2sfo3foSmuxzAn45gyrpJMDK+eFYqSPQ
VKD9jEEQZ5+U6CAKqq07RyI7EFOqIjNs1HxlEcVSy8ZIVaD3rAHrON92KtzwxYmz
5cYb2E0g7TBcTvFFD2Vd5dKcATT/NOSbZR6sStZCjBIb29aOyKXcwes9Rw23Vrgd
k0ZN8A9VLAgBK1scTjsoxhkTaSmWlvYLGzwAZrNn4Xo7Tj8LyxwJoGNkF2elqQDt
7FgwFhAvy4cSvM0d46nqhobf2kzfDmr9KzEIwp9x03C928g+HtXNzpivonI5dzZC
B0yBLdM67XctBBxN3jD2rgwG9VzA8A==
=zDIn
-----END PGP SIGNATURE-----

--wf7I5uavWQhV1L0TUQ6phNr3pLgt1SAUa--
