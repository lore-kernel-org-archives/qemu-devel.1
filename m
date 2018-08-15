Received: from eggs.gnu.org ([2001:4830:134:3::10]:33738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fptWH-0006kL-BA
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 06:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fptWG-00058j-4w
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 06:59:17 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fptWC-0004yK-6A
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 06:59:15 -0400
Received: by mail-oi0-x243.google.com with SMTP id b15-v6so1233155oib.10
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 03:59:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180815105430.e6satguezkvfudf5@toto>
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180814124254.5229-11-peter.maydell@linaro.org>
	<20180815105430.e6satguezkvfudf5@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Aug 2018 11:58:50 +0100
Message-ID: <CAFEAcA9xhUQt72bgj9kCJsKSFPeywsSH0usXYqbYhmexO33yAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 10/10] target/arm: Implement support for
 taking exceptions to Hyp mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Luc Michel <luc.michel@greensocs.com>, Edgar Iglesias <edgari@xilinx.com>

On 15 August 2018 at 11:54, Edgar E. Iglesias <edgar.iglesias@xilinx.com> wrote:
> On Tue, Aug 14, 2018 at 01:42:54PM +0100, Peter Maydell wrote:
>> Implement the necessary support code for taking exceptions
>> to Hyp mode in AArch32.
>
> Hi Peter,
>
> A general comment that I think this would be a little easier
> to look at if it was split into two patches, one non-functional
> change to break-out take_aarch32_exception() and then another
> patch to add the new logic...

Yeah, you're right. I'll split it.

>> +    mask = 0;
>> +    if (!(env->cp15.scr_el3 & SCR_EA)) {
>> +        mask |= CPSR_A;
>> +    }
>> +    if (!(env->cp15.scr_el3 & SCR_IRQ)) {
>> +        mask |= CPSR_I;
>> +    }
>> +    if (!(env->cp15.scr_el3 & SCR_IRQ)) {a
>                                  ^^^^^^^
> I think this should test for SCR_FIQ.

Yep, cut-n-paste error.

thanks
-- PMM
