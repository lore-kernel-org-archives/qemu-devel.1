Received: from eggs.gnu.org ([2001:4830:134:3::10]:37443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gRkcr-0006yC-Pq
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:10:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gRkcq-0005ko-Hs
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:10:33 -0500
MIME-Version: 1.0
References: <cover.1543352682.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1543352682.git.alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Nov 2018 13:10:02 -0800
Message-ID: <CAKmqyKMoFoCGdGrEju2fiJRujbdm2Vw4Juke3K3ryFzgPmo-eQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 00/24] Add RISC-V TCG backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On Tue, Nov 27, 2018 at 1:06 PM Alistair Francis
<Alistair.Francis@wdc.com> wrote:

It looks like the cover was lost, here it is:

This patch set adds RISC-V backend support to QEMU. This is based on
Michael Clark's original work with some patches ontop.

This has been slightly tested and can run other architecture softmmu
code for a number of instructions but eventually QEMU will do something
it shouldn't.

I haven't tested linux user support at all yet. I think Michael had that
working reliably though and hopefully my changes haven't broken it. I'll
test both a lot more before I send a full patchset.

There are still some todos in the code (there is missing instructions
and byte swapping) and I'll have to rebase this ontop of Richard's TCG
work. In the meantime I wanted to try and keep the ball rolling though.

There are two WIP patches at the end of the series that I am not sure
about, so they have been kept seperate from the series for the time
being.

This branch can be found here:
https://github.com/alistair23/qemu/tree/mainline/alistair/tcg-backend-upstream.next

The working version with Michael's orignal patch and work ontop can be
found here:
https://github.com/alistair23/qemu/tree/mainline/alistair/tcg-backend.next

RFC v2:
 - A large number of changes based on Richard's feedback


>
>
> Alistair Francis (24):
>   elf.h: Add the RISCV ELF magic numbers
>   linux-user: Add host dependency for RISC-V 32-bit
>   linux-user: Add host dependency for RISC-V 64-bit
>   exec: Add RISC-V GCC poison macro
>   riscv: Add the tcg-target header file
>   riscv: Add the tcg target registers
>   riscv: tcg-target: Add support for the constraints
>   riscv: tcg-target: Add the immediate encoders
>   riscv: tcg-target: Add the instruction emitters
>   riscv: tcg-target: Add the relocation functions
>   riscv: tcg-target: Add the mov and movi instruction
>   riscv: tcg-target: Add the extract instructions
>   riscv: tcg-target: Add the out load and store instructions
>   riscv: tcg-target: Add branch and jump instructions
>   riscv: tcg-target: Add slowpath load and store instructions
>   riscv: tcg-target: Add direct load and store instructions
>   riscv: tcg-target: Add the out op decoder
>   riscv: tcg-target: Add the prologue generation and register the JIT
>   riscv: tcg-target: Add the target init code
>   tcg: Add RISC-V cpu signal handler
>   dias: Add RISC-V support
>   configure: Add support for building RISC-V host
>   WIP: Add missing instructions
>   WIP: Try to patch longer branches
>
>  accel/tcg/user-exec.c             |   75 ++
>  configure                         |   12 +-
>  disas.c                           |   10 +-
>  include/elf.h                     |   55 +
>  include/exec/poison.h             |    1 +
>  linux-user/host/riscv32/hostdep.h |   11 +
>  linux-user/host/riscv64/hostdep.h |   11 +
>  tcg/riscv/tcg-target.h            |  173 +++
>  tcg/riscv/tcg-target.inc.c        | 1890 +++++++++++++++++++++++++++++
>  9 files changed, 2234 insertions(+), 4 deletions(-)
>  create mode 100644 linux-user/host/riscv32/hostdep.h
>  create mode 100644 linux-user/host/riscv64/hostdep.h
>  create mode 100644 tcg/riscv/tcg-target.h
>  create mode 100644 tcg/riscv/tcg-target.inc.c
>
> --
> 2.19.1
>
