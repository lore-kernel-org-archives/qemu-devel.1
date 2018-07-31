Received: from eggs.gnu.org ([2001:4830:134:3::10]:59405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fka8O-00043j-PW
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fka8K-0006Wz-OJ
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:16:40 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:45528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fka8K-0006WV-I7
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:16:36 -0400
Received: by mail-vk0-x244.google.com with SMTP id b78-v6so8082280vka.12
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 12:16:36 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-47-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6caaacd6-3a61-9e58-05c3-64833e39703a@linaro.org>
Date: Tue, 31 Jul 2018 15:16:31 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-47-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 46/76] target/mips: Add updating
 BadInstr, BadInstrP, BadInstrX for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/30/2018 12:12 PM, Aleksandar Markovic wrote:
> +        if ((env->CP0_Config3 & (1 << CP0C3_BP)) &&
> +            (env->hflags & MIPS_HFLAG_BMASK)) {
> +            if (!(env->hflags & MIPS_HFLAG_B16)) {
> +                env->CP0_BadInstrP = cpu_ldl_code(env, env->active_tc.PC - 4);
> +            } else {
> +                env->CP0_BadInstrP =
> +                    (cpu_lduw_code(env, env->active_tc.PC - 2)) << 16;
> +            }
> +        }

Why would BMASK ever be set for nanomips?
There are no delayed branches.


r~
