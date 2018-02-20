Received: from eggs.gnu.org ([2001:4830:134:3::10]:58791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eoB1i-0004Cd-78
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eoB1f-0003HP-JL
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:44:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1eoB1f-0003Fx-Cg
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:44:19 -0500
References: <20180207225540.31698-1-richard.henderson@linaro.org>
	<20180207225540.31698-20-richard.henderson@linaro.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ddb804a5-6c00-57c3-03ef-d77daedda511@redhat.com>
Date: Tue, 20 Feb 2018 17:44:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180207225540.31698-20-richard.henderson@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f5KeM8ejA4Qlf5OHeHyin7sCuxdXpIxgV"
Subject: Re: [Qemu-devel] [PULL 19/20] tcg/i386: Add vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f5KeM8ejA4Qlf5OHeHyin7sCuxdXpIxgV
From: Max Reitz <mreitz@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <ddb804a5-6c00-57c3-03ef-d77daedda511@redhat.com>
Subject: Re: [Qemu-devel] [PULL 19/20] tcg/i386: Add vector operations
References: <20180207225540.31698-1-richard.henderson@linaro.org>
 <20180207225540.31698-20-richard.henderson@linaro.org>
In-Reply-To: <20180207225540.31698-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-07 23:55, Richard Henderson wrote:
> The x86 vector instruction set is extremely irregular.  With newer
> editions, Intel has filled in some of the blanks.  However, we don't
> get many 64-bit operations until SSE4.2, introduced in 2009.
>=20
> The subsequent edition was for AVX1, introduced in 2011, which added
> three-operand addressing, and adjusts how all instructions should be
> encoded.
>=20
> Given the relatively narrow 2 year window between possible to support
> and desirable to support, and to vastly simplify code maintainence,
> I am only planning to support AVX1 and later cpus.
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/i386/tcg-target.h     |  41 +-
>  tcg/i386/tcg-target.opc.h |  13 +
>  tcg/i386/tcg-target.inc.c | 987 ++++++++++++++++++++++++++++++++++++++=
+++++---
>  3 files changed, 987 insertions(+), 54 deletions(-)
>  create mode 100644 tcg/i386/tcg-target.opc.h

This patch makes make check with clang -m32 fail for me.  (Interestingly
enough, though, clang -m64 and gcc -m32 work fine.)

  GTESTER check-qtest-x86_64
qemu-system-x86_64: tcg/tcg.c:1928: void process_op_defs(TCGContext *):
Assertion `tdefs !=3D ((void*)0)' failed.
socket_accept failed: Resource temporarily unavailable
**
ERROR:tests/libqtest.c:218:qtest_init_without_qmp_handshake: assertion
failed: (s->fd >=3D 0 && s->qmp_fd >=3D 0)
GTester: last random seed: R02Sd65222fb9e582d96aaa44bfe71602302
qemu-system-x86_64: tcg/tcg.c:1928: void process_op_defs(TCGContext *):
Assertion `tdefs !=3D ((void*)0)' failed.
socket_accept failed: Resource temporarily unavailable
**
ERROR:tests/libqtest.c:218:qtest_init_without_qmp_handshake: assertion
failed: (s->fd >=3D 0 && s->qmp_fd >=3D 0)
GTester: last random seed: R02S244a2da30d9373db0cf52cd40f1b726a

(This is with the tdefs !=3D NULL assertion enabled; usually, the qemu
process just crashes instead of printing that assertion failure message.)=


Max


--f5KeM8ejA4Qlf5OHeHyin7sCuxdXpIxgV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqMUFgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AjJYH/3FcfhiEQ23HuRbsEqIPJTdEG4ck+O0v
gXwUH0qwaDzIg63akQmoHUUreaHzgeJFa+QGvX4o+N/JULJgNN1EG9YyahnnD4vV
DyNYBVWGG8mnQSJkCKzw+YJ/vOIF2JDSGXsnKAEC/sqSLZf3lzbqoNxfU102IILP
lVCYEzN73Mt5IRWzkiHdaf45SXXgkidow8wY+cq4YFzSv80DwON3DjMLmWsjgbT3
tEHS+aBq9T8Vg4WYal6Wb+o6Uh6p8Do6aPvYVrAHtzn5qcJmddYr3wsxOShpOBqh
wYfjzlEa0cVuhjjX/fSHAFRfR4vBDIlkItzj6Bl9CDr9so3FHEL/gKI=
=8ZoC
-----END PGP SIGNATURE-----

--f5KeM8ejA4Qlf5OHeHyin7sCuxdXpIxgV--
