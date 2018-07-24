Received: from eggs.gnu.org ([2001:4830:134:3::10]:39690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fi1Kk-0001rv-0F
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fi1Kg-0000RF-TR
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:42:50 -0400
Received: from mail-cys01nam02on0110.outbound.protection.outlook.com
	([104.47.37.110]:24091
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fi1Kg-0000Qi-Ip
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:42:46 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 24 Jul 2018 17:42:42 +0000
Message-ID: <BN7PR08MB48684AF13DACF606380F25E6C6550@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532451888-8958-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532451888-8958-11-git-send-email-aleksandar.markovic@rt-rk.com>,
	<CAFEAcA_J70Kf+wPbWMCTw1B_mxERVsmjLspASOWKy=re0Q_S0Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_J70Kf+wPbWMCTw1B_mxERVsmjLspASOWKy=re0Q_S0Q@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 10/10] linux-user: Add preprocessor
 availability control to some syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paul Burton <pburton@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philippe.mathieu.daude@gmail.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: Tuesday, July 24, 2018 7:20 PM
> On 24 July 2018 at 18:04, Aleksandar Markovic
> <aleksandar.markovic@rt-rk.com> wrote:
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Add ability to target platforms to individually include user-mode
> > support for system calls from "stat" group of system calls.
> >
> > This change is related to new nanoMIPS platform in the sense that
> > it supports a different set of "stat" system calls than any other
> > target. nanoMIPS does not support structures stat and stat64 at
> > all. Also, support for certain number of other system calls is
> > dropped in nanoMIPS (those are most of the time obsoleted system
> > calls).
> >
> > Without this patch, build for nanoMIPS would fail.
> >
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> > Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> This looks like you're reviewing your own code -- has
> the author attribution got confused at some point with this patch?
>
> thanks
> -- PMM

You are right, good catch - it is author mis-attribution.

The authorship will be fixed next time.

Aleksandar
