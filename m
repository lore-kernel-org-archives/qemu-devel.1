Received: from eggs.gnu.org ([2001:4830:134:3::10]:49147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fqkxl-00086Q-IY
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 16:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fqkxk-0007Mv-Q8
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 16:03:13 -0400
References: <153430460784.10304.668502576933473446@502c9da6d61e>
	<91d64820-89d3-c0dc-741b-f6fb13175174@redhat.com>
	<87lg96g87u.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c8e243b1-5940-3c22-1ee0-f9da41883c39@redhat.com>
Date: Fri, 17 Aug 2018 22:03:01 +0200
MIME-Version: 1.0
In-Reply-To: <87lg96g87u.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4VZ1XIsj26FLRJyGdqOZ9SUmZTjsjVx0y"
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 00/31] block: Fix some filename
 generation issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, berto@igalia.com, famz@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4VZ1XIsj26FLRJyGdqOZ9SUmZTjsjVx0y
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, berto@igalia.com,
 famz@redhat.com, qemu-block@nongnu.org
Message-ID: <c8e243b1-5940-3c22-1ee0-f9da41883c39@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 00/31] block: Fix some filename
 generation issues
References: <153430460784.10304.668502576933473446@502c9da6d61e>
 <91d64820-89d3-c0dc-741b-f6fb13175174@redhat.com>
 <87lg96g87u.fsf@dusky.pond.sub.org>
In-Reply-To: <87lg96g87u.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-16 08:02, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> On 2018-08-15 05:43, no-reply@patchew.org wrote:
>>> Hi,
>>>
>>> This series seems to have some coding style problems. See output belo=
w for
>>> more information:
>>
>> [...]
>>
>>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>>> Checking PATCH 1/31: block: Use bdrv_refresh_filename() to pull...
>>> Checking PATCH 2/31: block: Use children list in bdrv_refresh_filenam=
e...
>>> Checking PATCH 3/31: block: Skip implicit nodes for filename info...
>>> Checking PATCH 4/31: block: Add BDS.auto_backing_file...
>>> Checking PATCH 5/31: block: Respect backing bs in bdrv_refresh_filena=
me...
>>> ERROR: return is not a function, parentheses are not required
>>> #46: FILE: block.c:5192:
>>> +        return (bs->auto_backing_file[0] !=3D '\0');
>>>
>>> total: 1 errors, 0 warnings, 136 lines checked
>>
>> Sure, but I'd hate you personally if you omitted them.
>=20
> @@
> expression E;
> @@
> -    return (E);
> +    return E;
>=20
> You're welcome!

Well, I really don't like not putting parenthesis when returning
something that is not an identifier or a function call.

In fact, before I drop the parentheses, I'd drop the "!=3D '\0'", because=

that is optional, too.  (And then I could drop the parentheses anyway.)

Or write it with an explicit if-else (return true - return false).

Max


--4VZ1XIsj26FLRJyGdqOZ9SUmZTjsjVx0y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt3KfUACgkQ9AfbAGHV
z0A1wQf/aHMugEM0t1CXf8sDqkH8CKAGRyHqtH5+vzNa9YDT2NsWx54fewH0dtF4
kk0TGrX7yMadqUKZZoO/kroYqNZLitBHwVDlo667ogFnN6rMUYEcq3Msc+0cSb5l
Jot3GWv2FogfUgx5fH4HsSNoAEfSIMKfnw3jR0MCElpExL2dNPPH5jPSN9lAOiDs
ZjPewN4msbjsk+mtapRPO2UNljnp89/2L09ZX5MXW1StVufanKfu2SDlAoewGcD8
Eh0HaY2qVpssIg+KA/vXTWc3AWzTAgf+FjIFbgDEuXix2rW82vNt4jyzD7DOj+M4
epstsCpIa5jZ7KulgBOSz5lTTkP0lQ==
=OHU0
-----END PGP SIGNATURE-----

--4VZ1XIsj26FLRJyGdqOZ9SUmZTjsjVx0y--
