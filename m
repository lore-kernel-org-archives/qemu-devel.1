Received: from eggs.gnu.org ([2001:4830:134:3::10]:49916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZanS-00056K-KG
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZanR-0006r3-Km
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:41:06 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZanR-0006pT-CD
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:41:05 -0400
Received: by mail-wm0-x229.google.com with SMTP id t201so14917537wmt.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 03:41:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170719044018.18063-1-rth@twiddle.net>
References: <20170719044018.18063-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 11:40:43 +0100
Message-ID: <CAFEAcA-m60XQOGJApVeezS1RUxdd=iTzPt=L2eqGpwqBEjNYUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10] util: Introduce
 include/qemu/cpuid.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 July 2017 at 05:40, Richard Henderson <rth@twiddle.net> wrote:
> Clang 3.9 passes the CONFIG_AVX2_OPT configure test.  However, the
> supplied <cpuid.h> does not contain the bit_AVX2 define that we use
> when detecting whether the routine can be enabled.
>
> Introduce a qemu-specific header that uses the compiler's definition
> of __cpuid et al, but supplies any missing bit_* definitions needed.
> This avoids introducing any extra ifdefs to util/bufferiszero.c, and
> allows quite a few to be removed from tcg/i386/tcg-target.inc.c.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>
> Peter, this is the clang 3.9 problem I mentioned the other day,
> when attempting to reproduce the other clang 3.8 problem.
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
