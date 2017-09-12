Received: from eggs.gnu.org ([2001:4830:134:3::10]:60871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drqIu-0007SN-IZ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drqIr-0000DV-Fe
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:53:00 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drqIr-0000D9-BM
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:52:57 -0400
Received: by mail-qk0-x241.google.com with SMTP id g128so7724960qke.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 11:52:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
	<20170912162513.21694-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c07c1ee2-19c3-cd3f-c362-1053a150e168@amsat.org>
Date: Tue, 12 Sep 2017 15:52:53 -0300
MIME-Version: 1.0
In-Reply-To: <20170912162513.21694-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/16] tcg: Remove tcg_regset_{or, and,
 andnot, not}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

On 09/12/2017 01:25 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tcg/tcg.h | 4 ----
>   tcg/tcg.c | 2 +-
>   2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index e168bd2c44..8b4208ea03 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -214,10 +214,6 @@ typedef enum TCGOpcode {
>   #define tcg_regset_set_reg(d, r) (d) |= 1L << (r)
>   #define tcg_regset_reset_reg(d, r) (d) &= ~(1L << (r))
>   #define tcg_regset_test_reg(d, r) (((d) >> (r)) & 1)
> -#define tcg_regset_or(d, a, b) (d) = (a) | (b)
> -#define tcg_regset_and(d, a, b) (d) = (a) & (b)
> -#define tcg_regset_andnot(d, a, b) (d) = (a) & ~(b)
> -#define tcg_regset_not(d, a) (d) = ~(a)
>   
>   #ifndef TCG_TARGET_INSN_UNIT_SIZE
>   # error "Missing TCG_TARGET_INSN_UNIT_SIZE"
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 873915925f..a19767b5ef 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -2306,7 +2306,7 @@ static TCGReg tcg_reg_alloc(TCGContext *s, TCGRegSet desired_regs,
>       TCGReg reg;
>       TCGRegSet reg_ct;
>   
> -    tcg_regset_andnot(reg_ct, desired_regs, allocated_regs);
> +    reg_ct = desired_regs & ~allocated_regs;
>       order = rev ? indirect_reg_alloc_order : tcg_target_reg_alloc_order;
>   
>       /* first try free registers */
> 
