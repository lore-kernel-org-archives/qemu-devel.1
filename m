Received: from eggs.gnu.org ([209.51.188.92]:41302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGSB9-0002hU-ED
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGSB6-0001Xx-HZ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:47:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hGSB6-0001X6-3H
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:47:28 -0400
References: <20190416083150.19649-1-richard.henderson@linaro.org>
	<20190416083150.19649-3-richard.henderson@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6860567d-8678-783e-e001-1dd53785c84a@redhat.com>
Date: Tue, 16 Apr 2019 12:47:25 -0500
MIME-Version: 1.0
In-Reply-To: <20190416083150.19649-3-richard.henderson@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Gl6sjBxiYzaJjoYfESXC9MMMz0kFLTVTg"
Subject: Re: [Qemu-devel] [PATCH 2/2] tcg: Restart after TB code generation
 overflow
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
--Gl6sjBxiYzaJjoYfESXC9MMMz0kFLTVTg
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <6860567d-8678-783e-e001-1dd53785c84a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] tcg: Restart after TB code generation
 overflow
References: <20190416083150.19649-1-richard.henderson@linaro.org>
 <20190416083150.19649-3-richard.henderson@linaro.org>
In-Reply-To: <20190416083150.19649-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/16/19 3:31 AM, Richard Henderson wrote:
> If a TB generates too much code, try again with fewer insns.
>=20
> Fixes: https://bugs.launchpad.net/bugs/1824853
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/translate-all.c | 39 +++++++++++++++++++++++++++++++++------=

>  tcg/tcg.c                 |  4 ++++
>  2 files changed, 37 insertions(+), 6 deletions(-)
>=20

> +             * Try again with half as many insns as we attempted this =
time.
> +             * If a single insn overflows, there's a bug somewhere...
> +             */
> +            max_insns =3D tb->icount;
> +qemu_log("TB overflow: pc=3D%lx insns=3D%d\n", (unsigned long)pc, max_=
insns);

Leftover debugging? Or should it be kept but properly indented?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Gl6sjBxiYzaJjoYfESXC9MMMz0kFLTVTg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly2FS0ACgkQp6FrSiUn
Q2oO3wf+JzSbQAi/nqmHj1mo4x4wtKkB/6j3AjTdbT71Xx47e/KcGLhBL3wwt5gc
J321/DmNba35R+VSEKmqf1LIBtfZPr+K8QHjayRUptqe6OD1zOo9nHTJlkO/BlZ5
7yKRBZWsJxCKM7RSzY2mHpG6uwGHjjDPa1E5bRP6r99gzQpwSoQao2Q3ArUibPT9
lLQmmk7R7QgLekhIanO9Z+Tq5xEYFamdu8uIP7cHGXC6xmsa13xSOHdel3JGHksO
JUn817hTWCFGnf8xoL2a3deost/SltBi6tOj0Nx129iPc1D1/YLDr3uVCOkb0/u+
4Abe6o7dGHCWkWeYpmOX2WB/nzVSfQ==
=PkxK
-----END PGP SIGNATURE-----

--Gl6sjBxiYzaJjoYfESXC9MMMz0kFLTVTg--
