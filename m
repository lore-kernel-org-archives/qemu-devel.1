Received: from eggs.gnu.org ([2001:4830:134:3::10]:46652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwpq-0007MI-QR
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwpp-0001tk-KV
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:15:42 -0400
References: <20170916185123.29255-1-mreitz@redhat.com>
	<20170916185123.29255-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce840ef8-6489-e0de-cc3c-2a5949205e36@redhat.com>
Date: Mon, 18 Sep 2017 09:15:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170916185123.29255-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="itVBQDPQ4PnpD1XOmvqKNiWONtcjEpGXH"
Subject: Re: [Qemu-devel] [PATCH v5 3/6] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--itVBQDPQ4PnpD1XOmvqKNiWONtcjEpGXH
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <ce840ef8-6489-e0de-cc3c-2a5949205e36@redhat.com>
Subject: Re: [PATCH v5 3/6] qapi: Add qobject_is_equal()
References: <20170916185123.29255-1-mreitz@redhat.com>
 <20170916185123.29255-4-mreitz@redhat.com>
In-Reply-To: <20170916185123.29255-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/16/2017 01:51 PM, Max Reitz wrote:
> This generic function (along with its implementations for different
> types) determines whether two QObjects are equal.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

> +    case QNUM_DOUBLE:
> +        switch (num_y->kind) {
> +        case QNUM_I64:
> +        case QNUM_U64:
> +            return false;
> +        case QNUM_DOUBLE:
> +            /* Comparison in native double type */
> +            return num_x->u.dbl =3D=3D num_y->u.dbl;

I saw comments mentioning the odd behavior of NaN; one other odd
behavior is that this treats -0.0 as equal to 0.0.  But that's fine by
me (it matches C semantics of double =3D=3D double).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--itVBQDPQ4PnpD1XOmvqKNiWONtcjEpGXH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/1QQACgkQp6FrSiUn
Q2rVtQgAk1JxuXuH+h6cg3EV+VT+qJnnYt0wgJqqsA8dChXt8J/quZgyxgCGUBgI
wOBIsj3C/qE02w14vEl39SZNN0/ubBZ31FEzxmartmoVOBX171IcjiyecxUGENED
opmHs4TcHL3No/ECP6NHUyBRh5rvO8d6ZtsLm+nZfuBlsk10tQYHkXKlFBKYCo7n
ycYK2fLEAEu86aHmMFlXue2ctcUTogW4PG4BF8Zq4l/a/8oz1pBbrQG2HasZIUya
250Sf0vaEJUMkRY0GKuAt46CVNzncvVbN2yvdSoqS6nX0uwB5tTactBCPLQdFmtz
zfnp2tt33hSaBn6KuoSbh6+vft/aAA==
=a1zm
-----END PGP SIGNATURE-----

--itVBQDPQ4PnpD1XOmvqKNiWONtcjEpGXH--
