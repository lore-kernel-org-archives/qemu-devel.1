Received: from eggs.gnu.org ([209.51.188.92]:57696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjQkJ-0008VG-MQ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjQkI-0007ED-Rm
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:35:19 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-7-eblake@redhat.com>
	<04ba8330-ac60-4f7a-2f99-64d0290e1c19@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5fa84914-aada-36c2-b647-85b887d51cc4@redhat.com>
Date: Tue, 15 Jan 2019 09:35:14 -0600
MIME-Version: 1.0
In-Reply-To: <04ba8330-ac60-4f7a-2f99-64d0290e1c19@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IvWFGIEAb7SqljHJ2Tr9fiItoTDEI4dmr"
Subject: Re: [Qemu-devel] [PATCH v3 06/19] qemu-nbd: Avoid strtol open-coding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IvWFGIEAb7SqljHJ2Tr9fiItoTDEI4dmr
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <5fa84914-aada-36c2-b647-85b887d51cc4@redhat.com>
Subject: Re: [PATCH v3 06/19] qemu-nbd: Avoid strtol open-coding
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-7-eblake@redhat.com>
 <04ba8330-ac60-4f7a-2f99-64d0290e1c19@virtuozzo.com>
In-Reply-To: <04ba8330-ac60-4f7a-2f99-64d0290e1c19@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 6:31 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.01.2019 20:57, Eric Blake wrote:
>> Our copy-and-pasted open-coding of strtol handling forgot to
>> handle overflow conditions.  Use qemu_strto*() instead.
>>
>> In the case of --partition, since we insist on a user-supplied
>> partition to be non-zero, we can use 0 rather than -1 for our
>> initial value to distinguish when a partition is not being
>> served, for slightly more optimal code.
>>
>> The error messages for out-of-bounds values are less specific,
>> but should not be a terrible loss in quality.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Message-Id: <20181215135324.152629-8-eblake@redhat.com>
>>

>> -            if (partition < 1 || partition > 8) {
>> -                error_report("Invalid partition %d", partition);
>> +            if (qemu_strtoi(optarg, NULL, 0, &partition) < 0 ||
>=20
> we can use unsigned conversion like for offset (and unsigned type for p=
artition), but this doesn't really matter.

Yes, but I didn't see the point in changing the variable types in this
patch.

>=20
> anyway,
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--IvWFGIEAb7SqljHJ2Tr9fiItoTDEI4dmr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw9/bIACgkQp6FrSiUn
Q2qSQAf+JPtxxe7RNB4WHLywudGJ3p006U6e32p03iqHARE7Jq/8R/YOlKyz/ODe
NMjQ+5DfkFLSsmWpfBN+cxPTIs8pTjNBY7xlS7U9Jt1sroI7IY/42xWtb8Lht8WB
weaYNwMBnDrPcwjGgbMVAJ3UUVa5tY41jyqs7Snhp8pZjvLo4bUaH0ezvzGXftrj
hxnHdQNhG+9ebKX3p44Q8AZ/UO3CX+7FzM9ylmXkwkpPRSUYIz+qdDClOVuHrx8B
lFoqtFUlt86/YZNQrBkR2Q158w8B7tbHNhQxi/IXnOcLpSt9jnnMQXEB4+W+DW/a
UypxXaHWaUwtcfkAYcwDUbzFCc9F7Q==
=5Zzn
-----END PGP SIGNATURE-----

--IvWFGIEAb7SqljHJ2Tr9fiItoTDEI4dmr--
