Received: from eggs.gnu.org ([2001:4830:134:3::10]:44772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d3lsN-00073S-Em
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d3lsK-0002Q2-8p
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:02:39 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:35326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d3lsK-0002P1-1c
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:02:36 -0400
Received: by mail-wm0-x234.google.com with SMTP id w64so20994997wma.0
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 09:02:35 -0700 (PDT)
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-2-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170427120006.20564-2-rth@twiddle.net>
Date: Thu, 27 Apr 2017 17:03:04 +0100
Message-ID: <877f2596tj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 01/19] target/nios2: Fix 64-bit ilp32
 compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org


Richard Henderson <rth@twiddle.net> writes:

> Avoid a "cast from pointer to integer of different size" warning
> by using the proper host type.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

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


--
Alex Bennée
