Received: from eggs.gnu.org ([2001:4830:134:3::10]:43043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZhOL-0006pH-Pq
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZhOK-0003z7-E3
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:15:53 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:39177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZhOK-0003xw-7a
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:15:52 -0500
Received: by mail-ot0-x244.google.com with SMTP id 37so2859516otv.6
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:15:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8b8162d6-f20e-270c-2aad-9c34eb00759d@linaro.org>
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
	<1515637324-96034-9-git-send-email-mjc@sifive.com>
	<8b8162d6-f20e-270c-2aad-9c34eb00759d@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 12 Jan 2018 07:15:50 +1300
Message-ID: <CAHNT7NvBViMnOu1LsxvZn3n2c_2mY-ionLdyJgmheOYhXhYAfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 08/21] RISC-V TCG Code Generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Fri, Jan 12, 2018 at 4:47 AM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 01/10/2018 06:21 PM, Michael Clark wrote:
> > TCG code generation for the RV32IMAFDC and RV64IMAFDC. The QEMU
> > RISC-V code generator has complete coverage for the Base ISA v2.2,
> > Privileged ISA v1.9.1 and Privileged ISA v1.10:
> >
> > - RISC-V Instruction Set Manual Volume I: User-Level ISA Version 2.2
> > - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.9.1
> > - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.10
> >
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > ---
> >  target/riscv/instmap.h   |  377 +++++++++
> >  target/riscv/translate.c | 1982 ++++++++++++++++++++++++++++++
> ++++++++++++++++
> >  2 files changed, 2359 insertions(+)
> >  create mode 100644 target/riscv/instmap.h
> >  create mode 100644 target/riscv/translate.c
>
> While there is forward progress within translate.c, it would seem that
> quite a
> lot of my v1 comments are not yet addressed.
>
> Also,
>
> > +        if (!riscv_has_ext(env, RVC)) {
>
> You may not access env in this way.  Any code generation differences must
> be
> computable from either unchanging values on the cpu or tb->flags.  MISA is
> not
> unchanging -- you allow runtime modification.
>
> Again, the partial patch I saw from Stefan would fix this.


We'll definately address this in the next spin...

Could you pleease forward me the patch or send me a pointer to where i
might find it?

Assuming we can use flags and misa is stored in the lower 26-bits then we
change riscv_has_ext to take an int. e.g.

riscv_has_ext(tb->flags, RVC))
