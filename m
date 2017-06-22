Received: from eggs.gnu.org ([2001:4830:134:3::10]:44765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dO6VC-0004Aw-Bh
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dO6V9-0000Fo-45
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:06:46 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:45464)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dO6V8-0000FS-O7
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:06:43 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149815391105.3600.9013710785760418418.stgit@frigg.lan>
Date: Thu, 22 Jun 2017 21:06:34 +0300
In-Reply-To: <149815391105.3600.9013710785760418418.stgit@frigg.lan>
	(=?utf-8?Q?=22Llu=C3=ADs?=
	Vilanova"'s message of "Thu, 22 Jun 2017 20:51:51 +0300")
Message-ID: <871sqblwwl.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 00/26] translate: [tcg] Generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Please ignore, I'm having problems with my mail server and there's patches =
being
dropeed.

Thanks,
  Lluis


Llu=C3=ADs Vilanova writes:

> This series proposes a generic (target-agnostic) instruction translation
> framework.

> It basically provides a generic main loop for instruction disassembly, wh=
ich
> calls target-specific functions when necessary. This generalization makes
> inserting new code in the main loop easier, and helps in keeping all targ=
ets in
> synch as to the contents of it.

> This series also paves the way towards adding events to trace guest code
> execution (BBLs and instructions).

> I've ported i386/x86-64 and arm/aarch64 as an example to see how it fits =
in the
> current organization, but will port the rest when this series gets merged.

> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
> ---

> Changes in v8
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> * Increase inter-mail sleep time during sending (list keeps refusing some=
 emails
>   due to an excessive send rate).


> Changes in v7
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> * Change BreakpointHitType (BH_*) for BreakpointCheckType (BC_*).
> * Move target-specific translation functions to a struct (TranslatorOps).
> * Split target-specific changes into multiple patches.
> * Rebase on edf8bc9842.


> Changes in v6
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> * Rebase on upstream master (64175afc69).
> * Reorder fields in DisasContextBase to minimize padding [Richard Henders=
on].


> Changes in v5
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> * Remove stray uses of "restrict" keyword.


> Changes in v4
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> * Document new macro QTAILQ_FOREACH_CONTINUE [Peter Maydell].
> * Fix coding style errors reported by checkpatch.
> * Remove use of "restrict" in added functions; it makes older gcc version=
s barf
>   about compilation errors.


> Changes in v3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> * Rebase on 0737f32daf.


> Changes in v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> * Port ARM and AARCH64 targets.
> * Fold single-stepping checks into "max_insns" [Richard Henderson].
> * Move instruction start marks to target code [Richard Henderson].
> * Add target hook for TB start.
> * Check for TCG temporary leaks.
> * Move instruction disassembly into a target hook.
> * Make breakpoint_hit() return an enum to accomodate target's needs (ARM).


> Llu=C3=ADs Vilanova (26):
>       Pass generic CPUState to gen_intermediate_code()
>       queue: Add macro for incremental traversal
>       cpu-exec: Avoid global variables in icount-related functions
>       target: [tcg] Add generic translation framework
>       target: [tcg] Redefine DISAS_* onto the generic translation framewo=
rk (DJ_*)
>       target: [tcg,i386] Port to DisasContextBase
>       target: [tcg,i386] Refactor init_disas_context
>       target: [tcg,i386] Refactor init_globals
>       target: [tcg,i386] Refactor insn_start
>       target: [tcg,i386] Refactor breakpoint_check
>       target: [tcg,i386] Refactor disas_insn
>       target: [tcg,i386] Refactor tb_stop
>       target: [tcg,i386] Refactor disas_flags
>       target: [tcg,i386] Replace DISAS_* with DJ_*
>       target: [tcg,i386] Port to generic translation framework
>       target: [tcg,arm] Replace DISAS_* with DJ_*
>       target: [tcg,arm] Port to DisasContextBase
>       target: [tcg,arm] Port to init_disas_context
>       target: [tcg,arm] Port to init_globals
>       target: [tcg,arm] Port to tb_start
>       target: [tcg,arm] Port to insn_start
>       target: [tcg,arm] Port to breakpoint_check
>       target: [tcg,arm] Port to disas_insn
>       target: [tcg,arm] Port to tb_stop
>       target: [tcg,arm] Port to disas_flags
>       target: [tcg,arm] Port to generic translation framework


>  Makefile.target                |    1=20
>  include/exec/exec-all.h        |   13 +
>  include/exec/gen-icount.h      |    8 -
>  include/exec/translate-block.h |  125 ++++++++++
>  include/qemu/queue.h           |   12 +
>  include/qom/cpu.h              |   22 ++
>  target/alpha/translate.c       |   25 +-
>  target/arm/translate-a64.c     |  312 ++++++++++++-------------
>  target/arm/translate.c         |  503 ++++++++++++++++++++++------------=
------
>  target/arm/translate.h         |   38 ++-
>  target/cris/translate.c        |   26 +-
>  target/hppa/translate.c        |    6=20
>  target/i386/translate.c        |  353 +++++++++++++++-------------
>  target/lm32/translate.c        |   36 +--
>  target/m68k/translate.c        |   24 +-
>  target/microblaze/translate.c  |   28 +-
>  target/mips/translate.c        |   41 ++-
>  target/moxie/translate.c       |   16 +
>  target/nios2/translate.c       |    6=20
>  target/openrisc/translate.c    |   25 +-
>  target/ppc/translate.c         |   21 +-
>  target/ppc/translate_init.c    |   32 +--
>  target/s390x/translate.c       |   22 +-
>  target/sh4/translate.c         |   21 +-
>  target/sparc/translate.c       |   17 +
>  target/tilegx/translate.c      |    9 -
>  target/tricore/translate.c     |   11 -
>  target/unicore32/translate.c   |   26 +-
>  target/xtensa/translate.c      |   39 ++-
>  translate-all.c                |    2=20
>  translate-block.c              |  185 +++++++++++++++
>  31 files changed, 1212 insertions(+), 793 deletions(-)
>  create mode 100644 include/exec/translate-block.h
>  create mode 100644 translate-block.c


> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
