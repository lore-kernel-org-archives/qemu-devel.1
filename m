Received: from eggs.gnu.org ([2001:4830:134:3::10]:52968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAkTd-00004v-Ka
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAkTa-0004wc-G0
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:34:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAkTa-0004wS-8d
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:34:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id 185-v6so11164891wmt.2
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 16:34:42 -0700 (PDT)
References: <20181011205206.3552-1-richard.henderson@linaro.org>
	<20181011205206.3552-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d1fe59d4-9506-d30d-9caa-4af6e8db9c76@redhat.com>
Date: Fri, 12 Oct 2018 01:34:39 +0200
MIME-Version: 1.0
In-Reply-To: <20181011205206.3552-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/20] target/arm: Mark some arrays const
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/translate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 736880ee71..d59ffa1c67 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -72,7 +72,7 @@ static TCGv_i64 cpu_F0d, cpu_F1d;
>  
>  #include "exec/gen-icount.h"
>  
> -static const char *regnames[] =
> +static const char * const regnames[] =
>      { "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
>        "r8", "r9", "r10", "r11", "r12", "r13", "r14", "pc" };
>  
> @@ -4907,7 +4907,7 @@ static struct {
>      int nregs;
>      int interleave;
>      int spacing;
> -} neon_ls_element_type[11] = {
> +} const neon_ls_element_type[11] = {
>      {4, 4, 1},
>      {4, 4, 2},
>      {4, 1, 1},
> @@ -13089,7 +13089,7 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
>      translator_loop(ops, &dc.base, cpu, tb);
>  }
>  
> -static const char *cpu_mode_names[16] = {
> +static const char * const cpu_mode_names[16] = {
>    "usr", "fiq", "irq", "svc", "???", "???", "mon", "abt",
>    "???", "???", "hyp", "und", "???", "???", "???", "sys"
>  };
> 
