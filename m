Received: from eggs.gnu.org ([2001:4830:134:3::10]:52189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da1pt-0008Ja-K9
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da1ps-0007qd-GL
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:33:25 -0400
References: <20170714123341.373857-1-vsementsov@virtuozzo.com>
	<b9f574d1-91b5-c5dc-46b2-1a8976c5539f@redhat.com>
	<f8f9bbae-2440-b2e0-b0dd-0c407515e736@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3b0bb163-8852-cb12-9eb7-8524c9b1e02a@redhat.com>
Date: Tue, 25 Jul 2017 10:33:13 -0500
MIME-Version: 1.0
In-Reply-To: <f8f9bbae-2440-b2e0-b0dd-0c407515e736@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IQ6h8DMknNTIwPr9s2GmJXEhkRiNEUKEq"
Subject: Re: [Qemu-devel] [PATCH] qcow2-bitmap: fix bitmap_free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IQ6h8DMknNTIwPr9s2GmJXEhkRiNEUKEq
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, peter.maydell@linaro.org
Message-ID: <3b0bb163-8852-cb12-9eb7-8524c9b1e02a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2-bitmap: fix bitmap_free
References: <20170714123341.373857-1-vsementsov@virtuozzo.com>
 <b9f574d1-91b5-c5dc-46b2-1a8976c5539f@redhat.com>
 <f8f9bbae-2440-b2e0-b0dd-0c407515e736@amsat.org>
In-Reply-To: <f8f9bbae-2440-b2e0-b0dd-0c407515e736@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2017 10:02 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Maybe worth adding "Coverity: CID 1377700"

At this point, the PULL request is already posted, so it may be too
late.  But it's not the end of the world if we miss the extra comment.

>=20
> On 07/14/2017 01:00 PM, Max Reitz wrote:
>> On 2017-07-14 14:33, Vladimir Sementsov-Ogievskiy wrote:
>>> Fix possible crash on error path in
>>> qcow2_remove_persistent_dirty_bitmap. Although bitmap_free was added =
in
>>> 88ddffae8fc the bug was introduced later in commit 469c71edc72 (when
>>> qcow2_remove_persistent_dirty_bitmap was added).
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>   block/qcow2-bitmap.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>
>> Thanks, applied to my block branch:
>>
>> https://github.com/XanClic/qemu/commits/block
>>
>> Max
>>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IQ6h8DMknNTIwPr9s2GmJXEhkRiNEUKEq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3ZLkACgkQp6FrSiUn
Q2qW5wf/Xf42boFL2TaRRAjnrRTnXXCPVqKQgoxADEFQF7gtlbKiVoiKLwAqHApY
QOoDBsh/LYibwm2T2pdxqQ64F1+8cAFuhdj2E3lahIxwQaB0fOA6Ejaurp8s29X8
FKnajTxvcRMkqnLBqua0sUQH9XkeTr1nltS11cQnCZ7NpQ/7crmdoh5RTf9sUlsh
oBppkU9Nd0Iuq1HBjsGkQs62NSBP7LU3djFjGC9UizL/ydX6jWib/Al8NuK9zSvg
OvBqm4uQULvjjMiWC3av+uYZavqe0wuWUOnAuIw1LOiNxf62xSvKRUmpvvIOX8Hc
rjOKIw3UYPyqVLMfH4xnwMjDELnHCw==
=6a+F
-----END PGP SIGNATURE-----

--IQ6h8DMknNTIwPr9s2GmJXEhkRiNEUKEq--
