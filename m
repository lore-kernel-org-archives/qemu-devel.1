Received: from eggs.gnu.org ([2001:4830:134:3::10]:39941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxzia-0001Pf-IZ
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 14:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxziZ-0000bD-Q0
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 14:08:56 -0400
References: <20170929170843.3711-1-mreitz@redhat.com>
	<cf6e8f28-760c-57ae-184b-d9b07c28f0f2@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c08cfd7e-c459-8ddf-a81c-fbe31ecfeac3@redhat.com>
Date: Fri, 29 Sep 2017 20:08:43 +0200
MIME-Version: 1.0
In-Reply-To: <cf6e8f28-760c-57ae-184b-d9b07c28f0f2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dWerVo1hkpRQxkH8dwbOW4Dt2kIwd8q3M"
Subject: Re: [Qemu-devel] [PATCH v3] iotests: Add test for dataplane
 mirroring
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dWerVo1hkpRQxkH8dwbOW4Dt2kIwd8q3M
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Jeff Cody <jcody@redhat.com>
Message-ID: <c08cfd7e-c459-8ddf-a81c-fbe31ecfeac3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] iotests: Add test for dataplane mirroring
References: <20170929170843.3711-1-mreitz@redhat.com>
 <cf6e8f28-760c-57ae-184b-d9b07c28f0f2@redhat.com>
In-Reply-To: <cf6e8f28-760c-57ae-184b-d9b07c28f0f2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-29 19:33, Eric Blake wrote:
> On 09/29/2017 12:08 PM, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> v3: Make the test actually pass (the reference output from v2 only
>>     worked with v1 of the test...)
>> ---
>>  tests/qemu-iotests/127     | 97 +++++++++++++++++++++++++++++++++++++=
+++++++++
>>  tests/qemu-iotests/127.out | 14 +++++++
>>  tests/qemu-iotests/group   |  1 +
>>  3 files changed, 112 insertions(+)
>>  create mode 100755 tests/qemu-iotests/127
>>  create mode 100644 tests/qemu-iotests/127.out
>>
>=20
>> +_cleanup()
>> +{
>> +    _cleanup_qemu
>> +    _cleanup_test_img
>> +    _rm_test_img "$TEST_IMG.overlay0"
>> +    _rm_test_img "$TEST_IMG.overlay1"
>> +}
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>=20
> Semantic conflict with Jeff's patches for './check -s' to preserve
> intermediate files.  Otherwise,
> Reviewed-by: Eric Blake <eblake@redhat.com>

True, but as long as v4 of his series is not around, I feel OK to put
the burden of having to rebase on him. :-)

Max


--dWerVo1hkpRQxkH8dwbOW4Dt2kIwd8q3M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnOjCsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYb0H/AqwaYsX1Zsb/ALPp4Lf/sZCxGgrQ4NT
qQOrPwwuGYwuFmARVkSevJi5aSOr0p8s/vaDQTOclYQI0IorLnDZUvpMQAUpPpjD
c4h5lMntHM3/o5FLO+sHSbx8GyA7wISYTjLWpCLTkcCB/sriojnKG9P5hifvoE1j
odKvBeuJdGBkNO/cqNRZ8W02x/CVynl5leby29TPnZ4Fd+G5EbMQdcd+4RTwJZE8
5ieFOTyY0UyC6kcmcP5W7+SK7LwblWYYgoecXIC6x9ai3nIDw853c5kBtV8EBJLI
cp+E3lYIndbg9pfieadsbXO90hkn7Cy7MqaIz0c0GDpS/vDjNxLHDHs=
=aREu
-----END PGP SIGNATURE-----

--dWerVo1hkpRQxkH8dwbOW4Dt2kIwd8q3M--
