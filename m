Received: from eggs.gnu.org ([2001:4830:134:3::10]:39596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cROE4-0003gr-8i
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:06:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cROE3-0007zs-Fl
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:06:24 -0500
References: <20161130011851.24696-1-mreitz@redhat.com>
	<20161130011851.24696-4-mreitz@redhat.com>
	<600b2a2e-d127-f8a0-e850-80e77594c375@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <36ab608e-93a2-949e-e9c8-ad78ff6d3a8b@redhat.com>
Date: Wed, 11 Jan 2017 20:06:12 +0100
MIME-Version: 1.0
In-Reply-To: <600b2a2e-d127-f8a0-e850-80e77594c375@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TBhka1LwQQbpxfXJVO3EkXUItxBBfVXF0"
Subject: Re: [Qemu-devel] [PATCH v3 03/25] block: Add BDS.backing_overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TBhka1LwQQbpxfXJVO3EkXUItxBBfVXF0
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <36ab608e-93a2-949e-e9c8-ad78ff6d3a8b@redhat.com>
Subject: Re: [PATCH v3 03/25] block: Add BDS.backing_overridden
References: <20161130011851.24696-1-mreitz@redhat.com>
 <20161130011851.24696-4-mreitz@redhat.com>
 <600b2a2e-d127-f8a0-e850-80e77594c375@redhat.com>
In-Reply-To: <600b2a2e-d127-f8a0-e850-80e77594c375@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.01.2017 20:00, Eric Blake wrote:
> On 11/29/2016 07:18 PM, Max Reitz wrote:
>> If the backing file is overridden, this most probably does change the
>> guest-visible data of a BDS. Therefore, we will need to consider this =
in
>> bdrv_refresh_filename().
>>
>> Adding a new field to the BDS is not nice, but it is very simple and
>> exactly keeps track of whether the backing file has been overridden.
>>
>> This commit adds a FIXME which will be remedied by a follow-up commit.=

>> Until then, the respective piece of code will not result in any behavi=
or
>> that is worse than what we currently have.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
>> +++ b/include/block/block_int.h
>> @@ -461,6 +461,7 @@ struct BlockDriverState {
>>      char backing_file[PATH_MAX]; /* if non zero, the image is a diff =
of
>>                                      this file image */
>>      char backing_format[16]; /* if non-zero and backing_file exists *=
/
>> +    bool backing_overridden; /* backing file has been specified by th=
e user */
>=20
> Should we group all of the bool in this struct so as to reduce its size=

> and improve cache locality?  But it's already clunky, so that may be
> appropriate as a separate patch.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Yep, makes sense, but we should do that in a separate patch.

(Or maybe we should fix the compiler to automatically do that
reordering? O:-))

Max


--TBhka1LwQQbpxfXJVO3EkXUItxBBfVXF0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh2giUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Al68IAIABBEhQNQ8qEqvh0AQPM7L/tXDOSSdx
3I8clI5Ji4adZm3Ee1kcBz2VgtHslIHJQFr4AAG2O7MMj6Wk8mwuOoH7XP5FPd9y
sav90RMx/ffg8QKtikndNDYUEONGo4Cf5cQYQOyQwoUhgD3oSJejO9rDDd10J8gT
gNdfsWIpJqKO49VD7s4u5UQb6LiCPnszOdaMGCtWUZNm6nXQS834icB+Mk3+n1os
mjodbjJdHRK8QCmQ7zlL783gID3QpfaUdzRXdPhx7LBZYZepXeqZBimkcje9Sa57
u5vryf+6a+KsEkNqgaLtKtL9X8Z4Uz3auWcwtYcDSN49gDMdEXDMTto=
=K9Ux
-----END PGP SIGNATURE-----

--TBhka1LwQQbpxfXJVO3EkXUItxBBfVXF0--
