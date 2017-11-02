Received: from eggs.gnu.org ([2001:4830:134:3::10]:33542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAJh4-0002Ml-Vj
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAJh3-0005HU-WB
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:54:19 -0400
References: <20171101154204.27146-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b3661dd-0ace-9040-e8ae-1983b3f63e3d@redhat.com>
Date: Thu, 2 Nov 2017 12:54:10 -0500
MIME-Version: 1.0
In-Reply-To: <20171101154204.27146-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7TJlGD8CttgjdqUsCOrowt4pWGheA3sAR"
Subject: Re: [Qemu-devel] [PATCH 1/2] nbd/server: fix
 nbd_negotiate_handle_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7TJlGD8CttgjdqUsCOrowt4pWGheA3sAR
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: den@openvz.org
Message-ID: <9b3661dd-0ace-9040-e8ae-1983b3f63e3d@redhat.com>
Subject: Re: [PATCH 1/2] nbd/server: fix nbd_negotiate_handle_info
References: <20171101154204.27146-1-vsementsov@virtuozzo.com>
In-Reply-To: <20171101154204.27146-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/01/2017 10:42 AM, Vladimir Sementsov-Ogievskiy wrote:

It's best to send a 0/2 cover letter for a series, even when both
patches are small, as that helps automation tools.

> namelen should be here, lenght is unrelated.

s/lenght/length/

Broken in introduction in commit f37708f6; hence adding qemu-stable in cc=
=2E

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/nbd/server.c b/nbd/server.c
> index 70b40ed27e..7fcec0af7e 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -433,7 +433,7 @@ static int nbd_negotiate_handle_info(NBDClient *cli=
ent, uint32_t length,
> =20
>      /* Don't bother sending NBD_INFO_NAME unless client requested it *=
/
>      if (sendname) {
> -        rc =3D nbd_negotiate_send_info(client, opt, NBD_INFO_NAME, len=
gth, name,
> +        rc =3D nbd_negotiate_send_info(client, opt, NBD_INFO_NAME, nam=
elen, name,

Interestingly enough, length =3D=3D 0 at this point, so we would always
report that the export name is '' (aka the default export), without
actually being a protocol violation.  Doesn't hurt qemu as a client,
since we don't ask for NBD_INFO_NAME, but may break other NBD client
implementations, if they then use NBD_OPT_GO on the '' name expecting it
to resolve to the same non-empty name they just queried on NBD_OPT_INFO.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7TJlGD8CttgjdqUsCOrowt4pWGheA3sAR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln7W8IACgkQp6FrSiUn
Q2qKTAf9GMQffgI/LqwIqGPVl9T+8jDz7/sRAAwMavXfAagt8izd9DvXxdn5BFFa
VmILOoUxurnbVWMYzjP2ekEti1fReblkI9uA1+mUuRQlk80KdU+1vGHs9hIj0p8z
KpxPiWlUzoI/2cOOY/HTGtCBjbNEBwkQ69gnbYhX5ozPBl/j2zp1WxWHwugwir+G
HY7puVJRBr0HQgOSXbpMkZFBT3fPAYGe2t++tCtEapLonWjhgIWgJDQAzZto4vLm
LiwzEfWQ6toc3WMvYnMy5LVp699i9bX3TMNd2T8HPdreH29uVPAbv89zA3p82c5B
u1u7UK/nFlpX8Etk3dOPYiVa70Yr9A==
=mLE7
-----END PGP SIGNATURE-----

--7TJlGD8CttgjdqUsCOrowt4pWGheA3sAR--
