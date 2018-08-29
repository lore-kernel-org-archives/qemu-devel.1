Received: from eggs.gnu.org ([2001:4830:134:3::10]:49530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuxkv-0008Tc-M6
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 06:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuxao-0006rc-Tk
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 06:20:55 -0400
References: <cover.1535291602.git.berto@igalia.com>
	<c96c83fefeaf6d586f0c521ddd36b076cd60eaed.1535291602.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <675abc39-6731-ca56-55e4-859fe0923232@redhat.com>
Date: Wed, 29 Aug 2018 12:20:46 +0200
MIME-Version: 1.0
In-Reply-To: <c96c83fefeaf6d586f0c521ddd36b076cd60eaed.1535291602.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9qr1PFj0JTQW8ftncytMhX8h6iiRezE21"
Subject: Re: [Qemu-devel] [PATCH 1/9] qemu-io: Fix writethrough check in
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9qr1PFj0JTQW8ftncytMhX8h6iiRezE21
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <675abc39-6731-ca56-55e4-859fe0923232@redhat.com>
Subject: Re: [PATCH 1/9] qemu-io: Fix writethrough check in reopen
References: <cover.1535291602.git.berto@igalia.com>
 <c96c83fefeaf6d586f0c521ddd36b076cd60eaed.1535291602.git.berto@igalia.com>
In-Reply-To: <c96c83fefeaf6d586f0c521ddd36b076cd60eaed.1535291602.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-26 16:09, Alberto Garcia wrote:
> "qemu-io reopen" doesn't allow changing the writethrough setting of
> the cache, but the check is wrong, causing an error even on a simple
> reopen with the default parameters:
>=20
>    $ qemu-img create -f qcow2 hd.qcow2 1M
>    $ qemu-system-x86_64 -monitor stdio -drive if=3Dvirtio,file=3Dhd.qco=
w2
>    (qemu) qemu-io virtio0 reopen
>    Cannot change cache.writeback: Device attached
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  qemu-io-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 5bf5f28178..db0b3ee5ef 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -2025,7 +2025,7 @@ static int reopen_f(BlockBackend *blk, int argc, =
char **argv)
>          return -EINVAL;
>      }
> =20
> -    if (writethrough !=3D blk_enable_write_cache(blk) &&
> +    if (!writethrough !=3D blk_enable_write_cache(blk) &&

I'd prefer the ! before the blk_enable_write_cache(), because that's how
the initial assignment of writethrough looks, but nobody really cares, so=
:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>          blk_get_attached_dev(blk))
>      {
>          error_report("Cannot change cache.writeback: Device attached")=
;
>=20



--9qr1PFj0JTQW8ftncytMhX8h6iiRezE21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGc34ACgkQ9AfbAGHV
z0CXJwgAs8DFZTdWZTo4H90y367aytlyyPThTSZot5ZyJil+/UYLdyu/3AzhepCN
uu7qYSwO9THUGvjWnIuiEYDyEBoRfAQZW1vkdexIpl9AMBsDXokAiSlm8TPmlBfU
IphxdlqVdUe9lkpJcYCk4ikX02v5rRdYOP+ngSB11SKWNwud2MSa+NhwWQ5XuQgQ
BprT7p1K2WvpwklcL2X7Ns6wQVhKJRr7Bt5IoW9kJxxFSDZns6VIETC0MH8NEgiO
5HhIKrUU16o1ZQZAndDxl+nOrAHL31OHkEyP78bbM5R3ZmQV4jbsykHDssEhhxV8
fygdyTztjpUfLUAHE5d6oi2PqbBMyw==
=GYAG
-----END PGP SIGNATURE-----

--9qr1PFj0JTQW8ftncytMhX8h6iiRezE21--
