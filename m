Received: from eggs.gnu.org ([2001:4830:134:3::10]:50721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPFM0-0003ED-Md
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 18:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPFLw-00009e-WA
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 18:22:48 -0500
MIME-Version: 1.0
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<cd89e90aeb79ed438aaee6cfa02ca42a36d633b6.1542321076.git.alistair.francis@wdc.com>
	<2aa0f464-c9c4-3d59-81da-952279f56843@linaro.org>
	<CAKmqyKN9DQkZUp=+hRwC5AwaX+X0oYgt4=L2Pw8dWAauzS59QQ@mail.gmail.com>
	<e04bac07-ad25-2715-1262-28e9324126a8@linaro.org>
In-Reply-To: <e04bac07-ad25-2715-1262-28e9324126a8@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Nov 2018 15:22:09 -0800
Message-ID: <CAKmqyKMSg34-p_9h6GhW-TqMLhq3GM0yH68cjDG7VyFcZJkwsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v1 20/23] riscv: tcg-target: Add the target
 init code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On Mon, Nov 19, 2018 at 10:55 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/20/18 12:04 AM, Alistair Francis wrote:
> > On Fri, Nov 16, 2018 at 9:26 AM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 11/15/18 11:36 PM, Alistair Francis wrote:
> >>> +    tcg_regset_set_reg(s->reserved_regs, TCG_REG_L0);
> >>> +    tcg_regset_set_reg(s->reserved_regs, TCG_REG_L1);
> >>> +    tcg_regset_set_reg(s->reserved_regs, TCG_REG_RA);
> >>
> >> Why are these three reserved?
> >
> > Do these not need to be? I thought we had to reserve them.
>
> The return address, I presume, has been saved by the prologue.  I see no reason
> why it can't be yet another call-clobbered register.

Ok, removed.

>
> As for the other two... what are they supposed to be?

They were old temp registers. L1 wasn't even used and I have replace
L0 with TMP0 as we have enough tmp registers.

Alistair

>
>
> r~
