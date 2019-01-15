Received: from eggs.gnu.org ([209.51.188.92]:40473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gjXAN-0006gZ-FP
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gjXA9-00036j-8L
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:26:30 -0500
MIME-Version: 1.0
References: <cover.1547510220.git.alistair.francis@wdc.com>
	<b17f45cb9053318f20ca2a5b2167afa96c1f933a.1547510220.git.alistair.francis@wdc.com>
	<62009a7b-877b-9c7d-7844-4eaa1930e9ff@linaro.org>
In-Reply-To: <62009a7b-877b-9c7d-7844-4eaa1930e9ff@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 15 Jan 2019 14:25:44 -0800
Message-ID: <CAKmqyKOgQLX3Feh=g2ytdiSbFaedWdExpVVjMt6v+SUqxRYhzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 5/8] RISC-V: Add priv_ver to DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>

On Tue, Jan 15, 2019 at 2:24 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/15/19 10:58 AM, Alistair Francis wrote:
> > -static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
> > +static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
>
> Why change this?  I know there is variation in the naming, but my
> preferred default mapping is CPUState *cs, RISCVCPU *cpu.

Good point, I have changed it back to cs.

Alistair

>
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
