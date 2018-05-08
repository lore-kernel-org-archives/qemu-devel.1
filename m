Received: from eggs.gnu.org ([2001:4830:134:3::10]:54673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG2Zp-0005gA-ID
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG2Zo-00067O-Jd
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:22:45 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG2Zo-00067B-E6
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:22:44 -0400
Received: by mail-oi0-x243.google.com with SMTP id c203-v6so28291152oib.7
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 06:22:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525563325-62963-1-git-send-email-mjc@sifive.com>
References: <1525563325-62963-1-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 14:22:23 +0100
Message-ID: <CAFEAcA_=gUN=FF8_--cpsnu8ynsReA+R_9mkfaXzMEmmSo2cKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/20] RISC-V: QEMU 2.13 Privileged ISA
 emulation updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Alistair Francis <alistair.francis@xilinx.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 6 May 2018 at 00:35, Michael Clark <mjc@sifive.com> wrote:
> The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9b9:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' into staging (2018-05-04 14:42:46 +0100)
>
> are available in the git repository at:
>
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.13-pull-20180506
>
> for you to fetch changes up to 5aec3247c190f10654250203a1742490ae7343a2:
>
>   RISC-V: Mark ROM read-only after copying in code (2018-05-06 10:54:21 +1200)
>
> ----------------------------------------------------------------
> RISC-V: QEMU 2.13 Privileged ISA emulation updates
>
> Several code cleanups, minor specification conformance changes,
> fixes to make ROM read-only and add device-tree size checks.
>
> * Honour privileged ISA v1.10 counter enable CSRs.
> * Implements WARL behavior for CSRs that don't support writes
>   * Past behavior of raising traps was non-conformant
>     with the RISC-V Privileged ISA Specification v1.10.
> * Allow S-mode access to sstatus.MXR when priv ISA >= v1.10
> * Sets mtval/stval to zero on exceptions without addresses
>   * Past behavior of leaving the last value was non-conformant
>     with the RISC-V Privileged ISA Specition v1.10. mtval/stval
>     must be set on all exceptions; to zero if not supported.
> * Make ROMs read-only and implement device-tree size checks
>   * Uses memory_region_init_rom and rom_add_blob_fixed_as
> * Adds hexidecimal instruction bytes to disassembly output.
> * Fixes missing break statement for rv128 disassembly.
> * Several code cleanups
>   * Replacing hard-coded constants with enums
>   * Dead-code elimination
>
> This is an incremental pull that contains 20 reviewed changes out
> of 38 changes currently queued in the qemu-2.13-for-upstream branch.
>

Applied, thanks.

-- PMM
