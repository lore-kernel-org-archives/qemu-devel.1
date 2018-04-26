Received: from eggs.gnu.org ([2001:4830:134:3::10]:60388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBj8x-00053q-LU
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBj8u-0008VK-Ew
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:49:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40600 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBj8u-0008VB-98
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:49:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3C0840201A4
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 15:49:06 +0000 (UTC)
References: <20180426152805.8469-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2695025c-30de-720a-4437-348a3bb7911b@redhat.com>
Date: Thu, 26 Apr 2018 10:49:01 -0500
MIME-Version: 1.0
In-Reply-To: <20180426152805.8469-1-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PRnjRmuifh5eYD2lf9jE3jS2MNYD7Vyjq"
Subject: Re: [Qemu-devel] [PATCH] qobject: Use qobject_to() instead of type
 cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PRnjRmuifh5eYD2lf9jE3jS2MNYD7Vyjq
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Message-ID: <2695025c-30de-720a-4437-348a3bb7911b@redhat.com>
Subject: Re: [PATCH] qobject: Use qobject_to() instead of type cast
References: <20180426152805.8469-1-armbru@redhat.com>
In-Reply-To: <20180426152805.8469-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 10:28 AM, Markus Armbruster wrote:
> The proper way to convert from (abstract) QObject to a (concrete)
> subtype is qobject_to().  Look for offenders that type cast instead:
>=20
>     $ git-grep '(Q[A-Z][a-z]* \*)'
>     hmp.c:    qmp_device_add((QDict *)qdict, NULL, &err);
>     include/qapi/qmp/qobject.h:        return (QObject *)obj;
>     qobject/qobject.c:static void (*qdestroy[QTYPE__MAX])(QObject *) =3D=
 {
>     tests/check-qdict.c:    dst =3D (QDict *)qdict_crumple(src, &error_=
abort);
>=20
> The first two cast away const, the third isn't a type cast.  Fix the
> fourth.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/check-qdict.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PRnjRmuifh5eYD2lf9jE3jS2MNYD7Vyjq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrh9O0ACgkQp6FrSiUn
Q2reHQf8CN0PRgpBTH0ZAZhWgp3Yo/i0rsBUZNjNIm4KM6jmOFnz56FPd7A/BHvj
iPnfFd8UBrMA6y40DRTDNdvIY/Yf0TYToa4MqqdHMCSn2lqHk8w5ghNuhuygvoxq
k3jYN1+VFqYFpBbYgsCtl2JXGzOVZmwkE4zlc8NyTyVOFLoci86qRHIELiOpfbZM
QXAzttwRWiaawgRuy6DCT3nA72Bs9v3xz+PICVOdUeXMqF7cYoXtt8kS2R+gjIfl
h3nrFZCGlUs7ZHq8nbFBauRIjT2KlUOOWSeJq0CQQF+4ryZLycz0KPrPeY90yARv
0W9keNSO0JxO5qxVEDb9QR1NSc59qw==
=LjIt
-----END PGP SIGNATURE-----

--PRnjRmuifh5eYD2lf9jE3jS2MNYD7Vyjq--
