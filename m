Received: from eggs.gnu.org ([209.51.188.92]:39319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW2L-0004J9-Sn
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVyb-0007tQ-Gd
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:51:30 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:43566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLVyb-0007sn-8u
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:51:29 -0400
Received: by mail-pg1-x534.google.com with SMTP id t22so4098247pgi.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:51:29 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-10-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <92815e75-c3da-51df-adb9-a1a2c5b06a30@linaro.org>
Date: Tue, 30 Apr 2019 09:51:15 -0700
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-10-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/14] target/ppc: introduce
 GEN_VSX_HELPER_R2 macro to fpu_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
> -void helper_xsrqpi(CPUPPCState *env, uint32_t opcode)
> +void helper_xsrqpi(CPUPPCState *env, uint32_t opcode,
> +                   ppc_vsr_t *xt, ppc_vsr_t *xb)
>  {
> -    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
> -    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
>      uint8_t r = Rrm(opcode);
>      uint8_t ex = Rc(opcode);
>      uint8_t rmc = RMC(opcode);

For future cleanup, it looks like the rounding mode should be passed in directly.

But anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
