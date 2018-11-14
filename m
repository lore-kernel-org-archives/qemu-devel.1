Received: from eggs.gnu.org ([2001:4830:134:3::10]:34262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gMxZ5-0003QA-6l
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gMxZ0-0003oz-0i
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:58:51 -0500
Received: from mail-eopbgr730122.outbound.protection.outlook.com
	([40.107.73.122]:30784
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gMxYp-0003eW-1U
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:58:40 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 14 Nov 2018 15:58:27 +0000
Message-ID: <BN6PR2201MB1251656CBED65791A03C06EDC6C30@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1542135956-3780-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAAdtpL4cd2i0ZgL_hyPc9wgp5-=v5qeExmAnpdr0XZ97_5cwjg@mail.gmail.com>
	<CAAdtpL7JsA90236QX5vCLeE1ma0hZ75-BLwwC=+Nc2Di9utDSg@mail.gmail.com>,
	<20181114153046.GA2359@sx9>
In-Reply-To: <20181114153046.GA2359@sx9>
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
To: Fredrik Noring <noring@nocrew.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Markovic <smarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, "Maciej W.
	Rozycki" <macro@linux-mips.org>, =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>

Fredrik wrote:

> Philippe wrote:
>
> > Then we will fix this for the 4.0 release.
>=20
> What exactly needs to be fixed regarding the psABI? The relevant opcodes
> would need to stay, and not be prohibited and removed as Aleksandar has
> suggested, since such opcode removal breaks the psABI requirements.
>=20
> Finally, as Maciej explained in some detail, the document that Aleksandar
> just recently requested is known to not exist, for any MIPS implementatio=
n,
> so we are not going to make any progress on that either.
>

I am going to list all the issues that needs to be clarified and
resolved, including the reasons why they are issues at all, and
possible ways to resolve them. I can't do it right now, but it'll
happen relatively soon.

Sincerely,
Aleksandar=
