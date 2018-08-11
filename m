Received: from eggs.gnu.org ([2001:4830:134:3::10]:56055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foVnF-0002S0-1q
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 11:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foVnB-0001qy-U3
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 11:27:05 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1foVnB-0001nT-Ks
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 11:27:01 -0400
Received: by mail-pg1-x543.google.com with SMTP id r1-v6so5668000pgp.11
	for <qemu-devel@nongnu.org>; Sat, 11 Aug 2018 08:27:01 -0700 (PDT)
References: <20180811082328.11268-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7195617a-1f47-00e1-638f-50d20c21ba9e@linaro.org>
Date: Sat, 11 Aug 2018 08:26:57 -0700
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On 08/11/2018 01:23 AM, Laurent Vivier wrote:
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
> ---
> 
> Notes:
>     v2:
>       don't revert the part of the original patch,
>       but fixes the state problem in gen_conditional_jump()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
