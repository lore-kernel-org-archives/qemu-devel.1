Received: from eggs.gnu.org ([209.51.188.92]:47217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpaaj-0000MN-TF
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpaai-0005e2-0i
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:18:53 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:32901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpaag-0005d9-8s
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:18:51 -0500
Received: by mail-oi1-x242.google.com with SMTP id c206so6099161oib.0
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 07:18:49 -0800 (PST)
MIME-Version: 1.0
References: <20190125225714.10234-1-richard.henderson@linaro.org>
In-Reply-To: <20190125225714.10234-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Feb 2019 15:18:37 +0000
Message-ID: <CAFEAcA-oxvAgWJbmYoUZ+YmKdUD6qKdRgzKdAzj2DE1K25pVBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/6] target/arm: Complete ARMv8.3-PAuth
 linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 25 Jan 2019 at 22:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> (1) Fix a bug I introduced at the last moment in the last
>     patch set -- enable pac keys during reset, not before.
> (2) Add the HWCAP bits.
> (3) Add the new prctl
> (4) Add a smoke test so that (1) doesn't happen again.
>
>
> r~
>
>
> Richard Henderson (6):
>   target/arm: Always enable pac keys for user-only
>   aarch64-linux-user: Update HWCAP bits from linux 5.0-rc1
>   aarch64-linux-user: Enable HWCAP bits for PAuth
>   linux-user: Initialize aarch64 pac keys
>   linux-user: Implement PR_PAC_RESET_KEYS
>   tests/tcg/aarch64: Add pauth smoke tests

Applied patches 1-4 to target-arm.next (5 has a minor nit
and 6 depends on 5).

thanks
-- PMM
