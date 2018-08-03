Received: from eggs.gnu.org ([2001:4830:134:3::10]:38407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flYkq-00026e-PY
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1flYkl-00075X-B6
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:00:24 -0400
Received: from mail-bn3nam01on0721.outbound.protection.outlook.com
	([2a01:111:f400:fe41::721]:59996
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1flYkl-00074u-57
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:00:19 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 3 Aug 2018 12:00:13 +0000
Message-ID: <SN6PR08MB4879775CC6CC8C50D9743B38C6230@SN6PR08MB4879.namprd08.prod.outlook.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>,
	<1533219424-7627-44-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-44-git-send-email-stefan.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 43/77] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 6
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

>=20
> From: Stefan Markovic <stefan.markovic@rt-rk.com>
> Sent: Thursday, August 2, 2018 4:16 PM
> Subject: [PATCH v6 43/77] target/mips: Add emulation of DSP ASE for nanoM=
IPS - part 6
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Add emulation of DSP ASE instructions for nanoMIPS - part 6.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 64 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 64 insertions(+)

> +    case NM_REPL_QB:
> +        {
> +            check_dsp(ctx);
> +            target_long result;
> +            imm =3D extract32(ctx->opcode, 13, 8);
> +            result =3D (uint32_t)imm << 24 |
> +                     (uint32_t)imm << 16 |
> +                    (uint32_t)imm << 8  |
=20
Missalignment. Otherwise:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
