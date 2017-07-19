Received: from eggs.gnu.org ([2001:4830:134:3::10]:35695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXksY-00054Q-O5
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXksV-0000vz-LT
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:02:46 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:39941
	helo=imgpgp01.kl.imgtec.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <James.Hogan@imgtec.com>)
	id 1dXksV-0000vY-CW
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:02:43 -0400
Date: Wed, 19 Jul 2017 10:02:41 +0100
From: James Hogan <james.hogan@imgtec.com>
Message-ID: <20170719090241.GB6973@jhogan-linux.le.imgtec.org>
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
	<150041287987.87.17542667042734114407@5d477a5b5989>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5aIuwG0DlmrBHPsb"
Content-Disposition: inline
In-Reply-To: <150041287987.87.17542667042734114407@5d477a5b5989>
Subject: Re: [Qemu-devel] [PATCH 0/14] target/mips: Add Enhanced Virtual
 Addressing (EVA) support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, yongbok.kim@imgtec.com, aurelien@aurel32.net, petar.jovanovic@imgtec.com

--5aIuwG0DlmrBHPsb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 02:21:20PM -0700, no-reply@patchew.org wrote:
> Checking PATCH 2/14: target/mips: Fix TLBWI shadow flush for EHINV, XI, R=
I...
> ERROR: space prohibited after that '&' (ctx:WxW)
> #44: FILE: target/mips/op_helper.c:2045:
> +    XI0 =3D (env->CP0_EntryLo0 >> CP0EnLo_XI) & 1;
>                                              ^
>=20
> ERROR: space prohibited after that '&' (ctx:WxW)
> #45: FILE: target/mips/op_helper.c:2046:
> +    RI0 =3D (env->CP0_EntryLo0 >> CP0EnLo_RI) & 1;
>                                              ^
>=20
> ERROR: space prohibited after that '&' (ctx:WxW)
> #48: FILE: target/mips/op_helper.c:2049:
> +    XI1 =3D (env->CP0_EntryLo1 >> CP0EnLo_XI) & 1;
>                                              ^
>=20
> ERROR: space prohibited after that '&' (ctx:WxW)
> #49: FILE: target/mips/op_helper.c:2050:
> +    RI1 =3D (env->CP0_EntryLo1 >> CP0EnLo_RI) & 1;
>                                              ^
>=20
> total: 4 errors, 0 warnings, 34 lines checked

These are false positives. The code looks fine to me. They are binary
bitwise-and operators, not unary address-of operators.

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

It looks orphaned.

> Checking PATCH 10/14: target/mips: Add an MMU mode for ERL...
> ERROR: trailing statements should be on next line
> #94: FILE: target/mips/op_helper.c:98:
> +    case 3: cpu_##insn##_error_ra(env, addr, val, retaddr); break;      \
>=20
> ERROR: trailing statements should be on next line
> #102: FILE: target/mips/op_helper.c:1456:
> +        case 3: qemu_log(", ERL\n"); break;
>=20
> ERROR: trailing statements should be on next line
> #110: FILE: target/mips/op_helper.c:2251:
> +        case 3: qemu_log(", ERL\n"); break;
>=20
> total: 3 errors, 0 warnings, 79 lines checked

These are all consistent with the surrounding code.

> Checking PATCH 12/14: target/mips: Implement segmentation control...
> ERROR: braces {} are necessary for all arms of this statement
> #246: FILE: target/mips/helper.c:836:
> +            if ((R !=3D 0 || UX) && (R !=3D 3 || KX) &&
> [...]
>=20
> ERROR: braces {} are necessary for all arms of this statement
> #258: FILE: target/mips/helper.c:854:
> +            if ((R !=3D 0 || UX) && (R !=3D 3 || KX) &&
> [...]
>=20
> total: 2 errors, 0 warnings, 234 lines checked

And these are both pre-existing style issues that the patch hasn't
changed.

Cheers
James

--5aIuwG0DlmrBHPsb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllvIDAACgkQbAtpk944
dnpqexAAj/J934F6hetLjYYX5HEtEm9eGfs+LhAd8LJ+wrHJ+MEZFOFbOT+YkQuZ
ABXA6Db/NF2k0LaNMedpbWb9dS/WqzZWzfKMLcr4bxkMaeDbeIQ47tMw547XtIKi
GZwlFpHweWJhR43fmf/FZE0aN5vQxAe2gWAyPffSNPSS/7St/cCgPxXlf8jSXyPW
j92yQ2sP8480E0FlVLlH8Aqw1J/oNvr6pmHGOmTpvy/5p2AuTf1tJlcaWtWTFyTC
Q5Z+ATn4kyQ2Rxckgm7te0U3JDEgRv3eVp1W4xmnskPWpYql++ukqUj895f1lqEL
TJ1Qkshka0YZVJMB1xmtKAhiSrKMu3IvFd09ZFSccYtk7VvIepvLggPKrVLqqR7G
NISBlEE28Ho9/rkA+2UsAv4fZCQIm7czDJ0KStJR2gaT/4uE4xqE1Q88PcDUCY7j
lgUKtezRrXjoxTlq1MXdm1If/XEvlymTCTZYB1dKd2p9FyjAiWm+mIUivsRIa5M2
G/JRpPur6mAehZT7EOoktX8u/Sra25E8jGjhInaoj61XEExR4/JVRJ0P70H3xItN
n71kA6p3L5HedosonwKUWrpMy7lpvmgAp0xulO9N6rij74OvG/klCJCztfeGj5es
PhFsWRBKc0l7aIyMA98ZGa3bTzLviNZeTZQDIAiT+d6rS6IbweM=
=QVHK
-----END PGP SIGNATURE-----

--5aIuwG0DlmrBHPsb--
