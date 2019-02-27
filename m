Received: from eggs.gnu.org ([209.51.188.92]:50949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzTy-00050b-SX
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzQ6-0007n3-Jr
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:38:47 -0500
References: <1549974951-731285-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<5c72aad4-d1bc-7241-a972-32dd07ef23b0@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <efdc687a-239e-3f30-c2d8-e46a47029496@redhat.com>
Date: Wed, 27 Feb 2019 14:00:10 +0100
MIME-Version: 1.0
In-Reply-To: <5c72aad4-d1bc-7241-a972-32dd07ef23b0@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RJDNkl2kmpgvNSIWRXpxzk6JhaX67iGLj"
Subject: Re: [Qemu-devel] [PATCH] Discard old bitmap directories in QCOW2
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RJDNkl2kmpgvNSIWRXpxzk6JhaX67iGLj
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <efdc687a-239e-3f30-c2d8-e46a47029496@redhat.com>
Subject: Re: [PATCH] Discard old bitmap directories in QCOW2 image
References: <1549974951-731285-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <5c72aad4-d1bc-7241-a972-32dd07ef23b0@virtuozzo.com>
In-Reply-To: <5c72aad4-d1bc-7241-a972-32dd07ef23b0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.02.19 16:36, Vladimir Sementsov-Ogievskiy wrote:
> 12.02.2019 15:35, Andrey Shinkevich wrote:
>> Clean QCOW2 image from bitmap obsolete directory when a new one
>> is allocated and stored. It slows down the image growth a little bit.
>> The flag QCOW2_DISCARD_ALWAYS allows a call to raw_co_pdiscard()
>> that does the actual cleaning of the image on disk.
>> With the flag QCOW2_DISCARD_OTHER, a reference count of the cluster
>> is updated only.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> side question: should not we change discard_passthrough[QCOW2_DISCARD_O=
THER] to
> true or at least flags&BDRV_O_UNMAP by default? What is the reason of n=
ot discarding
> things in qcow2-cluster?

As far as I remember the reason is that whenever you clean up something
its cluster is probably going to be reused rather soon.  So cleaning up
takes longer, repopulating that cluster takes longer, and you save only
rather little space.

This is also why I don't know whether this patch makes much sense.

Max


--RJDNkl2kmpgvNSIWRXpxzk6JhaX67iGLj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlx2idsACgkQ9AfbAGHV
z0DdBAf+LkdxWjpeLypUre55Z+36xco1mA9+ffkbeC9XfqYYMW5kNrHxZ1H7hu8Z
ptONoIKqNmry5VVKomiJgYniGcU1hGK88Uherq7XtEFqjXUC9ELceQZQloI2wDB2
e2yGKtPPvIQIk928hX8YmnTfkH0Nza1jAnLg8//VAJRE8FS55TiGBNq7cXUY7A0/
cAi0vO7MLe5YPfJpG7IkWJ8h7/MCTp0B2qwjXF54yXhMry690bsl4a4NPWwQMitM
kLkXWZorJUp0nvISCxN8HzMLKicOUwFVbVn8I068go0ghdzXxGI+QxChradc4oJ7
FTjDjJ+oVedA6uJH4b0VaSGorTsaxg==
=U9H0
-----END PGP SIGNATURE-----

--RJDNkl2kmpgvNSIWRXpxzk6JhaX67iGLj--
