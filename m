Received: from eggs.gnu.org ([2001:4830:134:3::10]:47851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqHpr-0000LS-6q
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqHpn-0007NS-4K
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:57:07 -0400
Received: from mail-eopbgr690110.outbound.protection.outlook.com
	([40.107.69.110]:61026
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fqHpm-0007La-OL
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:57:03 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 16 Aug 2018 12:56:57 +0000
Message-ID: <BN7PR08MB48689AECFBCE39DEC546EB93C63E0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1534182832-554-55-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-55-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 54/87] target/mips: Adjust
 exception_resume_pc() for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 13, 2018 7:53 PM
>=20
> Subject: [PATCH v8 54/87] target/mips: Adjust exception_resume_pc() for n=
anoMIPS
>=20
> From: James Hogan <james.hogan@mips.com>
>=20
> We shouldn't set the ISA bit in CP0_EPC for nanoMIPS.
>=20
> Signed-off-by: James Hogan <james.hogan@mips.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index b25e000..b429671 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -656,7 +656,8 @@ target_ulong exception_resume_pc (CPUMIPSState *env)
>      target_ulong bad_pc;
>      target_ulong isa_mode;
>=20
> -    isa_mode =3D !!(env->hflags & MIPS_HFLAG_M16);
> +    isa_mode =3D env->hflags & MIPS_HFLAG_M16 &&
> +                !(env->insn_flags & ISA_NANOMIPS32);
>      bad_pc =3D env->active_tc.PC | isa_mode;
>      if (env->hflags & MIPS_HFLAG_BMASK) {
>          /* If the exception was raised from a delay slot, come back to
> --
> 2.7.4
>=20


Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
