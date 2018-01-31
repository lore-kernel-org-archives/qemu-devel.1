Received: from eggs.gnu.org ([2001:4830:134:3::10]:40563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egxgM-0006yE-Ej
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egxgK-0006iq-Fx
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:04:30 -0500
References: <20180122104100.3674-1-vsementsov@virtuozzo.com>
	<7a5ef265-c266-21e7-f82d-bee77062111c@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9ac62cef-4331-a828-5c4d-b7a2fdd7b6b5@redhat.com>
Date: Wed, 31 Jan 2018 20:04:06 +0100
MIME-Version: 1.0
In-Reply-To: <7a5ef265-c266-21e7-f82d-bee77062111c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C4xFuF6IMhKOBNAb4COlrcDLHpmAZrxp1"
Subject: Re: [Qemu-devel] [PATCH v2] block: maintain persistent disabled
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C4xFuF6IMhKOBNAb4COlrcDLHpmAZrxp1
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com,
 mnestratov@virtuozzo.com
Message-ID: <9ac62cef-4331-a828-5c4d-b7a2fdd7b6b5@redhat.com>
Subject: Re: [PATCH v2] block: maintain persistent disabled bitmaps
References: <20180122104100.3674-1-vsementsov@virtuozzo.com>
 <7a5ef265-c266-21e7-f82d-bee77062111c@redhat.com>
In-Reply-To: <7a5ef265-c266-21e7-f82d-bee77062111c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-29 19:43, Max Reitz wrote:
> On 2018-01-22 11:41, Vladimir Sementsov-Ogievskiy wrote:
>> To maintain load/store disabled bitmap there is new approach:
>>
>>  - deprecate @autoload flag of block-dirty-bitmap-add, make it ignored=

>>  - store enabled bitmaps as "auto" to qcow2
>>  - store disabled bitmaps without "auto" flag to qcow2
>>  - on qcow2 open load "auto" bitmaps as enabled and others
>>    as disabled (except in_use bitmaps)
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> Reviewed-by: John Snow <jsnow@redhat.com>
>> ---
>=20
> Thanks, looks very reasonable.  Applied to my block branch:
>=20
> https://github.com/XanClic/qemu/commits/block

=2E..aaand I've only just now seen that iotest 176 will need to be fixed
along with this, so I'm going to unqueue this patch for now.

And when I'm already at it: Should we add deprecation information to
qemu-doc.texi?

Max


--C4xFuF6IMhKOBNAb4COlrcDLHpmAZrxp1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyEyYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AAzkIALb2abXzI2Svh8OtazHMOUxhuj91pAXK
a3GnfOfX4sab+tqjrsfQdFJzq+ci4GmgWio/i8rV78Nx0SYS22qVy7zHmcY+LxNm
wrUZA/oHPMWOxml9g1GSKus0TB4sdnXjSA+ZbS7RR9FXnr6BjkID5pPtaNxvbsAl
w4EXNf1NomLBnFOuvPiO1pVNiLHk2zW41wFbeen2txVDx+Mt9N36kIKqlZZLIkr4
hULhr5rT/Yz2n4UK/+Xe/rWsJiPgDeQDy852stKB8imfBCvGaQ0srQf58SzYHPRS
LGYRQZqsTU2mn19GYsRIgnRPe6NUkdm40/c2dS6rkhnIqasv3KVeRQE=
=zrf7
-----END PGP SIGNATURE-----

--C4xFuF6IMhKOBNAb4COlrcDLHpmAZrxp1--
