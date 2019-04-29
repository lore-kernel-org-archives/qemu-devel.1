Received: from eggs.gnu.org ([209.51.188.92]:46700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5YI-0004Hc-2y
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5YG-0005VO-LP
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:38:33 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL5YG-0005V4-Fi
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:38:32 -0400
Received: by mail-oi1-x243.google.com with SMTP id l1so6273405oib.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <1554321185-2825-1-git-send-email-sandra@codesourcery.com>
	<1554321185-2825-2-git-send-email-sandra@codesourcery.com>
In-Reply-To: <1554321185-2825-2-git-send-email-sandra@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 13:38:20 +0100
Message-ID: <CAFEAcA_CGqv+ORxyfDgAQyDhWuZaW3uOQyjqv5uiSppOHJi5_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 1/2] Add generic Nios II board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandra Loosemore <sandra@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

On Wed, 3 Apr 2019 at 20:53, Sandra Loosemore <sandra@codesourcery.com> wrote:
>
> This patch adds support for a generic MMU-less Nios II board that can
> be used e.g. for bare-metal compiler testing with the linker script
> and startup code provided by libgloss.  Nios II booting is also
> tweaked so that bare-metal binaries start executing in RAM starting at
> 0x00000000, rather than an alias at 0xc0000000, which allows features
> such as unwinding to work when binaries are linked to start at the
> beginning of the address space.
>
> The generic_nommu.c parts are based on code by Andrew Jenner, which was
> in turn based on code by Marek Vasut.
>
> Originally by Marek Vasut and Andrew Jenner.
>
> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
> Signed-off-by: Julian Brown <julian@codesourcery.com>
> Signed-off-by: Andrew Jenner <andrew@codesourcery.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
