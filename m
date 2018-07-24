Received: from eggs.gnu.org ([2001:4830:134:3::10]:54307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fi0zg-00056o-8A
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fi0zf-0005rp-62
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:21:04 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fi0ze-0005r0-Tu
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:21:03 -0400
Received: by mail-oi0-x241.google.com with SMTP id y207-v6so8874955oie.13
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 10:21:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1532451888-8958-11-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532451888-8958-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532451888-8958-11-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 18:20:41 +0100
Message-ID: <CAFEAcA_J70Kf+wPbWMCTw1B_mxERVsmjLspASOWKy=re0Q_S0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, pburton@wavecomp.com, Stefan Markovic <smarkovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe.mathieu.daude@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 24 July 2018 at 18:04, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add ability to target platforms to individually include user-mode
> support for system calls from "stat" group of system calls.
>
> This change is related to new nanoMIPS platform in the sense that
> it supports a different set of "stat" system calls than any other
> target. nanoMIPS does not support structures stat and stat64 at
> all. Also, support for certain number of other system calls is
> dropped in nanoMIPS (those are most of the time obsoleted system
> calls).
>
> Without this patch, build for nanoMIPS would fail.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

This looks like you're reviewing your own code -- has
the author attribution got confused at some point with this patch?

thanks
-- PMM
