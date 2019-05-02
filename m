Received: from eggs.gnu.org ([209.51.188.92]:59843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMC0l-0006nF-Ar
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMC0j-00071w-DF
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:44:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11719)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hMC0h-0006wQ-Eh
	for qemu-devel@nongnu.org; Thu, 02 May 2019 09:44:28 -0400
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-28-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <eaf5b7ff-b3cf-2053-ac1f-aa913be49a6e@redhat.com>
Date: Thu, 2 May 2019 15:44:20 +0200
MIME-Version: 1.0
In-Reply-To: <20190501050536.15580-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 27/29] target/s390x: Use tcg_gen_abs_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 01.05.19 07:05, Richard Henderson wrote:
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/translate.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index d4951836ad..e8e8a79b7d 100644
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
