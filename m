Received: from eggs.gnu.org ([209.51.188.92]:56775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glcE3-0000yr-GA
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glcE1-0001mm-LF
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:15:03 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glcE1-0001jC-GQ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:15:01 -0500
Received: by mail-oi1-x244.google.com with SMTP id x23so14966635oix.3
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 08:14:57 -0800 (PST)
MIME-Version: 1.0
References: <CAGGekkuc+-tvp5RJP7CM+Jy_hJF7eiRHZ96132sb=hPPCappKg@mail.gmail.com>
In-Reply-To: <CAGGekkuc+-tvp5RJP7CM+Jy_hJF7eiRHZ96132sb=hPPCappKg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 16:14:44 +0000
Message-ID: <CAFEAcA_W8t3go-QptcEEUenWMVqGNGxsD+SJmgELTTgVktmbPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target/arm: v8m: Ensure IDAU is
 respected if SAU is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Roth <code@stacksmashing.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Sun, 20 Jan 2019 at 14:51, Thomas Roth <code@stacksmashing.net> wrote:
>
> The current behavior of v8m_security_lookup in helper.c only checks whether the
> IDAU specifies a higher security if the SAU is enabled. If SAU.ALLNS is set to
> 1, this will lead to addresses being treated as non-secure, even though the
> IDAU indicates that they must be secure.
>
> This patch changes the behavior to also check the IDAU if the SAU is currently
> disabled.
>
> Signed-off-by: Thomas Roth <code@stacksmashing.net>

Oops, yes. In the v8M Arm ARM the pseudocode function for this
is SecurityCheck(), and we should indeed not ignore the IDAU for
the SAU disabled path.

Applied to target-arm.next, thanks. (I'll tweak the commit message
to add the Arm ARM reference and make the block comment follow
our current coding style, since we're moving it anyway.)

thanks
-- PMM
