Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9591FC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8C72075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJj80bqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8C72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52664 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDFP-0005lB-G3
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:03:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMCqE-0006nq-LX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMCqC-0002wl-Rc
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:37:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMCqC-0002tu-IP
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:37:40 -0400
Received: by mail-wm1-x341.google.com with SMTP id b10so3183777wmj.4
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:subject:in-reply-to:date:message-id
	:mime-version:content-transfer-encoding;
	bh=cW4RxLAWXSze9nJPamnhvjCfXkaKARqIpLnUoIaTcuI=;
	b=vJj80bqgpyJ58hOK215p+K5dEoBJo8ULh9o3yHzpJsq/NdX4l8ReVhux4Oox/TyzWt
	Shg41MdP9CXVwiqnA7d7e4hS7RDuBPR+K5iHakN4S/NAmzEmRMDe2agKKdP4V7L8uSOK
	AqoL1JrK3n+K2Hxf4DvkS+nVN4Jno0n2H8KMPVJFfdJXFEE1XvZCYEpnp7/oqyHmfmqe
	8+wrJLdxszj/OUTktZnS5ZBqyKsmfGSKyIMt7ZaAez1c15gub88GCe5OyzuFDpffLFGZ
	pq/JpKInZMXgmM1sjH+vEho3+KFH2OwT7Kuem2TRExqsAy9c04poc3GV3cENlub3VGmw
	mE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=cW4RxLAWXSze9nJPamnhvjCfXkaKARqIpLnUoIaTcuI=;
	b=Mic6wn/e7r7M7TaUNttrRrjgQ8Jo6l25zjglFqBf+7AZmFv0R8Y6Xlploj6vXfb9p0
	iA8zR3MGCaga2U2dFsaifWRGsr8tEy3EFtIDiJz8onUNZwCZvPva0HIImeDnPCe7sZdG
	XfKKLRdBH7G/oKcmfhEkSe8RbPUCJjBLxfTfI3Rdp79u/MS+STj08VArnXc9EVRlGttH
	3PXJtw/1CGSzZmr1S3s05gFQKR0mRzTHqriZhjElUsZuZ44Rpy9LZRZ3giGqQO8my/R1
	8aHvk1VhwtVMkKDceKIvkBArFG65yIh+zv6X8NAUizo8DfcnNZcWdNbxfBc4I4BXz122
	khmQ==
X-Gm-Message-State: APjAAAUU/ouaAgzrmJZ9XkPb9FVFZpkNPk1MHsPQgT6cSCHOTZwh4afI
	LM4lii+HttBzY30Xr9uPAam/zWow/U0=
X-Google-Smtp-Source: APXvYqwx91PDYZogQer4Thoi7Dq0fCMg3Gbe24WE9slfyBstH8GQgZQgPqnG4WsV1jG+jSYZmWdPAw==
X-Received: by 2002:a1c:81cc:: with SMTP id c195mr2610341wmd.61.1556807858954; 
	Thu, 02 May 2019 07:37:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	g10sm38859284wrq.2.2019.05.02.07.37.38 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 07:37:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id DFDDD1FF87
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 15:37:37 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-18-richard.henderson@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190501050536.15580-18-richard.henderson@linaro.org>
Date: Thu, 02 May 2019 15:37:37 +0100
Message-ID: <878svo6hxq.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 17/29] tcg: Add gvec expanders for
 vector shift by scalar
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502143737.fZmZXchCnkFGuvdiK7tKumzfgklJHw_z__00qyqq4Uw@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op-gvec.h |   7 ++
>  tcg/tcg-op.h      |   4 +
>  tcg/tcg-op-gvec.c | 204 ++++++++++++++++++++++++++++++++++++++++++++++
>  tcg/tcg-op-vec.c  |  54 ++++++++++++
>  4 files changed, 269 insertions(+)
>
> diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
> index 84a6247b16..6ee98f3378 100644
> --- a/tcg/tcg-op-gvec.h
> +++ b/tcg/tcg-op-gvec.h
> @@ -318,6 +318,13 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
>  void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         int64_t shift, uint32_t oprsz, uint32_t maxsz);
>
> +void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_shrs(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
> +
>  /*
>   * Perform vector shift by vector element, modulo the element size.
>   * E.g.  D[i] =3D A[i] << (B[i] % (8 << vece)).
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index 833c6330b5..472b73cb38 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -986,6 +986,10 @@ void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCG=
v_vec a, int64_t i);
>  void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
>  void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
>
> +void tcg_gen_shls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
> +void tcg_gen_shrs_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
> +void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
> +
>  void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
>  void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
>  void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 061ef329f1..8fc5ba042b 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -2555,6 +2555,210 @@ void tcg_gen_gvec_sari(unsigned vece, uint32_t do=
fs, uint32_t aofs,
>      }
>  }
>
> +/*
> + * Specialized generation vector shifts by a non-constant scalar.
> + */
> +
> +static void expand_2sh_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                           uint32_t oprsz, uint32_t tysz, TCGType type,
> +                           TCGv_i32 shift,
> +                           void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCG=
v_i32))
> +{
> +    TCGv_vec t0 =3D tcg_temp_new_vec(type);
> +    uint32_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D tysz) {
> +        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
> +        fni(vece, t0, t0, shift);
> +        tcg_gen_st_vec(t0, cpu_env, dofs + i);
> +    }
> +    tcg_temp_free_vec(t0);
> +}
> +
> +static void
> +do_gvec_shifts(unsigned vece, uint32_t dofs, uint32_t aofs,
> +               TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz,
> +               void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32),
> +               void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64),
> +               void (*fniv_s)(unsigned, TCGv_vec, TCGv_vec, TCGv_i32),
> +               void (*fniv_v)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec),
> +               gen_helper_gvec_2 *fno,

