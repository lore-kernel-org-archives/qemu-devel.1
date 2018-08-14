Received: from eggs.gnu.org ([2001:4830:134:3::10]:47307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fpXH2-0002VR-3r
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fpXGy-0006W3-Pv
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:14:04 -0400
Received: from mail-eopbgr690120.outbound.protection.outlook.com
	([40.107.69.120]:33111
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fpXGy-0006VN-BN
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:14:00 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 14 Aug 2018 11:13:55 +0000
Message-ID: <SN6PR08MB4879D855A6FFDC5477777B52C6380@SN6PR08MB4879.namprd08.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1534182832-554-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 03/87] target/mips: Avoid case
 statements formulated by ranges - part 2
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
> Subject: [PATCH v8 03/87] target/mips: Avoid case statements formulated b=
y ranges - part 2
>=20
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
>=20
> Remove "range style" case statements to make code analysis easier.
> This patch handles cases when the values in the range in question
> were not properly defined.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 78 +++++++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 71 insertions(+), 7 deletions(-)

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=
