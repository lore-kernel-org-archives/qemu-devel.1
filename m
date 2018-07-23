Received: from eggs.gnu.org ([2001:4830:134:3::10]:54556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhe8d-0002Kp-D8
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhe8c-0002Ln-Pe
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:56:47 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:36442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fhe8c-0002LJ-HB
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:56:46 -0400
Received: by mail-pg1-x535.google.com with SMTP id s7-v6so804720pgv.3
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 09:56:46 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-32-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <da8aba8f-904f-053e-d049-be3817d0c6e6@linaro.org>
Date: Mon, 23 Jul 2018 09:56:42 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-32-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 31/40] target/mips: Fix ERET/ERETNC
 behavior related to ADEL exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:55 AM, Stefan Markovic wrote:
>      if (env->insn_flags & ISA_NANOMIPS32) {
>          /* Don't clear MIPS_HFLAG_M16 */
> +        if (error_pc & 1) {
> +            if (!(env->hflags & MIPS_HFLAG_DM)) {
> +                env->CP0_BadVAddr = error_pc;
> +            }
> +            env->active_tc.PC = error_pc;
> +            do_raise_exception(env, EXCP_AdEL, 0);
> +        }
>          return;

Why does this need to be done here, when it is also done in translate.c?


r~
