Received: from eggs.gnu.org ([2001:4830:134:3::10]:53764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHd6S-0006NQ-PK
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 17:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHd6R-0000XL-FI
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 17:02:44 -0500
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
	<20171122101958.17065-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9104d2de-e723-9a16-09bc-5c69d6d0c880@redhat.com>
Date: Wed, 22 Nov 2017 16:02:34 -0600
MIME-Version: 1.0
In-Reply-To: <20171122101958.17065-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="950VKmvjM5GlKfSwUlOi0l1KbTrksjqtI"
Subject: Re: [Qemu-devel] [PATCH 5/5] nbd/server: structurize option reply
 sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--950VKmvjM5GlKfSwUlOi0l1KbTrksjqtI
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org
Message-ID: <9104d2de-e723-9a16-09bc-5c69d6d0c880@redhat.com>
Subject: Re: [PATCH 5/5] nbd/server: structurize option reply sending
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
 <20171122101958.17065-6-vsementsov@virtuozzo.com>
In-Reply-To: <20171122101958.17065-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/22/2017 04:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 40 +++++++++++++---------------------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
>=20

Nice diffstat; shows that this one probably makes sense (even if it will
need rebasing on top of the planned churn for the rest of the series).

> diff --git a/nbd/server.c b/nbd/server.c
> index 79b937d88f..975fe8efe9 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -152,43 +152,29 @@ static inline int nbd_opt_drop(NBDClient *client,=
 size_t size, Error **errp)
>      return nbd_drop(client->ioc, size, errp);
>  }
> =20
> +static inline void set_be_option_rep(NBDOptionReply *rep, uint32_t opt=
ion,
> +                                     uint32_t type, uint32_t length)

'static inline' is probably pointless; the compiler already knows what
static functions are ideal to inline, without us having to name it (I
realize you've already done this in other patches, so I probably ought
to post a cleanup patch that removes 'inline').

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--950VKmvjM5GlKfSwUlOi0l1KbTrksjqtI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloV8/oACgkQp6FrSiUn
Q2rkYggAq9+GqojRf8Sbsoc2oVhVAvNYPEsXJ/d5vUPx0ibSJ/DXyNGxFNMnV8H5
GfpcOgcMYf9r4tGx+Vf4rpVkKHAO79XftrKxUIPPw/q+DrwdyY9c9frGN3FxFn9I
BVlbf+ovLpAeAUCrKZ673YTbsNwFrYyHAZIK0jftPiU5I6kbtjcA1gIfhUN4ByYs
KDIXGkfKTNodNILLgkQJjk/u01QGMHa87KutLf2fccRD9GmRYReUjJpOOxez4Asc
wcqzn/tBBktaVe+dJDrIZEer7+TxaL4EWoGGzrEOx/xuzGpXMzmRghkaf0oE/vj2
umdnKTH3rphrxymh0XOKFI8WcO4rpQ==
=wXRf
-----END PGP SIGNATURE-----

--950VKmvjM5GlKfSwUlOi0l1KbTrksjqtI--
