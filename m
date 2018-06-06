Received: from eggs.gnu.org ([2001:4830:134:3::10]:43287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQeB4-0000h6-Rd
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQeB3-0005WG-Tv
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:33:02 -0400
References: <20180604141437.22758-1-mreitz@redhat.com>
	<b962bc23-039a-7653-e180-749e3085121c@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <deddda05-d458-b5c1-643d-da188ce2d9b0@redhat.com>
Date: Wed, 6 Jun 2018 21:32:51 +0200
MIME-Version: 1.0
In-Reply-To: <b962bc23-039a-7653-e180-749e3085121c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7ALhTBzGpcVqwI6zqyDluoE5QAtvtxxM8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] qcow2: Do not mark
 inactive images corrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ALhTBzGpcVqwI6zqyDluoE5QAtvtxxM8
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <deddda05-d458-b5c1-643d-da188ce2d9b0@redhat.com>
Subject: Re: [Qemu-block] [PATCH 0/2] qcow2: Do not mark inactive images
 corrupt
References: <20180604141437.22758-1-mreitz@redhat.com>
 <b962bc23-039a-7653-e180-749e3085121c@redhat.com>
In-Reply-To: <b962bc23-039a-7653-e180-749e3085121c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-04 20:58, John Snow wrote:
>=20
>=20
> On 06/04/2018 10:14 AM, Max Reitz wrote:
>> The non-public logs in
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1583346 (sorry...) revea=
l
>> this problem:
>>
>> $ (Create a qcow2 file "foo.qcow2" with a corrupted first L1 entry)
>> $ echo 'qemu-io none0 "read 0 512"' \
>>     | x86_64-softmmu/qemu-system-x86_64 -drive if=3Dnone,file=3Dfoo.qc=
ow2 \
>>                                         -monitor stdio \
>>                                         -incoming exec:'cat /dev/null'=

>> QEMU 2.12.50 monitor - type 'help' for more information
>> (qemu) qemu-io none0 "read 0 512"
>> qcow2: Marking image as corrupt: L2 table offset 0x44200 unaligned (L1=
 index: 0); further corruption events will be suppressed
>> qemu-system-x86_64: block/io.c:1691: bdrv_co_pwritev: Assertion `!(bs-=
>open_flags & BDRV_O_INACTIVE)' failed.
>> [1]    18444 done                 echo 'qemu-io none0 "read 0 512"' | =

>>        18445 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -d=
rive if=3Dnone,file=3Dfoo.qcow2 -monitor stdi
>>
>> Oops.
>>
>>
>> The first patch in this series fixes this by treating inactive images
>> like read-only images in this regard (which most importantly means not=

>> trying to set the corrupt flag on them), the second one adds an iotest=

>> case.
>>
>>
>> Max Reitz (2):
>>   qcow2: Do not mark inactive images corrupt
>>   iotests: Add case for a corrupted inactive image
>>
>>  block/qcow2.c              |  4 +++-
>>  tests/qemu-iotests/060     | 30 ++++++++++++++++++++++++++++++
>>  tests/qemu-iotests/060.out | 14 ++++++++++++++
>>  3 files changed, 47 insertions(+), 1 deletion(-)
>>
>=20
> Makes sense to me, provided it's safe to check via BDRV_O_RDWR instead
> of bs->read_only. (I assume it is.)

It's all a mess is all I can say.

Max


--7ALhTBzGpcVqwI6zqyDluoE5QAtvtxxM8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsYNuQACgkQ9AfbAGHV
z0AWOggAkwWShE9a61E3KnxzA2irevXRux1uurk+XS8PAJzXh3AwZgSPk6lSIP2u
lCEeLCNKEdYHPemjedg+0VZXvWGoU/SeANwqfehZT1TFik3LUdthAG/MkUMEubZ0
12xkyia1KDGXCOPN+CBN0a08X4Y3zBwP1SU5qtyNzj/dgSoRqys5xL/XpA8h3PB7
AOloW2BPgAbO7BszTC9YMb7T7jajgkqM5IoM9uZl0yZgGziMfZCaB7ariYPooD7x
JjWGq+XFdGVGYHnKb48XNsWN2yHbyEUcWzHd2nAn/ltAAHv0rHfM2PwGcMJY4XWT
ugL7S4a+JVJNjQIxQNKwo1qn29LNKw==
=6qOR
-----END PGP SIGNATURE-----

--7ALhTBzGpcVqwI6zqyDluoE5QAtvtxxM8--
