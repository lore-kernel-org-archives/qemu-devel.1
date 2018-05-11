Received: from eggs.gnu.org ([2001:4830:134:3::10]:47706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH1qC-000470-CU
	for qemu-devel@nongnu.org; Fri, 11 May 2018 02:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fH1q7-0005lt-Tw
	for qemu-devel@nongnu.org; Fri, 11 May 2018 02:47:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fH1q7-0005lj-OV
	for qemu-devel@nongnu.org; Fri, 11 May 2018 02:47:39 -0400
References: <20180511004345.26708-1-richard.henderson@linaro.org>
	<20180511004345.26708-15-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d56b7382-3735-971a-b9e5-00a769ef9a33@redhat.com>
Date: Fri, 11 May 2018 08:47:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180511004345.26708-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/19] target/s390x: Remove
 floatX_maybe_silence_nan from conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, Alexander Graf <agraf@suse.de>

On 11.05.2018 02:43, Richard Henderson wrote:
> This is now handled properly by the generic softfloat code.
> 
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/fpu_helper.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
> index 43f8bf1c94..5c5b451b3b 100644
> --- a/target/s390x/fpu_helper.c
> +++ b/target/s390x/fpu_helper.c
> @@ -269,7 +269,7 @@ uint64_t HELPER(ldeb)(CPUS390XState *env, uint64_t f2)
>  {
>      float64 ret = float32_to_float64(f2, &env->fpu_status);
>      handle_exceptions(env, GETPC());
> -    return float64_maybe_silence_nan(ret, &env->fpu_status);
> +    return ret;
>  }
>  
>  /* convert 128-bit float to 64-bit float */
> @@ -277,7 +277,7 @@ uint64_t HELPER(ldxb)(CPUS390XState *env, uint64_t ah, uint64_t al)
>  {
>      float64 ret = float128_to_float64(make_float128(ah, al), &env->fpu_status);
>      handle_exceptions(env, GETPC());
> -    return float64_maybe_silence_nan(ret, &env->fpu_status);
> +    return ret;
>  }
>  
>  /* convert 64-bit float to 128-bit float */
> @@ -285,7 +285,7 @@ uint64_t HELPER(lxdb)(CPUS390XState *env, uint64_t f2)
>  {
>      float128 ret = float64_to_float128(f2, &env->fpu_status);
>      handle_exceptions(env, GETPC());
> -    return RET128(float128_maybe_silence_nan(ret, &env->fpu_status));
> +    return RET128(ret);
>  }
>  
>  /* convert 32-bit float to 128-bit float */
> @@ -293,7 +293,7 @@ uint64_t HELPER(lxeb)(CPUS390XState *env, uint64_t f2)
>  {
>      float128 ret = float32_to_float128(f2, &env->fpu_status);
>      handle_exceptions(env, GETPC());
> -    return RET128(float128_maybe_silence_nan(ret, &env->fpu_status));
> +    return RET128(ret);
>  }
>  
>  /* convert 64-bit float to 32-bit float */
> @@ -301,7 +301,7 @@ uint64_t HELPER(ledb)(CPUS390XState *env, uint64_t f2)
>  {
>      float32 ret = float64_to_float32(f2, &env->fpu_status);
>      handle_exceptions(env, GETPC());
> -    return float32_maybe_silence_nan(ret, &env->fpu_status);
> +    return ret;
>  }
>  
>  /* convert 128-bit float to 32-bit float */
> @@ -309,7 +309,7 @@ uint64_t HELPER(lexb)(CPUS390XState *env, uint64_t ah, uint64_t al)
>  {
>      float32 ret = float128_to_float32(make_float128(ah, al), &env->fpu_status);
>      handle_exceptions(env, GETPC());
> -    return float32_maybe_silence_nan(ret, &env->fpu_status);
> +    return ret;
>  }
>  
>  /* 32-bit FP compare */
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
