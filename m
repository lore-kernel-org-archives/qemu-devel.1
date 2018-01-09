Received: from eggs.gnu.org ([2001:4830:134:3::10]:50879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYzDD-0001fR-Ku
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:05:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYzDC-00011s-G8
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:05:27 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c3d475e-ba19-90d3-263d-a7378d648da5@redhat.com>
Date: Tue, 9 Jan 2018 13:05:10 -0600
MIME-Version: 1.0
In-Reply-To: <20171207155102.66622-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9qrzpsVA6tOTZjVGKLP8B3DjYfg28h8uI"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qapi: add name parameter to
 nbd-server-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9qrzpsVA6tOTZjVGKLP8B3DjYfg28h8uI
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <9c3d475e-ba19-90d3-263d-a7378d648da5@redhat.com>
Subject: Re: [PATCH v2 2/6] qapi: add name parameter to nbd-server-add
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
 <20171207155102.66622-3-vsementsov@virtuozzo.com>
In-Reply-To: <20171207155102.66622-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 09:50 AM, Vladimir Sementsov-Ogievskiy wrote:
> Allow user to specify name for new export, to not reuse internal
> node name and to not show it to clients.
>=20
> This also allows creating several exports per device.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block.json |  9 +++++++--
>  blockdev-nbd.c  | 14 +++++++++-----
>  hmp.c           |  5 +++--
>  3 files changed, 19 insertions(+), 9 deletions(-)
>=20
> diff --git a/qapi/block.json b/qapi/block.json
> index f093fa3f27..503d4b287b 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -213,14 +213,19 @@
>  #
>  # @device: The device name or node name of the node to be exported
>  #
> +# @name: Export name. If unspecified @device parameter used as export =
name.

s/unspecified/unspecified, the/
s/used as/is used as the/

Will tweak as part of applying to my NBD queue.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9qrzpsVA6tOTZjVGKLP8B3DjYfg28h8uI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVEmYACgkQp6FrSiUn
Q2rmKgf/dWeQGiuTjYmRYPtoVWXTlSKTMq7AI8vAOAR29Om/L1N9fNJKvAe1u5sI
sohwdQ8xA5AuChi04KXxhCvqEGxG9yUaWbhxDzA4IbSFGVfm4+FBnYeI+diRS30x
kd7bFE2H31QoQm5TrzPD4LaoI23uYzVlFFElUYcobq5qrPLnNI5R0zDKx6i8/jDS
8Z3JYfMgL8GXasXGi/x89X4ys5yK4kxcEXIGXVqz/1nNGsfxs68vz4CUK24T2UnP
LOcVGdfQLHw5ZACQhGAlOYB1wdfxkmlICAaZHCVieTUqlxsihPzTzbWMXyvU7Ra0
lZSn3TXMPVBJL4oxTaFvp/Y2w3UcAw==
=/JXn
-----END PGP SIGNATURE-----

--9qrzpsVA6tOTZjVGKLP8B3DjYfg28h8uI--