This prototype seems a little heavy given we usually just pass around
a reference to the relevant GVecGenFoo structure with the various
options in it? Why the anti-pattern?

> +               const TCGOpcode *s_list, const TCGOpcode *v_list)
> +{
> +    TCGType type;
> +    uint32_t some;
> +
> +    check_size_align(oprsz, maxsz, dofs | aofs);
> +    check_overlap_2(dofs, aofs, maxsz);
> +
> +    /* If the backend has a scalar expansion, great.  */
> +    type =3D choose_vector_type(s_list, vece, oprsz, vece =3D=3D MO_64);
> +    if (type) {
> +        const TCGOpcode *hold_list =3D tcg_swap_vecop_list(NULL);
> +        switch (type) {
> +        case TCG_TYPE_V256:
> +            some =3D QEMU_ALIGN_DOWN(oprsz, 32);
> +            expand_2sh_vec(vece, dofs, aofs, some, 32,
> +                           TCG_TYPE_V256, shift, fniv_s);
> +            if (some =3D=3D oprsz) {
> +                break;
> +            }
> +            dofs +=3D some;
> +            aofs +=3D some;
> +            oprsz -=3D some;
> +            maxsz -=3D some;
> +            /* fallthru */
> +        case TCG_TYPE_V128:
> +            expand_2sh_vec(vece, dofs, aofs, oprsz, 16,
> +                           TCG_TYPE_V128, shift, fniv_s);
> +            break;
> +        case TCG_TYPE_V64:
> +            expand_2sh_vec(vece, dofs, aofs, oprsz, 8,
> +                           TCG_TYPE_V64, shift, fniv_s);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        tcg_swap_vecop_list(hold_list);
> +        goto clear_tail;
> +    }
> +
> +    /* If the backend supports variable vector shifts, also cool.  */
> +    type =3D choose_vector_type(v_list, vece, oprsz, vece =3D=3D MO_64);
> +    if (type) {
> +        const TCGOpcode *hold_list =3D tcg_swap_vecop_list(NULL);
> +        TCGv_vec v_shift =3D tcg_temp_new_vec(type);
> +
> +        if (vece =3D=3D MO_64) {
> +            TCGv_i64 sh64 =3D tcg_temp_new_i64();
> +            tcg_gen_extu_i32_i64(sh64, shift);
> +            tcg_gen_dup_i64_vec(MO_64, v_shift, sh64);
> +            tcg_temp_free_i64(sh64);
> +        } else {
> +            tcg_gen_dup_i32_vec(vece, v_shift, shift);
> +        }
> +
> +        switch (type) {
> +        case TCG_TYPE_V256:
> +            some =3D QEMU_ALIGN_DOWN(oprsz, 32);
> +            expand_2s_vec(vece, dofs, aofs, some, 32, TCG_TYPE_V256,
> +                          v_shift, false, fniv_v);
> +            if (some =3D=3D oprsz) {
> +                break;
> +            }
> +            dofs +=3D some;
> +            aofs +=3D some;
> +            oprsz -=3D some;
> +            maxsz -=3D some;
> +            /* fallthru */
> +        case TCG_TYPE_V128:
> +            expand_2s_vec(vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
> +                          v_shift, false, fniv_v);
> +            break;
> +        case TCG_TYPE_V64:
> +            expand_2s_vec(vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
> +                          v_shift, false, fniv_v);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        tcg_temp_free_vec(v_shift);
> +        tcg_swap_vecop_list(hold_list);
> +        goto clear_tail;
> +    }
> +
> +    /* Otherwise fall back to integral... */
> +    if (fni4 && check_size_impl(oprsz, 4)) {
> +        expand_2s_i32(dofs, aofs, oprsz, shift, false, fni4);
> +    } else if (fni8 && check_size_impl(oprsz, 8)) {
> +        TCGv_i64 sh64 =3D tcg_temp_new_i64();
> +        tcg_gen_extu_i32_i64(sh64, shift);
> +        expand_2s_i64(dofs, aofs, oprsz, sh64, false, fni8);
> +        tcg_temp_free_i64(sh64);
> +    } else {
> +        TCGv_ptr a0 =3D tcg_temp_new_ptr();
> +        TCGv_ptr a1 =3D tcg_temp_new_ptr();
> +        TCGv_i32 desc =3D tcg_temp_new_i32();
> +
> +        tcg_gen_shli_i32(desc, shift, SIMD_DATA_SHIFT);
> +        tcg_gen_ori_i32(desc, desc, simd_desc(oprsz, maxsz, 0));
> +        tcg_gen_addi_ptr(a0, cpu_env, dofs);
> +        tcg_gen_addi_ptr(a1, cpu_env, aofs);
> +
> +        fno(a0, a1, desc);
> +
> +        tcg_temp_free_ptr(a0);
> +        tcg_temp_free_ptr(a1);
> +        tcg_temp_free_i32(desc);
> +        return;
> +    }
> +
> + clear_tail:
> +    if (oprsz < maxsz) {
> +        expand_clr(dofs + oprsz, maxsz - oprsz);
> +    }
> +}
> +
> +void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const TCGOpcode scalar_list[] =3D { INDEX_op_shls_vec, 0 };
> +    static const TCGOpcode vector_list[] =3D { INDEX_op_shlv_vec, 0 };
> +    static gen_helper_gvec_2 * const fno[4] =3D {
> +        gen_helper_gvec_shl8i,
> +        gen_helper_gvec_shl16i,
> +        gen_helper_gvec_shl32i,
> +        gen_helper_gvec_shl64i,
> +    };
> +
> +    tcg_debug_assert(vece <=3D MO_64);
> +    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz,
> +                   vece =3D=3D MO_32 ? tcg_gen_shl_i32 : NULL,
> +                   vece =3D=3D MO_64 ? tcg_gen_shl_i64 : NULL,
> +                   tcg_gen_shls_vec, tcg_gen_shlv_vec, fno[vece],
> +                   scalar_list, vector_list);

Hmm I guess:

    static GVecGenFoo const ops[4] =3D {
        {
            .fno =3D gen_helper_gvec_shl8i
        },
        {
            .fno =3D gen_helper_gvec_shl16i
        },
        {
            .fno =3D gen_helper_gvec_shl32i,
            .fni4 =3D tcg_gen_shl_i32
        },
        {
            .fno =3D gen_helper_gvec_shl64i,
            .fni8 =3D tcg_gen_shl_i64
        }
    };
    tcg_debug_assert(vece <=3D MO_64);
    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz, &ops[vece],
                   tcg_gen_shls_vec, tcg_gen_shlv_vec,
                   scalar_list, vector_list);

