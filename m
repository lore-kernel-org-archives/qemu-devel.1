Received: from eggs.gnu.org ([2001:4830:134:3::10]:41894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1foGCH-0000xB-Lp
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 18:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1foGCC-0006MP-Jy
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 18:47:53 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:55764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1foGCC-0006LX-Ce
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 18:47:48 -0400
References: <20180810222502.19663-1-laurent@vivier.eu>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <8a16ea91-abdb-826e-cf2e-b5b25e1c6a74@physik.fu-berlin.de>
Date: Sat, 11 Aug 2018 00:47:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180810222502.19663-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sh4: fix use_icount with linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

On 08/11/2018 12:25 AM, Laurent Vivier wrote:
> This patch revert changes from 4834871bc9 that are
> not only state renaming.
> 
> This fixes java in a linux-user chroot:
>   $ java --version
>   qemu-sh4: .../accel/tcg/cpu-exec.c:634: cpu_loop_exec_tb: Assertion `use_icount' failed.
>   qemu: uncaught target signal 6 (Aborted) - core dumped
>   Aborted (core dumped)
> 
> The problem seems to be in gen_conditional_jump() in the
> GUSA_EXCLUSIVE part: it should reset base.is_jmp to DISAS_NEXT after the
> gen_goto_tb() as it is done in gen_delayed_conditional_jump() after the
> gen_jump().
Fantastic, this fixes it! Can we get this into 3.0.0 before release?

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
