Received: from eggs.gnu.org ([2001:4830:134:3::10]:39977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS0ij-0000sI-3v
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS0ii-0000Ry-4H
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:44:53 -0400
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b7fd85ab-f52c-dff3-67c6-bd62c17a2fa2@redhat.com>
Date: Mon, 3 Jul 2017 07:44:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170703122505.32017-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wN440at3H9FsOkOgvxEGLT1iiNh8nx5Lt"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wN440at3H9FsOkOgvxEGLT1iiNh8nx5Lt
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <b7fd85ab-f52c-dff3-67c6-bd62c17a2fa2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qapi: Add qobject_is_equal()
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-3-mreitz@redhat.com>
In-Reply-To: <20170703122505.32017-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2017 07:25 AM, Max Reitz wrote:
> This generic function (along with its implementations for different
> types) determines whether two QObjects are equal.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

> +++ b/qobject/qnum.c

> +    case QNUM_DOUBLE:
> +        switch (num_y->kind) {
> +        case QNUM_I64:
> +            return qnum_is_equal(y, x);
> +        case QNUM_U64:
> +            return qnum_is_equal(y, x);
> +        case QNUM_DOUBLE:
> +            /* Comparison in native double type */
> +            return num_x->u.dbl =3D=3D num_y->u.dbl;

Which returns false if we allow NaN (in general, JSON does not, so I'm
not sure if we allow NaN in a QNum)

> +++ b/qobject/qobject.c

> +bool qobject_is_equal(const QObject *x, const QObject *y)
> +{
> +    /* We cannot test x =3D=3D y because an object does not need to be=

> +     * equal to itself (e.g. NaN floats are not). */

But this comment matches the code above in QNum.

> +
> +    if (!x && !y) {
> +        return true;
> +    }
> +
> +    if (!x || !y || x->type !=3D y->type) {
> +        return false;
> +    }

I like that there is no implicit conversion between bool and int; the
only conversions that still allow equality are within the subtypes of QNu=
m.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wN440at3H9FsOkOgvxEGLT1iiNh8nx5Lt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWjw5AAoJEKeha0olJ0NqvoAIAJSFmGcvoPGn1xHUaXLSJDnI
ZqVOm1aeHpc8iYp/swp6dLCpjNMzp+TY7wzBZjzN3lp+JrBXbXSy9GWNfKKy/H//
KxTml1Bstzcva0yGR0wEDpUlc6mlwIXKDkSC5g5UYd41RhKNuHUNhpbcMU3xuYPV
tcxJCl8tdQ5ftfTO6jv7J21UgMo+fD0m1RVX7Ti9IKoTKZpEL2PCdKKymcM2OdzR
yzobh0tOp/TObHWXUgBbpHvWYKy0LoM4Ri8IaQtVD5ql4RDUosemZRRk9IzzGgE+
6Ja9/RYP/rUxAtxPPukKLXddeCOyb+J01BlrTUSeFhNIUDE6b8ovy4/iijvbR+A=
=QnH+
-----END PGP SIGNATURE-----

--wN440at3H9FsOkOgvxEGLT1iiNh8nx5Lt--
