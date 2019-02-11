Received: from eggs.gnu.org ([209.51.188.92]:34339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gt87s-0004sF-Ix
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gt87r-0001Ud-O8
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:43:44 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gt87r-0001OP-GI
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:43:43 -0500
Received: by mail-ot1-x343.google.com with SMTP id g1so2418651otj.11
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 01:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-4-richard.henderson@linaro.org>
	<CAFEAcA-BEfqu=BU-2y+8dUBdXsyC4n2zhZm5nZ1MofUj3cE2Lg@mail.gmail.com>
	<c37e6649-b2f9-88cf-913d-d0394a635045@linaro.org>
	<CAFEAcA-TwEh74GuvafhqFUXP_xesqC9b1oixubj=ztNa8t4a2g@mail.gmail.com>
	<56abf739-b75a-025f-1c38-dd1cd254617f@linaro.org>
In-Reply-To: <56abf739-b75a-025f-1c38-dd1cd254617f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Feb 2019 09:43:27 +0000
Message-ID: <CAFEAcA8b7O_GXibvE9k83Ko40u-w351tSUt5B0EiZ1nWnpgWVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/17] target/arm: Add MTE system registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Sun, 10 Feb 2019 at 22:47, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/10/19 1:40 PM, Peter Maydell wrote:
> >> Actually, we already break the TB here by default.
> >
> > Do we? I didn't see any code (apart from the handling
> > in the DAIFSet/Clear codepaths, which aren't used for TCO).
>
> At the start of the function:
>
>     /* End the TB by default, chaining is ok.  */
>     s->base.is_jmp = DISAS_TOO_MANY;

...that's only in the v2 patchset which you hadn't posted yet :-)

-- PMM
