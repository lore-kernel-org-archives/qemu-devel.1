Received: from eggs.gnu.org ([209.51.188.92]:36268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghykv-0004ey-CR
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghyku-0007Fo-Lw
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:29:57 -0500
References: <20190103213320.2653-1-lbloch@janustech.com>
	<20190103213320.2653-2-lbloch@janustech.com>
	<20190108122021.GB11492@linux.fritz.box>
	<91dfd3e9-7293-4301-e3ac-852d8a038d4e@janustech.com>
	<87d0p4he0v.fsf@dusky.pond.sub.org>
	<316c67a6-54aa-3312-1994-64baec94c164@janustech.com>
	<87ef9jaazk.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e2e81b4b-6a55-9163-4fcd-351931cd16cd@redhat.com>
Date: Fri, 11 Jan 2019 09:29:47 -0600
MIME-Version: 1.0
In-Reply-To: <87ef9jaazk.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KK4k0VJZzBBZtz4Frr5Rd8yd0vV6ZgPBn"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Leonid Bloch <lbloch@janustech.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KK4k0VJZzBBZtz4Frr5Rd8yd0vV6ZgPBn
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Leonid Bloch <lbloch@janustech.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
Message-ID: <e2e81b4b-6a55-9163-4fcd-351931cd16cd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Auto-generate the sizes
 lookup table
References: <20190103213320.2653-1-lbloch@janustech.com>
 <20190103213320.2653-2-lbloch@janustech.com>
 <20190108122021.GB11492@linux.fritz.box>
 <91dfd3e9-7293-4301-e3ac-852d8a038d4e@janustech.com>
 <87d0p4he0v.fsf@dusky.pond.sub.org>
 <316c67a6-54aa-3312-1994-64baec94c164@janustech.com>
 <87ef9jaazk.fsf@dusky.pond.sub.org>
In-Reply-To: <87ef9jaazk.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 1:50 AM, Markus Armbruster wrote:

>>> We have 54 of them.  I count six uses:
>>>
>>>      block/qcow2.h:#define QCOW_MAX_REFTABLE_SIZE S_8MiB
>>>      block/qcow2.h:#define QCOW_MAX_L1_SIZE S_32MiB
>>>      block/qcow2.h:#define DEFAULT_L2_CACHE_MAX_SIZE S_32MiB
>>>      block/qcow2.h:#define DEFAULT_L2_CACHE_MAX_SIZE S_8MiB
>>>      block/qcow2.h:#define DEFAULT_CLUSTER_SIZE S_64KiB
>>>      block/vdi.c:#define DEFAULT_CLUSTER_SIZE S_1MiB
>>>
>>> Which if them truly need stringify-able integers?
>>>
>>
>> These two:
>>
>> block/qcow2.h:#define DEFAULT_CLUSTER_SIZE
>> block/vdi.c:#define DEFAULT_CLUSTER_SIZE.
>=20
> Compared to the complexity visible in this thread,
>=20
>     .def_value_str =3D "65536", /* must match DEFAULT_CLUSTER_SIZE */
>=20
> looks attractively stupid to me then.

In general, .def_value_str =3D stringify(...) looks odd, compared to my v=
3
patch that lets us do .def_value_int =3D DEFAULT_CLUSTER_SIZE; my patch
also has the benefit that if DEFAULT_CLUSTER_SIZE changes value, we
don't have to remember to update the string.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--KK4k0VJZzBBZtz4Frr5Rd8yd0vV6ZgPBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw4tmsACgkQp6FrSiUn
Q2rfvggAqG9Xatg5PCFKCllMy0vBbRC+/pU+x+U4UnrnarKwO0YMdg3UHCq6KJC+
uQVvXxtipSsCib9Rvk1ulszslqjjv5ZrheQTjWkhBzEu4ilrzLbGprN+H7kPyJs5
NMcmNU+FHyokgYPW8OkE380qspWKP/d/hZEspyCUHEBWBI3U52oaEwd2mYjjmOsu
gNX1K5rRV9H7nVa3iF8f2NHplWhzkgR9qgP59YkOkxq4cOSz0o3wrozVB1HJ/3X8
5wSEA4/Pi8c7hTfHTCkURSWcoqD6yD6Ia5H+iUftrqYDDRYJQK88zAwD7uNzrS4X
UvXyJrKnIchA0YzMyVJjIggdTc7buA==
=gr5j
-----END PGP SIGNATURE-----

--KK4k0VJZzBBZtz4Frr5Rd8yd0vV6ZgPBn--
