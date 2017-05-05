Received: from eggs.gnu.org ([2001:4830:134:3::10]:38423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6blQ-0003Wj-HN
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6blN-0008N3-Dc
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:51:12 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d6blN-0008Mk-9J
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:51:09 -0400
Received: by mail-qk0-x241.google.com with SMTP id k74so452889qke.2
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 04:51:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170502192300.2124-1-rth@twiddle.net>
	<20170502192300.2124-2-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c26c25a9-26d4-de19-d926-8b338fcc4307@amsat.org>
Date: Fri, 5 May 2017 08:51:05 -0300
MIME-Version: 1.0
In-Reply-To: <20170502192300.2124-2-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 01/25] target/nios2: Fix 64-bit ilp32
 compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: cota@braap.org

On 05/02/2017 04:22 PM, Richard Henderson wrote:
> Avoid a "cast from pointer to integer of different size" warning
> by using the proper host type.
>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/nios2/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/nios2/translate.c b/target/nios2/translate.c
> index cfec479..2f3c2e5 100644
> --- a/target/nios2/translate.c
> +++ b/target/nios2/translate.c
> @@ -164,7 +164,7 @@ static void gen_goto_tb(DisasContext *dc, int n, uint32_t dest)
>      if (use_goto_tb(dc, dest)) {
>          tcg_gen_goto_tb(n);
>          tcg_gen_movi_tl(dc->cpu_R[R_PC], dest);
> -        tcg_gen_exit_tb((tcg_target_long)tb + n);
> +        tcg_gen_exit_tb((uintptr_t)tb + n);
>      } else {
>          tcg_gen_movi_tl(dc->cpu_R[R_PC], dest);
>          tcg_gen_exit_tb(0);
>
