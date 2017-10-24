Received: from eggs.gnu.org ([2001:4830:134:3::10]:35214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pOt-0003yT-BM
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pOq-0003Nt-8f
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:57:07 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:49809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pOq-0003Ne-31
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:57:04 -0400
Received: by mail-qk0-x243.google.com with SMTP id q83so24549780qke.6
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 19:57:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
	<20171020232023.15010-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4fcfe581-e063-2693-6045-e0aa479a8848@amsat.org>
Date: Mon, 23 Oct 2017 23:57:00 -0300
MIME-Version: 1.0
In-Reply-To: <20171020232023.15010-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 15/52] tcg: Push tcg_ctx into
 tcg_gen_callN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, pbonzini@redhat.com

On 10/20/2017 08:19 PM, Richard Henderson wrote:
> Reviewed-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/helper-gen.h | 12 ++++++------
>  tcg/tcg.h                 |  3 +--
>  tcg/tcg.c                 |  4 ++--
>  3 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
> index 8239ffc77c..476acd9220 100644
> --- a/include/exec/helper-gen.h
> +++ b/include/exec/helper-gen.h
> @@ -9,7 +9,7 @@
>  #define DEF_HELPER_FLAGS_0(name, flags, ret)                            \
>  static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
>  {                                                                       \
> -  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 0, NULL);       \
> +  tcg_gen_callN(HELPER(name), dh_retvar(ret), 0, NULL);                 \
>  }
>  
>  #define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
> @@ -17,7 +17,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
>      dh_arg_decl(t1, 1))                                                 \
>  {                                                                       \
>    TCGArg args[1] = { dh_arg(t1, 1) };                                   \
> -  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 1, args);       \
> +  tcg_gen_callN(HELPER(name), dh_retvar(ret), 1, args);                 \
>  }
>  
>  #define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2)                    \
> @@ -25,7 +25,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
>      dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
>  {                                                                       \
>    TCGArg args[2] = { dh_arg(t1, 1), dh_arg(t2, 2) };                    \
> -  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 2, args);       \
> +  tcg_gen_callN(HELPER(name), dh_retvar(ret), 2, args);                 \
>  }
>  
>  #define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3)                \
> @@ -33,7 +33,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
>      dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
>  {                                                                       \
>    TCGArg args[3] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3) };     \
> -  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 3, args);       \
> +  tcg_gen_callN(HELPER(name), dh_retvar(ret), 3, args);                 \
>  }
>  
>  #define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4)            \
> @@ -43,7 +43,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
>  {                                                                       \
>    TCGArg args[4] = { dh_arg(t1, 1), dh_arg(t2, 2),                      \
>                       dh_arg(t3, 3), dh_arg(t4, 4) };                    \
> -  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 4, args);       \
> +  tcg_gen_callN(HELPER(name), dh_retvar(ret), 4, args);                 \
>  }
>  
>  #define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5)        \
> @@ -53,7 +53,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
>  {                                                                       \
>    TCGArg args[5] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),       \
>                       dh_arg(t4, 4), dh_arg(t5, 5) };                    \
> -  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 5, args);       \
> +  tcg_gen_callN(HELPER(name), dh_retvar(ret), 5, args);                 \
>  }
>  
>  #include "helper.h"
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 563e7d36aa..0d61932301 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -951,8 +951,7 @@ do {\
>  
>  bool tcg_op_supported(TCGOpcode op);
>  
> -void tcg_gen_callN(TCGContext *s, void *func,
> -                   TCGArg ret, int nargs, TCGArg *args);
> +void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args);
>  
>  void tcg_op_remove(TCGContext *s, TCGOp *op);
>  TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op, TCGOpcode opc, int narg);
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index c10e73babe..dac3e06a5b 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -974,9 +974,9 @@ bool tcg_op_supported(TCGOpcode op)
>  /* Note: we convert the 64 bit args to 32 bit and do some alignment
>     and endian swap. Maybe it would be better to do the alignment
>     and endian swap in tcg_reg_alloc_call(). */
> -void tcg_gen_callN(TCGContext *s, void *func, TCGArg ret,
> -                   int nargs, TCGArg *args)
> +void tcg_gen_callN(void *func, TCGArg ret, int nargs, TCGArg *args)
>  {
> +    TCGContext *s = &tcg_ctx;

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      int i, real_args, nb_rets, pi;
>      unsigned sizemask, flags;
>      TCGHelperInfo *info;
> 
