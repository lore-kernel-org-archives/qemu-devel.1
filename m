Received: from eggs.gnu.org ([2001:4830:134:3::10]:54602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHe0q-0007Qu-KV
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 18:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHe0p-0004g7-LP
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 18:01:00 -0500
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
	<20171122101958.17065-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ec347fad-3a8e-8ff0-cfc5-ffb6b8e60600@redhat.com>
Date: Wed, 22 Nov 2017 17:00:51 -0600
MIME-Version: 1.0
In-Reply-To: <20171122101958.17065-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Uoa9HBPfiKeppLbnXuNpumXl3W4o0eM7X"
Subject: Re: [Qemu-devel] [PATCH 3/5] nbd/server: add helper nbd_opt_invalid
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
--Uoa9HBPfiKeppLbnXuNpumXl3W4o0eM7X
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org
Message-ID: <ec347fad-3a8e-8ff0-cfc5-ffb6b8e60600@redhat.com>
Subject: Re: [PATCH 3/5] nbd/server: add helper nbd_opt_invalid
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
 <20171122101958.17065-4-vsementsov@virtuozzo.com>
In-Reply-To: <20171122101958.17065-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/22/2017 04:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 74 +++++++++++++++++++++++++++++++++++++---------------=
--------
>  1 file changed, 46 insertions(+), 28 deletions(-)
>=20

> @@ -418,8 +447,8 @@ static int nbd_negotiate_handle_info(NBDClient *cli=
ent, uint16_t myflags,
>      be16_to_cpus(&requests);
>      trace_nbd_negotiate_handle_info_requests(requests);
>      if (requests !=3D client->optlen / sizeof(request)) {
> -        msg =3D "incorrect number of  requests for overall length";
> -        goto invalid;
> +        return nbd_opt_invalid(
> +            client, errp, "incorrect number of requests for overall le=
ngth");

Nice that you are fixing the typo of the double space in the error messag=
e.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Uoa9HBPfiKeppLbnXuNpumXl3W4o0eM7X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloWAaMACgkQp6FrSiUn
Q2oPswf+KPMICBMlYxgj4/pOZ40TjVIaEPn0ilIEqZbV4K7jd2T6tYXbuu3kNyCn
3Vy+VQzdds9Odjz9DH20rjwabGtjo2e2M3DIVYZJ6UY6hs0gZBhHoH0FGkfHwYVf
kCtFFN8bC9p3QvAuM578bWXxJemtz3V8BaKdJG8zGJ0zRfQ8R4rTdbcM13OK7F/j
/s48tlKta6j6w0IPKnHmj/FXPf8bbGNjWUwIIq1fRB3RwJWcKu9m0sOclDGCeCIb
1WTaZJFjuUbK4jc0AZcJL2DxKXWZToGUdkA/KFCOcRZ1ssPR6byuY7HhtLBRSZKN
BCJmPnWWo4lT0FJPMH4e4fwRWvJLig==
=VjXw
-----END PGP SIGNATURE-----

--Uoa9HBPfiKeppLbnXuNpumXl3W4o0eM7X--
