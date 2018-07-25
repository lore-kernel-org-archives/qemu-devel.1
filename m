Received: from eggs.gnu.org ([2001:4830:134:3::10]:53921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fiNOR-0000mi-3B
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 13:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fiNOO-0002tj-1b
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 13:16:07 -0400
Received: from mail-sn1nam02on0115.outbound.protection.outlook.com
	([104.47.36.115]:33216
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fiNON-0002sB-GM
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 13:16:03 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 25 Jul 2018 17:15:58 +0000
Message-ID: <BN7PR08MB4868AB4811A77E8C6B950BB1C6540@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532453527-22911-8-git-send-email-aleksandar.markovic@rt-rk.com>,
	<85bdf4b0-d17d-fb79-f7f5-7053edb9a5f7@linaro.org>
In-Reply-To: <85bdf4b0-d17d-fb79-f7f5-7053edb9a5f7@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 07/55] target/mips: Add emulation of
 nanoMIPS 16-bit load and store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>


> It might be handy to temporarily add
>=20
> target/mips/translate.o: QEMU_CFLAGS +=3D -Wshadow=3Dlocal
>=20
> to target/mips/Makefile.objs, but I don't know how prevalent that situati=
on is
> within the existing code base...

Richard, thanks for this useful tip. I did similar checks utilizing gcc war=
nings, but some other hard way. I see this can be handy for other situation=
s too - for example, if using -Wimplicit-fallthrough...

Aleksandar M.
