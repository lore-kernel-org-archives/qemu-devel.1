Received: from eggs.gnu.org ([2001:4830:134:3::10]:38570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnzzm-0006gX-SI
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnzzj-00087h-PV
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:29:54 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:43142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnzzj-000879-LU
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:29:51 -0400
Received: by mail-ua1-x943.google.com with SMTP id f4-v6so688983uao.10
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 22:29:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1533574847-19294-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <84bab0fd-3624-1613-4e73-5e3a9c06a589@amsat.org>
Date: Fri, 10 Aug 2018 02:29:43 -0300
MIME-Version: 1.0
In-Reply-To: <1533574847-19294-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 04/80] target/mips: Fix two instances of
 shadow variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com

On 08/06/2018 01:59 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Fix two instances of shadow variables. This cleans up entire file
> translate.c from shadow variables.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/mips/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index e32fd5f..d6eccc9 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -13247,7 +13247,7 @@ static void gen_pool16c_r6_insn(DisasContext *ctx)
>              gen_arith_imm(ctx, OPC_ADDIU, 29, 29, imm << 2);
>          } else {
>              /* JRC16 */
> -            int rs = extract32(ctx->opcode, 5, 5);
> +            rs = extract32(ctx->opcode, 5, 5);
>              gen_compute_branch(ctx, OPC_JR, 2, rs, 0, 0, 0);
>          }
>          break;
> @@ -15249,7 +15249,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
>          } else {
>              /* ADDIUPC */
>              int reg = mmreg(ZIMM(ctx->opcode, 23, 3));
> -            int offset = SIMM(ctx->opcode, 0, 23) << 2;
> +            offset = SIMM(ctx->opcode, 0, 23) << 2;
>  
>              gen_addiupc(ctx, reg, offset, 0, 0);
>          }
> 
