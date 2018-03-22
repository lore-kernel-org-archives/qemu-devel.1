Received: from eggs.gnu.org ([2001:4830:134:3::10]:56925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ez4vJ-00060D-8u
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ez4vG-0006Cv-EP
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:26:49 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:38144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ez4vG-0006CF-4A
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:26:46 -0400
Received: by mail-ot0-x22d.google.com with SMTP id 95-v6so10530083ote.5
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 11:26:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2ced1950-9cbb-9230-578a-162741713ff7@amsat.org>
References: <1521584722-39133-1-git-send-email-mjc@sifive.com>
	<2ced1950-9cbb-9230-578a-162741713ff7@amsat.org>
From: Michael Clark <mjc@sifive.com>
Date: Thu, 22 Mar 2018 11:26:44 -0700
Message-ID: <CAHNT7NsnE2ci24E8JPFRZUda2E1ZMrQaa1hyrB0NpePWp7te8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/25] RISC-V Post-merge spec conformance
 and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Thu, Mar 22, 2018 at 2:56 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Hi Michael,
>
> On 03/20/2018 07:25 PM, Michael Clark wrote:
> > The following changes since commit f1a63fcfcd92c88be8942b5ae71aef
> 9749a4f135:
> >
> >   Update version for v2.12.0-rc0 release (2018-03-20 19:04:22 +0000)
> >
> > are available in the git repository at:
> >
> >   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.12-fixes
> >
> > for you to fetch changes up to e1a247183ac0816284dfda61423f7030b6686679=
:
> >
> >   RISC-V: Remove erroneous comment from translate.c (2018-03-20 14:34:1=
3
> -0700)
> >
> > ----------------------------------------------------------------
> > This is a series of spec conformance bug fixes and code cleanups
> > that we would like to get in before the QEMU 2.12 release.
> >
> > * Implements WARL behavior for CSRs that don't support writes
> > * Improves specification conformance of the page table walker
> >   * Change access checks from ternary operator to if statements
> >   * Checks for misaligned PPNs
> >   * Disallow M-mode or S-mode from fetching from User pages
> >   * Adds reserved PTE flag check: W or W|X
> >   * Set READ flag for PTE X flag if mstatus.mxr is in effect
> >   * Improves page walker comments and general readability
> > * Several trivial code cleanups to hw/riscv
> >   * Replacing hard coded constants with reference to enums
> >     or the machine memory maps.
> >   * Remove unnecessary class initialization boilerplate
> > * Adds bounds checks when writing device-tree to ROM
> > * Updates the cpu model to use a more modern interface
> > * Sets mtval/stval to zero on exceptions without addresses
> > * Fixes memory allocation bug in riscv_isa_string
> >
> > v4
> >
> > * added fix for memory allocation bug in riscv_isa_string
> >
> > v3
> >
> > * refactor rcu_read_lock in PTE update to use single unlock
> > * mstatus.mxr is in effect regardless of privilege mode
> > * remove unnecessary class init from riscv_hart
> > * set mtval/stval to zero on exceptions without addresses
> >
> > v2
> >
> > * remove unused class boilerplate retains qom parent_obj
> > * convert cpu definition towards future model
> > * honor mstatus.mxr flag in page table walker
> >
> > v1
> >
> > * initial post merge cleanup patch series
> >
> > ----------------------------------------------------------------
> > Michael Clark (25):
> >       RISC-V: Make virt create_fdt interface consistent
> >       RISC-V: Replace hardcoded constants with enum values
> >       RISC-V: Make virt board description match spike
> >       RISC-V: Use ROM base address and size from memmap
> >       RISC-V: Remove identity_translate from load_elf
> >       RISC-V: Mark ROM read-only after copying in code
> >       RISC-V: Remove unused class definitions
> >       RISC-V: Make sure rom has space for fdt
> >       RISC-V: Include intruction hex in disassembly
> >       RISC-V: Hold rcu_read_lock when accessing memory
> >       RISC-V: Improve page table walker spec compliance
> >       RISC-V: Update E order and I extension order
> >       RISC-V: Make some header guards more specific
> >       RISC-V: Make virt header comment title consistent
> >       RISC-V: Use memory_region_is_ram in pte update
> >       RISC-V: Remove EM_RISCV ELF_MACHINE indirection
> >       RISC-V: Hardwire satp to 0 for no-mmu case
> >       RISC-V: Remove braces from satp case statement
> >       RISC-V: riscv-qemu port supports sv39 and sv48
> >       RISC-V: vectored traps are optional
> >       RISC-V: No traps on writes to misa,minstret,mcycle
> >       RISC-V: Remove support for adhoc X_COP interrupt
> >       RISC-V: Convert cpu definition towards future model
> >       RISC-V: Clear mtval/stval on exceptions without info
> >       RISC-V: Remove erroneous comment from translate.c
>
>
> I'm not a maintainer, so I'll just give my reviewer point of view, since
> I'm willing to review the RISC-V patches.
>
> From https://wiki.qemu.org/Contribute/FAQ:
>
>   "In order for your patch to be merged, it must either
>   (1) receive a Reviewed-by by a trusted reviewer on qemu-devel or
>   (2) be reviewed by a maintainer and accepted into their tree."
>

