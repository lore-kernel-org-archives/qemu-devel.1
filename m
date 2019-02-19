Received: from eggs.gnu.org ([209.51.188.92]:50045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gw6UT-0000nl-1o
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gw6UQ-0004iV-OS
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:35:20 -0500
Received: from mail-eopbgr760122.outbound.protection.outlook.com
	([40.107.76.122]:2375
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1gw6UQ-0004hm-Ac
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:35:18 -0500
From: Aleksandar Rikalo <arikalo@wavecomp.com>
Date: Tue, 19 Feb 2019 14:35:13 +0000
Message-ID: <DM5PR22MB1658D9BACA06ACB259C5821BD27C0@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1550503897-31141-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1550503897-31141-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550503897-31141-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/7] tests/tcg: target/mips: Add wrappers
 for MSA integer compare instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, February 18, 2019 4:31 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Aleksandar Markovic; peter.maydell@linaro.org; =
Aleksandar Rikalo
> Subject: [PATCH 4/7] tests/tcg: target/mips: Add wrappers for MSA integer=
 compare instructions
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add wrappers for MSA integer compare instructions.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  tests/tcg/mips/include/wrappers_msa.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/inclu=
de/wrappers_msa.h
> index 7a77fb9..3280f9b 100644
> --- a/tests/tcg/mips/include/wrappers_msa.h
> +++ b/tests/tcg/mips/include/wrappers_msa.h
> @@ -97,5 +97,30 @@ DO_MSA__WD__WS_WT(NOR_V, nor.v)
>  DO_MSA__WD__WS_WT(OR_V, or.v)
>  DO_MSA__WD__WS_WT(XOR_V, xor.v)
>
> +DO_MSA__WD__WS_WT(CEQ_B, ceq.b)
> +DO_MSA__WD__WS_WT(CEQ_H, ceq.h)
> +DO_MSA__WD__WS_WT(CEQ_W, ceq.w)
> +DO_MSA__WD__WS_WT(CEQ_D, ceq.d)
> +
> +DO_MSA__WD__WS_WT(CLE_S_B, cle_s.b)
> +DO_MSA__WD__WS_WT(CLE_S_H, cle_s.h)
> +DO_MSA__WD__WS_WT(CLE_S_W, cle_s.w)
> +DO_MSA__WD__WS_WT(CLE_S_D, cle_s.d)
> +
> +DO_MSA__WD__WS_WT(CLE_U_B, cle_u.b)
> +DO_MSA__WD__WS_WT(CLE_U_H, cle_u.h)
> +DO_MSA__WD__WS_WT(CLE_U_W, cle_u.w)
> +DO_MSA__WD__WS_WT(CLE_U_D, cle_u.d)
> +
> +DO_MSA__WD__WS_WT(CLT_S_B, clt_s.b)
> +DO_MSA__WD__WS_WT(CLT_S_H, clt_s.h)
> +DO_MSA__WD__WS_WT(CLT_S_W, clt_s.w)
> +DO_MSA__WD__WS_WT(CLT_S_D, clt_s.d)
> +
> +DO_MSA__WD__WS_WT(CLT_U_B, clt_u.b)
> +DO_MSA__WD__WS_WT(CLT_U_H, clt_u.h)
> +DO_MSA__WD__WS_WT(CLT_U_W, clt_u.w)
> +DO_MSA__WD__WS_WT(CLT_U_D, clt_u.d)
> +
>
>  #endif
> --
> 2.7.4
>
>

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
