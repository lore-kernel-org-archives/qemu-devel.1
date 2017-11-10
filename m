Received: from eggs.gnu.org ([2001:4830:134:3::10]:36686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDGkP-0001pw-6c
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 16:22:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDGkO-0001JU-8L
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 16:21:57 -0500
References: <20170616135847.17726-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <73457c1e-19c7-084d-852d-27e39a574c76@redhat.com>
Date: Fri, 10 Nov 2017 22:21:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170616135847.17726-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6bmkoD1QF20t9B7BtESAAjb3ftPLLpeB6"
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
--6bmkoD1QF20t9B7BtESAAjb3ftPLLpeB6
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <73457c1e-19c7-084d-852d-27e39a574c76@redhat.com>
Subject: Re: [PATCH] iotests: Add test for failing qemu-img commit
References: <20170616135847.17726-1-mreitz@redhat.com>
In-Reply-To: <20170616135847.17726-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-16 15:58, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> In order to pass, this depends on "fix: avoid an infinite loop or a
> dangling pointer problem in img_commit"
> (http://lists.nongnu.org/archive/html/qemu-block/2017-06/msg00443.html)=

> and on the "block: Don't compare strings in bdrv_reopen_prepare()"
> series
> (http://lists.nongnu.org/archive/html/qemu-block/2017-06/msg00424.html)=
=2E
> ---
>  tests/qemu-iotests/020     | 27 +++++++++++++++++++++++++++
>  tests/qemu-iotests/020.out | 17 +++++++++++++++++
>  2 files changed, 44 insertions(+)

Finally applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--6bmkoD1QF20t9B7BtESAAjb3ftPLLpeB6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloGGGsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AikkIAML6ne/K/qE6qLGryaMxcqw7Gnny9KEk
v3fInTqUm8QhWOMnvdmOD6uHkml/CRlevLzci12jQShq88OHeeM6zgTee0eWaTWK
SviooidZTE2hycRe+Xww8lFru5UwCbWwMj3iJkVUm248A1HazDZB6tTqSpFToixF
Hg+54XNby7BbQpdirxn//ZKQJ/lyvvFl368tEEBpHMXmY2/764k+OH2gJKoAuLAp
F6SNdhUI2ORdTocZwvuq92gFX+lyYxuFrlFW5MrGjTTiiGkJk4IDPHsIvzmvjOhK
jQsMq/lwFjeRM3Fd/wukWOF/vaOjkz4KSnmYH8A83Jg0PEYQ199ym4s=
=1xz9
-----END PGP SIGNATURE-----

--6bmkoD1QF20t9B7BtESAAjb3ftPLLpeB6--
