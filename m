Received: from eggs.gnu.org ([2001:4830:134:3::10]:53147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAkUd-0000am-60
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAkUZ-0005TK-Hj
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:35:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAkUZ-0005OR-B3
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:35:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so11461102wrw.12
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 16:35:42 -0700 (PDT)
References: <20181011205206.3552-1-richard.henderson@linaro.org>
	<20181011205206.3552-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e5f093cc-4cd2-63b0-81f2-b292ea8d318f@redhat.com>
Date: Fri, 12 Oct 2018 01:35:40 +0200
MIME-Version: 1.0
In-Reply-To: <20181011205206.3552-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/20] target/arm: Don't call
 tcg_clear_temp_count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 11/10/2018 22:51, Richard Henderson wrote:
> This is done generically in translator_loop.
> 
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/translate-a64.c | 1 -
>  target/arm/translate.c     | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 76b5ca3606..ac9723c1b9 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -13899,7 +13899,6 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
>  
>  static void aarch64_tr_tb_start(DisasContextBase *db, CPUState *cpu)
>  {
> -    tcg_clear_temp_count();
>  }
>  
>  static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 426db7828a..736880ee71 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -12701,7 +12701,6 @@ static void arm_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
>          tcg_gen_movi_i32(tmp, 0);
>          store_cpu_field(tmp, condexec_bits);
>      }
> -    tcg_clear_temp_count();
>  }
>  
>  static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
> 
