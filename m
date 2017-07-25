Received: from eggs.gnu.org ([2001:4830:134:3::10]:42770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1da1LG-0002Xt-9D
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1da1LF-0002ZT-ER
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:01:46 -0400
References: <1500973176-29235-1-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0b770d98-1efc-ee54-da06-d4868e338263@redhat.com>
Date: Tue, 25 Jul 2017 16:55:37 +0200
MIME-Version: 1.0
In-Reply-To: <1500973176-29235-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2MqAe1Gen4b4aHemHs8APKmgKO4TBK096"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-iotests: Fix reference
 output for 186
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2MqAe1Gen4b4aHemHs8APKmgKO4TBK096
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <0b770d98-1efc-ee54-da06-d4868e338263@redhat.com>
Subject: Re: [Qemu-block] [PATCH] qemu-iotests: Fix reference output for 186
References: <1500973176-29235-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500973176-29235-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-25 10:59, Kevin Wolf wrote:
> Commits 70f17a1 ('error: Revert unwanted change of warning messages')
> and e1824e5 ('qemu-iotests: Test 'info block'') had a semantic merge
> conflict, which results in failure for qemu-iotests case 186. Fix the
> reference output to consider the changes of 70f17a1.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/186.out | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--2MqAe1Gen4b4aHemHs8APKmgKO4TBK096
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZd1vpEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQGkS
B/9BruHaF24O5p9dCuiaV1V6hR9027m1nf/9Y+W9Y+aPLOHbFtr9hT69DR8k7GhP
PcttQ6zeUk/MINkUC7ceamuscOQ9+qzVAO54myos8uVc0I+2JSW6z9nxj375zn3Z
oJfRqurAZo6yf/HLMahtzNoJf5P//G9RXIS4Z6/w11ZiNs+GeDsqZ8lJVB2KutET
8InXBgLB09lsSyyv0ePlCeKMNPDhE2M/8C/zM5paw5+iUCWOewmOlC2enA/bl3dX
+wUywm8hb2zjO+MeDRtql+Jyz/PhTg+PlFls0GADjMC3xG6vjeWqCJgYMrkiBa80
O0MV2lvazsd9+NDiEc6DQW5y
=QAsY
-----END PGP SIGNATURE-----

--2MqAe1Gen4b4aHemHs8APKmgKO4TBK096--
