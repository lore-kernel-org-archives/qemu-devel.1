Received: from eggs.gnu.org ([209.51.188.92]:42553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8gp-0001E9-OX
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8go-0002Lq-Rr
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:59:35 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL8go-0002LV-Mg
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:59:34 -0400
Received: by mail-oi1-x241.google.com with SMTP id n187so8712480oih.6
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190330005900.17282-1-richard.henderson@linaro.org>
	<20190330005900.17282-2-richard.henderson@linaro.org>
In-Reply-To: <20190330005900.17282-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 16:59:22 +0100
Message-ID: <CAFEAcA_LuA8qU4YLHrJrB-Hick9Eyg9eAWhV_uBRyG4n19YVXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 1/4] linux-user/aarch64: Reset btype for
 syscalls and signals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On Sat, 30 Mar 2019 at 00:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The value of btype for syscalls is CONSTRAINED UNPREDICTABLE,
> so we need to make sure that the value is 0 before clone,
> fork, or syscall return.
>
> The value of btype for signals is defined, but it does not make
> sense for a SIGILL handler to enter with the btype set as for
> the indirect branch that caused the SIGILL.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
