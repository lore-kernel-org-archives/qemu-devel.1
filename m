Received: from eggs.gnu.org ([2001:4830:134:3::10]:46450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fddxo-0004Qx-Be
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fddxn-0003Pf-PV
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:57:04 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fddxn-0003PF-B8
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:57:03 -0400
Received: by mail-oi0-x244.google.com with SMTP id r16-v6so56740074oie.3
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 08:57:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180711103957.3040-1-richard.henderson@linaro.org>
References: <20180711103957.3040-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 16:56:42 +0100
Message-ID: <CAFEAcA8nivJvx8OJGidQo0w=1yf2=_CHxFnjeB+3N204bBXrZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.0] target/arm: Fix LD1W and LDFF1W
 (scalar plus vector)
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

On 11 July 2018 at 11:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
> 'I' was being double-incremented; correctly within the inner loop
> and incorrectly within the outer loop.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> Fixes a SIGSEGV within one of these generated helpers,
> exposed by an armclang vectorized code sample.
>


Applied to target-arm.next, thanks.

-- PMM
