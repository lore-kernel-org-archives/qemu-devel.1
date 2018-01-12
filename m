Received: from eggs.gnu.org ([2001:4830:134:3::10]:39938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea32J-0003XY-Di
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:22:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ea32I-0006Ip-M5
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:22:35 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ea32I-0006IW-Gc
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:22:34 -0500
Received: by mail-oi0-x244.google.com with SMTP id y141so4410414oia.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 09:22:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180110063337.21538-1-richard.henderson@linaro.org>
References: <20180110063337.21538-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 17:22:13 +0000
Message-ID: <CAFEAcA_yQPCNWcv0Mz9mKUObuQH74DcbzyBvo9=UWF6pJ0qPWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] target/arm: split out vfp_expand_imm
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

On 10 January 2018 at 06:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
> One more piece of target/arm prep work from my SVE branch.
>
> I saw that Alex was touching the same bit of code in his ARMv8.2
> fp16 patch set and thought we should coordinate on this.
>
>
> r~
>
>
> Richard Henderson (2):
>   target/arm: Split out vfp_expand_imm
>   target/arm: Add fp16 support to vfp_expand_imm
>
>  target/arm/translate-a64.c | 49 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 16 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I could put these in target-arm.next now if you like ?

thanks
-- PMM
