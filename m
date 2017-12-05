Received: from eggs.gnu.org ([2001:4830:134:3::10]:58256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMF1Q-0004Hr-KP
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMF14-0004lm-8Z
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:20:33 -0500
References: <1511196664-85304-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1511196664-85304-2-git-send-email-anton.nefedov@virtuozzo.com>
	<w51shcp5i0c.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b88c73db-c3a5-014e-0ee8-0ce157642834@redhat.com>
Date: Tue, 5 Dec 2017 09:19:06 -0600
MIME-Version: 1.0
In-Reply-To: <w51shcp5i0c.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bOd8Jo0q0o797o7KBTmP2gpI2D2u40q3o"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/7] qapi: add unmap to
 BlockDeviceStats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bOd8Jo0q0o797o7KBTmP2gpI2D2u40q3o
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, armbru@redhat.com,
 mreitz@redhat.com, pbonzini@redhat.com
Message-ID: <b88c73db-c3a5-014e-0ee8-0ce157642834@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/7] qapi: add unmap to
 BlockDeviceStats
References: <1511196664-85304-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1511196664-85304-2-git-send-email-anton.nefedov@virtuozzo.com>
 <w51shcp5i0c.fsf@maestria.local.igalia.com>
In-Reply-To: <w51shcp5i0c.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2017 09:09 AM, Alberto Garcia wrote:
> On Mon 20 Nov 2017 05:50:58 PM CET, Anton Nefedov wrote:
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>  qapi/block-core.json       | 20 ++++++++++++++++++++
>>  include/block/accounting.h |  1 +
>>  block/qapi.c               |  6 ++++++
>>  3 files changed, 27 insertions(+)
>>

>=20
> Admittedtly this is just a style issue and I don't know what others
> think, but wouldn't it be nicer if the documentation of new fields is
> located together with the existing ones?
>=20
> E.g
>=20
>  @rd_bytes
>  @wr_bytes
> +@unmap_bytes
>  @rd_operations
>  @wr_operations
>  @flush_operations
> +@unmap_operations
>=20

Grouping is fine, and your suggestion makes sense to me.  One of the
nice things of QMP is that since it is name/value based, you don't have
to worry about inserting a name in the middle if that makes more sense
logically (it doesn't break backwards compatibility with old QMP
clients, the way that inserting something into the middle of a C struct
breaks all callers that were using the old struct layout).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bOd8Jo0q0o797o7KBTmP2gpI2D2u40q3o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlomuOoACgkQp6FrSiUn
Q2rgpQf/XN8A8ZV+p5c9YQI9/mY7ir4MQyc1iawZjVeJwvEWLmJ5GqVOaUF13MrF
KyHe6+d5YK+9IeHzTUrGjcU7WEFCqVeaNeVLwP2Cpn7APKlXjZFUXI3NKF8C6aFf
gwKYSJ9QQKrLCBlBKt6svV+L+JpH8M3FX6kaFOsKS08PL7dSzUlIJ7Wtzz7+wd3C
F9PPAbILPSouLdUxT9IwxAhkH4q9eBrC/H4sZVXD5DbYQq/TfYIwbiKkB73D22Ra
YR06C3lLrvFwTd6TE+3RnqplcOyKxNbkzdCKV0uCype8u0uux21pYy0YO45pwaLX
Pf6MrTvCTWthweemgkOgmjqFEIl+AQ==
=Wkaj
-----END PGP SIGNATURE-----

--bOd8Jo0q0o797o7KBTmP2gpI2D2u40q3o--
