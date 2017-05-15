Received: from eggs.gnu.org ([2001:4830:134:3::10]:55756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAGmi-0003i9-3R
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAGmd-0000Rn-PP
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:15:40 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAGmd-0000RH-Kw
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:15:35 -0400
Received: by mail-qk0-x244.google.com with SMTP id y128so17324557qka.3
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 07:15:35 -0700 (PDT)
Date: Mon, 15 May 2017 15:15:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170515141533.GO1201@stefanha-x1.localdomain>
References: <20170513093248.18230-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ickEXl+ukcSQ/3E"
Content-Disposition: inline
In-Reply-To: <20170513093248.18230-1-aurelien@aurel32.net>
Subject: Re: [Qemu-devel] [PULL 00/15] Queued target/sh4 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--4ickEXl+ukcSQ/3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 13, 2017 at 11:32:33AM +0200, Aurelien Jarno wrote:
> The following changes since commit ecc1f5adeec4e3324d1b695a7c54e3967c5269=
49:
>=20
>   maintainers: Add myself as linux-user reviewer (2017-05-11 13:31:11 -04=
00)
>=20
> are available in the git repository at:
>=20
>   git://git.aurel32.net/qemu.git tags/pull-target-sh4-20170513
>=20
> for you to fetch changes up to 57e2d417d3108a6e28e705f4a9d6ff22ab79af16:
>=20
>   target/sh4: use cpu_loop_exit_restore (2017-05-13 11:18:27 +0200)
>=20
> ----------------------------------------------------------------
> Queued target/sh4 patches
>=20
> ----------------------------------------------------------------
> Aurelien Jarno (15):
>   target/sh4: split ctx->flags into ctx->tbflags and ctx->envflags
>   target/sh4: get rid of DELAY_SLOT_CLEARME
>   target/sh4: do not include DELAY_SLOT_TRUE in the TB state
>   target/sh4: move DELAY_SLOT_TRUE flag into a separate global
>   target/sh4: fix BS_STOP exit
>   target/sh4: fix BS_EXCP exit
>   target/sh4: only save flags state at the end of the TB
>   target/sh4: fold ctx->bstate =3D BS_BRANCH into gen_conditional_jump
>   target/sh4: optimize gen_store_fpr64
>   target/sh4: optimize gen_write_sr using extract op
>   target/sh4: generate fences for SH4
>   target/sh4: implement tas.b using atomic helper
>   target/sh4: movua.l is an SH4-A only instruction
>   target/sh4: trap unaligned accesses
>   target/sh4: use cpu_loop_exit_restore
>=20
>  target/sh4/cpu.c       |   1 +
>  target/sh4/cpu.h       |  18 ++-
>  target/sh4/helper.c    |   4 +-
>  target/sh4/op_helper.c |  26 ++--
>  target/sh4/translate.c | 322 +++++++++++++++++++++++--------------------=
------
>  5 files changed, 181 insertions(+), 190 deletions(-)
>=20
> --=20
> 2.11.0
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--4ickEXl+ukcSQ/3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGbgFAAoJEJykq7OBq3PIjLgIAMT7RqR7xaQd/ZmEPNs9iNH3
L14VqO0/TXBeAfOCsoBCGy1MSdntSQq+2PV8i4N6VPG4qEKpApdir4pNbCnpeIzU
tv9n1RfZywfvbnEEC+2oG/+SggI+JWnoAx38hE+mC1Zmy5uMu3VyfOG+BCziaIT1
owmsvEGbl2Dgbhn680r7O+8FsH3IMZZ6FV/5Tbr23FBVN7g+PQjKn6Vm4stQLzGe
cBWN+IJWkpHrNur+CBQYzfMF5HL5WiW2J/T25NpsqkjiKjw0s5Cw+YamsqEHdhqD
vVAEu0bObcf1aAjoKzztNe2+ckdVBoab6imyiDie0F6YFWK6t79m7LRTZvUuwtk=
=23dw
-----END PGP SIGNATURE-----

--4ickEXl+ukcSQ/3E--
