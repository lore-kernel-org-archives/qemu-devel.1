Received: from eggs.gnu.org ([209.51.188.92]:56269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3gN-0006I3-8T
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3gM-0007iL-CX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:14:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJ3gM-0007hD-5e
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:14:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so1971677wmf.1
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:14:30 -0700 (PDT)
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-26-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bc6662b1-3e76-1c82-a402-86fababebc7b@redhat.com>
Date: Wed, 24 Apr 2019 00:14:27 +0200
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 25/38] target/xtensa: Use tcg_gen_abs_i32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: david@redhat.com

On 4/20/19 9:34 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/xtensa/translate.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index 65561d2c49..62be8a6f6a 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -1707,14 +1707,7 @@ void restore_state_to_opc(CPUXtensaState *env, TranslationBlock *tb,
>  static void translate_abs(DisasContext *dc, const OpcodeArg arg[],
>                            const uint32_t par[])
>  {
> -    TCGv_i32 zero = tcg_const_i32(0);
> -    TCGv_i32 neg = tcg_temp_new_i32();
> -
> -    tcg_gen_neg_i32(neg, arg[1].in);
> -    tcg_gen_movcond_i32(TCG_COND_GE, arg[0].out,
> -                        arg[1].in, zero, arg[1].in, neg);
> -    tcg_temp_free(neg);
> -    tcg_temp_free(zero);
> +    tcg_gen_abs_i32(arg[0].out, arg[1].in);
>  }
>  
>  static void translate_add(DisasContext *dc, const OpcodeArg arg[],
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
