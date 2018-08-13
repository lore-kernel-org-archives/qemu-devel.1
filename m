Received: from eggs.gnu.org ([2001:4830:134:3::10]:36671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fpHLC-0008M4-7v
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 14:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fpHL9-0007IJ-0W
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 14:13:18 -0400
Received: from mail-by2nam01on0110.outbound.protection.outlook.com
	([104.47.34.110]:27566
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fpHL8-0007HV-DR
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 14:13:14 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 13 Aug 2018 18:13:06 +0000
Message-ID: <BN7PR08MB486891F0728900973F1E8508C6390@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1534182832-554-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-10-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 09/87] target/mips: Add support for
 availability control via bit MT
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
> Sent: Monday, August 13, 2018 7:52 PM
>=20
> Subject: [PATCH v8 09/87] target/mips: Add support for availability contr=
ol via bit MT
>=20
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
>=20
> Add a field in hflags for MT bit, and functions check_mt() and
> check_cp0_mt().
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/cpu.h       |  3 ++-
>  target/mips/internal.h  |  6 +++++-
>  target/mips/translate.c | 29 +++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> ...
> +/*
> + * This code generates a "coprocessor unusable" if CP) is not
> + * available, and, if that is not the case, generates a "reserved
> + * instruction" exception if the Config5 MT bit is NOT set.
> + * This is used for some of instructions in MT ASE.
> + */

" "coprocessor unusable" if CP) " should be " "coprocessor unusable" except=
ion if CP0 ". Otherwise:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
