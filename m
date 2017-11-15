Received: from eggs.gnu.org ([2001:4830:134:3::10]:54392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEy64-00027e-0Z
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEy63-0008NR-8Q
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:51:19 -0500
References: <20171114184127.24238-1-mreitz@redhat.com>
	<w51efozkiwf.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bcb8ada9-059f-1bc6-10f3-94eeeb29ffab@redhat.com>
Date: Wed, 15 Nov 2017 14:51:01 +0100
MIME-Version: 1.0
In-Reply-To: <w51efozkiwf.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VFOjJfHOUwq361ORWukR3g5fjCVKx6Q5b"
Subject: Re: [Qemu-devel] [PATCH for-2.11] qcow2: Fix overly broad madvise()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VFOjJfHOUwq361ORWukR3g5fjCVKx6Q5b
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <bcb8ada9-059f-1bc6-10f3-94eeeb29ffab@redhat.com>
Subject: Re: [PATCH for-2.11] qcow2: Fix overly broad madvise()
References: <20171114184127.24238-1-mreitz@redhat.com>
 <w51efozkiwf.fsf@maestria.local.igalia.com>
In-Reply-To: <w51efozkiwf.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-15 10:09, Alberto Garcia wrote:
> On Tue 14 Nov 2017 07:41:27 PM CET, Max Reitz wrote:
>> @mem_size and @offset are both size_t, thus subtracting them from one
>> another will just return a big size_t if mem_size < offset -- even mor=
e
>> obvious here because the result is stored in another size_t.
>>
>> Checking that result to be positive is therefore not sufficient to
>> excluse the case that offset > mem_size.  Thus, we currently sometimes=

>> issue an madvise() over a very large address range.
>>
>> This is triggered by iotest 163, but with -m64, this does not result i=
n
>> tangible problems.  But with -m32, this test produces three segfaults,=

>> all of which are fixed by this patch.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Oh, I guess this happens when the page size is larger than the cluster
> size? Otherwise I don't see how...
>=20
> Reviewed-by: Alberto Garcia <berto@igalia.com>

Yes, the test uses 512 byte clusters.

Max


--VFOjJfHOUwq361ORWukR3g5fjCVKx6Q5b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloMRkUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Au6UH/2NRJel54yNKKzp7x0wIBER5I6uHNcgc
rU9EzCTlfmQpI01xGie9DSHEzhZ1i/GM9zqGMW+kF9CWTLc7bCQvkSKlTWXZ2L2q
80M83Him4jKauB+tZeK9njRQEpu7UjJ2gbdnR/ZlNGLJd8QlhEc4RiU3jnVbXTRt
B9DkDbKp+6KzcajAYLThlhINpa6ZvSLkzFUemeMQEvzyzMsVo+12jbM5c/gs004L
/+psxR+sWwJyyr7vbanxViXZR2o852V/IKUFWUd+xvntsmywz+DgVHoEOX2P6Rzl
RjKpC6baabOegS98v6jHuvvCmoHPpkf7D5VrlFEcG185uoXQyT6XW1k=
=zXeQ
-----END PGP SIGNATURE-----

--VFOjJfHOUwq361ORWukR3g5fjCVKx6Q5b--
