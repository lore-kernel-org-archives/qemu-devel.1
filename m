Received: from eggs.gnu.org ([2001:4830:134:3::10]:60496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eo9HQ-0003BT-Ig
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eo9HN-0001O1-Gn
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 09:52:28 -0500
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-19-mreitz@redhat.com>
	<b9fa2031-a042-165a-47fd-e0d4b4a24738@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b937024c-5fbb-1250-a02c-f187f1522594@redhat.com>
Date: Tue, 20 Feb 2018 15:51:53 +0100
MIME-Version: 1.0
In-Reply-To: <b9fa2031-a042-165a-47fd-e0d4b4a24738@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6mYMTc1dVb2m5Mt9peHYFaoG6UnN6F8uk"
Subject: Re: [Qemu-devel] [PATCH v8 18/26] block: Add sgfnt_runtime_opts to
 BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6mYMTc1dVb2m5Mt9peHYFaoG6UnN6F8uk
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
Message-ID: <b937024c-5fbb-1250-a02c-f187f1522594@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 18/26] block: Add sgfnt_runtime_opts to
 BlockDriver
References: <20180205151835.20812-1-mreitz@redhat.com>
 <20180205151835.20812-19-mreitz@redhat.com>
 <b9fa2031-a042-165a-47fd-e0d4b4a24738@redhat.com>
In-Reply-To: <b9fa2031-a042-165a-47fd-e0d4b4a24738@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-06 20:43, Eric Blake wrote:
> On 02/05/2018 09:18 AM, Max Reitz wrote:
>> This new field can be set by block drivers to list the runtime options=

>> they accept that may influence the contents of the respective BDS. As =
of
>> a follow-up patch, this list will be used by the common
>> bdrv_refresh_filename() implementation to decide which options to put
>> into BDS.full_open_options (and consequently whether a JSON filename h=
as
>> to be created), thus freeing the drivers of having to implement that
>> logic themselves.
>>
>> Additionally, this patch adds the field to all of the block drivers th=
at
>> need it and sets it accordingly.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
>> +=C2=A0=C2=A0=C2=A0 /* Pointer to a NULL-terminated array of names of =
significant
>> options that
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * can be specified for bdrv_open(). A signif=
icant option is one
>> that
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * changes the data of a BDS.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If this pointer is NULL, the array is cons=
idered empty.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * "filename" and "driver" are always conside=
red significant. */
>> +=C2=A0=C2=A0=C2=A0 const char *const *sgfnt_runtime_opts;
>=20
> Warning: Bikeshedding follows:
>=20
> s/sgfnt/vital/
>=20
> might read easier (same number of letters, but has some vowels rthr thn=

> bng crptc bbrvtn).

So, did we reach any verdict on this? :-)

To sum up IRC (as far as I've understood), I don't quite like "vital" or
"needed" because they sound like those options would be required; but
they usually have defaults so they are not.

I preferred "strong", but you said that might mean something else
(although I still don't know what exactly :-)).

So...?

Max


--6mYMTc1dVb2m5Mt9peHYFaoG6UnN6F8uk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqMNgoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AAJ4IALPqeZ8MUmK+g+2GJ2sY0GsWR2f1r4Vk
1D6W/SVZR2rdh8nkinTbuDntpkzktebW80g/MDpXQxPabmnVxdW3YeX/QicMJf6K
3qRQEAYOkp5QuhMW+f0yoX9MPkZG300ClIxjYtdGXwXcX6rO1EAl2IAo6JLN8GKI
ZIk3b4mFDNhzWMrSQe1VYl3DaxWETmtXfu6BJ/rCSa1qP/V2LYhcTVS5O3ZP8VKQ
gKRSVmBLP28bsr4Hog23GROGsiS7qig8MRLUTbvh49nQ+ivHc7kG6J79N2kuIbPq
3cVp5pFkqJn1Y6EPfAZEffP/+09tbid6u6TkVBovMN0yxBGAd0FsmP0=
=WNHN
-----END PGP SIGNATURE-----

--6mYMTc1dVb2m5Mt9peHYFaoG6UnN6F8uk--
