Received: from eggs.gnu.org ([209.51.188.92]:54398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3eH-0005Tk-3H
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3eF-0004pn-VH
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:12:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJ3eB-0004k9-Rv
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:12:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so1948921wmj.3
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:12:13 -0700 (PDT)
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-25-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a08047bc-7157-49e9-6584-41331dc3b9b4@redhat.com>
Date: Wed, 24 Apr 2019 00:12:10 +0200
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 24/38] target/s390x: Use tcg_gen_abs_i64
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
>  target/s390x/translate.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 0afa8f7ca5..030129acbb 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -1407,13 +1407,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
>  
>  static DisasJumpType op_abs(DisasContext *s, DisasOps *o)
>  {
> -    TCGv_i64 z, n;
> -    z = tcg_const_i64(0);
> -    n = tcg_temp_new_i64();
> -    tcg_gen_neg_i64(n, o->in2);
> -    tcg_gen_movcond_i64(TCG_COND_LT, o->out, o->in2, z, n, o->in2);
> -    tcg_temp_free_i64(n);
> -    tcg_temp_free_i64(z);
> +    tcg_gen_abs_i64(o->out, o->in2);
>      return DISAS_NEXT;
>  }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
