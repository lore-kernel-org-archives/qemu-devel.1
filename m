Received: from eggs.gnu.org ([2001:4830:134:3::10]:47317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEdXi-0001lT-FJ
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEdXe-00052n-Ms
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:54:30 -0500
References: <20170616135847.17726-1-mreitz@redhat.com>
	<73457c1e-19c7-084d-852d-27e39a574c76@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ff4b8ecd-92d6-60e8-7815-619e64d8a838@redhat.com>
Date: Tue, 14 Nov 2017 16:54:16 +0100
MIME-Version: 1.0
In-Reply-To: <73457c1e-19c7-084d-852d-27e39a574c76@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IkB88HNj1kXXDdP5bsm8odWBHWCOfXNK9"
Subject: Re: [Qemu-devel] [PATCH] iotests: Add test for failing qemu-img
 commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IkB88HNj1kXXDdP5bsm8odWBHWCOfXNK9
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <ff4b8ecd-92d6-60e8-7815-619e64d8a838@redhat.com>
Subject: Re: [PATCH] iotests: Add test for failing qemu-img commit
References: <20170616135847.17726-1-mreitz@redhat.com>
 <73457c1e-19c7-084d-852d-27e39a574c76@redhat.com>
In-Reply-To: <73457c1e-19c7-084d-852d-27e39a574c76@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 22:21, Max Reitz wrote:
> On 2017-06-16 15:58, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> In order to pass, this depends on "fix: avoid an infinite loop or a
>> dangling pointer problem in img_commit"
>> (http://lists.nongnu.org/archive/html/qemu-block/2017-06/msg00443.html=
)
>> and on the "block: Don't compare strings in bdrv_reopen_prepare()"
>> series
>> (http://lists.nongnu.org/archive/html/qemu-block/2017-06/msg00424.html=
).
>> ---
>>  tests/qemu-iotests/020     | 27 +++++++++++++++++++++++++++
>>  tests/qemu-iotests/020.out | 17 +++++++++++++++++
>>  2 files changed, 44 insertions(+)
>=20
> Finally applied to my block tree:
>=20
> https://github.com/XanClic/qemu/commits/block

=2E..and dropped again because I had to drop the series this depends on.

Max


--IkB88HNj1kXXDdP5bsm8odWBHWCOfXNK9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLEagSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6uUH/iJmDs0nKdpY/7agomffMUCEALEzWlmN
QXtIzcr1XG3Dyng8tNJokk0xvt4ZEmsWAJOZB2PxT/lNIABXPVJEBCz4Qaec4aMM
Mtrpy/fuAdq5tmta8SJbsXHAeOF0fi1USihkFsjma8VAXVEQI8/2EfK/phgwnGbX
oBeNW/mwvEeCOi1RKYuDnPnFcZxVvNOLKyFUvOmLwCq9crMLF1fxowJa27jgh/30
LnAYw3Koa/CQliEwCYczvKGY7PTkvGawZXQ+iil34Oz1xzv1cjJ8Ek9/vlpylFHq
pfq5K2ILXPZ9+R5Rgsy0M9KPvABEO7rBQ+p+oiR/LtDxQgKT1QJDE0s=
=Ciij
-----END PGP SIGNATURE-----

--IkB88HNj1kXXDdP5bsm8odWBHWCOfXNK9--
