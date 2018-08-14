Received: from [2001:4830:134:3::10] (port=56882 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fpcuk-0004iE-5E
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fpcud-0000Qr-ND
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:15:23 -0400
Received: from mail-dm3nam03on0700.outbound.protection.outlook.com
	([2a01:111:f400:fe49::700]:41211
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fpcud-0000Qd-D1
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:15:19 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 14 Aug 2018 15:52:21 +0000
Message-ID: <SN6PR08MB4879EA03D85F08B67E9257D2C6380@SN6PR08MB4879.namprd08.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 00/87] Add nanoMIPS support to QEMU
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

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com
> Sent: Monday, August 13, 2018 7:52 PM
>=20
> Subject: [PATCH v8 00/87] Add nanoMIPS support to QEMU
>=20
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> v7->v8:
>=20
>   - the series is slightly reorganized so that:
>      - patches 1-19 are fixes and improvements that are not
>      dependent on the existence of nanoMIPS (even though most
>      of them are logically connected to (and necessary for)
>      nanoMIPS support) - they fix and improve pre-nanoMIPS code
>       - patches 20-65 introduce core nanoMIPS functionality, but
>       do not contain any dependence on or reference to nanoMIPS
>       Linux ABI
>       - patches 66-87 mostly deal with Linux user mode-related
>       nanoMIPS functionality, therefore dependent on nanoMIPS
>       Linux ABI
>   - the series will probably be split into three (corresponding
>      to the organization mentioned above) in near future

Hello, all,

I am going to do splitting as described above soon. This will hopefully all=
ow all of us to work easier with this series, and to make progress on parts=
 that don't depend on Linux ABI independently on the destiny of Linux ABI-d=
ependent parts.

Please let me know if you have any reservations.

Regards,
Aleksandar
