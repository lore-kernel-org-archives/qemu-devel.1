Received: from eggs.gnu.org ([2001:4830:134:3::10]:47615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eip3K-00056g-4z
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 17:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eip3I-0008Rr-Sn
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 17:15:54 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eip3I-0008Qt-LP
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 17:15:52 -0500
Received: by mail-oi0-x241.google.com with SMTP id l8so22339814oig.0
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 14:15:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f880f730-a999-b15d-1196-ce49ae63a266@linaro.org>
References: <1517811767-75958-1-git-send-email-mjc@sifive.com>
	<1517811767-75958-3-git-send-email-mjc@sifive.com>
	<f880f730-a999-b15d-1196-ce49ae63a266@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 6 Feb 2018 11:15:51 +1300
Message-ID: <CAHNT7Ntc7m-rWFuXfvMQGB8zgSjzVaR9=yUTStA=sOF9_gNS5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 03/22] RISC-V CPU Core Definition
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

On Tue, Feb 6, 2018 at 2:45 AM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 02/04/2018 10:22 PM, Michael Clark wrote:
> > Add CPU state header, CPU definitions and initialization routines
> >
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > ---
> >  target/riscv/cpu.c      | 385 ++++++++++++++++++++++++++++++
> ++++++++++++++
> >  target/riscv/cpu.h      | 256 +++++++++++++++++++++++++++++
> >  target/riscv/cpu_bits.h | 417 ++++++++++++++++++++++++++++++
> ++++++++++++++++++
> >  3 files changed, 1058 insertions(+)
> >  create mode 100644 target/riscv/cpu.c
> >  create mode 100644 target/riscv/cpu.h
> >  create mode 100644 target/riscv/cpu_bits.h
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> >
> > +static const RISCVCPUInfo riscv_cpus[] = {
> > +#ifdef CONFIG_USER_ONLY
> > +    { TYPE_RISCV_CPU_ANY,                riscv_any_cpu_init },
> > +#else
> > +    { TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_09, riscv_imafdcsu_priv1_9_cpu_init
> },
> > +    { TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_10, riscv_imafdcsu_priv1_10_cpu_init
> },
> > +    { TYPE_RISCV_CPU_IMACU_PRIV_1_10,    riscv_imacu_priv1_10_cpu_init
> },
> > +    { TYPE_RISCV_CPU_IMAC_PRIV_1_10,     riscv_imac_priv1_10_cpu_init },
> > +#endif
> > +    { NULL, NULL }
> > +};
>
> I do wonder if there might be value in providing the more restricted cpus
> for
> CONFIG_USER_ONLY as well.  E.g. toolchain testing, so that you can be sure
> that
> the compiler doesn't emit an instruction that is invalid for a given MISA.


Sounds like a good idea. I can also add a few more combinations.

We should have an RVI processor which is the minimal integer ISA, as well
as IM, and the current variants without Compression. The BOOM processor is
RV64IMAFD without C.
