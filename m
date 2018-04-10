Received: from eggs.gnu.org ([2001:4830:134:3::10]:37035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5qyn-00061o-Ok
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5qyn-0008W5-1i
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:58:25 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:33731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5qym-0008Vl-Sj
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:58:24 -0400
Received: by mail-oi0-x230.google.com with SMTP id 126-v6so10717388oig.0
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 03:58:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410055912.934-1-richard.henderson@linaro.org>
References: <20180410055912.934-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 11:58:03 +0100
Message-ID: <CAFEAcA9vx+Log3m+gesr=8ALuARit=8x468iQOzX44z6LmwG+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] fpu: Fix rounding mode for
 floatN_to_uintM_round_to_zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 10 April 2018 at 06:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
> We incorrectly passed in the current rounding mode
> instead of float_round_to_zero.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> Found while runnning SVE RISU tests; it should be visible with the
> right set of inputs to AdvSIMD RISU tests.



Applied to target-arm.next, thanks.

-- PMM
