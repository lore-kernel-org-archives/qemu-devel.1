Received: from eggs.gnu.org ([2001:4830:134:3::10]:56348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGmIZ-0004YS-Q5
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGmIZ-0004dm-2b
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:11:59 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:39443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGmIY-0004dZ-Sy
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:11:58 -0400
Received: by mail-oi0-x236.google.com with SMTP id n65-v6so1868649oig.6
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 07:11:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180510140934.22855-1-peter.maydell@linaro.org>
References: <20180510140934.22855-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 15:11:37 +0100
Message-ID: <CAFEAcA9xoFxqkCKzXTXHZ4D+chhaJP9=RFmyfx2HnJfFhvJWpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] fix fp16 tininess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 10 May 2018 at 15:09, Peter Maydell <peter.maydell@linaro.org> wrote:
> In commit d81ce0ef2c4f105 we added an extra float_status field
> fp_status_fp16 for Arm, but forgot to initialize it correctly
> by setting it to float_tininess_before_rounding. This currently
> will only cause problems for the new V8_FP16 feature, since the
> float-to-float conversion code doesn't use it yet. The effect
> would be that we failed to set the Underflow IEEE exception flag
> in all the cases where we should.

Oops, I forgot to fix the patch summary line from my
quick-hack commit. Something like:

target/arm: Fix tininess detection for fp16 arithmetic

would be a bit clearer.

thanks
-- PMM
