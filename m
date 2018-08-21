Received: from eggs.gnu.org ([208.118.235.92]:52226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fs4Ta-0000Yv-6M
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fs4TW-000565-P7
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:05:30 -0400
Received: from mail-eopbgr680117.outbound.protection.outlook.com
	([40.107.68.117]:12117
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fs4TW-00055H-IB
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:05:26 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 21 Aug 2018 11:05:23 +0000
Message-ID: <BN7PR08MB4868095BA930A863C6834ECDC6310@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1534789014-8310-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534789014-8310-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v11 04/46] target/mips: Prevent switching
 mode related to Config3 ISA bit for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Dimitrije Nikolic <dnikolic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 20, 2018 8:16 PM
>=20
> Subject: [PATCH v11 04/46] target/mips: Prevent switching mode related to=
 Config3 ISA bit for nanoMIPS
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Only if Config3.ISA is 3 (microMIPS), the mode should be switched in
> cpu_state_reset(). Config3.ISA is 1 for nanoMIPS processors, and no mode
> change should happen.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
> target/mips/translate.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)


Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
