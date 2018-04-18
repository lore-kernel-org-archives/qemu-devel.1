Received: from eggs.gnu.org ([2001:4830:134:3::10]:56679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8q5t-0001gG-BT
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8q5s-0001dK-Bp
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:38:05 -0400
References: <20180413143156.11409-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <461d56f3-4381-4cd6-f66d-1dd510c35fa8@redhat.com>
Date: Wed, 18 Apr 2018 11:37:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180413143156.11409-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wNFogd4faKh9fixph79vwXk82t5I1GaZN"
Subject: Re: [Qemu-devel] [PATCH] nbd/server: introduce NBD_CMD_CACHE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wNFogd4faKh9fixph79vwXk82t5I1GaZN
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, pbonzini@redhat.com
Message-ID: <461d56f3-4381-4cd6-f66d-1dd510c35fa8@redhat.com>
Subject: Re: [PATCH] nbd/server: introduce NBD_CMD_CACHE
References: <20180413143156.11409-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180413143156.11409-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2018 09:31 AM, Vladimir Sementsov-Ogievskiy wrote:
> Handle nbd CACHE command. Just do read, without sending read data back.=

> Cache mechanism should be done by exported node driver chain.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h |  3 ++-
>  nbd/server.c        | 10 ++++++----
>  2 files changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index fcdcd54502..b4793d0a29 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -135,6 +135,7 @@ typedef struct NBDExtent {
>  #define NBD_FLAG_SEND_TRIM         (1 << 5) /* Send TRIM (discard) */
>  #define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6) /* Send WRITE_ZEROES */
>  #define NBD_FLAG_SEND_DF           (1 << 7) /* Send DF (Do not Fragmen=
t) */
> +#define NBD_FLAG_SEND_CACHE        (1 << 8) /* Send CACHE (prefetch) *=
/

Hmm, this flag is not documented in the upstream NBD protocol yet; are
we sure it matches the xNBD implementation?  We'll want at least a
documentation patch proposed for the NBD list before taking this.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wNFogd4faKh9fixph79vwXk82t5I1GaZN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrXdGYACgkQp6FrSiUn
Q2rgBgf+Kvio5uHx62e1ZAlEZW6fhnL6gcHFMPPOGggEamrKhQ/BUb1o4oHC4E91
NeUiVdbuionSA7cDHvBmmZSAfXRcqVdo7e9c6pt06wuwa3BJLHnGg7K0XK1y0JOx
lP20CchQxwHNOxrBKUt3F/Nb/IznvPKCOKbpgnFiYp6ZLvwbDG8kooscz1GNYna/
0cfAfcXOmdZf7K2Z1OSQ4/zgnvQmPA62LpySqsOzDzxB04KlsjQNNvFVd3PmELsb
Zw2JhNkRvIbpo/nd64a44a6Z6dnnP5JRUl2PRTXDZNV7bXYYMnISSsIrRvSbNxmJ
OwCCA0WD7R5S1mu12tp8RbmAoGlahw==
=rLjL
-----END PGP SIGNATURE-----

--wNFogd4faKh9fixph79vwXk82t5I1GaZN--
