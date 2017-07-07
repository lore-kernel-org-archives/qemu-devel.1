Received: from eggs.gnu.org ([2001:4830:134:3::10]:49174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVcE-0000aG-Uj
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTVcA-0006o9-QV
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dTVcA-0006nF-Gm
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:56:18 -0400
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
	<20170707152918.23086-10-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dc454972-cd5e-73f0-d411-b4bb66e949a2@redhat.com>
Date: Fri, 7 Jul 2017 10:56:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170707152918.23086-10-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cH7TjJkWiiN3mIukAoVtVvq9l8SVMkk8O"
Subject: Re: [Qemu-devel] [PATCH v3 09/10] nbd: refactor tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, berrange@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cH7TjJkWiiN3mIukAoVtVvq9l8SVMkk8O
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 den@openvz.org
Message-ID: <dc454972-cd5e-73f0-d411-b4bb66e949a2@redhat.com>
Subject: Re: [PATCH v3 09/10] nbd: refactor tracing
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
 <20170707152918.23086-10-vsementsov@virtuozzo.com>
In-Reply-To: <20170707152918.23086-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 10:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> Reorganize traces: move, reword, add information, drop extra ones.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c |  3 ---
>  nbd/server.c | 30 +++++++++---------------------
>  2 files changed, 9 insertions(+), 24 deletions(-)
>=20

> +++ b/nbd/server.c

> @@ -1039,7 +1043,8 @@ static int nbd_co_receive_request(NBDRequestData =
*req, NBDRequest *request,
>          return -EIO;
>      }
> =20
> -    TRACE("Decoding type");
> +    TRACE("Decoding type: handle =3D %" PRIu64 ", type =3D %" PRIu16,
> +          request->handle, request->type);

Now just prints a number,

> =20
>      if (request->type !=3D NBD_CMD_WRITE) {
>          /* No payload, we are ready to read the next request.  */
> @@ -1049,7 +1054,6 @@ static int nbd_co_receive_request(NBDRequestData =
*req, NBDRequest *request,
>      if (request->type =3D=3D NBD_CMD_DISC) {
>          /* Special case: we're going to disconnect without a reply,
>           * whether or not flags, from, or len are bogus */
> -        TRACE("Request type is DISCONNECT");

where we used to print a name. But for debugging purposes, we can still
figure things out, so not a show-stopper.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cH7TjJkWiiN3mIukAoVtVvq9l8SVMkk8O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX68YAAoJEKeha0olJ0NqtXcH/iz12z6i7rc7xJczzem0o4PE
PKKsYFM+2+jC4QLp/IxCt1Th3RrkHcohIwugqMsVmH3YmAJh0IUCN0sxv/jmaEOu
tRwyeMVg5eNKNiyBT3ti0OULYeygyM6CDqQfR5HIUkL8LLx5MHd04oSJrarkvVu/
hzdX4eTAu4INZ6TmzqtcWPa1ZuNrUOYmRFEb4BkDzWdb7/AVXVV7PULfzI4Q3Tgh
elnhF1LkobM835IhYxcqhoE4HzP++bZLSUrNc7Ou0V+4M0w5h2s/+3XuRgPNmKSL
2X5NPlpVjbOQLGCKIAKU2mtEBp4ysyDuPbjLt408EKum4DZmmL7jpFzWDPwXWMk=
=HyEQ
-----END PGP SIGNATURE-----

--cH7TjJkWiiN3mIukAoVtVvq9l8SVMkk8O--
