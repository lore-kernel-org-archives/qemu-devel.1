Received: from eggs.gnu.org ([2001:4830:134:3::10]:55020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fiLKt-0002bV-Nq
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fiLKq-0006HD-Nt
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:04:19 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com
	([104.47.41.101]:26880
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fiLKq-0006Fg-Eq
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:04:16 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 25 Jul 2018 15:04:13 +0000
Message-ID: <BN7PR08MB48683A45E45204FCC454155EC6540@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1532453527-22911-24-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532453527-22911-24-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 23/55] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Tuesday, July 24, 2018 7:31 PM
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Add emulation of DSP ASE instructions for nanoMIPS - part 3.

This patch should be further split into four or so patches - each dealing w=
ith a single instruction pool.

Also, DSP instruction pools should use NM_XXX opcodes in decoding phase, an=
d only use OPC_XXX opcodes whet they call corresponding gen_XXX() function =
or correspondiong helper function. This is not the case for one of instruct=
ion pools from this patch, if I remember correctly.

Aleksandar M.=
