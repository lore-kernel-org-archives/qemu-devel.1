Received: from eggs.gnu.org ([209.51.188.92]:41276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFx4X-000738-Kd
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFx4W-0004L3-QF
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:34:37 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:34571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hFx4W-0004JQ-Is
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:34:36 -0400
Received: by mail-oi1-x232.google.com with SMTP id v10so13073186oib.1
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 01:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190411153942.4533-1-peter.maydell@linaro.org>
	<53930e87-3bb1-fdd5-a8fe-8603c0adecc2@linaro.org>
	<CAFEAcA-dbGvhgTrBKEtx-CPS7f2NJO5X+dj=mdcm+NrkF=uynQ@mail.gmail.com>
	<0ee4fdc6-c782-d5f5-ec40-9e25c1c9dd1f@linaro.org>
In-Reply-To: <0ee4fdc6-c782-d5f5-ec40-9e25c1c9dd1f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Apr 2019 09:34:24 +0100
Message-ID: <CAFEAcA-0oCc+9=LnpMJ9HmhsiSCTM9wA_prNS9MdNp6_157y6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Implement NSACR gating of
 floating point
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Sun, 14 Apr 2019 at 20:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/14/19 8:02 AM, Peter Maydell wrote:
> > There's similar wording for the effect of NSACR on CPACR, so
> > again I think we need to actually make the bits RAZ/WI
> > regardless of their underlying value, not just force them
> > to 0.
>
> I don't see that language for CPACR, just "the corresponding bits in the CPACR
> ignore writes and read as 0b00".  I'm willing to believe the manual is sloppy
> on this point though, and the "correct" language appears only once, somewhere.

It's in the documentation of CPACR cp10/cp11.

thanks
-- PMM
