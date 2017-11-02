Received: from eggs.gnu.org ([2001:4830:134:3::10]:40666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAICl-0006ds-17
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAICh-0006Gw-8K
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:18:55 -0400
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-19-mreitz@redhat.com>
	<w51o9okwtgx.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <15538193-cfa0-822e-04c4-4aedbfd0724a@redhat.com>
Date: Thu, 2 Nov 2017 17:18:31 +0100
MIME-Version: 1.0
In-Reply-To: <w51o9okwtgx.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0SUwPwLL7gILaUUOlnAS0mVXkJPiUQ2qT"
Subject: Re: [Qemu-devel] [PATCH v6 18/25] block: Add sgfnt_runtime_opts to
 BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0SUwPwLL7gILaUUOlnAS0mVXkJPiUQ2qT
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <15538193-cfa0-822e-04c4-4aedbfd0724a@redhat.com>
Subject: Re: [PATCH v6 18/25] block: Add sgfnt_runtime_opts to BlockDriver
References: <20170929165347.29658-1-mreitz@redhat.com>
 <20170929165347.29658-19-mreitz@redhat.com>
 <w51o9okwtgx.fsf@maestria.local.igalia.com>
In-Reply-To: <w51o9okwtgx.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-02 17:11, Alberto Garcia wrote:
> On Fri 29 Sep 2017 06:53:40 PM CEST, Max Reitz wrote:
>>      QLIST_ENTRY(BlockDriver) list;
>> +
>> +    /* Pointer to a NULL-terminated array of names of significant opt=
ions that
>> +     * can be specified for bdrv_open(). A significant option is one =
that
>> +     * changes the data of a BDS.
>> +     * If this pointer is NULL, the array is considered empty.
>> +     * "filename" and "driver" are always considered significant. */
>> +    const char *const *sgfnt_runtime_opts;
>>  };
>=20
> Is sgfnt a common acronym? I actually had to look it up...

I'm open for other suggestions to shorten "significant". :-)

(Actually, I can't remember where I got it from.  I think I just made it
up, but then I don't know why I didn't use sgfcnt -- maybe because cnt
looks either like count (or like something else, but that's a different
matter)...?)

Max

>> +static const char *const iscsi_sgfnt_runtime_opts[] =3D {
>> +    "transport",
>> +    "portal",
>> +    "target",
>> +    "user",
>> +    "password",
>> +    "password-secret",
>> +    "lun",
>> +    "initiator-name",
>> +    "header-digest",
>> +
>> +    NULL
>> +};
>=20
> Ideally it would be nice to have constants for all these options, but
> this is a pre-existing problem.
>=20
> Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20
> Berto
>=20



--0SUwPwLL7gILaUUOlnAS0mVXkJPiUQ2qT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAln7RVcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AVZEH/RLP7pb4M+VTMOWb9Armi/lJdXuAevDO
4eMtVUZRwscYrTNA2sDEWpuU5NpN/fZDyd2mnyYA93yrGCRWjF0usCdC4UaRJipJ
axA+uiAuPNyXRWutKxWXlQj04MANfIXHZxGn8k9KN7doFuonme8OAWGysvhTb5Hp
LKC8gPT0jnrIrNcaD2AKYT3ERP7a+zbkaiMqiYBp7M8k9N0xb+CQLvMlcXfrcJ7v
I1dLj2eCTwTf1u6NaNbCteGCYEYLaLJxZqizsmuUI46xxGyQfoMXOqMEQHBVlBaF
N4HeYXrPsNbWMKByXFw67IXssXULttgQrV9aCt/rvrYOclMZIjdgugk=
=Snl7
-----END PGP SIGNATURE-----

--0SUwPwLL7gILaUUOlnAS0mVXkJPiUQ2qT--
