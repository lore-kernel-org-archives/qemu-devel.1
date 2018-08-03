Received: from eggs.gnu.org ([2001:4830:134:3::10]:33097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flYJW-0001q4-9u
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flYJR-0007rh-7Y
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:32:10 -0400
Received: from mail-dm3nam03on0714.outbound.protection.outlook.com
	([2a01:111:f400:fe49::714]:59723
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1flYJR-0007rE-0H
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:32:05 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 3 Aug 2018 11:31:59 +0000
Message-ID: <BN7PR08MB4868827A761F586B4B935B2CC6230@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>,
	<1533219424-7627-42-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-42-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 41/77] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 4
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
> Subject: [PATCH v6 41/77] target/mips: Add emulation of DSP ASE for nanoM=
IPS - part 4
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Add emulation of DSP ASE instructions for nanoMIPS - part 4.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 365 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 365 insertions(+)
>=20

> +        case NM_BALIGN:
> +            if (rt !=3D 0) {
> +                gen_load_gpr(t0, rs);
> +                rd &=3D 3;
> +                if (rd !=3D 0 && rd !=3D 2) {
> +                    tcg_gen_shli_tl(cpu_gpr[ret], cpu_gpr[ret], 8 * rd);
> +                    tcg_gen_ext32u_tl(t0, t0);
> +                    tcg_gen_shri_tl(t0, t0, 8 * (4 - rd));
> +                    tcg_gen_or_tl(cpu_gpr[ret], cpu_gpr[ret], t0);
> +                }
> +                tcg_gen_ext32s_tl(cpu_gpr[ret], cpu_gpr[ret]);
> +            }
> +            break;

Missing availability control, here and in many other places in this patch.

Aleksandar M.=
