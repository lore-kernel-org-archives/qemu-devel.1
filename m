Received: from eggs.gnu.org ([2001:4830:134:3::10]:48050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhdox-0006YA-Id
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhdow-0000e7-S7
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:36:27 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:40974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fhdow-0000du-JX
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:36:26 -0400
Received: by mail-pl0-x241.google.com with SMTP id w8-v6so447379ply.8
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 09:36:26 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-25-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d32d4608-ac4b-1d13-f3dc-946a634833cb@linaro.org>
Date: Mon, 23 Jul 2018 09:36:22 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-25-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 24/40] target/mips: Add updating
 BadInstr and BadInstrP registers for nanoMIPS
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

On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> +        if (!(env->insn_flags & ISA_NANOMIPS32)) {
> +            /* TODO: add BadInstr support for pre-nanoMIPS */
> +             return;
> +        }
> +        if (env->CP0_Config3 & (1 << CP0C3_BI)) {
> +            instr = (cpu_lduw_code(env, env->active_tc.PC)) << 16;
> +            if ((env->insn_flags & ISA_NANOMIPS32) &&

Redundant check for nanomips.


r~
