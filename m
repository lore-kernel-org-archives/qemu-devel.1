Received: from eggs.gnu.org ([2001:4830:134:3::10]:47554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erxBn-0007gU-Q5
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 21:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erxBm-0001pU-Hh
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 21:46:23 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1erxBm-0001oc-9s
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 21:46:22 -0500
Received: by mail-ot0-x244.google.com with SMTP id w38so10474546ota.8
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 18:46:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_kTXTs9z-v3Zow8r52QFrWPwQ3YSjhZOzPr6aj8jdSJQ@mail.gmail.com>
References: <1519998942-73622-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_kTXTs9z-v3Zow8r52QFrWPwQ3YSjhZOzPr6aj8jdSJQ@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 3 Mar 2018 15:46:21 +1300
Message-ID: <CAHNT7Nt72aUwGAGfV0zYya_WH3qXipk6XnLbfDPytMXMTLSJ-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] RISC-V QEMU Port Submission v8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Sat, Mar 3, 2018 at 3:22 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 2 March 2018 at 13:55, Michael Clark <mjc@sifive.com> wrote:
> >
> > *** Changelog ***
> >
> > v8
> >
> > - - Added linux-user/riscv/target_elf.h during rebase
> > - - Make resetvec configurable and clear mpp and mie on reset
> > - - Use SiFive E31, E51, U34 and U54 cores in SiFive machines
> > - - Define SiFive E31, E51, U34 and U54 cores
> > - - Refactor CPU core definition in preparation for vendor cores
> > - - Prevent S or U mode unless S or U extensions are present
> > - - SiFive E Series cores have no MMU
> > - - SiFive E Series cores have U mode
> > - - Make privileged ISA v1.10 implicit in CPU types
> > - - Remove DRAM_BASE and EXT_IO_BASE as they vary by machine
> > - - Correctly handle mtvec and stvec alignment with respect to RVC
> > - - Print more machine mode state in riscv_cpu_dump_state
> > - - Make riscv_isa_string use compact extension order method
> > - - Fix bug introduced in v6 RISCV_CPU_TYPE_NAME macro change
> > - - Parameterize spike v1.9.1 config string
> > - - Coalesce spike_v1.9.1 and spike_v1.10 machines
> > - - Rename sifive_e300 to sifive_e, and sifive_u500 to sifive_u
>
> Please don't send pull requests until after patches have been put
> on list and been reviewed. A minor update to a pullreq is OK if
> it's something like a trivial compiler fix or just dropping some
> patches that had problems, but if you have this many changes that
> deserves a fresh patchset to be sent to the list for review.
>
> (For the QEMU workflow, a pull request isn't a request for patch
> review, it's a statement that patches have all had review and
> are ready to go into master immediately.)


My apoligies. I won't do this again.

I have some very very minor cleanups that do not affect logic, but perhaps
we could address this after getting approval to make a pull request for v8.

My qemu-devel branch holds changes against the latest rebase:

- https://github.com/michaeljclark/riscv-qemu/tree/qemu-devel

Someone raised timebase frequency on the RISC-V sw-dev and after looking at
the code I noticed we had a hard-coded value for a few of the constants we
put in device tree, and i spotted a missed rename. I'm going to have to
learn about the qemu-devel process for trivial fixes...

Thanks for bearing with me, and my apologies for not following QEMU
workflow ettiquite with the v8 series. the tag is locked down and signed in
any case.

Regards,
Michael.
