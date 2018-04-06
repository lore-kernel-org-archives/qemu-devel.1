Received: from eggs.gnu.org ([2001:4830:134:3::10]:52797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f4RCU-0005nB-2b
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f4RCP-0001ns-OW
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:14:42 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:57176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f4RCP-0001nF-A6
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:14:37 -0400
References: <20180217203132.31780-1-richard.henderson@linaro.org>
	<20180217203132.31780-4-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <0f27ac43-be6c-089d-5089-4eb08023f221@mail.uni-paderborn.de>
Date: Fri, 6 Apr 2018 15:14:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180217203132.31780-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/19] target/hppa: Convert move to/from
 system registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 02/17/2018 09:31 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/translate.c  | 57 +++++++++++++++++++++---------------------------
>  target/hppa/insns.decode | 15 +++++++++++++
>  2 files changed, 40 insertions(+), 32 deletions(-)
> 
[...]
> @@ -2267,24 +2265,26 @@ static void trans_ssm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
>      ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
>      nullify_end(ctx);
>  }
> +#endif /* !CONFIG_USER_ONLY */

This seems to not belong to this patch.

>  
> -static void trans_mtsm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
> +static void trans_mtsm(DisasContext *ctx, arg_mtsm *a, uint32_t insn)
>  {
> -    unsigned rr = extract32(insn, 16, 5);
> -    TCGv_reg tmp, reg;
> -
>      CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
> +#ifndef CONFIG_USER_ONLY

Why do you need to make this softmmu only in a simple convert patch?
This makes it at least confusing for the reviewer.

Otherwise it looks good to me.
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
