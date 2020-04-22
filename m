Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9378C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22932074B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXw/t3X/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22932074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHCg-0002gw-S7
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRH8G-0006vt-RX
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRH8F-0000Gp-P3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:17:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRH8E-0000Aq-74
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:17:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id f13so2821786wrm.13
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=SgT1MYpmMlIMmAUCQWQwGZSb6RD4feIljOC4VXSqalg=;
 b=WXw/t3X/ixtWOHDX1y2fQ/QIZ1RPiNALL/n6TRRkARarWIe053+jmeJeDP+5OtQfgg
 bFsToloa4vZPGmGmOB4/7az5r23DPoet7o9i+tEEvSGDWwfGIlTIiyCFwMudShR27Lv8
 fFWqiVovZwsg7MFq71z0E9nLdvkzhUXZpUoYq7XvG8bE4ocKeJ/UbXa7hH4STyAupAKU
 0D0HV72Tqra0mZc0BumxGRHL7WiTLP1UloSQTR3NKPudzQJXLCmSJ5Cp7Gz58zt9ELha
 FDcUA7jZ/Q/lkMpBb05EEjwaztYL4NjYMWHzvplUZRwhY6WNOJ741chk91fh2gEsnD7O
 KUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=SgT1MYpmMlIMmAUCQWQwGZSb6RD4feIljOC4VXSqalg=;
 b=EMyY3pLhNaYrqrtI3UlQsm92iHL0Ak7ItHYMgJ+dL+Pw7IHHl7s4PUlVtVdPbMuIOR
 HBVKCEQFl+QCYuyUbgXUzAEePRLVbUvz30VCSuYF6k6i3Ap8T7cdxHl9J5PBBO4Xj3UM
 a56kLCCJYz2ac9mNd7bPqVWc8Ac8tZuOL6/lfYjyGuxV6H3FUJmbHRkOkaEkzml1nsej
 B92aPX9q5LQHKJljSDUjhsQ7F4FxUVu7SycJiWdjilzFwSFIhg605SJzisM7FmcEgbGQ
 7nNgRXmpUTR8/iW76Az9E1ejzACt1GZfCNWLZfU+4xh+02r/2EIj5+fP92YeNmCiCflN
 EhaA==
X-Gm-Message-State: AGi0PuajS7pKp+Lj7/ad8gFDuLUWjtpTt0DiJhAUBUGTl0Bza8wv68qM
 udEfwjV+OyFEPgG+UsWZqlfxtw==
X-Google-Smtp-Source: APiQypLwE5jibvRrEVD811uEVBlzT/xqjv8bdpFNsclpTHUWv+aGliiSOsjlQv/2LZQTDk5KQrtsGw==
X-Received: by 2002:adf:efd1:: with SMTP id i17mr683657wrp.161.1587568657589; 
 Wed, 22 Apr 2020 08:17:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u184sm8618530wmb.13.2020.04.22.08.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 08:17:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5ED8E1FF7E;
 Wed, 22 Apr 2020 16:17:35 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-12-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 11/36] tcg: Introduce TYPE_CONST temporaries
