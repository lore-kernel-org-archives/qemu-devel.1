Received: from eggs.gnu.org ([2001:4830:134:3::10]:43330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ekIeU-0001y3-Ac
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 19:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ekIeT-0002vn-1X
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 19:04:22 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:45232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ekIeS-0002vc-QH
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 19:04:20 -0500
Received: by mail-ot0-x242.google.com with SMTP id 73so9290820oti.12
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 16:04:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2832ff22-e0c8-85b9-c0ce-15b0cc3cdc72@linaro.org>
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<2832ff22-e0c8-85b9-c0ce-15b0cc3cdc72@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 10 Feb 2018 13:04:19 +1300
Message-ID: <CAHNT7NsMqbQfXCKGh7t7OU=fXeOCWk4e94XiQ=k0n9c7db+1_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 00/23] RISC-V QEMU Port Submission
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

On Sat, Feb 10, 2018 at 8:42 AM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 02/07/2018 05:28 PM, Michael Clark wrote:
> >  create mode 100644 hw/riscv/Makefile.objs
> >  create mode 100644 hw/riscv/riscv_elf.c
> >  create mode 100644 hw/riscv/riscv_hart.c
> >  create mode 100644 hw/riscv/riscv_htif.c
> >  create mode 100644 hw/riscv/sifive_clint.c
> >  create mode 100644 hw/riscv/sifive_e300.c
> >  create mode 100644 hw/riscv/sifive_plic.c
> >  create mode 100644 hw/riscv/sifive_prci.c
> >  create mode 100644 hw/riscv/sifive_test.c
> >  create mode 100644 hw/riscv/sifive_u500.c
> >  create mode 100644 hw/riscv/sifive_uart.c
> >  create mode 100644 hw/riscv/spike_v1_09.c
> >  create mode 100644 hw/riscv/spike_v1_10.c
> >  create mode 100644 hw/riscv/virt.c
>
> I have no plans to review these last 9 patches.
> They all look plausible to me, but I'm not so
> up-to-date on best practices within hw/.
>

No problem. Thanks a lot for your help with reviewing disas, target/riscv
and linux-user. The code is now in much much better shape than it was
before. The patches that have been reviewed represent the bulk of the port
(over ~10K LOC of the ~14K LOC in total). The remaining 11 or so patches
are relatively small in comparison.

We could submit the core of the port which would give us linux-user however
it would be nice to get the spike machines and virt machine upstream. The
spike v1.10 machine is required to run riscv-tests and the virt machine is
being used by linux porters.

BTW Let us know when the softfloat changes have landed. We could
potentially point fmin/fmax at minnum/maxnum in the interim.

In any case, we still have a reasonable amount of time left if we want to
get in to the 2.12 release... I see that March 13th is the soft feature
freeze:

- https://wiki.qemu.org/Planning/2.12
