Received: from eggs.gnu.org ([2001:4830:134:3::10]:59255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gCQeQ-0001in-IB
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gCQeN-0005Kj-BD
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:48:50 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com
	([104.47.38.137]:25581
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gCQeN-0005Jg-52
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:48:47 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 16 Oct 2018 14:48:43 +0000
Message-ID: <BN6PR2201MB1251B52F98B2096C04285A98C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1539701213-25046-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539701213-25046-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] target/mips: Fix misplaced 'break' in
 NM_SHRA_R_PH handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Tuesday, October 16, 2018 4:46 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Aleksandar Markovic; Stefan Markovic; Petar Jov=
anovic; > peter.maydell@linaro.org
> Subject: [PATCH] target/mips: Fix misplaced 'break' in NM_SHRA_R_PH handl=
ing
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Fix misplaced 'break' in handling of NM_SHRA_R_PH. Found by
> Coverity (CID 1395627).
>=20
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index faf05ae..e93c6f9 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -19991,8 +19991,8 @@ static void gen_pool32a5_nanomips_insn(DisasConte=
xt *ctx, int > opc,
>          case 0:
>              /* SHRA_PH */
>              gen_helper_shra_ph(v1_t, t0, v1_t);
> -            break;
>              gen_store_gpr(v1_t, rt);
> +            break;
>          case 1:
>              /* SHRA_R_PH */
>              gen_helper_shra_r_ph(v1_t, t0, v1_t);
> --
> 2.7.4
>=20
> =
