Received: from eggs.gnu.org ([2001:4830:134:3::10]:47422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqHoB-0006oD-Mf
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqHo8-0006OX-Fm
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:55:23 -0400
Received: from mail-by2nam03on0121.outbound.protection.outlook.com
	([104.47.42.121]:46624
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fqHo8-0006NL-2B
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:55:20 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 16 Aug 2018 12:55:14 +0000
Message-ID: <BN7PR08MB486850C58D2721C0A503C122C63E0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1534182832-554-59-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-59-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 58/87] elf: Add EM_NANOMIPS value as a
 valid one for e_machine field
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
> Subject: [PATCH v8 58/87] elf: Add EM_NANOMIPS value as a valid one for e=
_machine field
>=20
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
>=20
> Value 249 is registered as valid for usage for nanoMIPS executables.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  include/elf.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/include/elf.h b/include/elf.h
> index 28a5a63..312f68a 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -143,6 +143,8 @@ typedef int64_t  Elf64_Sxword;
>=20
>  #define EM_RISCV        243     /* RISC-V */
>=20
> +#define EM_NANOMIPS     249     /* Wave Computing nanoMIPS */
> +
>  /*
>   * This is an interim value that we will use until the committee comes
>   * up with a final number.
> --
> 2.7.4=20
>=20

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
