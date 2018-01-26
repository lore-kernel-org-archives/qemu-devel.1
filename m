Received: from eggs.gnu.org ([2001:4830:134:3::10]:37847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6tk-0001Fg-AJ
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6tj-00067z-8j
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:30:40 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<07a984cef4f1c97dcca44e365aa90ba5b6881e09.1516978645.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac9633be-5f3a-1176-73e9-fe2235d9729f@redhat.com>
Date: Fri, 26 Jan 2018 10:30:26 -0600
MIME-Version: 1.0
In-Reply-To: <07a984cef4f1c97dcca44e365aa90ba5b6881e09.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yyhNGUkTtH8bohBNX6wlHad51WnYOOIdK"
Subject: Re: [Qemu-devel] [PATCH v3 17/39] qcow2: Update l2_allocate() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yyhNGUkTtH8bohBNX6wlHad51WnYOOIdK
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <ac9633be-5f3a-1176-73e9-fe2235d9729f@redhat.com>
Subject: Re: [PATCH v3 17/39] qcow2: Update l2_allocate() to support L2 slices
References: <cover.1516978645.git.berto@igalia.com>
 <07a984cef4f1c97dcca44e365aa90ba5b6881e09.1516978645.git.berto@igalia.com>
In-Reply-To: <07a984cef4f1c97dcca44e365aa90ba5b6881e09.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 08:59 AM, Alberto Garcia wrote:
> This patch updates l2_allocate() to support the qcow2 cache returning
> L2 slices instead of full L2 tables.
>=20
> The old code simply gets an L2 table from the cache and initializes it
> with zeroes or with the contents of an existing table. With a cache
> that returns slices instead of tables the idea remains the same, but
> the code must now iterate over all the slices that are contained in an
> L2 table.
>=20
> Since now we're operating with slices the function can no longer
> return the newly-allocated table, so it's up to the caller to retrieve
> the appropriate L2 slice after calling l2_allocate() (note that with
> this patch the caller is still loading full L2 tables, but we'll deal
> with that in a separate patch).
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 56 +++++++++++++++++++++++++++++++------------=
--------
>  1 file changed, 34 insertions(+), 22 deletions(-)
>=20

> =20
> -            /* if there was an old l2 table, read it from the disk */
> +            /* if there was an old l2 table, read an slice from the di=
sk */

s/an /a /

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--yyhNGUkTtH8bohBNX6wlHad51WnYOOIdK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlprV6IACgkQp6FrSiUn
Q2o7NQf/fbnioCV0C0/qCjpTciHeo1jcFwuGONgbs3+9ZvHNlsF9aBZiNGN9pB0T
kTJ0kh8qv+Ank9fgsGBODWDASPsHn8gF3QqWwefANonHJp84/iH9aOhzB1Jp9Pfj
2O7HFc4755DJUSNPQf9TyRmiu86zXaBm+S6M0aBqC483GPqJEWWORznZoHmstVGq
JnR/rhmdGweDHsbS6hwFfTkiegbLAt3DfSplvtrV4IJhsVQywQjdzyNiOtBcsFgy
IMtni3pToGXiz3zUU78QKxArzdSrMW9HeHTqA1o+3/L2hY9On00wf0B47pkEDk1F
1ybV3CzN+ZYGync6PjCKQ4gL+6MJig==
=vKKU
-----END PGP SIGNATURE-----

--yyhNGUkTtH8bohBNX6wlHad51WnYOOIdK--
