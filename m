Received: from eggs.gnu.org ([2001:4830:134:3::10]:41237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fkxJu-0004E8-5O
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 16:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fkxJq-0000p8-Ab
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 16:02:06 -0400
Received: from mail-bn3nam04on072d.outbound.protection.outlook.com
	([2a01:111:f400:fe4e::72d]:7904
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fkxJp-0000oy-Ra
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 16:02:02 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 1 Aug 2018 20:01:36 +0000
Message-ID: <BN7PR08MB4868ACB7B1F69351E1A44885C62D0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-8-git-send-email-aleksandar.markovic@rt-rk.com>
	<4bc391e5-9aac-57c6-7173-0fdd7a25bccc@vivier.eu>
	<BN7PR08MB4868ECFD24601E06677D4C55C62D0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<CAFEAcA9xdOSKY6LRRYM4HZQx=xbFiD1-24zMGn-i7BiDWqTZSA@mail.gmail.com>
In-Reply-To: <CAFEAcA9xdOSKY6LRRYM4HZQx=xbFiD1-24zMGn-i7BiDWqTZSA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 07/76] elf: Remove duplicate
 preprocessor constant definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paul Burton <pburton@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

>=20
> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: Wednesday, August 1, 2018 9:37 PM
>=20
> > The simplest way to do that is just to delete
> > the second (original) EF_MIPS_ARCH #define, the one just
> > below the EF_MIPS_NAN2008 define.
> >
> > We could line up with the order the glibc headers use, but
> > that seems like overkill compared to just deleting a line.
>=20

This sounds reasonable to me, and, if nobody disputes it, I will implement =
it this way in the next version.

Aleksandar=
