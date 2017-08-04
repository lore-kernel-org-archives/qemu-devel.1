Received: from eggs.gnu.org ([2001:4830:134:3::10]:38968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddhrk-0003al-QV
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 15:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddhrk-0007vR-1C
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 15:02:32 -0400
References: <20170804152655.31510-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c608a5c2-720c-7c20-6e1d-0a29cb483664@redhat.com>
Date: Fri, 4 Aug 2017 14:02:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170804152655.31510-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9arbgwG2lxDKCbMqVRg47Qnbt3bTS34xT"
Subject: Re: [Qemu-devel] [PATCH] block: drop bdrv_set_key from BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9arbgwG2lxDKCbMqVRg47Qnbt3bTS34xT
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Message-ID: <c608a5c2-720c-7c20-6e1d-0a29cb483664@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: drop bdrv_set_key from BlockDriver
References: <20170804152655.31510-1-pbonzini@redhat.com>
In-Reply-To: <20170804152655.31510-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:26 AM, Paolo Bonzini wrote:
> This is not used anymore since c01c214b69 ("block: remove all encryptio=
n
> handling APIs", 2017-07-11).
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/block/block_int.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index d4f4ea7584..7571c0aaaf 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -127,7 +127,6 @@ struct BlockDriver {
>                            Error **errp);
>      void (*bdrv_close)(BlockDriverState *bs);
>      int (*bdrv_create)(const char *filename, QemuOpts *opts, Error **e=
rrp);
> -    int (*bdrv_set_key)(BlockDriverState *bs, const char *key);
>      int (*bdrv_make_empty)(BlockDriverState *bs);
> =20
>      void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options=
);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9arbgwG2lxDKCbMqVRg47Qnbt3bTS34xT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmExL0ACgkQp6FrSiUn
Q2oPNwf/TwMuMwSu3IA+cexePIV+i5OFoT3ih2zMKcx8eH8SlCO7rqxivaYozkLA
V0HnIgFl9qZMYm2M5z6XyhZK3AhP781uCLLv35Jm0gDh7/jPssNWPLCH9hPCt/KU
jnLF+w5GcDZPK6gnqQAaD6+u23yvMG6wrR1eb0VwYTVjFXyYR47E0mKl150CbCaG
1QQYETZNqgIpuBMsg3HiF7Qgea9n9p9h6emuyvz4x8K1T4HzLQHtH+eIjf5ZcvYj
OpjsTbQsCXoAEMBdFO3KuMKiu8y2lAzsfNDkCt4VVtYZvIpx6pQGj/kEI6FoIzEc
HGzLcdzmtTWBkbmZJcLf7n2JKqHkEg==
=cqhX
-----END PGP SIGNATURE-----

--9arbgwG2lxDKCbMqVRg47Qnbt3bTS34xT--
