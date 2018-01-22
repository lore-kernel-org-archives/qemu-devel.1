Received: from eggs.gnu.org ([2001:4830:134:3::10]:37777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edfRG-00005N-Ih
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edfRF-0004Gk-Rn
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:59:18 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edfRF-0004GT-NV
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:59:17 -0500
Received: by mail-oi0-x243.google.com with SMTP id w135so6409781oie.3
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 08:59:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180119182248.10821-5-ard.biesheuvel@linaro.org>
References: <20180119182248.10821-1-ard.biesheuvel@linaro.org>
	<20180119182248.10821-5-ard.biesheuvel@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 16:58:56 +0000
Message-ID: <CAFEAcA-XbhvZ01Q5puegjf0-Spy6AoC_fUHn2k91zWQ4jDsN6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 4/4] target/arm: enable user-mode SHA-3,
 SM3 and SHA-512 instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 19 January 2018 at 18:22, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Add support for the new ARMv8.2 SHA-3, SM3 and SHA-512 instructions to
> AArch64 user mode emulation.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  linux-user/elfload.c | 18 ++++++++++++++++++
>  target/arm/cpu64.c   |  3 +++
>  2 files changed, 21 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
