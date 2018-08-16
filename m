Received: from eggs.gnu.org ([2001:4830:134:3::10]:37232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqH24-0007uD-J9
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqH21-000422-Dw
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:05:40 -0400
Received: from mail-sn1nam02on0114.outbound.protection.outlook.com
	([104.47.36.114]:33313
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fqH21-00041b-6U
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:05:37 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 16 Aug 2018 12:05:33 +0000
Message-ID: <BN7PR08MB4868602A6910D3F01ACE23D1C63E0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1534182832-554-56-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-56-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 55/87] target/mips: Adjust
 set_hflags_for_handler() for nanoMIPS
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
> Subject: [PATCH v8 55/87] target/mips: Adjust set_hflags_for_handler() fo=
r nanoMIPS
>=20
> From: James Hogan <james.hogan@mips.com>
>=20
> We shouldn't clear M16 mode when entering an interrupt on nanoMIPS,
> otherwise we'll start interpreting the code as normal MIPS code.
>=20
> Signed-off-by: James Hogan <james.hogan@mips.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
> target/mips/helper.c | 3 +++
>  1 file changed, 3 insertions(+)

This code segment should be re-thought and redesigned in future cleanups. F=
or now:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
