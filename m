Received: from eggs.gnu.org ([209.51.188.92]:50235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjndv-0003uW-FP
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjndo-00058m-Va
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:02:15 -0500
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
	<20180731173033.75467-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b9866680-39a7-4700-be77-0d0ce3b1f04d@redhat.com>
Date: Wed, 16 Jan 2019 10:01:37 -0600
MIME-Version: 1.0
In-Reply-To: <20180731173033.75467-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KcMVcroBH49fBNW3waXFhOQrfsrSquCrA"
Subject: Re: [Qemu-devel] [PATCH v4 04/10] block/nbd-client: fix
 nbd_reply_chunk_iter_receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KcMVcroBH49fBNW3waXFhOQrfsrSquCrA
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Message-ID: <b9866680-39a7-4700-be77-0d0ce3b1f04d@redhat.com>
Subject: Re: [PATCH v4 04/10] block/nbd-client: fix
 nbd_reply_chunk_iter_receive
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
 <20180731173033.75467-5-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7/31/18 12:30 PM, Vladimir Sementsov-Ogievskiy wrote:
> Use exported report, not the variable to be reused (should not really
> matter).
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index a1813cbfe1..263d1721f9 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -599,7 +599,7 @@ static bool nbd_reply_chunk_iter_receive(NBDClientS=
ession *s,
>      }
> =20
>      /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple r=
eply. */
> -    if (nbd_reply_is_simple(&s->reply) || s->quit) {
> +    if (nbd_reply_is_simple(reply) || s->quit) {
>          goto break_loop;
>      }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--KcMVcroBH49fBNW3waXFhOQrfsrSquCrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/VWEACgkQp6FrSiUn
Q2qD7gf9Ed35FwNykFXWWph5iacO8ek/s4HrcdZOsmsucqcNMhE/Ac8yWo8RLtrn
o/xG1qQTf1FOCE90GlP5+BQM8Y7cBhtBvMc3sVATdKcrciE8vlCKdrgFqQgEn/Z1
p01wJpSNJZ2ML+m+jdfG/Ym7qQDWEw8dkzvdme67reYSFh0y/GiKt2miyTNRRSgI
qDrkfusx4zdlYOxDEZBhJxMhIwYX5G9HZy6d/NNEW/v4Pe6r955hAtyJhmXYcDhp
IJZyES/xsVVbJIio9GjYKHjpFJhm4ma9Wf0rzuZ1BKbdEq6pKWoXocr6MAveG91y
w0ddkzHSmjYUG5mMkL31B+NAjKPuMw==
=SKOy
-----END PGP SIGNATURE-----

--KcMVcroBH49fBNW3waXFhOQrfsrSquCrA--
