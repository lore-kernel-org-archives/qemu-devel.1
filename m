Received: from eggs.gnu.org ([2001:4830:134:3::10]:58795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fY8mT-0005TR-W7
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fY8mQ-0004NS-OS
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:38:38 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fY8mQ-0004MJ-CP
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:38:34 -0400
Received: by mail-wm0-x22d.google.com with SMTP id z137-v6so5148051wmc.0
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 04:38:34 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-4-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180621015359.12018-4-richard.henderson@linaro.org>
Date: Wed, 27 Jun 2018 12:38:31 +0100
Message-ID: <87efgswjbc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 03/35] target/arm: Implement SVE Memory
 Contiguous Store Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper-sve.h    |  29 +++++
>  target/arm/sve_helper.c    | 211 +++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c |  65 ++++++++++++
>  target/arm/sve.decode      |  38 +++++++
>  4 files changed, 343 insertions(+)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 7338abbbcf..b768128951 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -794,3 +794,32 @@ DEF_HELPER_FLAGS_4(sve_ldnf1sdu_r, TCG_CALL_NO_WG, v=
oid, env, ptr, tl, i32)
>  DEF_HELPER_FLAGS_4(sve_ldnf1sds_r, TCG_CALL_NO_WG, void, env, ptr, tl, i=
32)
>
>  DEF_HELPER_FLAGS_4(sve_ldnf1dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i3=
2)
> +
> +DEF_HELPER_FLAGS_4(sve_st1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st4bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_st1hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st2hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st3hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st4hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_st1ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st2ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st3ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st4ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_st1dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st2dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st3dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st4dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_st1bh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st1bs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st1bd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_st1hs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st1hd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_st1sd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 6e1b539ce3..f20774e240 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -3119,3 +3119,214 @@ DO_LDNF1(sds_r)
>  DO_LDNF1(dd_r)
>
>  #undef DO_LDNF1
> +
> +/*
> + * Store contiguous data, protected by a governing predicate.
> + */
> +#define DO_ST1(NAME, FN, TYPEE, TYPEM, H)                  \
> +void HELPER(NAME)(CPUARMState *env, void *vg,              \
> +                  target_ulong addr, uint32_t desc)        \
> +{                                                          \
> +    intptr_t i, oprsz =3D simd_oprsz(desc);                  \
> +    intptr_t ra =3D GETPC();                                 \
> +    unsigned rd =3D simd_data(desc);                         \
> +    void *vd =3D &env->vfp.zregs[rd];                        \
> +    for (i =3D 0; i < oprsz; ) {                             \
> +        uint16_t pg =3D *(uint16_t *)(vg + H1_2(i >> 3));    \
> +        do {                                               \
> +            if (pg & 1) {                                  \
> +                TYPEM m =3D *(TYPEE *)(vd + H(i));           \
> +                FN(env, addr, m, ra);                      \
> +            }                                              \
> +            i +=3D sizeof(TYPEE), pg >>=3D sizeof(TYPEE);      \
> +            addr +=3D sizeof(TYPEM);                         \
> +        } while (i & 15);                                  \
> +    }                                                      \
> +}
> +
> +#define DO_ST1_D(NAME, FN, TYPEM)                          \
> +void HELPER(NAME)(CPUARMState *env, void *vg,              \
> +                  target_ulong addr, uint32_t desc)        \
> +{                                                          \
> +    intptr_t i, oprsz =3D simd_oprsz(desc) / 8;              \
> +    intptr_t ra =3D GETPC();                                 \
> +    unsigned rd =3D simd_data(desc);                         \
> +    uint64_t *d =3D &env->vfp.zregs[rd].d[0];                \
> +    uint8_t *pg =3D vg;                                      \
> +    for (i =3D 0; i < oprsz; i +=3D 1) {                       \
> +        if (pg[H1(i)] & 1) {                               \
> +            FN(env, addr, d[i], ra);                       \
> +        }                                                  \
> +        addr +=3D sizeof(TYPEM);                             \
> +    }                                                      \
> +}
> +
> +#define DO_ST2(NAME, FN, TYPEE, TYPEM, H)                  \
> +void HELPER(NAME)(CPUARMState *env, void *vg,              \
> +                  target_ulong addr, uint32_t desc)        \
> +{                                                          \
> +    intptr_t i, oprsz =3D simd_oprsz(desc);                  \
> +    intptr_t ra =3D GETPC();                                 \
> +    unsigned rd =3D simd_data(desc);                         \
> +    void *d1 =3D &env->vfp.zregs[rd];                        \
> +    void *d2 =3D &env->vfp.zregs[(rd + 1) & 31];             \
> +    for (i =3D 0; i < oprsz; ) {                             \
> +        uint16_t pg =3D *(uint16_t *)(vg + H1_2(i >> 3));    \
> +        do {                                               \
> +            if (pg & 1) {                                  \
> +                TYPEM m1 =3D *(TYPEE *)(d1 + H(i));          \
> +                TYPEM m2 =3D *(TYPEE *)(d2 + H(i));          \
> +                FN(env, addr, m1, ra);                     \
> +                FN(env, addr + sizeof(TYPEM), m2, ra);     \
> +            }                                              \
> +            i +=3D sizeof(TYPEE), pg >>=3D sizeof(TYPEE);      \
> +            addr +=3D 2 * sizeof(TYPEM);                     \
> +        } while (i & 15);                                  \
> +    }                                                      \
> +}
> +
> +#define DO_ST3(NAME, FN, TYPEE, TYPEM, H)                  \
> +void HELPER(NAME)(CPUARMState *env, void *vg,              \
> +                  target_ulong addr, uint32_t desc)        \
> +{                                                          \
> +    intptr_t i, oprsz =3D simd_oprsz(desc);                  \
> +    intptr_t ra =3D GETPC();                                 \
> +    unsigned rd =3D simd_data(desc);                         \
> +    void *d1 =3D &env->vfp.zregs[rd];                        \
> +    void *d2 =3D &env->vfp.zregs[(rd + 1) & 31];             \
> +    void *d3 =3D &env->vfp.zregs[(rd + 2) & 31];             \
> +    for (i =3D 0; i < oprsz; ) {                             \
> +        uint16_t pg =3D *(uint16_t *)(vg + H1_2(i >> 3));    \
> +        do {                                               \
> +            if (pg & 1) {                                  \
> +                TYPEM m1 =3D *(TYPEE *)(d1 + H(i));          \
> +                TYPEM m2 =3D *(TYPEE *)(d2 + H(i));          \
> +                TYPEM m3 =3D *(TYPEE *)(d3 + H(i));          \
> +                FN(env, addr, m1, ra);                     \
> +                FN(env, addr + sizeof(TYPEM), m2, ra);     \
> +                FN(env, addr + 2 * sizeof(TYPEM), m3, ra); \
> +            }                                              \
> +            i +=3D sizeof(TYPEE), pg >>=3D sizeof(TYPEE);      \
> +            addr +=3D 3 * sizeof(TYPEM);                     \
> +        } while (i & 15);                                  \
> +    }                                                      \
> +}
> +
> +#define DO_ST4(NAME, FN, TYPEE, TYPEM, H)                  \
> +void HELPER(NAME)(CPUARMState *env, void *vg,              \
> +                  target_ulong addr, uint32_t desc)        \
> +{                                                          \
> +    intptr_t i, oprsz =3D simd_oprsz(desc);                  \
> +    intptr_t ra =3D GETPC();                                 \
> +    unsigned rd =3D simd_data(desc);                         \
> +    void *d1 =3D &env->vfp.zregs[rd];                        \
> +    void *d2 =3D &env->vfp.zregs[(rd + 1) & 31];             \
> +    void *d3 =3D &env->vfp.zregs[(rd + 2) & 31];             \
> +    void *d4 =3D &env->vfp.zregs[(rd + 3) & 31];             \
> +    for (i =3D 0; i < oprsz; ) {                             \
> +        uint16_t pg =3D *(uint16_t *)(vg + H1_2(i >> 3));    \
> +        do {                                               \
> +            if (pg & 1) {                                  \
> +                TYPEM m1 =3D *(TYPEE *)(d1 + H(i));          \
> +                TYPEM m2 =3D *(TYPEE *)(d2 + H(i));          \
> +                TYPEM m3 =3D *(TYPEE *)(d3 + H(i));          \
> +                TYPEM m4 =3D *(TYPEE *)(d4 + H(i));          \
> +                FN(env, addr, m1, ra);                     \
> +                FN(env, addr + sizeof(TYPEM), m2, ra);     \
> +                FN(env, addr + 2 * sizeof(TYPEM), m3, ra); \
> +                FN(env, addr + 3 * sizeof(TYPEM), m4, ra); \
> +            }                                              \
> +            i +=3D sizeof(TYPEE), pg >>=3D sizeof(TYPEE);      \
> +            addr +=3D 4 * sizeof(TYPEM);                     \
> +        } while (i & 15);                                  \
> +    }                                                      \
> +}
> +
> +DO_ST1(sve_st1bh_r, cpu_stb_data_ra, uint16_t, uint8_t, H1_2)
> +DO_ST1(sve_st1bs_r, cpu_stb_data_ra, uint32_t, uint8_t, H1_4)
> +DO_ST1_D(sve_st1bd_r, cpu_stb_data_ra, uint8_t)
> +
> +DO_ST1(sve_st1hs_r, cpu_stw_data_ra, uint32_t, uint16_t, H1_4)
> +DO_ST1_D(sve_st1hd_r, cpu_stw_data_ra, uint16_t)
> +
> +DO_ST1_D(sve_st1sd_r, cpu_stl_data_ra, uint32_t)
> +
> +DO_ST1(sve_st1bb_r, cpu_stb_data_ra, uint8_t, uint8_t, H1)
> +DO_ST2(sve_st2bb_r, cpu_stb_data_ra, uint8_t, uint8_t, H1)
> +DO_ST3(sve_st3bb_r, cpu_stb_data_ra, uint8_t, uint8_t, H1)
> +DO_ST4(sve_st4bb_r, cpu_stb_data_ra, uint8_t, uint8_t, H1)
> +
> +DO_ST1(sve_st1hh_r, cpu_stw_data_ra, uint16_t, uint16_t, H1_2)
> +DO_ST2(sve_st2hh_r, cpu_stw_data_ra, uint16_t, uint16_t, H1_2)
> +DO_ST3(sve_st3hh_r, cpu_stw_data_ra, uint16_t, uint16_t, H1_2)
> +DO_ST4(sve_st4hh_r, cpu_stw_data_ra, uint16_t, uint16_t, H1_2)
> +
> +DO_ST1(sve_st1ss_r, cpu_stl_data_ra, uint32_t, uint32_t, H1_4)
> +DO_ST2(sve_st2ss_r, cpu_stl_data_ra, uint32_t, uint32_t, H1_4)
> +DO_ST3(sve_st3ss_r, cpu_stl_data_ra, uint32_t, uint32_t, H1_4)
> +DO_ST4(sve_st4ss_r, cpu_stl_data_ra, uint32_t, uint32_t, H1_4)
> +
> +DO_ST1_D(sve_st1dd_r, cpu_stq_data_ra, uint64_t)
> +
> +void HELPER(sve_st2dd_r)(CPUARMState *env, void *vg,
> +                         target_ulong addr, uint32_t desc)
> +{
> +    intptr_t i, oprsz =3D simd_oprsz(desc) / 8;
> +    intptr_t ra =3D GETPC();
> +    unsigned rd =3D simd_data(desc);
> +    uint64_t *d1 =3D &env->vfp.zregs[rd].d[0];
> +    uint64_t *d2 =3D &env->vfp.zregs[(rd + 1) & 31].d[0];
> +    uint8_t *pg =3D vg;
> +
> +    for (i =3D 0; i < oprsz; i +=3D 1) {
> +        if (pg[H1(i)] & 1) {
> +            cpu_stq_data_ra(env, addr, d1[i], ra);
> +            cpu_stq_data_ra(env, addr + 8, d2[i], ra);
> +        }
> +        addr +=3D 2 * 8;
> +    }
> +}
> +
> +void HELPER(sve_st3dd_r)(CPUARMState *env, void *vg,
> +                         target_ulong addr, uint32_t desc)
> +{
> +    intptr_t i, oprsz =3D simd_oprsz(desc) / 8;
> +    intptr_t ra =3D GETPC();
> +    unsigned rd =3D simd_data(desc);
> +    uint64_t *d1 =3D &env->vfp.zregs[rd].d[0];
> +    uint64_t *d2 =3D &env->vfp.zregs[(rd + 1) & 31].d[0];
> +    uint64_t *d3 =3D &env->vfp.zregs[(rd + 2) & 31].d[0];
> +    uint8_t *pg =3D vg;
> +
> +    for (i =3D 0; i < oprsz; i +=3D 1) {
> +        if (pg[H1(i)] & 1) {
> +            cpu_stq_data_ra(env, addr, d1[i], ra);
> +            cpu_stq_data_ra(env, addr + 8, d2[i], ra);
> +            cpu_stq_data_ra(env, addr + 16, d3[i], ra);
> +        }
> +        addr +=3D 3 * 8;
> +    }
> +}
> +
> +void HELPER(sve_st4dd_r)(CPUARMState *env, void *vg,
> +                         target_ulong addr, uint32_t desc)
> +{
> +    intptr_t i, oprsz =3D simd_oprsz(desc) / 8;
> +    intptr_t ra =3D GETPC();
> +    unsigned rd =3D simd_data(desc);
> +    uint64_t *d1 =3D &env->vfp.zregs[rd].d[0];
> +    uint64_t *d2 =3D &env->vfp.zregs[(rd + 1) & 31].d[0];
> +    uint64_t *d3 =3D &env->vfp.zregs[(rd + 2) & 31].d[0];
> +    uint64_t *d4 =3D &env->vfp.zregs[(rd + 3) & 31].d[0];
> +    uint8_t *pg =3D vg;
> +
> +    for (i =3D 0; i < oprsz; i +=3D 1) {
> +        if (pg[H1(i)] & 1) {
> +            cpu_stq_data_ra(env, addr, d1[i], ra);
> +            cpu_stq_data_ra(env, addr + 8, d2[i], ra);
> +            cpu_stq_data_ra(env, addr + 16, d3[i], ra);
> +            cpu_stq_data_ra(env, addr + 24, d4[i], ra);
> +        }
> +        addr +=3D 4 * 8;
> +    }
> +}
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 09f77b5405..b25fe96b77 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -3716,3 +3716,68 @@ static bool trans_LDNF1_zpri(DisasContext *s, arg_=
rpri_load *a, uint32_t insn)
>      }
>      return true;
>  }
> +
> +static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
> +                      int msz, int esz, int nreg)
> +{
> +    static gen_helper_gvec_mem * const fn_single[4][4] =3D {
> +        { gen_helper_sve_st1bb_r, gen_helper_sve_st1bh_r,
> +          gen_helper_sve_st1bs_r, gen_helper_sve_st1bd_r },
> +        { NULL,                   gen_helper_sve_st1hh_r,
> +          gen_helper_sve_st1hs_r, gen_helper_sve_st1hd_r },
> +        { NULL, NULL,
> +          gen_helper_sve_st1ss_r, gen_helper_sve_st1sd_r },
> +        { NULL, NULL, NULL, gen_helper_sve_st1dd_r },
> +    };
> +    static gen_helper_gvec_mem * const fn_multiple[3][4] =3D {
> +        { gen_helper_sve_st2bb_r, gen_helper_sve_st2hh_r,
> +          gen_helper_sve_st2ss_r, gen_helper_sve_st2dd_r },
> +        { gen_helper_sve_st3bb_r, gen_helper_sve_st3hh_r,
> +          gen_helper_sve_st3ss_r, gen_helper_sve_st3dd_r },
> +        { gen_helper_sve_st4bb_r, gen_helper_sve_st4hh_r,
> +          gen_helper_sve_st4ss_r, gen_helper_sve_st4dd_r },
> +    };
> +    gen_helper_gvec_mem *fn;
> +
> +    if (nreg =3D=3D 0) {
> +        /* ST1 */
> +        fn =3D fn_single[msz][esz];
> +    } else {
> +        /* ST2, ST3, ST4 -- msz =3D=3D esz, enforced by encoding */
> +        assert(msz =3D=3D esz);
> +        fn =3D fn_multiple[nreg - 1][msz];
> +    }
> +    assert(fn !=3D NULL);
> +    do_mem_zpa(s, zt, pg, addr, fn);
> +}
> +
> +static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a, uint32_t i=
nsn)
> +{
> +    if (a->rm =3D=3D 31 || a->msz > a->esz) {
> +        return false;
> +    }
> +    if (sve_access_check(s)) {
> +        TCGv_i64 addr =3D new_tmp_a64(s);
> +        tcg_gen_muli_i64(addr, cpu_reg(s, a->rm), (a->nreg + 1) << a->ms=
z);
> +        tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
> +        do_st_zpa(s, a->rd, a->pg, addr, a->msz, a->esz, a->nreg);
> +    }
> +    return true;
> +}
> +
> +static bool trans_ST_zpri(DisasContext *s, arg_rpri_store *a, uint32_t i=
nsn)
> +{
> +    if (a->msz > a->esz) {
> +        return false;
> +    }
> +    if (sve_access_check(s)) {
> +        int vsz =3D vec_full_reg_size(s);
> +        int elements =3D vsz >> a->esz;
> +        TCGv_i64 addr =3D new_tmp_a64(s);
> +
> +        tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn),
> +                         (a->imm * elements * (a->nreg + 1)) << a->msz);
> +        do_st_zpa(s, a->rd, a->pg, addr, a->msz, a->esz, a->nreg);
> +    }
> +    return true;
> +}
> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index afbed57de1..6e159faaec 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -27,6 +27,7 @@
>  %imm7_22_16     22:2 16:5
>  %imm8_16_10     16:5 10:3
>  %imm9_16_10     16:s6 10:3
> +%size_23        23:2
>
>  # A combination of tsz:imm3 -- extract esize.
>  %tszimm_esz     22:2 5:5 !function=3Dtszimm_esz
> @@ -76,6 +77,8 @@
>  &incdec2_pred   rd rn pg esz d u
>  &rprr_load      rd pg rn rm dtype nreg
>  &rpri_load      rd pg rn imm dtype nreg
> +&rprr_store     rd pg rn rm msz esz nreg
> +&rpri_store     rd pg rn imm msz esz nreg
>
>  ########################################################################=
###
>  # Named instruction formats.  These are generally used to
> @@ -184,6 +187,12 @@
>  @rpri_load_msz  ....... .... . imm:s4 ... pg:3 rn:5 rd:5 \
>                  &rpri_load dtype=3D%msz_dtype
>
> +# Stores; user must fill in ESZ, MSZ, NREG as needed.
> +@rprr_store         ....... ..    ..     rm:5 ... pg:3 rn:5 rd:5    &rpr=
r_store
> +@rpri_store_msz     ....... msz:2 .. . imm:s4 ... pg:3 rn:5 rd:5    &rpr=
i_store
> +@rprr_store_esz_n0  ....... ..    esz:2  rm:5 ... pg:3 rn:5 rd:5 \
> +                    &rprr_store nreg=3D0
> +
>  ########################################################################=
###
>  # Instruction patterns.  Grouped according to the SVE encodingindex.xhtm=
l.
>
> @@ -705,3 +714,32 @@ LD_zprr         1010010 .. nreg:2 ..... 110 ... ....=
. .....     @rprr_load_msz
>  # SVE load multiple structures (scalar plus immediate)
>  # LD2B, LD2H, LD2W, LD2D; etc.
>  LD_zpri         1010010 .. nreg:2 0.... 111 ... ..... .....     @rpri_lo=
ad_msz
> +
> +### SVE Memory Store Group
> +
> +# SVE contiguous store (scalar plus immediate)
> +# ST1B, ST1H, ST1W, ST1D; require msz <=3D esz
> +ST_zpri         1110010 .. esz:2  0.... 111 ... ..... ..... \
> +                @rpri_store_msz nreg=3D0
> +
> +# SVE contiguous store (scalar plus scalar)
> +# ST1B, ST1H, ST1W, ST1D; require msz <=3D esz
> +# Enumerate msz lest we conflict with STR_zri.
> +ST_zprr         1110010 00 ..     ..... 010 ... ..... ..... \
> +                @rprr_store_esz_n0 msz=3D0
> +ST_zprr         1110010 01 ..     ..... 010 ... ..... ..... \
> +                @rprr_store_esz_n0 msz=3D1
> +ST_zprr         1110010 10 ..     ..... 010 ... ..... ..... \
> +                @rprr_store_esz_n0 msz=3D2
> +ST_zprr         1110010 11 11     ..... 010 ... ..... ..... \
> +                @rprr_store msz=3D3 esz=3D3 nreg=3D0
> +
> +# SVE contiguous non-temporal store (scalar plus immediate)  (nreg =3D=
=3D 0)
> +# SVE store multiple structures (scalar plus immediate)      (nreg !=3D =
0)
> +ST_zpri         1110010 .. nreg:2 1.... 111 ... ..... ..... \
> +                @rpri_store_msz esz=3D%size_23
> +
> +# SVE contiguous non-temporal store (scalar plus scalar)     (nreg =3D=
=3D 0)
> +# SVE store multiple structures (scalar plus scalar)         (nreg !=3D =
0)
> +ST_zprr         1110010 msz:2 nreg:2 ..... 011 ... ..... ..... \
> +                @rprr_store esz=3D%size_23


--
Alex Benn=C3=A9e
