Received: from eggs.gnu.org ([2001:4830:134:3::10]:35749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKOop-0000Nj-H3
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:24:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKOoo-0003KG-BT
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:23:59 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-9-mreitz@redhat.com>
	<20171130031803.GL16237@lemon>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <105361ec-21d2-e0dc-d480-ef3c9910dd12@redhat.com>
Date: Thu, 30 Nov 2017 14:23:36 +0100
MIME-Version: 1.0
In-Reply-To: <20171130031803.GL16237@lemon>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="elb9S2Cd8ePUXCdFqMU80vpl8neT4Pmtx"
Subject: Re: [Qemu-devel] [PATCH 08/17] iotests: Skip 103 for refcount_bits=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--elb9S2Cd8ePUXCdFqMU80vpl8neT4Pmtx
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <105361ec-21d2-e0dc-d480-ef3c9910dd12@redhat.com>
Subject: Re: [PATCH 08/17] iotests: Skip 103 for refcount_bits=1
References: <20171123020832.8165-1-mreitz@redhat.com>
 <20171123020832.8165-9-mreitz@redhat.com> <20171130031803.GL16237@lemon>
In-Reply-To: <20171130031803.GL16237@lemon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-30 04:18, Fam Zheng wrote:
> On Thu, 11/23 03:08, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/103 | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
>> index ecbd8ebd71..d0cfab8844 100755
>> --- a/tests/qemu-iotests/103
>> +++ b/tests/qemu-iotests/103
>> @@ -40,6 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt qcow2
>>  _supported_proto file nfs
>>  _supported_os Linux
>> +# Internal snapshots are (currently) impossible with refcount_bits=3D=
1
>> +_unsupported_imgopts 'refcount_bits=3D1[^0-9]'
>=20
> What is the "[^0-9]" part for?

It's so you can specify refcount_bits=3D16, but not
refcount_bits=3D1,compat=3D0.10 or just refcount_bits=3D1.

Max


--elb9S2Cd8ePUXCdFqMU80vpl8neT4Pmtx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlogBlgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A3o0IAKknpbgONr3D04U8jIH2a8EUkC7dXQyx
pY4GFms0RulDmRYRlsmPUBkCdW6QipAoojNJqGXEhkUexShZEKXHiJtXplBZlFsq
3ak9fY9rDVWq8VLmx4hmOJEYqkf4uZQk2igV29dpFIA3g85xZknx6L2tjWaaxRFh
loQ444vb00o4T4fpUVLIRNGAGc9Rd3tb6DWOJwUMx1OLDA5v5rrcUzKDYMJfphHH
Mdu48Jz5FMhS90At6e+8NVMp7fnbvoZ2VPLo3RhHaIJjQjr/2AProSE154aVEtOE
gExQbCtqlL9mQB2tKsdVp2wpcmcSdxJwCdFVg/E8mqEdGXOIuUadmqA=
=t/Am
-----END PGP SIGNATURE-----

--elb9S2Cd8ePUXCdFqMU80vpl8neT4Pmtx--
