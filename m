Received: from eggs.gnu.org ([2001:4830:134:3::10]:45194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eww2N-0006f5-Gc
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eww2L-0004VQ-DK
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:33:15 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:39786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eww2K-0004UO-Sh
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:33:13 -0400
Received: by mail-oi0-x236.google.com with SMTP id p9so5840904oic.6
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 13:33:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <152123079148.75.8090271236020036291@71c20359a636>
References: <1521229281-73637-1-git-send-email-mjc@sifive.com>
	<152123079148.75.8090271236020036291@71c20359a636>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 16 Mar 2018 13:33:11 -0700
Message-ID: <CAHNT7NsKKj2u_3nLz-U3vRF3VdFeWmXomg5G8K4nrEoPvbm40g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [patches] Re: [PATCH v3 00/24] RISC-V Post-merge
 spec conformance and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: RISC-V Patches <patches@groups.riscv.org>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Fri, Mar 16, 2018 at 1:06 PM, <no-reply@patchew.org> wrote:

> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> Type: series
> Message-id: 1521229281-73637-1-git-send-email-mjc@sifive.com
> Subject: [Qemu-devel] [PATCH v3 00/24] RISC-V Post-merge spec conformance
> and cleanup
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
>
> BASE=base
> n=1
> total=$(git log --oneline $BASE.. | wc -l)
> failed=0
>
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
>
> commits="$(git log --format=%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback
> -; then
>         failed=1
>         echo
>     fi
>     n=$((n+1))
> done
>
> exit $failed
> === TEST SCRIPT END ===
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/1521229281-73637-1-
> git-send-email-mjc@sifive.com -> patchew/1521229281-73637-1-
> git-send-email-mjc@sifive.com
> Switched to a new branch 'test'
> cf9ad8471c RISC-V: Clear mtval/stval on exceptions without info
> e0eb5ad03f RISC-V: Convert cpu definition towards future model
> cb986bd661 RISC-V: Remove support for adhoc X_COP interrupt
> c1bea999fe RISC-V: No traps on writes to misa, minstret, mcycle
> c45005f71d RISC-V: vectored traps are optional
> 23dccf73aa RISC-V: riscv-qemu port supports sv39 and sv48
> 9beecddea0 RISC-V: Remove braces from satp case statement
> db362a77b9 RISC-V: Hardwire satp to 0 for no-mmu case
> c696060959 RISC-V: Remove EM_RISCV ELF_MACHINE indirection
> e48c09d25a RISC-V: Use memory_region_is_ram in pte update
> eaa01d4e61 RISC-V: Make virt header comment title consistent
> 9435045fd8 RISC-V: Make some header guards more specific
> 23973a84f7 RISC-V: Update E order and I extension order
> 6efbb781e4 RISC-V: Improve page table walker spec compliance
> 924e46b0b8 RISC-V: Hold rcu_read_lock when accessing memory
> eef95b067f RISC-V: Include intruction hex in disassembly
> 3884a14086 RISC-V: Make sure rom has space for fdt
> 49ad774612 RISC-V: Remove unused class definitions
> 4b771876d8 RISC-V: Mark ROM read-only after copying in code
> 646a8d2508 RISC-V: Remove identity_translate from load_elf
> c582b7bbf0 RISC-V: Use ROM base address and size from memmap
> 8a3ef54b0d RISC-V: Make virt board description match spike
> ba0cbace2d RISC-V: Replace hardcoded constants with enum values
> ec0c0eea8c RISC-V: Make virt create_fdt interface consistent
>
> === OUTPUT BEGIN ===
> Checking PATCH 1/24: RISC-V: Make virt create_fdt interface consistent...
> Checking PATCH 2/24: RISC-V: Replace hardcoded constants with enum
> values...
> Checking PATCH 3/24: RISC-V: Make virt board description match spike...
> Checking PATCH 4/24: RISC-V: Use ROM base address and size from memmap...
> Checking PATCH 5/24: RISC-V: Remove identity_translate from load_elf...
> Checking PATCH 6/24: RISC-V: Mark ROM read-only after copying in code...
> Checking PATCH 7/24: RISC-V: Remove unused class definitions...
> Checking PATCH 8/24: RISC-V: Make sure rom has space for fdt...
> Checking PATCH 9/24: RISC-V: Include intruction hex in disassembly...
> Checking PATCH 10/24: RISC-V: Hold rcu_read_lock when accessing memory...
> ERROR: switch and case should be at the same indent
> #50: FILE: target/riscv/helper.c:240:
> +                switch (action) {
> +                    case success: break;
> +                    case translate_fail: return TRANSLATE_FAIL;
> +                    case restart_walk: goto restart;
>
> ERROR: trailing statements should be on next line
> #51: FILE: target/riscv/helper.c:241:
> +                    case success: break;
>
> ERROR: trailing statements should be on next line
> #53: FILE: target/riscv/helper.c:243:
> +                    case restart_walk: goto restart;
>
> total: 3 errors, 0 warnings, 32 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> Checking PATCH 11/24: RISC-V: Improve page table walker spec compliance...
> Checking PATCH 12/24: RISC-V: Update E order and I extension order...
> Checking PATCH 13/24: RISC-V: Make some header guards more specific...
> Checking PATCH 14/24: RISC-V: Make virt header comment title consistent...
> Checking PATCH 15/24: RISC-V: Use memory_region_is_ram in pte update...
> Checking PATCH 16/24: RISC-V: Remove EM_RISCV ELF_MACHINE indirection...
> Checking PATCH 17/24: RISC-V: Hardwire satp to 0 for no-mmu case...
> Checking PATCH 18/24: RISC-V: Remove braces from satp case statement...
> Checking PATCH 19/24: RISC-V: riscv-qemu port supports sv39 and sv48...
> Checking PATCH 20/24: RISC-V: vectored traps are optional...
> ERROR: trailing whitespace
> #27: FILE: target/riscv/op_helper.c:265:
> +        /* we do not support vectored traps for asynchrounous interrupts
> */ $
>
> ERROR: trailing whitespace
> #42: FILE: target/riscv/op_helper.c:286:
> +        /* we do not support vectored traps for asynchrounous interrupts
> */ $
>
> total: 2 errors, 0 warnings, 28 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> Checking PATCH 21/24: RISC-V: No traps on writes to misa, minstret,
> mcycle...
> Checking PATCH 22/24: RISC-V: Remove support for adhoc X_COP interrupt...
> Checking PATCH 23/24: RISC-V: Convert cpu definition towards future
> model...
> Checking PATCH 24/24: RISC-V: Clear mtval/stval on exceptions without
> info...
> === OUTPUT END ===
>
> Test command exited with code: 1



BTW: I've just fixed the checkpatch warnings and they are in my tree here:

- https://github.com/michaeljclark/riscv-qemu/tree/qemu-devel
