Received: from eggs.gnu.org ([209.51.188.92]:36713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIqMJ-0007Z5-4H
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hIqMI-0001X7-1p
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:00:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hIqMH-0001Uw-Pe
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:00:53 -0400
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-2-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <606d1286-b0e0-b84b-afc4-9757eb70c417@redhat.com>
Date: Tue, 23 Apr 2019 10:00:47 +0200
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/38] target/arm: Fill in .opc for cmtst_op
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
> This allows us to fall back to integers if the tcg backend
> does not support comparisons in the given vece.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index d408e4d7ef..13e2dc6562 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -6140,16 +6140,20 @@ static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
>  const GVecGen3 cmtst_op[4] = {
>      { .fni4 = gen_helper_neon_tst_u8,
>        .fniv = gen_cmtst_vec,
> +      .opc = INDEX_op_cmp_vec,
>        .vece = MO_8 },
>      { .fni4 = gen_helper_neon_tst_u16,
>        .fniv = gen_cmtst_vec,
> +      .opc = INDEX_op_cmp_vec,
>        .vece = MO_16 },
>      { .fni4 = gen_cmtst_i32,
>        .fniv = gen_cmtst_vec,
> +      .opc = INDEX_op_cmp_vec,
>        .vece = MO_32 },
>      { .fni8 = gen_cmtst_i64,
>        .fniv = gen_cmtst_vec,
>        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +      .opc = INDEX_op_cmp_vec,
>        .vece = MO_64 },
>  };
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
