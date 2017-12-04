Received: from eggs.gnu.org ([2001:4830:134:3::10]:34267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eLvQh-0007wD-Bk
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 13:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eLvQg-0002nl-6L
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 13:25:23 -0500
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-22-mreitz@redhat.com>
	<w51shcq30wc.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ff4ca1cc-b489-1c4e-8686-1c250e88065f@redhat.com>
Date: Mon, 4 Dec 2017 19:25:09 +0100
MIME-Version: 1.0
In-Reply-To: <w51shcq30wc.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CNDhINIcTDt3KgcthqK707HXlTvPR3HHT"
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 21/25] block: Purify
 .bdrv_refresh_filename()
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
--CNDhINIcTDt3KgcthqK707HXlTvPR3HHT
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <ff4ca1cc-b489-1c4e-8686-1c250e88065f@redhat.com>
Subject: Re: [PATCH v7 for-2.12 21/25] block: Purify .bdrv_refresh_filename()
References: <20171120201004.14999-1-mreitz@redhat.com>
 <20171120201004.14999-22-mreitz@redhat.com>
 <w51shcq30wc.fsf@maestria.local.igalia.com>
In-Reply-To: <w51shcq30wc.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-04 17:37, Alberto Garcia wrote:
> On Mon 20 Nov 2017 09:10:00 PM CET, Max Reitz wrote:
>> -static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *op=
tions)
>> +static void blkdebug_refresh_filename(BlockDriverState *bs)
>>  {
>>      BDRVBlkdebugState *s =3D bs->opaque;
>> -    QDict *opts;
>>      const QDictEntry *e;
>> -    bool force_json =3D false;
>> -
>> -    for (e =3D qdict_first(options); e; e =3D qdict_next(options, e))=
 {
>> -        if (strcmp(qdict_entry_key(e), "config") &&
>> -            strcmp(qdict_entry_key(e), "x-image"))
>> -        {
>> -            force_json =3D true;
>> -            break;
>> -        }
>> -    }
>> +    int ret;
>> =20
>> -    if (force_json && !bs->file->bs->full_open_options) {
>> -        /* The config file cannot be recreated, so creating a plain f=
ilename
>> -         * is impossible */
>> +    if (!bs->file->bs->exact_filename[0]) {
>>          return;
>>      }
>> =20
>> -    if (!force_json && bs->file->bs->exact_filename[0]) {
>> -        int ret =3D snprintf(bs->exact_filename, sizeof(bs->exact_fil=
ename),
>> -                           "blkdebug:%s:%s", s->config_file ?: "",
>> -                           bs->file->bs->exact_filename);
>> -        if (ret >=3D sizeof(bs->exact_filename)) {
>> -            /* An overflow makes the filename unusable, so do not rep=
ort any */
>> -            bs->exact_filename[0] =3D 0;
>> +    for (e =3D qdict_first(bs->full_open_options); e;
>> +         e =3D qdict_next(bs->full_open_options, e))
>> +    {
>> +        if (strcmp(qdict_entry_key(e), "config") &&
>> +            strcmp(qdict_entry_key(e), "image") &&
>=20
> Shouldn't this be "x-image" ?

Er, yes.  It should.

Max


--CNDhINIcTDt3KgcthqK707HXlTvPR3HHT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlolkwUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AgjwH+wcAHF5EEiH9oR5e60z1yVA2eRXOeaM3
f96O8BXgIYobQn/ZTYC735VwnhMNCKvG91G6w9A9Yl2innPTwKYoVh2MY7VUzhqo
d8q3h8kGe87hmZeCzdZrdbG8+jlKrgFVke3GFDtrKfBfa9XWVu6Z+QkD9/6cwEZr
BZ/7gk7vw/O3/DCXDPBCq08gfqcpg532ktqgxwACd/hg4DV+Nmb/eFIBnWjVRC+v
z+2Q6OMMbSDOvkKL0ELH+PrFVnLPQqlZ+7SZjDh96da8cAOPZgojqhZ0yZe5xZBL
pIoE12Vd2inxJP1GrpHMjvtpHydmrmey0Lx+sjj+sFkfTszxTB2lUT8=
=6d2U
-----END PGP SIGNATURE-----

--CNDhINIcTDt3KgcthqK707HXlTvPR3HHT--
