Received: from eggs.gnu.org ([2001:4830:134:3::10]:52574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehdEe-0004QN-1f
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehdDa-0003uh-06
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:26:39 -0500
References: <20180122104100.3674-1-vsementsov@virtuozzo.com>
	<7a5ef265-c266-21e7-f82d-bee77062111c@redhat.com>
	<9ac62cef-4331-a828-5c4d-b7a2fdd7b6b5@redhat.com>
	<cbeff34d-b676-3663-654c-e7a224b389b0@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <90c3ab12-1bda-c3a4-fdbf-626fcefaa7ca@redhat.com>
Date: Fri, 2 Feb 2018 16:23:06 +0100
MIME-Version: 1.0
In-Reply-To: <cbeff34d-b676-3663-654c-e7a224b389b0@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HUsaCP55T5miAth9EN3Lf9CuhmTuJD4qM"
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
--HUsaCP55T5miAth9EN3Lf9CuhmTuJD4qM
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com,
 mnestratov@virtuozzo.com
Message-ID: <90c3ab12-1bda-c3a4-fdbf-626fcefaa7ca@redhat.com>
Subject: Re: [PATCH v2] block: maintain persistent disabled bitmaps
References: <20180122104100.3674-1-vsementsov@virtuozzo.com>
 <7a5ef265-c266-21e7-f82d-bee77062111c@redhat.com>
 <9ac62cef-4331-a828-5c4d-b7a2fdd7b6b5@redhat.com>
 <cbeff34d-b676-3663-654c-e7a224b389b0@virtuozzo.com>
In-Reply-To: <cbeff34d-b676-3663-654c-e7a224b389b0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-02 16:18, Vladimir Sementsov-Ogievskiy wrote:
> 31.01.2018 22:04, Max Reitz wrote:
>> On 2018-01-29 19:43, Max Reitz wrote:
>>> On 2018-01-22 11:41, Vladimir Sementsov-Ogievskiy wrote:
>>>> To maintain load/store disabled bitmap there is new approach:
>>>>
>>>> =C2=A0 - deprecate @autoload flag of block-dirty-bitmap-add, make it=
 ignored
>>>> =C2=A0 - store enabled bitmaps as "auto" to qcow2
>>>> =C2=A0 - store disabled bitmaps without "auto" flag to qcow2
>>>> =C2=A0 - on qcow2 open load "auto" bitmaps as enabled and others
>>>> =C2=A0=C2=A0=C2=A0 as disabled (except in_use bitmaps)
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>>> ---
>>> Thanks, looks very reasonable.=C2=A0 Applied to my block branch:
>>>
>>> https://github.com/XanClic/qemu/commits/block
>> ...aaand I've only just now seen that iotest 176 will need to be fixed=

>> along with this, so I'm going to unqueue this patch for now.
>=20
> ohh, sorry for that. Will resend today.
>=20
>>
>> And when I'm already at it: Should we add deprecation information to
>> qemu-doc.texi?
>=20
> didn't find anything in qemu-doc.texi about dirty bitmaps, so I think, =
no.

I mean in the "Deprecated features" appendix.  I think whenever we
deprecate something, it should be noted there (as far as I've understood)=
=2E

(Also on the Wiki, I think.)

> Is there a way to generate some documentation files from qapi comments?=

> Where is it?

There is docs/interop/qemu-qmp-qapi.texi in the build directory.

Max


--HUsaCP55T5miAth9EN3Lf9CuhmTuJD4qM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp0gloSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ap2cH/290GVQ0FXQj6JC0euSCPpe5iHAQbH1N
O1puHfHTx9JDb83h7Gy+U9Rn9yf9P8cKbLTJvLo7IsK0H7wxYYFTUagZkCsvCw5a
zLb3zMzAtsFZgEg/82f1BMe+KJT9BdgqaxyPJAPA5N+hhasj2S2C6gJzCyNgUcLH
ndBJc4IJOISz4Pc6qfduOJ/lQ9Ld5yRxVlcvRqgY139Wth76Fz8YyGKqa+X1v1bE
PaHNU1sXcgQbOgvQiqDn4gT2FLxIAs73x9aeeyKJTZmgaKNDdmXIZf+D9mjC8Dal
0j193yKFAs/T5D+IU2R4uTLhD4S8AMWQA29xePQNk0UmXzQ0FbH6y3U=
=d7VC
-----END PGP SIGNATURE-----

--HUsaCP55T5miAth9EN3Lf9CuhmTuJD4qM--
