Received: from eggs.gnu.org ([209.51.188.92]:51474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqeC7-00010z-Iu
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqe0J-0003Bs-Dv
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:09:45 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqe0I-0002z4-NM
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:09:39 -0500
Received: by mail-ot1-x343.google.com with SMTP id s5so12780451oth.7
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 05:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20190128223118.5255-1-richard.henderson@linaro.org>
In-Reply-To: <20190128223118.5255-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 13:09:15 +0000
Message-ID: <CAFEAcA-WXUeFUTq9Eu-9VH4zmdzt9b+m5uLewUWfT+yf2UBy4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 00/12] target/arm: Implement ARMv8.5-BTI
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

On Mon, 28 Jan 2019 at 22:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The branch target identification extension does not yet have
> kernel or gcc support.  It should be in shape for developing
> those though.
>
> In system mode I do honor the GP bit from the page tables.
> In user-only mode, there is a way to pretend that the GP bit
> is always set.  Further linux-user changes will have to track
> the ABI that gets developed.
>
> In the meantime, provide a statically linable make check-tcg
> test for the functionality.
>
> Changes since v2:
>   * Rebase on master.
>   * Incorporate feedback from Peter.

I've applied patches 1-8 and 10 to target-arm.next, which gives
us the system emulation part. The linux-user support I've given
some review comments on.

thanks
-- PMM
