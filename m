Received: from eggs.gnu.org ([2001:4830:134:3::10]:48904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frnmJ-0006sV-Mi
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frnmE-0002fb-Et
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:15:42 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:39993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frnm4-0002XK-Sr
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:15:30 -0400
Received: by mail-oi0-x241.google.com with SMTP id w126-v6so27118946oie.7
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 10:15:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180814002653.12828-1-richard.henderson@linaro.org>
References: <20180814002653.12828-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 18:15:07 +0100
Message-ID: <CAFEAcA-JMjZ0ypHP6gYA7LjFKBDR9bAgh2s2ZUqSn3auTHsYbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/4] target/arm: Fix int64_to_float16
 double-rounding
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

On 14 August 2018 at 01:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
> In 88808a022c0, I tried to fix an overflow problem that affected float16
> scaling by coverting first to float64 and then rounding after that.
>
> However, Laurent reported that -0x3ff40000000001 converted to float16
> resulted in 0xfbfe instead of the expected 0xfbff.  This is caused by
> the inexact conversion to float64.
>
> Rather than build more logic into target/arm to compensate, just add
> a function that takes a scaling parameter so that the whole thing is
> done all at once with only one rounding.
>
> I don't have a failing test case for the float-to-int paths, but it
> seemed best to apply the same solution.
>
>
> r~
>
>
> Richard Henderson (4):
>   softfloat: Add scaling int-to-float routines
>   softfloat: Add scaling float-to-int routines
>   target/arm: Use the int-to-float-scale softfloat routines
>   target/arm: Use the float-to-int-scale softfloat routines

series
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

and applied to target-arm.next.

thanks
-- PMM
