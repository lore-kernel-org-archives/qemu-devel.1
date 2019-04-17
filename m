Received: from eggs.gnu.org ([209.51.188.92]:56448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGntq-0003bc-At
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGntp-0005fI-Bq
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:59:06 -0400
References: <20190401145741.28322-1-eblake@redhat.com>
	<d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
Date: Wed, 17 Apr 2019 11:58:57 -0500
MIME-Version: 1.0
In-Reply-To: <d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VbYyaMBiNNYFYGw4M5JJOIt4UxXFzctrx"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2] qemu-img: Saner printing of
 large file sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>, Alberto Garcia <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VbYyaMBiNNYFYGw4M5JJOIt4UxXFzctrx
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
Subject: Re: [PATCH for-4.1 v2] qemu-img: Saner printing of large file sizes
References: <20190401145741.28322-1-eblake@redhat.com>
 <d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
In-Reply-To: <d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/10/19 2:28 PM, Max Reitz wrote:
> On 01.04.19 16:57, Eric Blake wrote:
>> Disk sizes close to INT64_MAX cause overflow, for some pretty
>> ridiculous output:
>>
>>   $ ./nbdkit -U - memory size=3D$((2**63 - 512)) --run 'qemu-img info =
$nbd'
>>   image: nbd+unix://?socket=3D/tmp/nbdkitHSAzNz/socket
>>   file format: raw
>>   virtual size: -8388607T (9223372036854775296 bytes)
>>   disk size: unavailable
>>

>=20
> There are more iotests this breaks.  First, there is 059 for vmdk, whic=
h
> looks just like the rest.

Easy enough; I was able to reproduce.

>=20
> But for -m32, it gets a bit more difficult.  Every size above 999 GB
> (1000 GB gets rounded to 1 TB, which is 2^31 * 512) gets printed as
> "inf [unit]":

Ouch - pre-existing bug in size_to_str(); I'll have to fix that, then
send a v3.

Kevin, do you want to unqueue this from block-next until then?

>=20
> But regardless of the iotests, we shouldn=E2=80=99t show the size as in=
finite
> just because of -m32.

Is there an easy docker setup for building -m32?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--VbYyaMBiNNYFYGw4M5JJOIt4UxXFzctrx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly3W1EACgkQp6FrSiUn
Q2o5QAgAoup69jIha5tJTEzZu3qIqFpbruAnlNoQCO2wqBlK9t//+vaPW52lDHYV
xfLMly9mK3F5eJlIjkWkh432LSrSx5eRH66tdYtPTXnVmNeCw4GZ82B45kyUQLAO
x5kAyoKB1OY5dkqxLEt6YoLTrwV8qgBnwO8vrbi5tlFMjkuQar00tiLU02mZ74c7
jbeEK8HX3sPxaeJhUox3QiBx7CiC45rGKpCAkcq2t/DPawdI2QOvkywyfu8jvV+v
+mUDGQL3c2U0zBEMhEOFmnQH6KIj2X4OHGkI75r1eUnNt82gOczrnSdvh1N6zm36
feHuR903W6Z8xjKdMeKOEb15DzfQ8A==
=A9BI
-----END PGP SIGNATURE-----

--VbYyaMBiNNYFYGw4M5JJOIt4UxXFzctrx--
