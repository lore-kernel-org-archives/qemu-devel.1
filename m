Received: from eggs.gnu.org ([2001:4830:134:3::10]:57653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gMvhs-000831-Hz
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gMvhm-0004Cv-Q7
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:59:48 -0500
Received: from mail-eopbgr740130.outbound.protection.outlook.com
	([40.107.74.130]:21328
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gMvhi-00043H-T4
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:59:41 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 14 Nov 2018 13:59:29 +0000
Message-ID: <BN6PR2201MB1251910140D2FE6E94E21A03C6C30@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1542135956-3780-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAAdtpL4cd2i0ZgL_hyPc9wgp5-=v5qeExmAnpdr0XZ97_5cwjg@mail.gmail.com>,
	<CAAdtpL7JsA90236QX5vCLeE1ma0hZ75-BLwwC=+Nc2Di9utDSg@mail.gmail.com>
In-Reply-To: <CAAdtpL7JsA90236QX5vCLeE1ma0hZ75-BLwwC=+Nc2Di9utDSg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] target/mips: Disable R5900 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Markovic <smarkovic@wavecomp.com>, Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>

Philippe Mathieu-Daud=E9 <philippe@mathieu-daude.net> wrote:

> Can you add:
>=20
> This reverts commit ed4f49ba9bb56ebca6987b1083255daf6c89b5de.
>=20
> Or
>=20
> Fixes: ed4f49ba9
>=20
> when applying?

Sure, I'll add something along that line.

> If the issues you mentioned are "the R5900 tcg opcodes are not
> implemented correctly", then this patch is OK, because no cpu
> can use the R5900 opcodes.
>=20
> At some point while reading your reviews, I understood the R5900
> patches introduced incorrect behaviors for the non-R5900 cpus.
> In this case this patch wouldn't suffice.

This patch will be applied after the patches that Fredrik kindly
submitted under "Fix decoding..." series. Fredrik's patches will
remove any doubt about R5900 interfering other architectures, so,
as a consequence, this patch is sufficient and appropriate for
disabling R5900 support.

Additional clarification: This patch is to give more time for
all R5900 issues to be cleared in 3.1+ time frame. If R5900 code
was left enabled, we could have unpleasant backward compatibility
issues between R5900 support and different versions of QEMU.

The R5900 support is intended to be enabled again when all issues
are resolved and agreed upon.

Sincerely,
Aleksandar
