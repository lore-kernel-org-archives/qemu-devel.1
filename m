Received: from eggs.gnu.org ([2001:4830:134:3::10]:52274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cHsXF-0000wL-Rd
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cHsXF-0006lR-0A
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:26:53 -0500
References: <20161130011851.24696-1-mreitz@redhat.com>
	<20161130011851.24696-8-mreitz@redhat.com>
	<w51lgvhdu4d.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <090c4fe2-7ed6-e993-5fe8-df4dda79d85e@redhat.com>
Date: Fri, 16 Dec 2016 14:26:29 +0100
MIME-Version: 1.0
In-Reply-To: <w51lgvhdu4d.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XJqQKdBGt61Jtl00TJhLmVEECnlURxOvh"
Subject: Re: [Qemu-devel] [PATCH v3 07/25] block:
 bdrv_get_full_backing_filename's ret. val.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XJqQKdBGt61Jtl00TJhLmVEECnlURxOvh
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <090c4fe2-7ed6-e993-5fe8-df4dda79d85e@redhat.com>
Subject: Re: [PATCH v3 07/25] block: bdrv_get_full_backing_filename's ret.
 val.
References: <20161130011851.24696-1-mreitz@redhat.com>
 <20161130011851.24696-8-mreitz@redhat.com>
 <w51lgvhdu4d.fsf@maestria.local.igalia.com>
In-Reply-To: <w51lgvhdu4d.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 15.12.2016 17:39, Alberto Garcia wrote:
> On Wed 30 Nov 2016 02:18:33 AM CET, Max Reitz wrote:
>>  int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_option=
s,
>>                             const char *bdref_key, Error **errp)
>>  {
>> -    char *backing_filename =3D g_malloc0(PATH_MAX);
>> +    char *backing_filename =3D NULL;
>>      char *bdref_key_dot;
>>      const char *reference =3D NULL;
>>      int ret =3D 0;
>> @@ -1511,7 +1505,7 @@ int bdrv_open_backing_file(BlockDriverState *bs,=
 QDict *parent_options,
>> =20
>>      reference =3D qdict_get_try_str(parent_options, bdref_key);
>>      if (reference || qdict_haskey(options, "file.filename")) {
>> -        backing_filename[0] =3D '\0';
>> +        backing_filename =3D NULL;
>=20
> You're making it NULL, but it's NULL already.

Yes, so I hope the compiler can optimize it away. :-)

I initialized it to NULL here to make it more clear that under the given
condition we do not have a backing filename (so that it's clear from a
single look at this if-else block what exactly happens in each case
without having to know the state of variables beforehand).

So it was intentional, but I can either change it so that
backing_filename would no longer be initialized to NULL (meaning the
first "goto free_exit;" would need to be just a "return 0;") or make it
a comment (/* backing_filename is already NULL */). I'm leaning towards
the latter because it would mean less changes to this series, although I
personally think that simply explicitly setting backing_filename to NULL
instead of such a comment is just as good.

So if I have to send a v4 (which I probably will), I'll make it a
comment, but I probably won't send a v4 just for this (I'm sure there
are other good reasons, however :-)).

And thanks for reviewing!

Max


--XJqQKdBGt61Jtl00TJhLmVEECnlURxOvh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhT65ESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AkLMIAIHNE1xltjC5uBeB33N1CuRw0/bQr3y3
gMSuolwru/mmtk+ylEPgHR4nyKCWchHF12FB92swL8080FbcfXNfnw9Kg0i1igta
bCwmQExd/Lhs8dDN1fxEMrOtTNHo3E6ZkHT15Hcl4WX2mnXqXFHCDisnuvQp3MCV
a8nzEV3Vat0qyQ5wdGPo1namKfFtoQz2+ZaoqfD+xdpq4WaF5h9yklFUfMVJWBm/
eaJA/2/kgkG6K9F0zdN9o5228Tp/DV42+M9RQ5xld3BMuMDrQxmlq2Rjoew+qexn
qOJ4yqwEiCSWD/ClUOViGjmpTmV8wniXUvx4v2wvEKG7CYzUVABdykQ=
=D6BI
-----END PGP SIGNATURE-----

--XJqQKdBGt61Jtl00TJhLmVEECnlURxOvh--
