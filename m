Received: from eggs.gnu.org ([209.51.188.92]:51628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqcPh-0005K2-H5
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqcJb-0002j3-O1
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:21:29 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqcJb-0002iA-JD
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:21:27 -0500
Received: by mail-ot1-x341.google.com with SMTP id a11so12280565otr.10
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 03:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20190204052712.30833-1-richard.henderson@linaro.org>
	<20190204052712.30833-4-richard.henderson@linaro.org>
	<CABoDooOYVShpc+OAXVCnZ0CF2P1xqk=vEzOMsoxOiCzDjnkQjw@mail.gmail.com>
	<b84d3114-d046-ab9b-bb20-4098f7a5070e@linaro.org>
In-Reply-To: <b84d3114-d046-ab9b-bb20-4098f7a5070e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 11:21:14 +0000
Message-ID: <CAFEAcA8+FJ1SL4mB=hMQ8mLS4vkJr885=+kxD0chAHS-nBh_Dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] target/arm: Implement ARMv8.3-JSConv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Mon, 4 Feb 2019 at 10:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/4/19 8:00 AM, Laurent Desnogues wrote:
> > The pseudo code asks for NaN inputs to return 0 since FPUnpack returns
> > a value of 0 for NaN.
> >
> > The rest looks correct.
>
> So it does.  I apparently copied the INT_MAX thing from softfloat.c without
> double-checking.

I'm a little surprised risu didn't catch that -- it's usually
quite keen on checking NaN behaviour...

thanks
-- PMM
