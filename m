Received: from eggs.gnu.org ([2001:4830:134:3::10]:54769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUafg-0004ZI-Bt
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUaff-0002An-BL
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:32:24 -0400
References: <20170710150559.30163-1-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0d456c94-180c-089a-8379-e50e4482901a@redhat.com>
Date: Mon, 10 Jul 2017 10:32:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170710150559.30163-1-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wEeokI3Gh4LEdlg6Cx1uRuJ6D8J0VBG9I"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] block: fix shadowed variable in
 bdrv_co_pdiscard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wEeokI3Gh4LEdlg6Cx1uRuJ6D8J0VBG9I
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <0d456c94-180c-089a-8379-e50e4482901a@redhat.com>
Subject: Re: [PATCH v2 1/1] block: fix shadowed variable in bdrv_co_pdiscard
References: <20170710150559.30163-1-den@openvz.org>
In-Reply-To: <20170710150559.30163-1-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/10/2017 10:05 AM, Denis V. Lunev wrote:
> We've had a shadowed 'ret' variable, which risks returning the wrong
> value, introduced in commit b9c64947.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> ---
>  block/io.c | 1 -
>  1 file changed, 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/block/io.c b/block/io.c
> index 23170a57ee..87208990c4 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2327,7 +2327,6 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverStat=
e *bs, int64_t offset,
>      assert(max_pdiscard >=3D bs->bl.request_alignment);
> =20
>      while (bytes > 0) {
> -        int ret;
>          int num =3D bytes;
> =20
>          if (head) {
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wEeokI3Gh4LEdlg6Cx1uRuJ6D8J0VBG9I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZY532AAoJEKeha0olJ0NqAGwH/0/wJDmUUYKx4G8NXzloaTeA
KqzcpcVlISTU5bZxueFMPi5k+5el9vd370lwXD10UFgJ73A41bpjuz5AufFLT5HV
2d2EdAoTaWg9cH0GbUR0TLPU6pQRTbd9Cyq00ZU8PEO+zu+7ZVjtt6SSL/MXFuyL
OKvQiw5tsC8ClszpiYAXUBwF7Kwtdi/cxlVtA+T/+oUctwRTjCWt5V8exjSrGYuH
AS0vmPjnCLK9w/TplIEuqtKKzrhmHVmwzdu4HGyvxtFPZ4lHZToUv5Pcf7gqT+hq
XgQ64OCIYEJQo0K7QlDMDbpC0Qw6nWoLumKfVyOfZZkOUL9irLnTrrDsB+rtmto=
=jiUi
-----END PGP SIGNATURE-----

--wEeokI3Gh4LEdlg6Cx1uRuJ6D8J0VBG9I--
