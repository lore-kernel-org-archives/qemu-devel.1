Received: from eggs.gnu.org ([2001:4830:134:3::10]:51635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEZY-0007wv-M7
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIEZX-0002IB-Ut
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:35:32 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:42218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIEZX-0002Hy-P4
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:35:31 -0400
Received: by mail-ot0-x243.google.com with SMTP id l13-v6so14520276otk.9
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 07:35:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-17-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 15:35:10 +0100
Message-ID: <CAFEAcA_JwqmcieEgP0bZ=RqteBMDrduDmrmxnzdJt1L=geOPjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 16/27] target/arm: Remove
 floatX_maybe_silence_nan from conversions
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

On 12 May 2018 at 01:43, Richard Henderson <richard.henderson@linaro.org> wrote:
> This is now handled properly by the generic softfloat code.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.c |  1 -
>  target/arm/helper.c     | 12 ++----------
>  2 files changed, 2 insertions(+), 11 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
