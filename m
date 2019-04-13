Received: from eggs.gnu.org ([209.51.188.92]:35209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hF73Q-00061p-3D
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hF73O-0003Hi-UO
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:02:00 -0400
References: <20190410205715.2209-1-mreitz@redhat.com>
	<20190410205715.2209-3-mreitz@redhat.com>
	<acb069c8-5207-368e-e972-baa2ba44d850@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c2ff2802-7093-ca78-da7e-2c68bd0ac91c@redhat.com>
Date: Sat, 13 Apr 2019 03:01:51 +0200
MIME-Version: 1.0
In-Reply-To: <acb069c8-5207-368e-e972-baa2ba44d850@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NV1sfjUkXs4Z42FfYS1cNIR3NHWXgp8vF"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qemu-img: Add salvaging mode to
 convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NV1sfjUkXs4Z42FfYS1cNIR3NHWXgp8vF
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>
Message-ID: <c2ff2802-7093-ca78-da7e-2c68bd0ac91c@redhat.com>
Subject: Re: [PATCH v2 2/6] qemu-img: Add salvaging mode to convert
References: <20190410205715.2209-1-mreitz@redhat.com>
 <20190410205715.2209-3-mreitz@redhat.com>
 <acb069c8-5207-368e-e972-baa2ba44d850@virtuozzo.com>
In-Reply-To: <acb069c8-5207-368e-e972-baa2ba44d850@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.04.19 16:33, Vladimir Sementsov-Ogievskiy wrote:
> 10.04.2019 23:57, Max Reitz wrote:
>> This adds a salvaging mode (--salvage) to qemu-img convert which ignor=
es
>> read errors and treats the respective areas as containing only zeroes.=

>> This can be used for instance to at least partially recover the data
>> from terminally corrupted qcow2 images.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
> [..]
>=20
>> --- a/qemu-img.texi
>> +++ b/qemu-img.texi
>> @@ -175,6 +175,11 @@ improve performance if the data is remote, such a=
s with NFS or iSCSI backends,
>>   but will not automatically sparsify zero sectors, and may result in =
a fully
>>   allocated target image depending on the host support for getting all=
ocation
>>   information.
>> +@item --salvage
>> +Try to ignore I/O errors when reading.  Unless in quiet mode (@code{-=
q}), errors
>> +will still be printed.  Areas that cannot be read from the source wil=
l be
>> +treated as containing only zeroes.  This option has no effect in copy=
 offloading
>> +mode (@code{-C}).
>=20
> Isn't it better to restrict such it, instead of creating meaningless co=
mbination?
> And drop the restriction if we support it in future, instead of silent =
move from
> noop to the feature?

You=E2=80=99re right, I should do that.

> Otherwise, looks OK for me. I dislike mixing byte-based and sector-base=
d logic, but it
> is not about the series, we should move to byte-based like in other pla=
ces, and it may
> be done later.

Thanks for having a look!

Max


--NV1sfjUkXs4Z42FfYS1cNIR3NHWXgp8vF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyxNP8ACgkQ9AfbAGHV
z0B34Qf/Tu+v9qW4JyWhvQi6GRXe1UFi86d3EaXIwXiXjkDYpQu3QSR6fQlOxaeg
Y2DUexQggJzmk6AsoxQww0g6vAbK3ZmMjJsRTYkIrmr1RZcfG2gXVp8qxxZex56O
iDRW5bsLWvTSV6+DbmVh4ZvzUL+njZyivhT/WVxx47IjN2Pb76DMLqq0AWyncXMD
V22ZWvESAbGAQSLk6g1TMHRtvunHRjdvCYHvIYKwq1XIZO8ZkPCAjdr7g8J1XxKR
0EX/r/DSq/CZIRiF1xml/c0/d4LTyyB0EfIJxNGb6j2aCW4e4AEazZr4NrTMEW4B
OJvxefxb6rxTeBbc0SnmNZlAz9LQQg==
=xhYB
-----END PGP SIGNATURE-----

--NV1sfjUkXs4Z42FfYS1cNIR3NHWXgp8vF--
