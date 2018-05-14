Received: from eggs.gnu.org ([2001:4830:134:3::10]:43096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIE1W-00080P-IB
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIE1N-0003pE-7Y
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:00:22 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:46135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIE1M-0003oN-Kn
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:00:12 -0400
Received: by mail-ot0-x22a.google.com with SMTP id t1-v6so14353577ott.13
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 07:00:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-16-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 14:59:51 +0100
Message-ID: <CAFEAcA_u4w72k2bjvx1672n95G0pBNa=MEcCqnzv3WS5a24w9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 15/27] target/arm: Fix fp_status_f16
 tininess before rounding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-stable <qemu-stable@nongnu.org>

On 12 May 2018 at 01:42, Richard Henderson <richard.henderson@linaro.org> wrote:
> From: Peter Maydell <peter.maydell@linaro.org>
>
> In commit d81ce0ef2c4f105 we added an extra float_status field
> fp_status_fp16 for Arm, but forgot to initialize it correctly
> by setting it to float_tininess_before_rounding. This currently
> will only cause problems for the new V8_FP16 feature, since the
> float-to-float conversion code doesn't use it yet. The effect
> would be that we failed to set the Underflow IEEE exception flag
> in all the cases where we should.
>
> Add the missing initialization.
>
> Fixes: d81ce0ef2c4f105
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

NB that there are reviewed-by: tags from you and Alex that need
to be added to this commit message.

Thanks for fixing up the subject line for me.

thanks
-- PMM
