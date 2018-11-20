Received: from eggs.gnu.org ([2001:4830:134:3::10]:42119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP788-0008ES-5R
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP787-0002mE-9u
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:35:56 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP787-0002ln-4Y
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:35:55 -0500
Received: by mail-oi1-x243.google.com with SMTP id x23so1652783oix.3
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:35:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181116212154.GG23658@quinoa.localdomain>
References: <20181105185046.2802-1-aaron@os.amperecomputing.com>
	<20181105185046.2802-13-aaron@os.amperecomputing.com>
	<20181116212154.GG23658@quinoa.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 14:35:33 +0000
Message-ID: <CAFEAcA-RkSKviFW0uah+HYuy9K4LAn1Ye=V-UVujLT_WRHCT=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 12/12] target/arm: Send interrupts on
 PMU counter overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

On 16 November 2018 at 21:22, Aaron Lindsay
<aaron@os.amperecomputing.com> wrote:
> On Nov 05 13:52, Aaron Lindsay wrote:
>> Setup a QEMUTimer to get a callback when we expect counters to next
>> overflow and trigger an interrupt at that time.
>
> Peter,
>
> It looks like there's probably going to be at least a v8 in this series
> since you've made a few comments which require changes. But I don't
> think this final patch has ever received any review comments from
> anyone, and I suspect it's not because it's perfect...
>
> Would you mind taking a look at this one during your review if you can
> find time?

I think I'd rather let Richard review this one...

thanks
-- PMM
