Received: from eggs.gnu.org ([2001:4830:134:3::10]:55288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1foVjL-00009s-NL
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 11:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1foVjI-0007Jy-Hc
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 11:23:03 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:39847)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1foVjI-0007Ho-9A
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 11:23:00 -0400
References: <20180811082328.11268-1-laurent@vivier.eu>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <d4baf81e-a4db-ca58-cf79-64f9995b37ed@physik.fu-berlin.de>
Date: Sat, 11 Aug 2018 17:22:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180811082328.11268-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] sh4: fix use_icount with linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 08/11/2018 10:23 AM, Laurent Vivier wrote:
> This fixes java in a linux-user chroot:
>   $ java --version
>   qemu-sh4: .../accel/tcg/cpu-exec.c:634: cpu_loop_exec_tb: Assertion `use_icount' failed.
>   qemu: uncaught target signal 6 (Aborted) - core dumped
>   Aborted (core dumped)
> 
> In gen_conditional_jump() in the GUSA_EXCLUSIVE part, we must reset
> base.is_jmp to DISAS_NEXT after the gen_goto_tb() as it is done in
> gen_delayed_conditional_jump() after the gen_jump().
> 
> Bug: https://bugs.launchpad.net/qemu/+bug/1768246
> Fixes: 4834871bc95b67343248100e2a75ae0d287bc08b
>        ("target/sh4: Convert to DisasJumpType")
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Thanks, testing this revision now as well.

Both patches finally allow me to use much newer QEMU versions for SH4,
before that I was stuck to versions from before the regression was
introduced.

So far, the overall improvement is quite spectacular and even the
Haskell compiler GHC now works much more reliable on qemu-sh4 than
it did in the past.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
