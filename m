Received: from eggs.gnu.org ([2001:4830:134:3::10]:34596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eLvRX-0008Po-NJ
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 13:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eLvRW-0003OW-QN
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 13:26:15 -0500
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-25-mreitz@redhat.com>
	<w51k1y2307y.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bcbf0021-4fcd-26d0-e05c-cd3e35608988@redhat.com>
Date: Mon, 4 Dec 2017 19:26:02 +0100
MIME-Version: 1.0
In-Reply-To: <w51k1y2307y.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TlpQCUgBAujUHGiVElfcQ5StlVn1eqAjR"
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 24/25] block/curl: Implement
 bdrv_refresh_filename()
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
--TlpQCUgBAujUHGiVElfcQ5StlVn1eqAjR
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <bcbf0021-4fcd-26d0-e05c-cd3e35608988@redhat.com>
Subject: Re: [PATCH v7 for-2.12 24/25] block/curl: Implement
 bdrv_refresh_filename()
References: <20171120201004.14999-1-mreitz@redhat.com>
 <20171120201004.14999-25-mreitz@redhat.com>
 <w51k1y2307y.fsf@maestria.local.igalia.com>
In-Reply-To: <w51k1y2307y.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-04 17:51, Alberto Garcia wrote:
> On Mon 20 Nov 2017 09:10:03 PM CET, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/curl.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/block/curl.c b/block/curl.c
>> index 11318a9a29..fe57223fda 100644
>> --- a/block/curl.c
>> +++ b/block/curl.c
>> @@ -957,6 +957,20 @@ static int64_t curl_getlength(BlockDriverState *b=
s)
>>      return s->len;
>>  }
>> =20
>> +static void curl_refresh_filename(BlockDriverState *bs)
>> +{
>> +    BDRVCURLState *s =3D bs->opaque;
>> +
>> +    if (!s->sslverify || s->cookie ||
>> +        s->username || s->password || s->proxyusername || s->proxypas=
sword)
>> +    {
>=20
> Is !s->sslverify negative because that setting is true by default?

Yes, exactly.  If it's false, you'd need to override it (and you can't
do that through a plain filename).

Thanks for reviewing, again. :-)

Max


--TlpQCUgBAujUHGiVElfcQ5StlVn1eqAjR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlolkzoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ARCkH/Rjpf4dYwXYI2fQITN4h7sUk/KQ8S0JU
7U1481+LfRA1ZtUTydV5CyMCUy+5HjvUWUVi61ZRe5W7H7/1v+IK4BPAVeYYoCzq
qZ1n2PBavMu9orf2l0587Gll4JRI+zqmjzo9rdHf8Xs9Njelp8ZDLqo6Qir1ZQI2
GQPgjFqDPa4INBQyj+pzqeAH6VYiGasjatnuqWEO80MjcIIdGmkhrehjhDHj68ud
3FgBqq4oKHRp9b/ZH2gSPp8CIDrTwBo3Tdm5rUnjrf3rewzgWJYtM+OgvhLM+/Gm
7tCE18+lJ2kOpMHaAz+oSCMK8Bv7yF0HHpfxUQzuE66tCD4wWkg2Bbc=
=6OJX
-----END PGP SIGNATURE-----

--TlpQCUgBAujUHGiVElfcQ5StlVn1eqAjR--
