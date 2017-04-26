Received: from eggs.gnu.org ([2001:4830:134:3::10]:55356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d3Uu5-0005O0-JP
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 17:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d3Uu4-00005n-Oo
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 17:55:17 -0400
References: <20170418013356.3578-1-eblake@redhat.com>
	<20170418013356.3578-3-eblake@redhat.com>
	<8f65f4aa-c5a2-bad9-404f-0d72961d3cc6@redhat.com>
	<ee675116-5c29-b5d0-9c56-514daf81d9ae@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <49ff286c-55f9-f001-fc29-c2a0ecbbd1c4@redhat.com>
Date: Wed, 26 Apr 2017 17:54:56 -0400
MIME-Version: 1.0
In-Reply-To: <ee675116-5c29-b5d0-9c56-514daf81d9ae@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q8bswmJ9EFFUKJUun6bgMiWAE8nAdmK8x"
Subject: Re: [Qemu-devel] [PATCH 02/31] block: Make bdrv_round_to_clusters()
 signature more useful
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, kwolf@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q8bswmJ9EFFUKJUun6bgMiWAE8nAdmK8x
From: John Snow <jsnow@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kwolf@nongnu.org
Message-ID: <49ff286c-55f9-f001-fc29-c2a0ecbbd1c4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/31] block: Make bdrv_round_to_clusters()
 signature more useful
References: <20170418013356.3578-1-eblake@redhat.com>
 <20170418013356.3578-3-eblake@redhat.com>
 <8f65f4aa-c5a2-bad9-404f-0d72961d3cc6@redhat.com>
 <ee675116-5c29-b5d0-9c56-514daf81d9ae@redhat.com>
In-Reply-To: <ee675116-5c29-b5d0-9c56-514daf81d9ae@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 04/26/2017 05:47 PM, Eric Blake wrote:
> On 04/26/2017 04:41 PM, John Snow wrote:
>>
>>
>> On 04/17/2017 09:33 PM, Eric Blake wrote:
>>> In the process of converting sector-based interfaces to bytes,
>>> I'm finding it easier to represent a byte count as a 64-bit
>>> integer at the block layer (even if we are internally capped
>>> by SIZE_MAX or even INT_MAX for individual transactions, it's
>>> still nicer to not have to worry about truncation/overflow
>>> issues on as many variables).  Update the signature of
>>> bdrv_round_to_clusters() to uniformly use uint64_t, matching
>>                                             ^^^^^^^^
>>
>> While we're here, since you went with int64_t in the end, what steered=

>> you away from uint64_t, or was that just a thinko?
>=20
> Later patches were made easier with signed (the compiler complained whe=
n
> I mixed signed and unsigned pointers).
>=20
>>
>> (AFAICT: off_t is usually something like int64_t, so your choice makes=

>> sense to me, generally.)
>=20
> Indeed, and that's something I should update my commit message to menti=
on.
>=20
>>
>> --js
>>
>>> the signature already chosen for bdrv_is_allocated, and
>>> adjust clients according to the required fallout.
>=20
> If you want me to try and use uint64_t *pnum instead of int64_t *pnum
> throughout both my series 1  (the changes to bdrv_is_allocated) and thi=
s
> one, it will take more effort.  I'll do it if there's a reason, but I'd=

> rather not if the signed version is good enough.
>=20

No, I didn't mean to imply you should, I was just pointing out the
commit message typo. int64_t is likely the correct choice for a number
of reasons, at least being able to return -1 from functions returning a
byte offset being the chief reason.

--js


--Q8bswmJ9EFFUKJUun6bgMiWAE8nAdmK8x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIuBAEBCAAYBQJZARc6ERxqc25vd0ByZWRoYXQuY29tAAoJEH3vgQaq/DkO+HkP
/AiIH+VNxAjfFN0BIgIouA4+CMG942yxP8ZrY+/frN/aU9bs3Xo5+chTUp7RMCWU
dsT3/jWqRI0Me18oguZ0gFJBw9K6Ohtgzl6Mv0J4xBXLNUxMz3ROTwZsOu4vhLpk
O0JXVxCn+YirNCdjN+mFL3VVHyewf70T+wOz4nevO4Ko2rYUHzwph0Jmr15AG8L7
DkzuvG07IvJwN0tjR5YSTPXnKuEIzuNGgn/aZWNqyR3gmkr0vPl/deuDQKDqka1Z
QFLHxrZZxItQZR7onYyqnuwJcmqDMskeXQPTs2qksOcEKaQl22EVIaMiIXSPRwrW
HdlTfccMa93/zpeCrUv0Xq4XxSmT1bbAz/6XyBz09PbQ/2E4zkR1NO50y3vMkGKU
fdiIwvFtMjMwKbBP67JTDMErrD8ebeBY9mokPGEgQ7djNwpIY+XbOD32u2oVgRtK
li+XCls3ZBiGZY7k02bo4fxy5U5j8e4jPHd9QY7uVKUj1mdzp3QwmoI64HjI79WV
LBgdXLJV1J8b+/rAgxyFSQNXj2rSRHFEEMoG5z2FQjHJBOCFclkYfq0TLtM83mK3
4+Xb3dxjhAVXU9AEv+3IAoTlcC0m/2WPDOUbWirwM2f/AtCShVtmFdSJGDyQq3mb
X3eIUiHIwpx5bZtzhL2nqt8mBN8KBN3D5rZ9+OCXxyyB
=drH8
-----END PGP SIGNATURE-----

--Q8bswmJ9EFFUKJUun6bgMiWAE8nAdmK8x--
