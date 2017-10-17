Received: from eggs.gnu.org ([2001:4830:134:3::10]:49593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4Zes-0008Bg-3G
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 17:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4Zer-0001kx-8w
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 17:44:18 -0400
References: <bdbb9d79839f3149db9cf2ff11a2cc04977e0a64.1507817548.git.pkrempa@redhat.com>
	<20171017151149.28062-1-kwolf@redhat.com>
	<20171017151658.GD7660@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8cc79cda-a053-33bd-fec6-eb44bff9404b@redhat.com>
Date: Tue, 17 Oct 2017 16:44:08 -0500
MIME-Version: 1.0
In-Reply-To: <20171017151658.GD7660@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UQuU5QXIb1iWI9XlAcUALkUf5Bh3ksVcK"
Subject: Re: [Qemu-devel] [PATCH 2/1] qemu-iotests: Test backing_fmt with
 backing node reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UQuU5QXIb1iWI9XlAcUALkUf5Bh3ksVcK
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <8cc79cda-a053-33bd-fec6-eb44bff9404b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/1] qemu-iotests: Test backing_fmt with
 backing node reference
References: <bdbb9d79839f3149db9cf2ff11a2cc04977e0a64.1507817548.git.pkrempa@redhat.com>
 <20171017151149.28062-1-kwolf@redhat.com>
 <20171017151658.GD7660@dhcp-200-186.str.redhat.com>
In-Reply-To: <20171017151658.GD7660@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/17/2017 10:16 AM, Kevin Wolf wrote:
> Am 17.10.2017 um 17:11 hat Kevin Wolf geschrieben:
>> This changes test case 191 to include a backing image that has
>> backing_fmt set in the image file, but is referenced by node name in t=
he
>> qemu command line.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  tests/qemu-iotests/191     | 5 +++--
>>  tests/qemu-iotests/191.out | 2 +-
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
>> index ac2b88fd78..00202efd47 100755
>> --- a/tests/qemu-iotests/191
>> +++ b/tests/qemu-iotests/191
>> @@ -56,9 +56,10 @@ echo =3D=3D=3D Preparing and starting VM =3D=3D=3D
>>  echo
>> =20
>>  TEST_IMG=3D"${TEST_IMG}.base" _make_test_img $size
>> -TEST_IMG=3D"${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base"
>> +IMGOPTS=3D$(_optstr_add "$IMGOPTS" "backing_fmt=3D$IMGFMT") \
>> +    TEST_IMG=3D"${TEST_IMG}.mid" _make_test_img -b "${TEST_IMG}.base"=
 $size
>>  _make_test_img -b "${TEST_IMG}.mid"
>> -TEST_IMG=3D"${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid"
>> +TEST_IMG=3D"${TEST_IMG}.ovl2" _make_test_img -b "${TEST_IMG}.mid" $si=
ze
>=20
> Please pretend you don't see the addition of " $size" here, it's
> unnecessary and I'll remove it again.

As tweaked,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UQuU5QXIb1iWI9XlAcUALkUf5Bh3ksVcK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnmeagACgkQp6FrSiUn
Q2revggAkBahjBHhrJ/VqDmviVXrKAFStX0DFqfIY8gOyOzuDDyAoP1PAhjp2UhN
6JsLyATx2igsq5xkj20afzAqENXtiF0AicXu2Wz7Hv87cstgH/vEl9JF98N1Asf6
6e2VJGCi6ofQGtEF9ijB3uVRjHgz7b/9DgX+6pM3Ms8TsRFPnKv7nMQxrHn4pzLa
zWTFF5Tph+TIk6D4wiCEAqCECyTCzugaUD+MLxfQayEKlE/sg+Z1RkcXGmInsD4T
hiJ79wqNcAhTQde34DjKNs7xw9mR79m+dNgObx1V8HGtULaozrysyOHaVCZtkBB7
vyrlc8L3I7LSWpf02hKedInv3fPPqA==
=XDcE
-----END PGP SIGNATURE-----

--UQuU5QXIb1iWI9XlAcUALkUf5Bh3ksVcK--
