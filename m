Received: from eggs.gnu.org ([209.51.188.92]:37013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsxtC-0004in-A1
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 17:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsxtB-0005sW-H2
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 17:47:54 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsxtB-0005lE-98
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 17:47:53 -0500
Received: by mail-pg1-x544.google.com with SMTP id w7so4074441pgp.13
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 14:47:42 -0800 (PST)
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-4-richard.henderson@linaro.org>
	<CAFEAcA-BEfqu=BU-2y+8dUBdXsyC4n2zhZm5nZ1MofUj3cE2Lg@mail.gmail.com>
	<c37e6649-b2f9-88cf-913d-d0394a635045@linaro.org>
	<CAFEAcA-TwEh74GuvafhqFUXP_xesqC9b1oixubj=ztNa8t4a2g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <56abf739-b75a-025f-1c38-dd1cd254617f@linaro.org>
Date: Sun, 10 Feb 2019 14:47:38 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-TwEh74GuvafhqFUXP_xesqC9b1oixubj=ztNa8t4a2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/17] target/arm: Add MTE system registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 2/10/19 1:40 PM, Peter Maydell wrote:
>> Actually, we already break the TB here by default.
> 
> Do we? I didn't see any code (apart from the handling
> in the DAIFSet/Clear codepaths, which aren't used for TCO).

At the start of the function:

    /* End the TB by default, chaining is ok.  */
    s->base.is_jmp = DISAS_TOO_MANY;

Since the change to TCO is from an immediate, the change to MTE_ACTIVE is also
constant, and so chaining will work.


r~