Re 2). I am listed as a maintainer for hw/riscv and target/riscv which is
the only area these patches touch and these patches have been in the
riscv.org tree for quite some time. Indeed, most folk are running RISC-V
QEMU from the riscv.org tree as it has previously been the only way to
access the port before it very recently made it upstream.

$ sed -n '/RISC-V/,/^$/p' MAINTAINERS
RISC-V
M: Michael Clark <mjc@sifive.com>
M: Palmer Dabbelt <palmer@sifive.com>
M: Sagar Karandikar <sagark@eecs.berkeley.edu>
M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
S: Maintained
F: target/riscv/
F: hw/riscv/
F: include/hw/riscv/
F: disas/riscv.c

Besides some trivial cleanups (erroneous comments, dead-code), and the cpu
init work we were asked to work on by Peter Maydell, the focus of the
changes are specification conformance. e.g. cases where we were trapping on
CSR accesses when we should return 0 or cases where the page walker didn't
comply with the specification. To review these, it will require a thorough
reading of the RISC-V Privileged ISA Specification:

- https://riscv.org/specifications/privileged-isa/

Given i'm the primary active RISC-V QEMU maintainer then its mostly my
responsibility that we conform with the RISC-V specifications. In time we
will have tests for these corner cases in page walker, and control and
status registers on processor variants that implement different subsets of
the specification (such as SiFive's E series that has no MMU and no S mode,
versus the SiFive U series which implements S mode and has an MMU), but at
this stage it requires a very careful reading of the RISC-V ISA Privileged
ISA Specification.

We will more changes and the patch queue will only grow longer. Soon we
will be trapping on s* CSRs if misa.S is not set and we'll
add RISCV_FEATURE_MMU_HW_AD so that we can distinguish processors that
handle PTE AD bits in hardware vs processors that defer PTE AD bit handling
to software. These can only be reviewed by someone who is familar with the
RISC-V Privileged ISA specification.

As I understand the review process, reviewers can:
> - directly agree with your patches and add their R-b tag so you can pull
> your patches,
> - ask changes.
> If the change is easy/obvious they can:
> - give you the option to add their R-b tag if you agree and do their
> change,
> - wait you respin another version, and review again.
> (Normally when a reviewer commented on a patch, he will track your
> respin, but it is safer to Cc: him due to the mass amount of traffic).
>
> There are sometime misunderstanding and if the updated patch is not what
> the reviewer suggested, he can still notify you in time.
>
>
> In your 25 matches, only 12 have R-b tag.
>
> You could have sent a PR of the reviewed patches, and respin the
> unreviewed patches separately.
>
> I also see you addressed some of my comments, so I'd have liked be able
> to take time to review and eventually test your series.
>

Sure take your time, however do consider that we should be able to fix bugs
as a maintainer for RISC-V. I'm very able to separate well-tested changes
from experimental code. e.g

- https://github.com/michaeljclark/riscv-qemu/tree/wip-riscv-tcg-backend

It will be some time before we submit patches for the RISC-V backend. It
needs to be rock-solid before I would consider submitting it.

In any case, folk are mostly using the riscv-all branch on the riscv.org
tree for the RISC-V QEMU port, so it's not an immediate concern. It just
means that riscv.org QEMU is more likely to be RISC-V compliant than
qemu.org QEMU, assuming specification compliance fixes aren't accepted
upstream. That said, i'd appreciate careful external review, but the most
appropriate source are the RISC-V instruction set architects.

That was my two reviewer's cents.


Thanks for your help with review. I really appreciate it.

The only problem we have that is not your fault, nor your responsibility,
is that the really hard to review patches, that don't have review other
than by the "active" maintainer, may never actually receive review unless
someone dedicates the time to finding the specific paragraphs within the RI=
SC-V
ISA Privileged ISA Specification. The focus of the series, after all,
besides the cleanups is on specification conformance bugs. So they may need
to be accepted under category 2), i.e. are in the maintainers tree.

I'm going to ask around for some folk with RISC-V domain knowledge to
review the remaining patches. Thanks for your help so far...


> >  disas/riscv.c                   |  39 +++++++------
> >  hw/riscv/riscv_hart.c           |   6 --
> >  hw/riscv/sifive_clint.c         |   9 +--
> >  hw/riscv/sifive_e.c             |  34 +----------
> >  hw/riscv/sifive_u.c             |  65 +++++++--------------
> >  hw/riscv/spike.c                |  65 ++++++++-------------
> >  hw/riscv/virt.c                 |  77 +++++++++----------------
> >  include/hw/riscv/sifive_clint.h |   4 ++
> >  include/hw/riscv/sifive_e.h     |   5 --
> >  include/hw/riscv/sifive_u.h     |   9 ++-
> >  include/hw/riscv/spike.h        |  15 ++---
> >  include/hw/riscv/virt.h         |  17 +++---
> >  target/riscv/cpu.c              | 125 ++++++++++++++++++++++--------
> ----------
> >  target/riscv/cpu.h              |   6 +-
> >  target/riscv/cpu_bits.h         |   3 -
> >  target/riscv/helper.c           |  84 ++++++++++++++++++++-------
> >  target/riscv/op_helper.c        |  52 ++++++++---------
> >  target/riscv/translate.c        |   1 -
> >  18 files changed, 281 insertions(+), 335 deletions(-)
> >
>
>
