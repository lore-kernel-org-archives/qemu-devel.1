Received: from eggs.gnu.org ([2001:4830:134:3::10]:54519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAGiP-0000iB-Dn
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAGiK-0006R1-Iu
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:11:13 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAGiK-0006Qt-Do
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:11:08 -0400
Received: by mail-qk0-x243.google.com with SMTP id y128so17296690qka.3
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 07:11:08 -0700 (PDT)
Date: Mon, 15 May 2017 15:11:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170515141105.GM1201@stefanha-x1.localdomain>
References: <20170512234009.32557-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YS7t75H5cNTCpbja"
Content-Disposition: inline
In-Reply-To: <20170512234009.32557-1-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PULL 0/9] Queued s390 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com


--YS7t75H5cNTCpbja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 04:40:00PM -0700, Richard Henderson wrote:
> This is a combination of my queued patches and those
> posted by Aurelien this week.
>=20
>=20
> r~
>=20
>=20
> The following changes since commit ecc1f5adeec4e3324d1b695a7c54e3967c5269=
49:
>=20
>   maintainers: Add myself as linux-user reviewer (2017-05-11 13:31:11 -04=
00)
>=20
> are available in the git repository at:
>=20
>   git://github.com/rth7680/qemu.git tags/pull-s390-20170512
>=20
> for you to fetch changes up to 538fad597d898f677f81cb4daacd37e7cdc18e6e:
>=20
>   target/s390x: implement serialization in BRANCH CONDITION (2017-05-12 1=
5:48:41 -0700)
>=20
> ----------------------------------------------------------------
> Queued target/s390 patches
>=20
> ----------------------------------------------------------------
> Aurelien Jarno (3):
>       target/s390x: mask the SIGP order_code using SIGP_ORDER_MASK
>       target/s390x: fix SIGNAL PROCESSOR return value
>       target/s390x: implement serialization in BRANCH CONDITION
>=20
> Eric Bischoff (1):
>       target/s390x: Implement LOAD PAIR DISJOINT
>=20
> Miroslav Benes (1):
>       target/s390x: Implement LOAD PROGRAM PARAMETER
>=20
> Richard Henderson (4):
>       target/s390x: Implement STORE FACILITIES LIST EXTENDED
>       target/s390x: Diagnose specification exception for atomics
>       target/s390x: Use atomic operations for COMPARE SWAP
>       target/s390x: Use atomic operations for LOAD AND OP
>=20
>  target/s390x/cpu.c         |   1 +
>  target/s390x/cpu.h         |   6 ++
>  target/s390x/helper.c      |  16 +++
>  target/s390x/helper.h      |   3 +
>  target/s390x/insn-data.def |  38 ++++---
>  target/s390x/kvm.c         |   2 -
>  target/s390x/mem_helper.c  |  40 ++++++++
>  target/s390x/misc_helper.c |  62 +++++++++++-
>  target/s390x/translate.c   | 245 ++++++++++++++++++++++++++-------------=
------
>  9 files changed, 288 insertions(+), 125 deletions(-)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--YS7t75H5cNTCpbja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGbb5AAoJEJykq7OBq3PIFFYIAJW6RY7UrBUE5vAsb2pqQ0bq
HtjIbomuOTNEJKxdYS1GlDrHcjGFakrFiAqVDBYsMQHQ38hF62C4RPWJSLIJBuol
yoFORl/vgPrcjac8TOaAdveUQW6tQh+klS4vsrbAAFRTl/lXGexytKZhTAGCK3Cc
EXzuilYosVnaE6EzN58SJ1lKjfJrusZhlnncPwH698TR8XWIOTwUB3F+bMSUmGSU
5S0OvmQwUL+uYoX+9u7V9hwhrzxBpEXCCg97+0U7EwXApA/ezgieYMxILK+SJ0kA
binWT19ocTnFFGT80f0mgn7qEtCOssSM2vN64MNNgTbqwWpoeVNXpjy4030OtTo=
=NfLA
-----END PGP SIGNATURE-----

--YS7t75H5cNTCpbja--
