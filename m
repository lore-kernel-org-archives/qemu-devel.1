Received: from eggs.gnu.org ([2001:4830:134:3::10]:33127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dwvWq-0000hR-N3
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dwvWm-00040x-Jw
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:28:24 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:46577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dwvWm-00040i-7c
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:28:20 -0400
Received: by mail-wm0-x235.google.com with SMTP id m72so11289328wmc.1
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 12:28:19 -0700 (PDT)
References: <20170916023417.14599-1-richard.henderson@linaro.org>
	<20170916023417.14599-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170916023417.14599-2-richard.henderson@linaro.org>
Date: Tue, 26 Sep 2017 20:28:16 +0100
Message-ID: <87shf9cl9r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/6] tcg: Add types and operations for
 host vectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Nothing uses or enables them yet.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op.h  |  26 +++++++
>  tcg/tcg-opc.h |  37 ++++++++++
>  tcg/tcg.h     |  34 +++++++++
>  tcg/tcg-op.c  | 234 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tcg/tcg.c     |  77 ++++++++++++++++++-
>  tcg/README    |  46 ++++++++++++
>  6 files changed, 453 insertions(+), 1 deletion(-)
>
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index 5d3278f243..b9b0b9f46f 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -915,6 +915,32 @@ void tcg_gen_atomic_or_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
>  void tcg_gen_atomic_xor_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
>  void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
>
> +void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
> +void tcg_gen_movi_vec(TCGv_vec, tcg_target_long);
> +void tcg_gen_add8_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_add16_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_add32_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_add64_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_sub8_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_sub16_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_sub32_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_sub64_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_and_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_or_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_xor_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_andc_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_orc_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b);
> +void tcg_gen_not_vec(TCGv_vec r, TCGv_vec a);
> +void tcg_gen_neg8_vec(TCGv_vec r, TCGv_vec a);
> +void tcg_gen_neg16_vec(TCGv_vec r, TCGv_vec a);
> +void tcg_gen_neg32_vec(TCGv_vec r, TCGv_vec a);
> +void tcg_gen_neg64_vec(TCGv_vec r, TCGv_vec a);
> +
> +void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
> +void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
> +void tcg_gen_ldz_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType sz);
> +void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType sz);
> +
>  #if TARGET_LONG_BITS == 64
>  #define tcg_gen_movi_tl tcg_gen_movi_i64
>  #define tcg_gen_mov_tl tcg_gen_mov_i64
> diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
> index 956fb1e9f3..8200184fa9 100644
> --- a/tcg/tcg-opc.h
> +++ b/tcg/tcg-opc.h
> @@ -204,8 +204,45 @@ DEF(qemu_ld_i64, DATA64_ARGS, TLADDR_ARGS, 1,
>  DEF(qemu_st_i64, 0, TLADDR_ARGS + DATA64_ARGS, 1,
>      TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
>
> +/* Host vector support.  */
> +
> +#define IMPLVEC  \
> +    IMPL(TCG_TARGET_HAS_v64 | TCG_TARGET_HAS_v128 | TCG_TARGET_HAS_v256)
> +
> +DEF(mov_vec, 1, 1, 1, TCG_OPF_NOT_PRESENT)
> +
> +/* ??? Simple, but perhaps dupiN would be more descriptive.  */
> +DEF(movi_vec, 1, 0, 2, TCG_OPF_NOT_PRESENT)
> +
> +DEF(ld_vec, 1, 1, 2, IMPLVEC)
> +DEF(ldz_vec, 1, 1, 3, IMPLVEC)
> +DEF(st_vec, 0, 2, 2, IMPLVEC)
> +
> +DEF(add8_vec, 1, 2, 1, IMPLVEC)
> +DEF(add16_vec, 1, 2, 1, IMPLVEC)
> +DEF(add32_vec, 1, 2, 1, IMPLVEC)
> +DEF(add64_vec, 1, 2, 1, IMPLVEC)
> +
> +DEF(sub8_vec, 1, 2, 1, IMPLVEC)
> +DEF(sub16_vec, 1, 2, 1, IMPLVEC)
> +DEF(sub32_vec, 1, 2, 1, IMPLVEC)
> +DEF(sub64_vec, 1, 2, 1, IMPLVEC)
> +
> +DEF(neg8_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_neg_vec))
> +DEF(neg16_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_neg_vec))
> +DEF(neg32_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_neg_vec))
> +DEF(neg64_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_neg_vec))
> +
> +DEF(and_vec, 1, 2, 1, IMPLVEC)
> +DEF(or_vec, 1, 2, 1, IMPLVEC)
> +DEF(xor_vec, 1, 2, 1, IMPLVEC)
> +DEF(andc_vec, 1, 2, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_andc_vec))
> +DEF(orc_vec, 1, 2, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_orc_vec))
> +DEF(not_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_not_vec))
> +
>  #undef TLADDR_ARGS
>  #undef DATA64_ARGS
>  #undef IMPL
>  #undef IMPL64
> +#undef IMPLVEC
>  #undef DEF
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 25662c36d4..7cd356e87f 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -173,6 +173,16 @@ typedef uint64_t TCGRegSet;
>  # error "Missing unsigned widening multiply"
>  #endif
>
> +#ifndef TCG_TARGET_HAS_v64
> +#define TCG_TARGET_HAS_v64              0
> +#define TCG_TARGET_HAS_v128             0
> +#define TCG_TARGET_HAS_v256             0
> +#define TCG_TARGET_HAS_neg_vec          0
> +#define TCG_TARGET_HAS_not_vec          0
> +#define TCG_TARGET_HAS_andc_vec         0
> +#define TCG_TARGET_HAS_orc_vec          0
> +#endif
> +
>  #ifndef TARGET_INSN_START_EXTRA_WORDS
>  # define TARGET_INSN_START_WORDS 1
>  #else
> @@ -249,6 +259,11 @@ typedef struct TCGPool {
>  typedef enum TCGType {
>      TCG_TYPE_I32,
>      TCG_TYPE_I64,
> +
> +    TCG_TYPE_V64,
> +    TCG_TYPE_V128,
> +    TCG_TYPE_V256,
> +
>      TCG_TYPE_COUNT, /* number of different types */
>
>      /* An alias for the size of the host register.  */
> @@ -399,6 +414,8 @@ typedef tcg_target_ulong TCGArg;
>      * TCGv_i32 : 32 bit integer type
>      * TCGv_i64 : 64 bit integer type
>      * TCGv_ptr : a host pointer type
> +    * TCGv_vec : a host vector type; the exact size is not exposed
> +                 to the CPU front-end code.

Isn't this a guest vector type (which is pointed to by a host pointer)?

>      * TCGv : an integer type the same size as target_ulong
>               (an alias for either TCGv_i32 or TCGv_i64)
>     The compiler's type checking will complain if you mix them
> @@ -424,6 +441,7 @@ typedef tcg_target_ulong TCGArg;
>  typedef struct TCGv_i32_d *TCGv_i32;
>  typedef struct TCGv_i64_d *TCGv_i64;
>  typedef struct TCGv_ptr_d *TCGv_ptr;
> +typedef struct TCGv_vec_d *TCGv_vec;
>  typedef TCGv_ptr TCGv_env;
>  #if TARGET_LONG_BITS == 32
>  #define TCGv TCGv_i32
> @@ -448,6 +466,11 @@ static inline TCGv_ptr QEMU_ARTIFICIAL MAKE_TCGV_PTR(intptr_t i)
>      return (TCGv_ptr)i;
>  }
>
> +static inline TCGv_vec QEMU_ARTIFICIAL MAKE_TCGV_VEC(intptr_t i)
> +{
> +    return (TCGv_vec)i;
> +}
> +
>  static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_I32(TCGv_i32 t)
>  {
>      return (intptr_t)t;
> @@ -463,6 +486,11 @@ static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_PTR(TCGv_ptr t)
>      return (intptr_t)t;
>  }
>
> +static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_VEC(TCGv_vec t)
> +{
> +    return (intptr_t)t;
> +}
> +
>  #if TCG_TARGET_REG_BITS == 32
>  #define TCGV_LOW(t) MAKE_TCGV_I32(GET_TCGV_I64(t))
>  #define TCGV_HIGH(t) MAKE_TCGV_I32(GET_TCGV_I64(t) + 1)
> @@ -471,15 +499,18 @@ static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_PTR(TCGv_ptr t)
>  #define TCGV_EQUAL_I32(a, b) (GET_TCGV_I32(a) == GET_TCGV_I32(b))
>  #define TCGV_EQUAL_I64(a, b) (GET_TCGV_I64(a) == GET_TCGV_I64(b))
>  #define TCGV_EQUAL_PTR(a, b) (GET_TCGV_PTR(a) == GET_TCGV_PTR(b))
> +#define TCGV_EQUAL_VEC(a, b) (GET_TCGV_VEC(a) == GET_TCGV_VEC(b))
>
>  /* Dummy definition to avoid compiler warnings.  */
>  #define TCGV_UNUSED_I32(x) x = MAKE_TCGV_I32(-1)
>  #define TCGV_UNUSED_I64(x) x = MAKE_TCGV_I64(-1)
>  #define TCGV_UNUSED_PTR(x) x = MAKE_TCGV_PTR(-1)
> +#define TCGV_UNUSED_VEC(x) x = MAKE_TCGV_VEC(-1)
>
>  #define TCGV_IS_UNUSED_I32(x) (GET_TCGV_I32(x) == -1)
>  #define TCGV_IS_UNUSED_I64(x) (GET_TCGV_I64(x) == -1)
>  #define TCGV_IS_UNUSED_PTR(x) (GET_TCGV_PTR(x) == -1)
> +#define TCGV_IS_UNUSED_VEC(x) (GET_TCGV_VEC(x) == -1)
>
>  /* call flags */
>  /* Helper does not read globals (either directly or through an exception). It
> @@ -790,9 +821,12 @@ TCGv_i64 tcg_global_reg_new_i64(TCGReg reg, const char *name);
>
>  TCGv_i32 tcg_temp_new_internal_i32(int temp_local);
>  TCGv_i64 tcg_temp_new_internal_i64(int temp_local);
> +TCGv_vec tcg_temp_new_vec(TCGType type);
> +TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match);
>
>  void tcg_temp_free_i32(TCGv_i32 arg);
>  void tcg_temp_free_i64(TCGv_i64 arg);
> +void tcg_temp_free_vec(TCGv_vec arg);
>
>  static inline TCGv_i32 tcg_global_mem_new_i32(TCGv_ptr reg, intptr_t offset,
>                                                const char *name)
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 688d91755b..50b3177e5f 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -3072,3 +3072,237 @@ static void tcg_gen_mov2_i64(TCGv_i64 r, TCGv_i64 a, TCGv_i64 b)
>  GEN_ATOMIC_HELPER(xchg, mov2, 0)
>
>  #undef GEN_ATOMIC_HELPER
> +
> +static void tcg_gen_op2_vec(TCGOpcode opc, TCGv_vec r, TCGv_vec a)
> +{
> +    TCGArg ri = GET_TCGV_VEC(r);
> +    TCGArg ai = GET_TCGV_VEC(a);
> +    TCGTemp *rt = &tcg_ctx.temps[ri];
> +    TCGTemp *at = &tcg_ctx.temps[ai];
> +    TCGType type = rt->base_type;
> +
> +    tcg_debug_assert(at->base_type == type);
> +    tcg_gen_op3(&tcg_ctx, opc, ri, ai, type - TCG_TYPE_V64);
> +}
> +
> +static void tcg_gen_op3_vec(TCGOpcode opc, TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    TCGArg ri = GET_TCGV_VEC(r);
> +    TCGArg ai = GET_TCGV_VEC(a);
> +    TCGArg bi = GET_TCGV_VEC(b);
> +    TCGTemp *rt = &tcg_ctx.temps[ri];
> +    TCGTemp *at = &tcg_ctx.temps[ai];
> +    TCGTemp *bt = &tcg_ctx.temps[bi];
> +    TCGType type = rt->base_type;
> +
> +    tcg_debug_assert(at->base_type == type);
> +    tcg_debug_assert(bt->base_type == type);
> +    tcg_gen_op4(&tcg_ctx, opc, ri, ai, bi, type - TCG_TYPE_V64);
> +}
> +
> +void tcg_gen_mov_vec(TCGv_vec r, TCGv_vec a)
> +{
> +    if (!TCGV_EQUAL_VEC(r, a)) {
> +        tcg_gen_op2_vec(INDEX_op_mov_vec, r, a);
> +    }
> +}
> +
> +void tcg_gen_movi_vec(TCGv_vec r, tcg_target_long a)
> +{
> +    TCGArg ri = GET_TCGV_VEC(r);
> +    TCGTemp *rt = &tcg_ctx.temps[ri];
> +    TCGType type = rt->base_type;
> +
> +    tcg_debug_assert(a == 0 || a == -1);
> +    tcg_gen_op3(&tcg_ctx, INDEX_op_movi_vec, ri, a, type - TCG_TYPE_V64);
> +}
> +
> +void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr b, TCGArg o)
> +{
> +    TCGArg ri = GET_TCGV_VEC(r);
> +    TCGArg bi = GET_TCGV_PTR(b);
> +    TCGTemp *rt = &tcg_ctx.temps[ri];
> +    TCGType type = rt->base_type;
> +
> +    tcg_gen_op4(&tcg_ctx, INDEX_op_ld_vec, ri, bi, o, type - TCG_TYPE_V64);
> +}
> +
> +void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr b, TCGArg o)
> +{
> +    TCGArg ri = GET_TCGV_VEC(r);
> +    TCGArg bi = GET_TCGV_PTR(b);
> +    TCGTemp *rt = &tcg_ctx.temps[ri];
> +    TCGType type = rt->base_type;
> +
> +    tcg_gen_op4(&tcg_ctx, INDEX_op_st_vec, ri, bi, o, type - TCG_TYPE_V64);
> +}
> +
> +/* Load data into a vector R from B+O using TYPE.  If R is wider than TYPE,
> +   fill the high bits with zeros.  */
> +void tcg_gen_ldz_vec(TCGv_vec r, TCGv_ptr b, TCGArg o, TCGType type)
> +{
> +    TCGArg ri = GET_TCGV_VEC(r);
> +    TCGArg bi = GET_TCGV_PTR(b);
> +    TCGTemp *rt = &tcg_ctx.temps[ri];
> +    TCGType btype = rt->base_type;
> +
> +    if (type < btype) {
> +        tcg_gen_op5(&tcg_ctx, INDEX_op_ldz_vec, ri, bi, o,
> +                    type - TCG_TYPE_V64, btype - TCG_TYPE_V64);
> +    } else {
> +        tcg_debug_assert(type == btype);
> +        tcg_gen_op4(&tcg_ctx, INDEX_op_ld_vec, ri, bi, o, type - TCG_TYPE_V64);
> +    }
> +}
> +
> +/* Store data from vector R into B+O using TYPE.  If R is wider than TYPE,
> +   store only the low bits.  */
> +void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr b, TCGArg o, TCGType type)
> +{
> +    TCGArg ri = GET_TCGV_VEC(r);
> +    TCGArg bi = GET_TCGV_PTR(b);
> +    TCGTemp *rt = &tcg_ctx.temps[ri];
> +    TCGType btype = rt->base_type;
> +
> +    tcg_debug_assert(type <= btype);
> +    tcg_gen_op4(&tcg_ctx, INDEX_op_st_vec, ri, bi, o, type - TCG_TYPE_V64);
> +}
> +
> +void tcg_gen_add8_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    tcg_gen_op3_vec(INDEX_op_add8_vec, r, a, b);
> +}
> +
> +void tcg_gen_add16_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    tcg_gen_op3_vec(INDEX_op_add16_vec, r, a, b);
> +}
> +
> +void tcg_gen_add32_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    tcg_gen_op3_vec(INDEX_op_add32_vec, r, a, b);
> +}
> +
> +void tcg_gen_add64_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    tcg_gen_op3_vec(INDEX_op_add64_vec, r, a, b);
> +}
> +
> +void tcg_gen_sub8_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    tcg_gen_op3_vec(INDEX_op_sub8_vec, r, a, b);
> +}
> +
> +void tcg_gen_sub16_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    tcg_gen_op3_vec(INDEX_op_sub16_vec, r, a, b);
> +}
> +
> +void tcg_gen_sub32_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    tcg_gen_op3_vec(INDEX_op_sub32_vec, r, a, b);
> +}
> +
> +void tcg_gen_sub64_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    tcg_gen_op3_vec(INDEX_op_sub64_vec, r, a, b);
> +}
> +
> +void tcg_gen_and_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    tcg_gen_op3_vec(INDEX_op_and_vec, r, a, b);
> +}
> +
> +void tcg_gen_or_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    tcg_gen_op3_vec(INDEX_op_or_vec, r, a, b);
> +}
> +
> +void tcg_gen_xor_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    tcg_gen_op3_vec(INDEX_op_xor_vec, r, a, b);
> +}
> +
> +void tcg_gen_andc_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    if (TCG_TARGET_HAS_andc_vec) {
> +        tcg_gen_op3_vec(INDEX_op_andc_vec, r, a, b);
> +    } else {
> +        TCGv_vec t = tcg_temp_new_vec_matching(r);
> +        tcg_gen_not_vec(t, b);
> +        tcg_gen_and_vec(r, a, t);
> +        tcg_temp_free_vec(t);
> +    }
> +}
> +
> +void tcg_gen_orc_vec(TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    if (TCG_TARGET_HAS_orc_vec) {
> +        tcg_gen_op3_vec(INDEX_op_orc_vec, r, a, b);
> +    } else {
> +        TCGv_vec t = tcg_temp_new_vec_matching(r);
> +        tcg_gen_not_vec(t, b);
> +        tcg_gen_or_vec(r, a, t);
> +        tcg_temp_free_vec(t);
> +    }
> +}
> +
> +void tcg_gen_not_vec(TCGv_vec r, TCGv_vec a)
> +{
> +    if (TCG_TARGET_HAS_not_vec) {
> +        tcg_gen_op2_vec(INDEX_op_orc_vec, r, a);
> +    } else {
> +        TCGv_vec t = tcg_temp_new_vec_matching(r);
> +        tcg_gen_movi_vec(t, -1);
> +        tcg_gen_xor_vec(r, a, t);
> +        tcg_temp_free_vec(t);
> +    }
> +}
> +
> +void tcg_gen_neg8_vec(TCGv_vec r, TCGv_vec a)
> +{
> +    if (TCG_TARGET_HAS_neg_vec) {
> +        tcg_gen_op2_vec(INDEX_op_neg8_vec, r, a);
> +    } else {
> +        TCGv_vec t = tcg_temp_new_vec_matching(r);
> +        tcg_gen_movi_vec(t, 0);
> +        tcg_gen_sub8_vec(r, t, a);
> +        tcg_temp_free_vec(t);
> +    }
> +}
> +
> +void tcg_gen_neg16_vec(TCGv_vec r, TCGv_vec a)
> +{
> +    if (TCG_TARGET_HAS_neg_vec) {
> +        tcg_gen_op2_vec(INDEX_op_neg16_vec, r, a);
> +    } else {
> +        TCGv_vec t = tcg_temp_new_vec_matching(r);
> +        tcg_gen_movi_vec(t, 0);
> +        tcg_gen_sub16_vec(r, t, a);
> +        tcg_temp_free_vec(t);
> +    }
> +}
> +
> +void tcg_gen_neg32_vec(TCGv_vec r, TCGv_vec a)
> +{
> +    if (TCG_TARGET_HAS_neg_vec) {
> +        tcg_gen_op2_vec(INDEX_op_neg32_vec, r, a);
> +    } else {
> +        TCGv_vec t = tcg_temp_new_vec_matching(r);
> +        tcg_gen_movi_vec(t, 0);
> +        tcg_gen_sub32_vec(r, t, a);
> +        tcg_temp_free_vec(t);
> +    }
> +}
> +
> +void tcg_gen_neg64_vec(TCGv_vec r, TCGv_vec a)
> +{
> +    if (TCG_TARGET_HAS_neg_vec) {
> +        tcg_gen_op2_vec(INDEX_op_neg64_vec, r, a);
> +    } else {
> +        TCGv_vec t = tcg_temp_new_vec_matching(r);
> +        tcg_gen_movi_vec(t, 0);
> +        tcg_gen_sub64_vec(r, t, a);
> +        tcg_temp_free_vec(t);
> +    }
> +}
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index dff9999bc6..a4d55efdf0 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -116,7 +116,7 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
>  static bool tcg_out_ldst_finalize(TCGContext *s);
>  #endif
>
> -static TCGRegSet tcg_target_available_regs[2];
> +static TCGRegSet tcg_target_available_regs[TCG_TYPE_COUNT];
>  static TCGRegSet tcg_target_call_clobber_regs;
>
>  #if TCG_TARGET_INSN_UNIT_SIZE == 1
> @@ -664,6 +664,44 @@ TCGv_i64 tcg_temp_new_internal_i64(int temp_local)
>      return MAKE_TCGV_I64(idx);
>  }
>
> +TCGv_vec tcg_temp_new_vec(TCGType type)
> +{
> +    int idx;
> +
> +#ifdef CONFIG_DEBUG_TCG
> +    switch (type) {
> +    case TCG_TYPE_V64:
> +        assert(TCG_TARGET_HAS_v64);
> +        break;
> +    case TCG_TYPE_V128:
> +        assert(TCG_TARGET_HAS_v128);
> +        break;
> +    case TCG_TYPE_V256:
> +        assert(TCG_TARGET_HAS_v256);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +#endif
> +
> +    idx = tcg_temp_new_internal(type, 0);
> +    return MAKE_TCGV_VEC(idx);
> +}
> +

A one line comment wouldn't go amiss here. This looks like we are
allocating a new temp of the same type as an existing temp?

> +TCGv_vec tcg_temp_new_vec_matching(TCGv_vec match)
> +{
> +    TCGContext *s = &tcg_ctx;
> +    int idx = GET_TCGV_VEC(match);
> +    TCGTemp *ts;
> +
> +    tcg_debug_assert(idx >= s->nb_globals && idx < s->nb_temps);
> +    ts = &s->temps[idx];
> +    tcg_debug_assert(ts->temp_allocated != 0);
> +
> +    idx = tcg_temp_new_internal(ts->base_type, 0);
> +    return MAKE_TCGV_VEC(idx);
> +}
> +
>  static void tcg_temp_free_internal(int idx)
>  {
>      TCGContext *s = &tcg_ctx;
> @@ -696,6 +734,11 @@ void tcg_temp_free_i64(TCGv_i64 arg)
>      tcg_temp_free_internal(GET_TCGV_I64(arg));
>  }
>
> +void tcg_temp_free_vec(TCGv_vec arg)
> +{
> +    tcg_temp_free_internal(GET_TCGV_VEC(arg));
> +}
> +
>  TCGv_i32 tcg_const_i32(int32_t val)
>  {
>      TCGv_i32 t0;
> @@ -753,6 +796,9 @@ int tcg_check_temp_count(void)
>     Test the runtime variable that controls each opcode.  */
>  bool tcg_op_supported(TCGOpcode op)
>  {
> +    const bool have_vec
> +        = TCG_TARGET_HAS_v64 | TCG_TARGET_HAS_v128 | TCG_TARGET_HAS_v256;
> +
>      switch (op) {
>      case INDEX_op_discard:
>      case INDEX_op_set_label:
> @@ -966,6 +1012,35 @@ bool tcg_op_supported(TCGOpcode op)
>      case INDEX_op_mulsh_i64:
>          return TCG_TARGET_HAS_mulsh_i64;
>
> +    case INDEX_op_mov_vec:
> +    case INDEX_op_movi_vec:
> +    case INDEX_op_ld_vec:
> +    case INDEX_op_ldz_vec:
> +    case INDEX_op_st_vec:
> +    case INDEX_op_add8_vec:
> +    case INDEX_op_add16_vec:
> +    case INDEX_op_add32_vec:
> +    case INDEX_op_add64_vec:
> +    case INDEX_op_sub8_vec:
> +    case INDEX_op_sub16_vec:
> +    case INDEX_op_sub32_vec:
> +    case INDEX_op_sub64_vec:
> +    case INDEX_op_and_vec:
> +    case INDEX_op_or_vec:
> +    case INDEX_op_xor_vec:
> +        return have_vec;
> +    case INDEX_op_not_vec:
> +        return have_vec && TCG_TARGET_HAS_not_vec;
> +    case INDEX_op_neg8_vec:
> +    case INDEX_op_neg16_vec:
> +    case INDEX_op_neg32_vec:
> +    case INDEX_op_neg64_vec:
> +        return have_vec && TCG_TARGET_HAS_neg_vec;
> +    case INDEX_op_andc_vec:
> +        return have_vec && TCG_TARGET_HAS_andc_vec;
> +    case INDEX_op_orc_vec:
> +        return have_vec && TCG_TARGET_HAS_orc_vec;
> +
>      case NB_OPS:
>          break;
>      }
> diff --git a/tcg/README b/tcg/README
> index 03bfb6acd4..3bf3af67db 100644
> --- a/tcg/README
> +++ b/tcg/README
> @@ -503,6 +503,52 @@ of the memory access.
>  For a 32-bit host, qemu_ld/st_i64 is guaranteed to only be used with a
>  64-bit memory access specified in flags.
>
> +********* Host vector operations
> +
> +All of the vector ops have a final constant argument that specifies the
> +length of the vector operation LEN as 64 << LEN bits.

That doesn't scan well. So would a 4 lane operation be encoded as 64 <<
4? Is this because we are using the bottom bits for something?

> +
> +* mov_vec   v0, v1, len
> +* ld_vec    v0, t1, len
> +* st_vec    v0, t1, len
> +
> +  Move, load and store.
> +
> +* movi_vec  v0, c, len
> +
> +  Copy C across the entire vector.
> +  At present the only supported values for C are 0 and -1.

I guess this is why the size in unimportant? This is for clearing or
setting the whole of the vector? What does len mean in this case?

> +
> +* add8_vec    v0, v1, v2, len
> +* add16_vec   v0, v1, v2, len
> +* add32_vec   v0, v1, v2, len
> +* add64_vec   v0, v1, v2, len
> +
> +  v0 = v1 + v2, in elements of 8/16/32/64 bits, across len.
> +
> +* sub8_vec    v0, v1, v2, len
> +* sub16_vec   v0, v1, v2, len
> +* sub32_vec   v0, v1, v2, len
> +* sub64_vec   v0, v1, v2, len
> +
> +  Similarly, v0 = v1 - v2.
> +
> +* neg8_vec    v0, v1, len
> +* neg16_vec   v0, v1, len
> +* neg32_vec   v0, v1, len
> +* neg64_vec   v0, v1, len
> +
> +  Similarly, v0 = -v1.
> +
> +* and_vec     v0, v1, v2, len
> +* or_vec      v0, v1, v2, len
> +* xor_vec     v0, v1, v2, len
> +* andc_vec    v0, v1, v2, len
> +* orc_vec     v0, v1, v2, len
> +* not_vec     v0, v1, len
> +
> +  Similarly, logical operations.

Similarly, logical operations with and without compliment?

> +
>  *********
>
>  Note 1: Some shortcuts are defined when the last operand is known to be


--
Alex Bennée
