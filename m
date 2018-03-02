Received: from eggs.gnu.org ([2001:4830:134:3::10]:38999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erlZv-0006Sw-O8
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:22:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erlZu-0006Nu-EU
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:22:31 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erlZu-0006Np-9G
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:22:30 -0500
Received: by mail-oi0-x244.google.com with SMTP id x10so7129669oig.2
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 06:22:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519998942-73622-1-git-send-email-mjc@sifive.com>
References: <1519998942-73622-1-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 14:22:09 +0000
Message-ID: <CAFEAcA_kTXTs9z-v3Zow8r52QFrWPwQ3YSjhZOzPr6aj8jdSJQ@mail.gmail.com>
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
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 2 March 2018 at 13:55, Michael Clark <mjc@sifive.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> The following changes since commit 427cbc7e4136a061628cb4315cc8182ea36d772f:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-03-01 18:46:41 +0000)
>
> are available in the git repository at:
>
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-upstream-v8
>
> for you to fetch changes up to b6e0a38a922005d4015e2fdb42e8a783b3cc8e41:
>
>   RISC-V Build Infrastructure (2018-03-03 02:29:21 +1300)
>
> - ----------------------------------------------------------------
> QEMU RISC-V Emulation Support (RV64GC, RV32GC)
>
> This release renames the SiFive machines to sifive_e and sifive_u
> to represent the SiFive Everywhere and SiFive Unleashed platforms.
> SiFive has configurable soft-core IP, so it is intended that these
> machines will be extended to enable a variety of SiFive IP blocks.
> The CPU definition infrastructure has been improved and there are
> now vendor CPU modules including the SiFiVe E31, E51, U34 and U54
> cores. The emulation accuracy for the E series has been improved
> by disabling the MMU for the E series. S mode has been disabled on
> cores that only support M mode and U mode. The two Spike machines
> that support two privileged ISA versions have been coalesced into
> one file. This series has Signed-off-by from the core contributors.
>
> The git tree for the v8 patch series tree (squashed and rebased):
>
> - - https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v8
>
> The git tree for the v1-v7 patch series with review commit history:
>
> - - https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v7
> - - https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v6
> - - https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v5
> - - https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v4
> - - https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v3
> - - https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v2
> - - https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v1
>
> *** Known Issues ***
>
> - - Disassembler has some checkpatch warnings for the sake of code brevity
> - - scripts/qemu-binfmt-conf.sh has checkpatch warnings due to line length
> - - PMP (Physical Memory Protection) is as-of-yet unused and needs testing
>
> *** Changelog ***
>
> v8
>
> - - Added linux-user/riscv/target_elf.h during rebase
> - - Make resetvec configurable and clear mpp and mie on reset
> - - Use SiFive E31, E51, U34 and U54 cores in SiFive machines
> - - Define SiFive E31, E51, U34 and U54 cores
> - - Refactor CPU core definition in preparation for vendor cores
> - - Prevent S or U mode unless S or U extensions are present
> - - SiFive E Series cores have no MMU
> - - SiFive E Series cores have U mode
> - - Make privileged ISA v1.10 implicit in CPU types
> - - Remove DRAM_BASE and EXT_IO_BASE as they vary by machine
> - - Correctly handle mtvec and stvec alignment with respect to RVC
> - - Print more machine mode state in riscv_cpu_dump_state
> - - Make riscv_isa_string use compact extension order method
> - - Fix bug introduced in v6 RISCV_CPU_TYPE_NAME macro change
> - - Parameterize spike v1.9.1 config string
> - - Coalesce spike_v1.9.1 and spike_v1.10 machines
> - - Rename sifive_e300 to sifive_e, and sifive_u500 to sifive_u

Please don't send pull requests until after patches have been put
on list and been reviewed. A minor update to a pullreq is OK if
it's something like a trivial compiler fix or just dropping some
patches that had problems, but if you have this many changes that
deserves a fresh patchset to be sent to the list for review.

(For the QEMU workflow, a pull request isn't a request for patch
review, it's a statement that patches have all had review and
are ready to go into master immediately.)

thanks
-- PMM
