Received: from eggs.gnu.org ([2001:4830:134:3::10]:39149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTwZP-0004ra-2j
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 17:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTwZO-0001J8-Bd
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 17:20:03 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gTwZO-0001Hy-46
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 17:20:02 -0500
Received: by mail-oi1-x242.google.com with SMTP id i6so12464233oia.6
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 14:20:01 -0800 (PST)
MIME-Version: 1.0
References: <20181120212553.8480-1-aaron@os.amperecomputing.com>
	<20181120212553.8480-8-aaron@os.amperecomputing.com>
	<CAFEAcA92+6NdqpB+L42cu1Ba7qvvHoLkjSDgcEDLvR=iqpd4gg@mail.gmail.com>
	<20181203204452.GB5549@quinoa.localdomain>
In-Reply-To: <20181203204452.GB5549@quinoa.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 22:19:48 +0000
Message-ID: <CAFEAcA900U3amGOGRKGNu+-j9EDhdrZ1U1U5MtoW5BeTo74iOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 07/13] target-arm: Make PMCEID[01]_EL0
 64 bit registers, add PMCEID[23]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Mon, 3 Dec 2018 at 20:45, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
>
> On Nov 30 16:10, Peter Maydell wrote:
> > PMCEID2 and PMCEID3 are only defined from ARMv8.1; before that they
> > are UNDEFINED. So these registers need to be only defined if a
> > suitable feature bit or ID register field check passes.
>
> It looks like we don't currently support any ARMv8.1+ CPUs and don't
> have an entry in the `arm_features` enum for it. I'll plan to add
> ARM_FEATURE_V81 and make defining these registers depend on it, assuming
> any future CPUs supporting it will use that, unless you feel I should do
> something different.

I think that the idea going forward is to prefer an ID
register check of some kind -- Richard ?

thanks
-- PMM
