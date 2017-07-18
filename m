Received: from eggs.gnu.org ([2001:4830:134:3::10]:38853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXbXY-0005vv-NN
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXbXV-0003g1-HX
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:04:28 -0400
Received: from hall.aurel32.net ([163.172.24.10]:47276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXbXV-0003fK-6h
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 19:04:25 -0400
Date: Wed, 19 Jul 2017 01:02:09 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170718230209.apm26psuvviqf5i7@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
	<150041774840.87.1271379523441005091@5d477a5b5989>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150041774840.87.1271379523441005091@5d477a5b5989>
Subject: Re: [Qemu-devel] [PULL 00/31] target/sh4 queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

On 2017-07-18 15:42, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [Qemu-devel] [PULL 00/31] target/sh4 queue
> Message-id: 20170718215050.3812-1-aurelien@aurel32.net
> Type: series
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
> From https://github.com/patchew-project/qemu
>  - [tag update]      patchew/20170717101632.23247-1-kraxel@redhat.com -> patchew/20170717101632.23247-1-kraxel@redhat.com
> Switched to a new branch 'test'
> 3d16bb6 target/sh4: Use tcg_gen_lookup_and_goto_ptr
> 34df079 target/sh4: Implement fsrra
> ad2bb72 target/sh4: Add missing FPSCR.PR == 0 checks
> f7cf869 target/sh4: Implement fpchg
> 3ab5d19 target/sh4: Introduce CHECK_SH4A
> 3bb62bf target/sh4: Introduce CHECK_FPSCR_PR_*
> 907bcb9 target/sh4: Tidy misc illegal insn checks
> 04ed6b8 target/sh4: Unify code for CHECK_FPU_ENABLED
> 328fcad target/sh4: Unify code for CHECK_PRIVILEGED
> ed53477 target/sh4: Unify code for CHECK_NOT_DELAY_SLOT
> 7d9efde target/sh4: Simplify 64-bit fp reg-reg move
> 5386355 target/sh4: Load/store Dr as 64-bit quantities
> e542610 target/sh4: Merge DREG into fpr64 routines
> e74ac3e6 target/sh4: Eliminate unused XREG macro
> c1c6ee6 target/sh4: Hoist fp register bank selection
> d1b7466 target/sh4: Pass DisasContext to fpr64 routines
> bb17467 target/sh4: Unify cpu_fregs into FREG
> 6db404a target/sh4: Hoist register bank selection
> 0a0f12e linux-user/sh4: Clean env->flags on signal boundaries
> 2f7995c linux-user/sh4: Notice gUSA regions during signal delivery
> e532ba6 target/sh4: Recognize common gUSA sequences
> f47b13f target/sh4: Handle user-space atomics
> eb123e9 target/sh4: Adjust TB_FLAG_PENDING_MOVCA
> 1c3e6c5 target/sh4: Keep env->flags clean
> ae99c5a target/sh4: Introduce TB_FLAG_ENVFLAGS_MASK
> 3f61bea target/sh4: Consolidate end-of-TB tests
> a4421f7 target/sh4: return result of fcmp using TCG
> 30390ef target/sh4: do not use a helper to implement fneg
> 8011852 target/sh4: fix FPSCR cause vs flag inversion
> 70f6b8e target/sh4: fix FPU unorderered compare
> a11e1bf target/sh4: do not check for PR bit for fabs instruction
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/31: target/sh4: do not check for PR bit for fabs instruction...
> Checking PATCH 2/31: target/sh4: fix FPU unorderered compare...
> Checking PATCH 3/31: target/sh4: fix FPSCR cause vs flag inversion...
> Checking PATCH 4/31: target/sh4: do not use a helper to implement fneg...
> Checking PATCH 5/31: target/sh4: return result of fcmp using TCG...
> Checking PATCH 6/31: target/sh4: Consolidate end-of-TB tests...
> Checking PATCH 7/31: target/sh4: Introduce TB_FLAG_ENVFLAGS_MASK...
> Checking PATCH 8/31: target/sh4: Keep env->flags clean...
> Checking PATCH 9/31: target/sh4: Adjust TB_FLAG_PENDING_MOVCA...
> Checking PATCH 10/31: target/sh4: Handle user-space atomics...
> Checking PATCH 11/31: target/sh4: Recognize common gUSA sequences...
> ERROR: braces {} are necessary for all arms of this statement
> #62: FILE: target/sh4/translate.c:1919:
> +    do { if (i >= max_insns) goto fail; ctx->opcode = insns[i++]; } while (0)
> [...]
> 
> ERROR: space prohibited after that '*' (ctx:WxW)
> #184: FILE: target/sh4/translate.c:2041:
> +            if (pc + (i + 1 + B7_0s) * 2 != pc_end) {
>                                       ^
> 
> ERROR: space prohibited after that '*' (ctx:WxW)
> #216: FILE: target/sh4/translate.c:2073:
> +            || pc + (i + 1 + B7_0s) * 2 != pc_end) {
>                                      ^
> 
> total: 3 errors, 0 warnings, 337 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 12/31: linux-user/sh4: Notice gUSA regions during signal delivery...
> Checking PATCH 13/31: linux-user/sh4: Clean env->flags on signal boundaries...
> Checking PATCH 14/31: target/sh4: Hoist register bank selection...
> Checking PATCH 15/31: target/sh4: Unify cpu_fregs into FREG...
> Checking PATCH 16/31: target/sh4: Pass DisasContext to fpr64 routines...
> Checking PATCH 17/31: target/sh4: Hoist fp register bank selection...
> Checking PATCH 18/31: target/sh4: Eliminate unused XREG macro...
> Checking PATCH 19/31: target/sh4: Merge DREG into fpr64 routines...
> Checking PATCH 20/31: target/sh4: Load/store Dr as 64-bit quantities...
> Checking PATCH 21/31: target/sh4: Simplify 64-bit fp reg-reg move...
> Checking PATCH 22/31: target/sh4: Unify code for CHECK_NOT_DELAY_SLOT...
> Checking PATCH 23/31: target/sh4: Unify code for CHECK_PRIVILEGED...
> Checking PATCH 24/31: target/sh4: Unify code for CHECK_FPU_ENABLED...
> Checking PATCH 25/31: target/sh4: Tidy misc illegal insn checks...
> Checking PATCH 26/31: target/sh4: Introduce CHECK_FPSCR_PR_*...
> Checking PATCH 27/31: target/sh4: Introduce CHECK_SH4A...
> ERROR: externs should be avoided in .c files
> #100: FILE: target/sh4/translate.c:1565:
> +        CHECK_SH4A
> 
> ERROR: externs should be avoided in .c files
> #130: FILE: target/sh4/translate.c:1590:
> +        CHECK_SH4A
> 
> total: 2 errors, 0 warnings, 112 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 28/31: target/sh4: Implement fpchg...
> ERROR: externs should be avoided in .c files
> #21: FILE: target/sh4/translate.c:484:
> +        CHECK_SH4A
> 
> total: 1 errors, 0 warnings, 11 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 29/31: target/sh4: Add missing FPSCR.PR == 0 checks...
> ERROR: externs should be avoided in .c files
> #22: FILE: target/sh4/translate.c:476:
> +        CHECK_FPSCR_PR_0
> 
> ERROR: externs should be avoided in .c files
> #27: FILE: target/sh4/translate.c:481:
> +        CHECK_FPSCR_PR_0
> 
> total: 2 errors, 0 warnings, 12 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 30/31: target/sh4: Implement fsrra...
> Checking PATCH 31/31: target/sh4: Use tcg_gen_lookup_and_goto_ptr...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 

Those are all false positives.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
