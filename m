Received: from eggs.gnu.org ([2001:4830:134:3::10]:42278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXqwU-0000S2-1W
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXqwS-0002eo-Vm
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:31:14 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXqwS-0002eK-OU
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:31:12 -0400
Received: by mail-wr0-x233.google.com with SMTP id y43so60105186wrd.3
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 08:31:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2017 16:30:50 +0100
Message-ID: <CAFEAcA9MnPUSbKk+YyQmvbP7jrv8VgprU-hwTiq-PE25RU+Tdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/31] target/sh4 queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 July 2017 at 22:50, Aurelien Jarno <aurelien@aurel32.net> wrote:
> This is the target/sh4 patch queue. It contains a better support for atomics
> in linux-user, various FPU fixes and various cleanups.
>
> Thanks,
> Aurelien
>
>
> The following changes since commit 6887dc6700ccb7820d8a9d370f421ee361c748e8:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20170718' into staging (2017-07-18 21:13:48 +0100)
>
> are available in the git repository at:
>
>   git://git.aurel32.net/qemu.git tags/pull-target-sh4-20170718
>
> for you to fetch changes up to ec2eb22ebb3b36f39755414dcbe4f99c2c0562c9:
>
>   target/sh4: Use tcg_gen_lookup_and_goto_ptr (2017-07-18 23:39:18 +0200)
>
> ----------------------------------------------------------------
> Queued target/sh4 patches
>
> ----------------------------------------------------------------
> Aurelien Jarno (5):
>       target/sh4: do not check for PR bit for fabs instruction
>       target/sh4: fix FPU unorderered compare
>       target/sh4: fix FPSCR cause vs flag inversion
>       target/sh4: do not use a helper to implement fneg
>       target/sh4: return result of fcmp using TCG
>
> Richard Henderson (26):
>       target/sh4: Consolidate end-of-TB tests
>       target/sh4: Introduce TB_FLAG_ENVFLAGS_MASK
>       target/sh4: Keep env->flags clean
>       target/sh4: Adjust TB_FLAG_PENDING_MOVCA
>       target/sh4: Handle user-space atomics
>       target/sh4: Recognize common gUSA sequences
>       linux-user/sh4: Notice gUSA regions during signal delivery
>       linux-user/sh4: Clean env->flags on signal boundaries
>       target/sh4: Hoist register bank selection
>       target/sh4: Unify cpu_fregs into FREG
>       target/sh4: Pass DisasContext to fpr64 routines
>       target/sh4: Hoist fp register bank selection
>       target/sh4: Eliminate unused XREG macro
>       target/sh4: Merge DREG into fpr64 routines
>       target/sh4: Load/store Dr as 64-bit quantities
>       target/sh4: Simplify 64-bit fp reg-reg move
>       target/sh4: Unify code for CHECK_NOT_DELAY_SLOT
>       target/sh4: Unify code for CHECK_PRIVILEGED
>       target/sh4: Unify code for CHECK_FPU_ENABLED
>       target/sh4: Tidy misc illegal insn checks
>       target/sh4: Introduce CHECK_FPSCR_PR_*
>       target/sh4: Introduce CHECK_SH4A
>       target/sh4: Implement fpchg
>       target/sh4: Add missing FPSCR.PR == 0 checks
>       target/sh4: Implement fsrra
>       target/sh4: Use tcg_gen_lookup_and_goto_ptr

Applied, thanks.

-- PMM
