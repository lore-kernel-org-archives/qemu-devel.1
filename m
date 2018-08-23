Received: from eggs.gnu.org ([2001:4830:134:3::10]:46977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fss6I-0000JN-1M
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fss6E-0007ah-3X
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:04:43 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fss6D-0007a0-RT
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:04:41 -0400
Received: by mail-oi0-x241.google.com with SMTP id y207-v6so10127440oie.13
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:04:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-14-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 17:04:20 +0100
Message-ID: <CAFEAcA9Op254D1aJ3VCvDpzv7SvPLrsqpTLfnJi=HCaMnJhe5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 13/20] target/arm: Rewrite
 helper_sve_ld[234]*_r
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 9 August 2018 at 05:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Use the same *_tlb primitives as we use for ld1.  This is not
> a significant change, but does (for linux-user) hoist the set
> of helper_retaddr, and (for softmmu) hoist the computation of
> the current mmu_idx outside the loop.
>
> This does fix the endianness problem for softmmu, and does
> move the main loop out of a macro and into an inlined function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
