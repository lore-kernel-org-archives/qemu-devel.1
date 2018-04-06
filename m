Received: from eggs.gnu.org ([2001:4830:134:3::10]:40753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f4TOh-0008Cf-Q9
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f4TOg-0005fC-V6
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:35:27 -0400
References: <20180406151759.11223-1-mreitz@redhat.com>
	<29bf83ee-4ee2-5278-7dd8-31fb50b28842@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <98b43ff7-699a-ff42-3974-ddebef0afb62@redhat.com>
Date: Fri, 6 Apr 2018 17:35:17 +0200
MIME-Version: 1.0
In-Reply-To: <29bf83ee-4ee2-5278-7dd8-31fb50b28842@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NYIcnAwBWgbuICecmD00wGrosGsWY6vWE"
Subject: Re: [Qemu-devel] [PATCH] iotests: 122 needs at least two refcount
 bits now
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NYIcnAwBWgbuICecmD00wGrosGsWY6vWE
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <98b43ff7-699a-ff42-3974-ddebef0afb62@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: 122 needs at least two refcount
 bits now
References: <20180406151759.11223-1-mreitz@redhat.com>
 <29bf83ee-4ee2-5278-7dd8-31fb50b28842@redhat.com>
In-Reply-To: <29bf83ee-4ee2-5278-7dd8-31fb50b28842@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-06 17:32, Eric Blake wrote:
> On 04/06/2018 10:17 AM, Max Reitz wrote:
>> The new test case for compressed clusters (added in commit
>> abd3622cc03cf41ed542126a540385f30a4c0175) requires two refcount bits t=
o
>> succeed, so we need to skip the test when refcount_bits=3D1 was reques=
ted.
>=20
> We already questioned whether the changes to 122 were appropriate, give=
n
> that it didn't even use qemu-img convert.  Should we instead split this=

> into two tests (keeping 122 as it was before, and making the new
> compressed refcount munging tests be separate), where only the new test=

> needs this filter?

Can do, why not.

Max

>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/122 | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
>> index 6cf4fcb866..95e7c51e72 100755
>> --- a/tests/qemu-iotests/122
>> +++ b/tests/qemu-iotests/122
>> @@ -42,6 +42,10 @@ _supported_fmt qcow2
>>  _supported_proto file
>>  _supported_os Linux
>> =20
>> +# Repairing the compressed image requires qemu-img check to store a
>> +# refcount up to 3, which requires at least two refcount bits.
>> +_unsupported_imgopts 'refcount_bits=3D1[^0-9]'
>> +
>=20
> This makes sense, but I'm withholding R-b until we decide if splitting
> the tests is wiser.
>=20



--NYIcnAwBWgbuICecmD00wGrosGsWY6vWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrHk7UACgkQ9AfbAGHV
z0DDlQf/eOZ11tDzEW2iHADiv/2Hth+298ej+vVIAWzBnilghzUojQHGqKk0QM5T
zB4ZKmwuZV9lAfQQsMlEHilcLcbQR+GRpEx5REB6pbnXLI327OGprmB13u+J0Br3
xUC+Plw5VyCREZlz9r7mO8C4kfuUTQ0IE7nbWkc1hjQu7DzrzfUt2lJbAtM+ZoQ0
kJ1OlyQ4h2QjJ3932MUhGsFZTT19kdSwzERiBnhxogxkZaTgEJ9bFogWrWib1Y8+
sDnKRFweIDOrrVDgHPzAcNq/C/0tb9NJKx4i4dSuWpE/ez2iyXg+Z0k8+i3yn+mu
5A9HUl1YwsfBlr68vYYacE/Y/t8/GQ==
=BMzv
-----END PGP SIGNATURE-----

--NYIcnAwBWgbuICecmD00wGrosGsWY6vWE--
