Received: from eggs.gnu.org ([209.51.188.92]:40572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIsMk-0006qZ-PJ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIsMi-0005S7-DL
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:09:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIsMg-0005KG-17
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:09:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id b1so8088478wru.3
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 03:09:24 -0700 (PDT)
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-23-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d5f24e5a-0120-b7ab-e2d8-03956cd36eb9@redhat.com>
Date: Tue, 23 Apr 2019 12:09:21 +0200
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 22/38] target/cris: Use tcg_gen_abs_tl
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
>  target/cris/translate.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index 11b2c11174..0374718f66 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -1685,18 +1685,11 @@ static int dec_cmp_r(CPUCRISState *env, DisasContext *dc)
>  
>  static int dec_abs_r(CPUCRISState *env, DisasContext *dc)
>  {
> -    TCGv t0;
> -
>      LOG_DIS("abs $r%u, $r%u\n",
>              dc->op1, dc->op2);
>      cris_cc_mask(dc, CC_MASK_NZ);
>  
> -    t0 = tcg_temp_new();
> -    tcg_gen_sari_tl(t0, cpu_R[dc->op1], 31);
> -    tcg_gen_xor_tl(cpu_R[dc->op2], cpu_R[dc->op1], t0);
> -    tcg_gen_sub_tl(cpu_R[dc->op2], cpu_R[dc->op2], t0);
> -    tcg_temp_free(t0);
> -
> +    tcg_gen_abs_tl(cpu_R[dc->op2], cpu_R[dc->op1]);
>      cris_alu(dc, CC_OP_MOVE,
>              cpu_R[dc->op2], cpu_R[dc->op2], cpu_R[dc->op2], 4);
>      return 2;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
