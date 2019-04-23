Received: from eggs.gnu.org ([209.51.188.92]:39087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ0LZ-0001hY-Gv
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ0LX-0002OP-GQ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:40:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hJ0LX-0002Mr-7d
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:40:47 -0400
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-25-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <dbba8b1e-b108-cd66-f49d-1519158f1462@redhat.com>
Date: Tue, 23 Apr 2019 20:40:44 +0200
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 20.04.19 09:34, Richard Henderson wrote:
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

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
