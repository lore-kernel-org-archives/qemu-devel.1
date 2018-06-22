Received: from eggs.gnu.org ([2001:4830:134:3::10]:32944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@mips.com>) id 1fWMNq-0001zQ-F0
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@mips.com>) id 1fWMNm-0005t8-Ij
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:45:50 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:43565)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aleksandar.Markovic@mips.com>)
	id 1fWMNm-0005rJ-9O
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:45:46 -0400
From: Aleksandar Markovic <Aleksandar.Markovic@mips.com>
Date: Fri, 22 Jun 2018 13:45:34 +0000
Message-ID: <35f88de544ad4c8b9a4c19ea3a66e6a6@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>,
	<20180620120620.12806-3-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-3-yongbok.kim@mips.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/35] target/mips: Fix microMIPS on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <Yongbok.Kim@mips.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, James Hogan <James.Hogan@mips.com>, Paul Burton <Paul.Burton@mips.com>, Matthew Fortune <Matthew.Fortune@mips.com>, Stefan Markovic <Stefan.Markovic@mips.com>

> From: Yongbok Kim <yongbok.kim@imgtec.com>
>
> Fix to activate microMIPS (and nanoMIPS) on reset when Config3.ISA =3D=3D=
 {1, 3}
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>

Reviewed-by: Aleksandar Markovic <aleksandar.markovic@mips.com>

> ---
>  target/mips/translate.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index e57d71e..bfbc300 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -20713,6 +20713,11 @@ void cpu_state_reset(CPUMIPSState *env)
>          env->CP0_Status |=3D (1 << CP0St_FR);
>      }
>
> +    if (env->CP0_Config3 & (1 << CP0C3_ISA)) {
> +        /*  microMIPS/nanoMIPS on reset when Config3.ISA =3D=3D {1, 3} *=
/
> +        env->hflags |=3D MIPS_HFLAG_M16;
> +    }
> +
>      /* MSA */
>      if (env->CP0_Config3 & (1 << CP0C3_MSAP)) {
>          msa_reset(env);
> --
> 1.9.1
