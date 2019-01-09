Received: from eggs.gnu.org ([209.51.188.92]:47922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghDgN-0004hn-7g
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghDgL-0004EY-Bl
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:14:06 -0500
References: <1546200557-774583-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1546200557-774583-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<872d42b0-c794-c104-30a9-fa1296f812d6@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cfeff1a6-f515-f5cf-caa2-fb260c0cddc9@redhat.com>
Date: Wed, 9 Jan 2019 14:13:54 +0100
MIME-Version: 1.0
In-Reply-To: <872d42b0-c794-c104-30a9-fa1296f812d6@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3oJfeooyB0ySxtwuXJcj6R1VQuLPBllAS"
Subject: Re: [Qemu-devel] [PATCH v5 1/6] Stream block job involves
 copy-on-read filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3oJfeooyB0ySxtwuXJcj6R1VQuLPBllAS
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <cfeff1a6-f515-f5cf-caa2-fb260c0cddc9@redhat.com>
Subject: Re: [PATCH v5 1/6] Stream block job involves copy-on-read filter
 driver
References: <1546200557-774583-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1546200557-774583-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <872d42b0-c794-c104-30a9-fa1296f812d6@virtuozzo.com>
In-Reply-To: <872d42b0-c794-c104-30a9-fa1296f812d6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.01.19 14:45, Vladimir Sementsov-Ogievskiy wrote:
> 30.12.2018 23:09, Andrey Shinkevich wrote:
>> The copy-on-read filter is applied to block-stream operation.
>> It is necessary for further block discard option.
>=20
> If we move to c-o-r filter in stream, I think we should:
> 1. get rid of COPY_ON_READ flag in stream code (so, this thing to be do=
ne in one place)
> 2. add base parameter to c-o-r filter, to not copy things that are belo=
w base.
>=20
> Current behavior of stream is enabling copy-on-read on bs during stream=
 if base =3D=3D NULL.
> So, if we just add c-o-r filter, we will copy extra blocks. On the othe=
r hand, if we
> support base parameter in c-o-r filter we will involve guest reads to t=
he stream
> process for cases with base !=3D NULL, so stream operation should becom=
e more efficient.
>=20
> So for me the following sequence seems reasonable:
>=20
> - prepare iotests for graph changes
> - add base parameter to c-o-r filter
> - use c-o-r in stream and drop COPY_ON_READ flag from stream code
>=20
> then (may be in separate series) add discard functionality. And looks l=
ike again, it should
> be property of c-o-r filter, not stream job itself, to involve guest re=
ads to discarding too.
>=20
> In general, Max, is that correspond to what you mean?

Yep, that sounds good to me.

Max


--3oJfeooyB0ySxtwuXJcj6R1VQuLPBllAS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw185IACgkQ9AfbAGHV
z0BsmAf9GYxubR9Q+P3JqZoSoI5a+GUKtFeUR4j8JYrNzO3gBjXK445tbEc6ArbE
3G2ZNDbw6xD8dkTH8PpKziRt7iZxbaDTD380RiQz70LC+UXXBcan/WZO25Xui0/s
ZieIPcUu0IdNsmtyKOgG0d+XPVmZx6nLkAshjl2cRRnIHEobV4wu/24zhvyW3fx9
vzaY+2GJtf1D3UzKqYtQsJwhHevmudc738zovnesD72S4qQsqJHRbB0zwEGNZT4J
L+r0zXZCwsEPhMN8dTKraLIz5EZXmAzOaJh0iDHvkTMjNLtblz6eE/DhkSo/Me/6
1glCO3HPFNdi95n7aqbrHmBlrHS9bg==
=iYKB
-----END PGP SIGNATURE-----

--3oJfeooyB0ySxtwuXJcj6R1VQuLPBllAS--
