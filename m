Received: from eggs.gnu.org ([2001:4830:134:3::10]:51482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZxWO-0003qd-2k
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZxWH-0007m6-Ky
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:01:32 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:38021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fZxWH-0007lf-Aa
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:01:25 -0400
Received: by mail-pg0-x243.google.com with SMTP id c9-v6so7061500pgf.5
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 05:01:24 -0700 (PDT)
Date: Mon, 2 Jul 2018 21:01:19 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180702120119.GP24595@lianli.shorne-pla.net>
References: <20180628030330.15615-1-richard.henderson@linaro.org>
	<153049914837.615.12803592704677471272@946cad8fd14e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153049914837.615.12803592704677471272@946cad8fd14e>
Subject: Re: [Qemu-devel] [PATCH v3 00/23] target/openrisc improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, famz@redhat.com

On Sun, Jul 01, 2018 at 07:39:08PM -0700, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20180628030330.15615-1-richard.henderson@linaro.org
> Subject: [Qemu-devel] [PATCH v3 00/23] target/openrisc improvements
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
>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
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
> Switched to a new branch 'test'
> d2fcddb810 linux-user: Fix struct sigaltstack for openrisc
> 54bf3816e0 linux-user: Implement signals for openrisc
> afd05358f9 target/openrisc: Add support in scripts/qemu-binfmt-conf.sh
> 6c3691e32d target/openrisc: Reorg tlb lookup
> f53e2facc7 target/openrisc: Increase the TLB size
> 0d21fc5c8c target/openrisc: Stub out handle_mmu_fault for softmmu
> f62561d1b7 target/openrisc: Use identical sizes for ITLB and DTLB
> 836489970f target/openrisc: Fix cpu_mmu_index
> 82ec0e63d4 target/openrisc: Fix tlb flushing in mtspr
> 7657ccb683 target/openrisc: Reduce tlb to a single dimension
> 0dedf4e4b9 target/openrisc: Merge mmu_helper.c into mmu.c
> 55d39fdea4 target/openrisc: Remove indirect function calls for mmu
> 68faceb291 target/openrisc: Merge tlb allocation into CPUOpenRISCState
> bb22ed4bd0 target/openrisc: Form the spr index from tcg
> aee6c05885 target/openrisc: Exit the TB after l.mtspr
> 2fa87705e3 target/openrisc: Split out is_user
> 8ffdeef89c target/openrisc: Link more translation blocks
> 14800ca37d target/openrisc: Fix singlestep_enabled
> d40522dde7 target/openrisc: Use exit_tb instead of CPU_INTERRUPT_EXITTB
> 3571c024ff target/openrisc: Remove DISAS_JUMP & DISAS_TB_JUMP
> 7ae2154034 target/openrisc: Log interrupts
> f1f81972ff target/openrisc: Add print_insn_or1k
> 92ac734d19 target/openrisc: Fix mtspr shadow gprs
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/23: target/openrisc: Fix mtspr shadow gprs...
> Checking PATCH 2/23: target/openrisc: Add print_insn_or1k...
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #69: 
> new file mode 100644
> 
> ERROR: Macros with complex values should be enclosed in parenthesis
> #104: FILE: target/openrisc/disas.c:31:
> +#define output(mnemonic, format, ...) \
> +    info->fprintf_func(info->stream, "%-9s " format, \
> +                       mnemonic, ##__VA_ARGS__)
> 
> ERROR: spaces required around that '*' (ctx:WxV)
> #129: FILE: target/openrisc/disas.c:56:
> +    arg_l_##opcode *a, uint32_t insn)                   \
>                     ^
> 
> ERROR: spaces required around that '*' (ctx:WxV)
> #224: FILE: target/openrisc/disas.c:151:
> +    arg_lf_##opcode##_##suffix *a, uint32_t insn)                \
>                                 ^

I have fixed these on my branch.

  https://github.com/stffrdhrn/qemu/tree/or1k-fixes-212-1

> total: 3 errors, 1 warnings, 923 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 3/23: target/openrisc: Log interrupts...
> Checking PATCH 4/23: target/openrisc: Remove DISAS_JUMP & DISAS_TB_JUMP...
> Checking PATCH 5/23: target/openrisc: Use exit_tb instead of CPU_INTERRUPT_EXITTB...
> Checking PATCH 6/23: target/openrisc: Fix singlestep_enabled...
> Checking PATCH 7/23: target/openrisc: Link more translation blocks...
> Checking PATCH 8/23: target/openrisc: Split out is_user...
> Checking PATCH 9/23: target/openrisc: Exit the TB after l.mtspr...
> Checking PATCH 10/23: target/openrisc: Form the spr index from tcg...
> Checking PATCH 11/23: target/openrisc: Merge tlb allocation into CPUOpenRISCState...
> Checking PATCH 12/23: target/openrisc: Remove indirect function calls for mmu...
> Checking PATCH 13/23: target/openrisc: Merge mmu_helper.c into mmu.c...
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #49: 
> deleted file mode 100644
> 
> total: 0 errors, 1 warnings, 23 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 14/23: target/openrisc: Reduce tlb to a single dimension...
> Checking PATCH 15/23: target/openrisc: Fix tlb flushing in mtspr...
> Checking PATCH 16/23: target/openrisc: Fix cpu_mmu_index...
> Checking PATCH 17/23: target/openrisc: Use identical sizes for ITLB and DTLB...
> Checking PATCH 18/23: target/openrisc: Stub out handle_mmu_fault for softmmu...
> Checking PATCH 19/23: target/openrisc: Increase the TLB size...
> Checking PATCH 20/23: target/openrisc: Reorg tlb lookup...
> Checking PATCH 21/23: target/openrisc: Add support in scripts/qemu-binfmt-conf.sh...
> WARNING: line over 80 characters
> #32: FILE: scripts/qemu-binfmt-conf.sh:127:
> +or1k_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x5c'
> 
> ERROR: line over 90 characters
> #33: FILE: scripts/qemu-binfmt-conf.sh:128:
> +or1k_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'

I will not fix this one.  All other lines are just like this.

I just realized the merge window is nearing an end.  I will send a pull request
soon.

-Stafford

> total: 1 errors, 1 warnings, 23 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 22/23: linux-user: Implement signals for openrisc...
> Checking PATCH 23/23: linux-user: Fix struct sigaltstack for openrisc...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
