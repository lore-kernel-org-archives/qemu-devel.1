Received: from eggs.gnu.org ([2001:4830:134:3::10]:40434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dPZbu-0004w7-D1
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 15:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dPZbt-0001VE-MS
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 15:23:46 -0400
References: <20170621131157.16584-1-mreitz@redhat.com>
	<bb5dec50-75bc-e7bb-5fb2-290e8d0f4afe@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <43783ae5-d4cf-da6c-6a18-a99e94e2d089@redhat.com>
Date: Mon, 26 Jun 2017 21:23:33 +0200
MIME-Version: 1.0
In-Reply-To: <bb5dec50-75bc-e7bb-5fb2-290e8d0f4afe@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SLVx4vnUK5ON1WDof76ibMXKPaLq4RnOB"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: 181 does not work
 for all formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SLVx4vnUK5ON1WDof76ibMXKPaLq4RnOB
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <43783ae5-d4cf-da6c-6a18-a99e94e2d089@redhat.com>
Subject: Re: [Qemu-block] [PATCH] iotests: 181 does not work for all formats
References: <20170621131157.16584-1-mreitz@redhat.com>
 <bb5dec50-75bc-e7bb-5fb2-290e8d0f4afe@redhat.com>
In-Reply-To: <bb5dec50-75bc-e7bb-5fb2-290e8d0f4afe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-26 21:17, John Snow wrote:
>=20
>=20
> On 06/21/2017 09:11 AM, Max Reitz wrote:
>> Test 181 only works for formats which support live migration (naturall=
y,
>> as it is a live migration test). Disable it for all formats which do
>> not.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/181 | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
>> index e969a2a..f73ad5a 100755
>> --- a/tests/qemu-iotests/181
>> +++ b/tests/qemu-iotests/181
>> @@ -43,6 +43,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  . ./common.qemu
>> =20
>>  _supported_fmt generic
>> +# Formats that do not support live migration
>> +_unsupported_fmt qcow vdi vhdx vmdk vpc vvfat
>>  _supported_proto generic
>>  _supported_os Linux
>> =20
>>
>=20
> Does this come up elsewhere in iotests? I guess not often enough to
> justify some macro like formats_unmigratable.

Well, formats_no_backing might happen more often...

> Eh.

Don't want to volunteer? :-)

> Reviewed-by: John Snow <jsnow@redhat.com>

Thanks!

Aaand applied to my block branch.

Max


--SLVx4vnUK5ON1WDof76ibMXKPaLq4RnOB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZUV82EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQP5y
CACeyGID7AeSE2Rwvtv8U4TtINhDo4laHFsuz9d+LnUNm5Ht0TZIJf8DlT+FOm/a
N4g1qTznfc1o3utqL5eNVPUvsiSLkqs7HwQPdc4SgyyotPr1V9AB0IvUYEkbwHKD
jYp/dwX7UA/9QkoaEFdg3cNb7oPyeqX2vfIhexhnp6uVfxVFz6zp/nh0mFh9xVpL
Meg57PqEKYyE7Be8xq1pDmDUGvO24XOp+J+9/noRHjRO2KVGm4hmxI9UFs2n2ODh
lrFM5mQ/eUvfur6+zb+1jrTcTuDBDPjUGM13pOMJQ1F0e6oui5m/22hmzgw8dItY
sKfPAm+GOfA7kxdTcTaBfHfC
=fxDJ
-----END PGP SIGNATURE-----

--SLVx4vnUK5ON1WDof76ibMXKPaLq4RnOB--