In-reply-to: <20200422011722.13287-12-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 16:17:35 +0100
Message-ID: <87pnbzczxs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> These will hold a single constant for the duration of the TB.
> They are hashed, so that each value has one temp across the TB.
>
> Not used yet, this is all infrastructure.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg.h |  27 ++++++++++-
>  tcg/optimize.c    |  40 ++++++++++-------
>  tcg/tcg-op-vec.c  |  17 +++++++
>  tcg/tcg.c         | 111 +++++++++++++++++++++++++++++++++++++++++-----
>  4 files changed, 166 insertions(+), 29 deletions(-)
>
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 27e1b509a6..f72530dfda 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -489,6 +489,8 @@ typedef enum TCGTempKind {
>      TEMP_GLOBAL,
>      /* Temp is in a fixed register. */
>      TEMP_FIXED,
> +    /* Temp is a fixed constant. */
> +    TEMP_CONST,
>  } TCGTempKind;
>=20=20
>  typedef struct TCGTemp {
> @@ -664,6 +666,7 @@ struct TCGContext {
>      QSIMPLEQ_HEAD(, TCGOp) plugin_ops;
>  #endif
>=20=20
> +    GHashTable *const_table[TCG_TYPE_COUNT];
>      TCGTempSet free_temps[TCG_TYPE_COUNT * 2];
>      TCGTemp temps[TCG_MAX_TEMPS]; /* globals first, temps after */
>=20=20
> @@ -680,7 +683,7 @@ struct TCGContext {
>=20=20
>  static inline bool temp_readonly(TCGTemp *ts)
>  {
> -    return ts->kind =3D=3D TEMP_FIXED;
> +    return ts->kind >=3D TEMP_FIXED;

I should have clarified in the previous patch - TEMP_FIXED is a fixed
value, e.g. env or other internal pointer which we won't be overwriting
or otherwise trashing anywhere in the block?

>  }
>=20=20
>  extern TCGContext tcg_init_ctx;
> @@ -1038,6 +1041,7 @@ TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op=
, TCGOpcode opc);
>=20=20
>  void tcg_optimize(TCGContext *s);
>=20=20
> +/* Allocate a new temporary and initialize it with a constant. */
>  TCGv_i32 tcg_const_i32(int32_t val);
>  TCGv_i64 tcg_const_i64(int64_t val);
>  TCGv_i32 tcg_const_local_i32(int32_t val);
> @@ -1047,6 +1051,27 @@ TCGv_vec tcg_const_ones_vec(TCGType);
>  TCGv_vec tcg_const_zeros_vec_matching(TCGv_vec);
>  TCGv_vec tcg_const_ones_vec_matching(TCGv_vec);
>=20=20
> +/*
> + * Locate or create a read-only temporary that is a constant.
> + * This kind of temporary need not and should not be freed.
> + */
> +TCGTemp *tcg_constant_internal(TCGType type, tcg_target_long val);
> +
> +static inline TCGv_i32 tcg_constant_i32(int32_t val)
> +{
> +    return temp_tcgv_i32(tcg_constant_internal(TCG_TYPE_I32, val));
> +}
> +
> +static inline TCGv_i64 tcg_constant_i64(int64_t val)
> +{
> +    if (TCG_TARGET_REG_BITS =3D=3D 32) {
> +        qemu_build_not_reached();
> +    }
> +    return temp_tcgv_i64(tcg_constant_internal(TCG_TYPE_I64, val));
> +}
> +
> +TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val);
> +
>  #if UINTPTR_MAX =3D=3D UINT32_MAX
>  # define tcg_const_ptr(x)        ((TCGv_ptr)tcg_const_i32((intptr_t)(x)))
>  # define tcg_const_local_ptr(x)  ((TCGv_ptr)tcg_const_local_i32((intptr_=
t)(x)))
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index afb4a9a5a9..effb47eefd 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -99,8 +99,17 @@ static void init_ts_info(struct tcg_temp_info *infos,
>          ts->state_ptr =3D ti;
>          ti->next_copy =3D ts;
>          ti->prev_copy =3D ts;
> -        ti->is_const =3D false;
> -        ti->mask =3D -1;
> +        if (ts->kind =3D=3D TEMP_CONST) {
> +            ti->is_const =3D true;
> +            ti->val =3D ti->mask =3D ts->val;
> +            if (TCG_TARGET_REG_BITS > 32 && ts->type =3D=3D TCG_TYPE_I32=
) {
> +                /* High bits of a 32-bit quantity are garbage.  */
> +                ti->mask |=3D ~0xffffffffull;
> +            }
> +        } else {
> +            ti->is_const =3D false;
> +            ti->mask =3D -1;
> +        }
>          set_bit(idx, temps_used->l);
>      }
>  }
> @@ -113,31 +122,28 @@ static void init_arg_info(struct tcg_temp_info *inf=
os,
>=20=20
>  static TCGTemp *find_better_copy(TCGContext *s, TCGTemp *ts)
>  {
> -    TCGTemp *i;
> +    TCGTemp *i, *g, *l;
>=20=20
> -    /* If this is already a global, we can't do better. */
> -    if (ts->kind >=3D TEMP_GLOBAL) {
> +    /* If this is already readonly, we can't do better. */
> +    if (temp_readonly(ts)) {
>          return ts;
>      }
>=20=20
> -    /* Search for a global first. */
> +    g =3D l =3D NULL;
>      for (i =3D ts_info(ts)->next_copy; i !=3D ts; i =3D ts_info(i)->next=
_copy) {
> -        if (i->kind >=3D TEMP_GLOBAL) {
> +        if (temp_readonly(i)) {
>              return i;
> -        }
> -    }
> -
> -    /* If it is a temp, search for a temp local. */
> -    if (ts->kind =3D=3D TEMP_NORMAL) {
> -        for (i =3D ts_info(ts)->next_copy; i !=3D ts; i =3D ts_info(i)->=
next_copy) {
> -            if (i->kind >=3D TEMP_LOCAL) {
> -                return i;
> +        } else if (i->kind > ts->kind) {
> +            if (i->kind =3D=3D TEMP_GLOBAL) {
> +                g =3D i;
> +            } else if (i->kind =3D=3D TEMP_LOCAL) {
> +                l =3D i;
>              }
>          }
>      }
>=20=20
> -    /* Failure to find a better representation, return the same temp. */
> -    return ts;
> +    /* If we didn't find a better representation, return the same temp. =
*/
> +    return g ? g : l ? l : ts;
>  }
>=20=20
>  static bool ts_are_copies(TCGTemp *ts1, TCGTemp *ts2)
> diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
> index b6937e8d64..f3927089a7 100644
> --- a/tcg/tcg-op-vec.c
> +++ b/tcg/tcg-op-vec.c
> @@ -209,6 +209,23 @@ static void vec_gen_op3(TCGOpcode opc, unsigned vece,
>      vec_gen_3(opc, type, vece, temp_arg(rt), temp_arg(at), temp_arg(bt));
>  }
>=20=20
> +TCGv_vec tcg_constant_vec(TCGType type, unsigned vece, int64_t val)
> +{
> +    val =3D dup_const(vece, val);
> +
> +    /*
> +     * For MO_64 constants that can't be represented in tcg_target_long,
> +     * we must use INDEX_op_dup2_vec, which requires a non-const tempora=
ry.
> +     */
> +    if (TCG_TARGET_REG_BITS =3D=3D 32 &&
> +        val !=3D deposit64(val, 32, 32, val) &&
> +        val !=3D (uint64_t)(int32_t)val) {
> +        g_assert_not_reached();
> +    }
> +
> +    return temp_tcgv_vec(tcg_constant_internal(type, val));
> +}
> +
>  void tcg_gen_mov_vec(TCGv_vec r, TCGv_vec a)
>  {
>      if (r !=3D a) {
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 92b3767097..59beb2bf29 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1127,6 +1127,7 @@ void tcg_func_start(TCGContext *s)
>=20=20
>      /* No temps have been previously allocated for size or locality.  */
>      memset(s->free_temps, 0, sizeof(s->free_temps));
> +    memset(s->const_table, 0, sizeof(s->const_table));
>=20=20
>      s->nb_ops =3D 0;
>      s->nb_labels =3D 0;
> @@ -1199,13 +1200,19 @@ TCGTemp *tcg_global_mem_new_internal(TCGType type=
, TCGv_ptr base,
>      bigendian =3D 1;
>  #endif
>=20=20
> -    if (base_ts->kind !=3D TEMP_FIXED) {
> +    switch (base_ts->kind) {
> +    case TEMP_FIXED:
> +        break;
> +    case TEMP_GLOBAL:
>          /* We do not support double-indirect registers.  */
>          tcg_debug_assert(!base_ts->indirect_reg);
>          base_ts->indirect_base =3D 1;
>          s->nb_indirects +=3D (TCG_TARGET_REG_BITS =3D=3D 32 && type =3D=
=3D TCG_TYPE_I64
>                              ? 2 : 1);
>          indirect_reg =3D 1;
> +        break;
> +    default:
> +        g_assert_not_reached();
>      }
>=20=20
>      if (TCG_TARGET_REG_BITS =3D=3D 32 && type =3D=3D TCG_TYPE_I64) {
> @@ -1346,6 +1353,37 @@ void tcg_temp_free_internal(TCGTemp *ts)
>      set_bit(idx, s->free_temps[k].l);
>  }
>=20=20
> +TCGTemp *tcg_constant_internal(TCGType type, tcg_target_long val)
> +{
> +    TCGContext *s =3D tcg_ctx;
> +    GHashTable *h =3D s->const_table[type];
> +    TCGTemp *ts;
> +
> +    if (h =3D=3D NULL) {
> +        if (sizeof(tcg_target_long) =3D=3D sizeof(gint64)) {
> +            h =3D g_hash_table_new(g_int64_hash, g_int64_equal);
> +        } else if (sizeof(tcg_target_long) =3D=3D sizeof(gint)) {
> +            h =3D g_hash_table_new(g_int_hash, g_int_equal);
> +        } else {
> +            qemu_build_not_reached();
> +        }
> +        s->const_table[type] =3D h;
> +    }
> +
> +    ts =3D g_hash_table_lookup(h, &val);
> +    if (ts =3D=3D NULL) {
> +        ts =3D tcg_temp_alloc(s);
> +        ts->base_type =3D type;
> +        ts->type =3D type;
> +        ts->kind =3D TEMP_CONST;
> +        ts->temp_allocated =3D 1;
> +        ts->val =3D val;
> +        g_hash_table_insert(h, &ts->val, ts);

I worried about the efficiency of using a hash table for a low number of
constants but glib's implementation starts with 8 buckets and then
scales up so it seems a reasonable approach.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

