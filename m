Received: from eggs.gnu.org ([2001:4830:134:3::10]:37022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flYgc-0007e9-8K
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flYgY-0004bX-DZ
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:56:02 -0400
Received: from mail-eopbgr700131.outbound.protection.outlook.com
	([40.107.70.131]:53264
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1flYgX-0004ay-QN
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:55:58 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 3 Aug 2018 11:55:53 +0000
Message-ID: <BN7PR08MB4868CC2F3BD73F766E1329BFC6230@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>,
	<1533219424-7627-43-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-43-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 42/77] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Stefan Markovic <stefan.markovic@rt-rk.com>
> Sent: Thursday, August 2, 2018 4:16 PM
> Subject: [PATCH v6 42/77] target/mips: Add emulation of DSP ASE for nanoM=
IPS - part 5
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Add emulation of DSP ASE instructions for nanoMIPS - part 5.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 159 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 159 insertions(+)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index aa1dff5..2a45302 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -17403,6 +17403,161 @@ static void gen_pool32axf_2_nanomips_insn(Disas=
Context *ctx, uint32_t opc,
>      tcg_temp_free(v1_t);
>  }
>=20
> +    case NM_BITSWAP:
> +        gen_bitswap(ctx, OPC_BITSWAP, ret, rs);
> +        break;
> +    case NM_CLO:
> +        gen_cl(ctx, OPC_CLO, ret, rs);
> +        break;
> +    case NM_CLZ:
> +        gen_cl(ctx, OPC_CLZ, ret, rs);
> +        break;
> +    case NM_WSBH:
> +        gen_bshfl(ctx, OPC_WSBH, ret, rs);
> +        break;

It would have been better if these four non-DSP instructions were in a sepa=
rate patch, situated much earlier in this series, but since the net result =
is the same:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