gets a little verbose....

> +}
> +
> +void tcg_gen_gvec_shrs(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const TCGOpcode scalar_list[] =3D { INDEX_op_shrs_vec, 0 };
> +    static const TCGOpcode vector_list[] =3D { INDEX_op_shrv_vec, 0 };
> +    static gen_helper_gvec_2 * const fno[4] =3D {
> +        gen_helper_gvec_shr8i,
> +        gen_helper_gvec_shr16i,
> +        gen_helper_gvec_shr32i,
> +        gen_helper_gvec_shr64i,
> +    };
> +
> +    tcg_debug_assert(vece <=3D MO_64);
> +    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz,
> +                   vece =3D=3D MO_32 ? tcg_gen_shr_i32 : NULL,
> +                   vece =3D=3D MO_64 ? tcg_gen_shr_i64 : NULL,
> +                   tcg_gen_shrs_vec, tcg_gen_shrv_vec, fno[vece],
> +                   scalar_list, vector_list);
> +}
> +
> +void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const TCGOpcode scalar_list[] =3D { INDEX_op_sars_vec, 0 };
> +    static const TCGOpcode vector_list[] =3D { INDEX_op_sarv_vec, 0 };
> +    static gen_helper_gvec_2 * const fno[4] =3D {
> +        gen_helper_gvec_sar8i,
> +        gen_helper_gvec_sar16i,
> +        gen_helper_gvec_sar32i,
> +        gen_helper_gvec_sar64i,
> +    };
> +
> +    tcg_debug_assert(vece <=3D MO_64);
> +    do_gvec_shifts(vece, dofs, aofs, shift, oprsz, maxsz,
> +                   vece =3D=3D MO_32 ? tcg_gen_sar_i32 : NULL,
> +                   vece =3D=3D MO_64 ? tcg_gen_sar_i64 : NULL,
> +                   tcg_gen_sars_vec, tcg_gen_sarv_vec, fno[vece],
> +                   scalar_list, vector_list);
> +}
> +
>  /*
>   * Expand D =3D A << (B % element bits)
>   *
> diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
> index 96317dbd10..16062f5995 100644
> --- a/tcg/tcg-op-vec.c
> +++ b/tcg/tcg-op-vec.c
> @@ -598,3 +598,57 @@ void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCG=
v_vec a, TCGv_vec b)
>  {
>      do_op3(vece, r, a, b, INDEX_op_sarv_vec);
>  }
> +
> +static void do_shifts(unsigned vece, TCGv_vec r, TCGv_vec a,
> +                      TCGv_i32 s, TCGOpcode opc_s, TCGOpcode opc_v)
> +{
> +    TCGTemp *rt =3D tcgv_vec_temp(r);
> +    TCGTemp *at =3D tcgv_vec_temp(a);
> +    TCGTemp *st =3D tcgv_i32_temp(s);
> +    TCGArg ri =3D temp_arg(rt);
> +    TCGArg ai =3D temp_arg(at);
> +    TCGArg si =3D temp_arg(st);
> +    TCGType type =3D rt->base_type;
> +    const TCGOpcode *hold_list;
> +    int can;
> +
> +    tcg_debug_assert(at->base_type >=3D type);
> +    tcg_assert_listed_vecop(opc_s);
> +    hold_list =3D tcg_swap_vecop_list(NULL);
> +
> +    can =3D tcg_can_emit_vec_op(opc_s, type, vece);
> +    if (can > 0) {
> +        vec_gen_3(opc_s, type, vece, ri, ai, si);
> +    } else if (can < 0) {
> +        tcg_expand_vec_op(opc_s, type, vece, ri, ai, si);
> +    } else {
> +        TCGv_vec vec_s =3D tcg_temp_new_vec(type);
> +
> +        if (vece =3D=3D MO_64) {
> +            TCGv_i64 s64 =3D tcg_temp_new_i64();
> +            tcg_gen_extu_i32_i64(s64, s);
> +            tcg_gen_dup_i64_vec(MO_64, vec_s, s64);
> +            tcg_temp_free_i64(s64);
> +        } else {
> +            tcg_gen_dup_i32_vec(vece, vec_s, s);
> +        }
> +        do_op3(vece, r, a, vec_s, opc_v);
> +        tcg_temp_free_vec(vec_s);
> +    }
> +    tcg_swap_vecop_list(hold_list);
> +}
> +
> +void tcg_gen_shls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 b)
> +{
> +    do_shifts(vece, r, a, b, INDEX_op_shls_vec, INDEX_op_shlv_vec);
> +}
> +
> +void tcg_gen_shrs_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 b)
> +{
> +    do_shifts(vece, r, a, b, INDEX_op_shrs_vec, INDEX_op_shrv_vec);
> +}
> +
> +void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 b)
> +{
> +    do_shifts(vece, r, a, b, INDEX_op_sars_vec, INDEX_op_sarv_vec);
> +}


Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e

