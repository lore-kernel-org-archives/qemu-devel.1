Received: from eggs.gnu.org ([2001:4830:134:3::10]:54120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1esza4-0008Ct-Ka
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 18:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1esza2-0002Mj-6w
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 18:31:44 -0500
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:33197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1esza1-0002MX-VH
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 18:31:42 -0500
Received: by mail-ot0-x22d.google.com with SMTP id y11so16688071otg.0
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 15:31:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180305190014.GA17059@flamenco>
References: <1519690504-37792-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_0qNcikG2iLii=4zEPYvhz1koEbhCCrCXssdKYv06OJA@mail.gmail.com>
	<CADJ6UvPQMDq_RES_u6WUmXHsita+On4oLu-V=emp3MnmmzjHhQ@mail.gmail.com>
	<CAHNT7Nv04hScm7QDtJMhFZeB=WOyOQ6HW1J-xOEO11GM1xFqyA@mail.gmail.com>
	<20180228222627.GA3575@flamenco>
	<CAHNT7NsPog=OLcU-RuVQQVpYk2n9nvHM453YLdDZocu8h0HYDQ@mail.gmail.com>
	<20180305190014.GA17059@flamenco>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 6 Mar 2018 12:31:40 +1300
Message-ID: <CAHNT7NsmNOO87hSeG4N-8wPSt9aoruOJUwWQxajEVt3bzkwUkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [patches] Re: [PULL] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Stef O'Rear <sorear2@gmail.com>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Tue, Mar 6, 2018 at 8:00 AM, Emilio G. Cota <cota@braap.org> wrote:

> On Sat, Mar 03, 2018 at 02:26:12 +1300, Michael Clark wrote:
> > It was qemu-2.7.50 (late 2016). The benchmarks were generated mid last
> year.
> >
> > I can run the benchmarks again... Has it doubled in speed?
>
> It depends on the benchmarks. Small-ish benchmarks such as rv8-bench
> show about a 1.5x speedup since QEMU v2.6.0 for Aarch64:
>
>                 Aarch64 rv8-bench performance under QEMU user-mode
>                   Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
>
>   4.5 +-+----+------+------+------+------+------+------+------+---
> ---+----+-+
>       |                                                 ++
>   |
>     4 +-+..........v2.8.0.........v2.9.0........v2.10.0.%%.....
> v2.11.0....+-+
>   3.5 +-+...............................................%%@.......
> ........+-+
>       |                                                 %%@
>  |
>     3 +-+...............................................%%@.......
> ........+-+
>   2.5 +-+...............................................%%@.......
> ........+-+
>       |                     ++                        $$$%@
>  |
>     2 +-+.................$$$%@......................##.$%@.......
> ........+-+
>       |                  ##+$%@ ##$$%@               ## $%@
>  |
>   1.5 +-+..+++%%@.......**#.$%@.##.$%@++++%%@........##.$%@.......
> .##$$%@.+-+
>     1 +-+.**#$$%@+##$$%@**#.$%@**#.$%@**#$$%@**#$$%@**#.$%@**#$$%@
> **#.$%@.+-+
>       |   **# $%@**# $%@**# $%@**# $%@**# $%@**#+$%@**# $%@**# $%@**# $%@
>  |
>   0.5 +-+-**#$$%@**#$$%@**#$$%@**#$$%@**#$$%@**#$$%@**#$$%@**#$$%@
> **#$$%@-+-+
>           aes bigidhrystone  miniz   norx primes  qsort sha512geomean
>   png: https://imgur.com/Agr5CJd
>
> SPEC06int shows a larger improvement, up to ~2x avg speedup for the train
> set:
>           Aarch64 SPEC06int (train set) performance under QEMU user-mode
>                   Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
>
>     4 +-+--+----+----+----+----+----+----+----+----+----+----+----
> +----+--+-+
>       |    %%                                           ++
>   |
>   3.5 +-+..%%@.....v2.8.0.........v2.9.0........v2.10.0.%%+....
> v2.11.0....+-+
>       |    %%@                                          %%@       ++
>   |
>     3 +-+..%%@.......++.................................%%@.......
> %%+.....+-+
>       |   +$%@        |+                                %%@       %%@
>  |
>   2.5 +-+.##%@.......%%@...............................+$%@.......
> %%@.....+-+
>     2 +-+.##%@......+%%@.......%%@.................%%@.##%@.......
> %%@..++.+-+
>       |   ##%@  %%@ ##%@      +$%@       %%@       %%@ ##%@       $%@
> %%@  |
>   1.5 +-+**#%@.##%@.##%@......##%@.......$%@.......$%@.##%@..%%+.#
> #%@.##%@+-+
>       |  **#%@**#%@**#%@  +++**#%@      ##%@  ++  ##%@**#%@ ##%@ ##%@
> ##%@  |
>     1 +-+**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@+##%@**#%@+##%@**
> #%@**#%@+-+
>       |  **#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@
> |
>   0.5 +-+**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**#%@**
> #%@**#%@+-+
>        401.bzi403.g429445.g456.h462.libq464.h471.omn4483.xalancbgeomean
>   png: https://imgur.com/JknVT5H
>
> Note that the test set is less sensitive to the changes:
>   https://imgur.com/W7CT0eO
>
> Running small benchmarks (such as SPEC "test" or rv8-bench) is
> very useful to get quick feedback on optimizations. However, some
> of these runs are still dominated by parts of the code that aren't
> that relevant -- for instance, some of them take so little time to
> run that the major contributor to execution time is memory allocation.
> Therefore, when publishing results it's best to stick with larger
> benchmarks that run for longer (e.g. SPEC "train" set), which are more
> sensitive to DBT performance.
>
> I tried running some other benchmarks, such as nbench[1], under rv-jit.
> I quickly get a "bus error" though -- don't know if I'm doing anything
> wrong, or maybe compiling with the glibc cross-compiler I used
> to build riscv linux isn't supported.
> I managed though to run rv8-bench on both rv-jit and qemu (v8 patchset);
> rv-jit is 1.30x faster on average for those, although note I dropped
> qsort because it wasn't working properly on rv-jit:
>

That's interesting. I know from some analysis that the current slow-down in
rv8 is mostly from accessing statically spilled registers (which in many
cases we embed in x86 memory operands to keep up code density, and make use
of the instruction cracker and uop cache in Intel's front-end). The
slowdown is mostly L1 cache latency vs register access latency given we are
emulating 31 registers on a 16 register host with a static register
allocation (based on the compiler register allocation order which optimizes
for the RVC accessible registers). With the addition of a register
allocator, I am sure I can make rv8 substantially faster. perhaps 1.7x

The user-mode emulation in rv8 is very limited, and so far has been
targetted at running rv8-bench compiled with musl-riscv-toolchain
(musl-libc). It has also been tested somewhat with newlib.

- https://github.com/rv8-io/musl-riscv
- https://github.com/rv8-io/musl-riscv-toolchain

I haven't really tested glibc.  It is what I would call a late stage
proof-of-concept, research simulator.

The user-mode simulator was a good way to bring-up the easy part of the
JIT. The next step is register allocation with a hot-spot tiered
optizimation strategy. i.e. interp -> T1 -> T2, where T2 lifts the RISC-V
code to SSA form and does register allocation, and inter-trace swaps based
on the traces entry and exit live register mappings.

When I get time I'd like to implement hardmmu emulation of the RISC-V
privileged ISA. I have a plan to use CR4.PCIDE and PCID to run M, S and U
mode in Ring 3 with different address space IDs. We can take advantage of
various architectural optimisations that are more difficult with a
multi-target translator. i.e. my intended baseline for the (vapourware)
privileged mode translator is Broadwell. i.e. x86_64 + CR4.PCIDE = 1. I
should be able to emulate RISC-V ASID using a LRU/MRU for ASID. I'll also
emulate sv39 page tables, but use 4 level page tables in the first level
page tables of the x86_64 host (not EPT), so that the translator can live
in address space unreachable by the guest, and also so that the translator
can run as a regular guest, in fact inside qemu/kvm for x86_64. i.e. so I
don't need to futz around with Hyperkit/HyperV/HAX/KVM, etc. It will just
be a kernel that can load an RV32/RV64 boot loader in privileged mode.

The problem is SiFive want me to spend most of my time on QEMU, so it's a
weekend project, however most weekends recently have been spent on the
RISC-V QEMU port.

I do hope I have time to spend on rv8 in the future. I will re-run the
rv8-bench suite with a more recent version of QEMU and upload the results.
It could also be useful to track performance differences between different
versions of QEMU. I've automated the generation of charts and tables so it
is pretty easy for me to regenerate the results with new compiler versions
and emulator versions.

               rv8-bench performance under rv-jit and QEMU user-mode
>                   Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
>              [qsort does not finish cleanly for rv8, so I dropped it.]
>
>     3 +-+-----+-------+------+-------+-------+-------+------+-----
> --+-----+-+
>   2.5 +-+..................*****..................................
> ........+-+
>       |                    *-+-* b1bae23b7c2
>   |
>     2 +-+..................*...*...................+-+-+..........
> ........+-+
>   1.5 +-+...........*****..*...*...................*****..........
> ........+-+
>       |     *****   *-+-*  *   *   *****           *   *   ++-+   *****
>  |
>     1 +-+...*-+-*...*...*..*...*...*...*...*****...*...*...****...
> *...*...+-+
>   0.5 +-+---*****---*****--*****---*****---*****---*****---****---
> *****---+-+
>            aes  bigidhrystone   miniz    norx  primes sha512 geomean
>   png: https://imgur.com/rLmTH3L
>
> > I think I can get close to double again with tiered optimization and a
> good
> > register allocator (lift RISC-V asm to SSA form). It's also a hotspot
> > interpreter, which is definately faster than compiling all code, as I
> > benchmarked it. It profiles and only translates hot paths, so code that
> > only runs a few iterations is not translated. When I did eager
> transaltion
> > I got a slow-down.
>
> Yes, hotspot is great for real-life workloads (e.g. booting a system). Note
> though that most benchmarks (e.g. SPEC) don't translate code that often;
> most execution time is spent in loops and therefore the quality of
> the generated code does matter. Hotspot detection of TBs/traces is great
> for this as well, because it allows you to spend more resources generating
> higher-quality code--for instance, see HQEMU[2].
>
> Thanks,
>
>                 Emilio
>
> [1] https://github.com/cota/nbench
> [2] http://www.iis.sinica.edu.tw/papers/dyhong/18243-F.pdf
> PS. One page with all the png's: https://imgur.com/a/5P5zj
>
>
Regards,
Michael.
