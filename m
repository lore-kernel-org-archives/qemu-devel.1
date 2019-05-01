Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710D2C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26617208C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Add5OLmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26617208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32808 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLr5p-0003ys-Co
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 11:24:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLr4s-0003Yr-Cx
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLr4o-0000Qt-0v
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:23:21 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLr4n-0000Q4-No
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:23:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id k23so1987379wrd.4
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=Xfa6S9o2LrqPuFs0RAUdHZJXiCVrFfCjhrb1+nBUzm4=;
	b=Add5OLmz3CjSEc8YI1wt+J1rVW4wQqA9FxW7UB4n05+lahs+r5ba23z93wOwxk6HrX
	SeyiukHZIykVReCoT3JkNJxgQeTbOd2kLfLJzDMC37xvh21Jy+eVtTqZyJP0mnUY+Ujc
	hiGQvLGGblD7P2NOjOG+IA9Izk0QPo4ZpPiNTfvNJ6gfYsTJ2ELpN2e4JBHiuLV96mzx
	0FW4RsfSL9cLexYOppHttT98vcv8AIuj2D76L72bCh21Y0cK8H4lfetT6iNVn9VXblX9
	SoJ7+XBpriBBdkPtu8G55WxHvDpi5QlEblVZ9633BVsi7D/pilZLiAwm7w1IuAPz2vH/
	p30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=Xfa6S9o2LrqPuFs0RAUdHZJXiCVrFfCjhrb1+nBUzm4=;
	b=mej6PsX+2bZm+b0pAEsvjPX2p6QjSt7eBxws+7UgzdGMyhgkvIReixEZGXFPlaPZOD
	whGPqCgtQszhtniyMSDY5Er24vHq/9ELPd3IVYeWDPiqk49hT02IlNsET6Zfzfwsax9L
	Nb8rUxikAZz9SGYTE4MkCR8i0BWiPnUP9U85m7MAvnjhOIi5Af2O5YBKsv8vAN/DLPyj
	jDZ9DsL6Ahhtor8XVTtdtuMv46DIHdyr3DmzOJ6g7Od6CJfb3l9mN8tKxEndXc0G4VvH
	dHDNvD9kNi1auhWqKCrSr5bgl41Gpt+QiTQXw4dARhUTO4ZKPdMvKpXK8CEsXDzqPRjk
	E98A==
X-Gm-Message-State: APjAAAXSvAsnU27c47NvvHfN23KIiR9b5O6AbSmLiac/HdY+KCO3fOHT
	OF74erMCGYenmkv0n96pKpY0nSpk4ek=
X-Google-Smtp-Source: APXvYqysvqlxw9C/lJDaDrUlb2LU+l5ZIGRnXDgTY0Q6iqyPGaDNcQZP52hf06FQod5DuAztdn+32Q==
X-Received: by 2002:a5d:43cd:: with SMTP id v13mr11812435wrr.227.1556724195557;
	Wed, 01 May 2019 08:23:15 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	o130sm6295075wmo.43.2019.05.01.08.23.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 08:23:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 898E01FF87;
	Wed,  1 May 2019 16:23:14 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-2-richard.henderson@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190501050536.15580-2-richard.henderson@linaro.org>
Date: Wed, 01 May 2019 16:23:14 +0100
Message-ID: <87woja5hct.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2 01/29] tcg: Implement tcg_gen_gvec_3i()
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
Cc: David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501152314.sPiSFwlrw9b51qtUwor4MdBb-tB1sRTj_FYogFBBvQU@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> From: David Hildenbrand <david@redhat.com>
>
> Let's add tcg_gen_gvec_3i(), similar to tcg_gen_gvec_2i(), however
> without introducing "gen_helper_gvec_3i *fnoi", as it isn't needed
> for now.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Message-Id: <20190416185301.25344-2-david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op-gvec.h |  24 ++++++++
>  tcg/tcg-op-gvec.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 163 insertions(+)
>
> diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
> index 850da32ded..c093243c4c 100644
> --- a/tcg/tcg-op-gvec.h
> +++ b/tcg/tcg-op-gvec.h
> @@ -164,6 +164,27 @@ typedef struct {
>      bool load_dest;
>  } GVecGen3;
>
> +typedef struct {
> +    /*
> +     * Expand inline as a 64-bit or 32-bit integer. Only one of these wi=
ll be
> +     * non-NULL.
> +     */
> +    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64, int64_t);
> +    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32, int32_t);
> +    /* Expand inline with a host vector type.  */
> +    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, int64_t);
> +    /* Expand out-of-line helper w/descriptor, data in descriptor.  */
> +    gen_helper_gvec_3 *fno;
> +    /* The opcode, if any, to which this corresponds.  */
> +    TCGOpcode opc;
> +    /* The vector element size, if applicable.  */
> +    uint8_t vece;
> +    /* Prefer i64 to v64.  */
> +    bool prefer_i64;
> +    /* Load dest as a 3rd source operand.  */
> +    bool load_dest;
> +} GVecGen3i;
> +
>  typedef struct {
>      /* Expand inline as a 64-bit or 32-bit integer.
>         Only one of these will be non-NULL.  */
> @@ -193,6 +214,9 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, ui=
nt32_t oprsz,
>                       uint32_t maxsz, TCGv_i64 c, const GVecGen2s *);
>  void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>                      uint32_t oprsz, uint32_t maxsz, const GVecGen3 *);
> +void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                     uint32_t oprsz, uint32_t maxsz, int64_t c,
> +                     const GVecGen3i *);
>  void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_=
t cofs,
>                      uint32_t oprsz, uint32_t maxsz, const GVecGen4 *);
>
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 0996ef0812..f831adb4e7 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -663,6 +663,29 @@ static void expand_3_i32(uint32_t dofs, uint32_t aof=
s,
>      tcg_temp_free_i32(t0);
>  }
>
> +static void expand_3i_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                          uint32_t oprsz, int32_t c, bool load_dest,
> +                          void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32, int3=
2_t))
> +{
> +    TCGv_i32 t0 =3D tcg_temp_new_i32();
> +    TCGv_i32 t1 =3D tcg_temp_new_i32();
> +    TCGv_i32 t2 =3D tcg_temp_new_i32();
> +    uint32_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D 4) {
> +        tcg_gen_ld_i32(t0, cpu_env, aofs + i);
> +        tcg_gen_ld_i32(t1, cpu_env, bofs + i);
> +        if (load_dest) {
> +            tcg_gen_ld_i32(t2, cpu_env, dofs + i);
> +        }
> +        fni(t2, t0, t1, c);
> +        tcg_gen_st_i32(t2, cpu_env, dofs + i);
> +    }
> +    tcg_temp_free_i32(t0);
> +    tcg_temp_free_i32(t1);
> +    tcg_temp_free_i32(t2);
> +}
> +
>  /* Expand OPSZ bytes worth of three-operand operations using i32 element=
s.  */
>  static void expand_4_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>                           uint32_t cofs, uint32_t oprsz, bool write_aofs,
> @@ -770,6 +793,29 @@ static void expand_3_i64(uint32_t dofs, uint32_t aof=
s,
>      tcg_temp_free_i64(t0);
>  }
>
> +static void expand_3i_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                          uint32_t oprsz, int64_t c, bool load_dest,
> +                          void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64, int6=
4_t))
> +{
> +    TCGv_i64 t0 =3D tcg_temp_new_i64();
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +    uint32_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D 8) {
> +        tcg_gen_ld_i64(t0, cpu_env, aofs + i);
> +        tcg_gen_ld_i64(t1, cpu_env, bofs + i);
> +        if (load_dest) {
> +            tcg_gen_ld_i64(t2, cpu_env, dofs + i);
> +        }
> +        fni(t2, t0, t1, c);
> +        tcg_gen_st_i64(t2, cpu_env, dofs + i);
> +    }
> +    tcg_temp_free_i64(t0);
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +}
> +
>  /* Expand OPSZ bytes worth of three-operand operations using i64 element=
s.  */
>  static void expand_4_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>                           uint32_t cofs, uint32_t oprsz, bool write_aofs,
> @@ -883,6 +929,35 @@ static void expand_3_vec(unsigned vece, uint32_t dof=
s, uint32_t aofs,
>      tcg_temp_free_vec(t0);
>  }
>
> +/*
> + * Expand OPSZ bytes worth of three-vector operands and an immediate ope=
rand
> + * using host vectors.
> + */
> +static void expand_3i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                          uint32_t bofs, uint32_t oprsz, uint32_t tysz,
> +                          TCGType type, int64_t c, bool load_dest,
> +                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv=
_vec,
> +                                      int64_t))
> +{
> +    TCGv_vec t0 =3D tcg_temp_new_vec(type);
> +    TCGv_vec t1 =3D tcg_temp_new_vec(type);
> +    TCGv_vec t2 =3D tcg_temp_new_vec(type);
> +    uint32_t i;
> +
> +    for (i =3D 0; i < oprsz; i +=3D tysz) {
> +        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
> +        tcg_gen_ld_vec(t1, cpu_env, bofs + i);
> +        if (load_dest) {
> +            tcg_gen_ld_vec(t2, cpu_env, dofs + i);
> +        }
> +        fni(vece, t2, t0, t1, c);
> +        tcg_gen_st_vec(t2, cpu_env, dofs + i);
> +    }
> +    tcg_temp_free_vec(t0);
> +    tcg_temp_free_vec(t1);
> +    tcg_temp_free_vec(t2);
> +}
> +
>  /* Expand OPSZ bytes worth of four-operand operations using host vectors=
.  */
>  static void expand_4_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
>                           uint32_t bofs, uint32_t cofs, uint32_t oprsz,
> @@ -1174,6 +1249,70 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, =
uint32_t bofs,
>      }
>  }
>
> +/* Expand a vector operation with three vectors and an immediate.  */
> +void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
> +                     uint32_t oprsz, uint32_t maxsz, int64_t c,
> +                     const GVecGen3i *g)
> +{
> +    TCGType type;
> +    uint32_t some;
> +
> +    check_size_align(oprsz, maxsz, dofs | aofs | bofs);
> +    check_overlap_3(dofs, aofs, bofs, maxsz);
> +
> +    type =3D 0;
> +    if (g->fniv) {
> +        type =3D choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i6=
4);
> +    }
> +    switch (type) {
> +    case TCG_TYPE_V256:
> +        /*
> +         * Recall that ARM SVE allows vector sizes that are not a
> +         * power of 2, but always a multiple of 16.  The intent is
> +         * that e.g. size =3D=3D 80 would be expanded with 2x32 + 1x16.
> +         */
> +        some =3D QEMU_ALIGN_DOWN(oprsz, 32);
> +        expand_3i_vec(g->vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256,
> +                      c, g->load_dest, g->fniv);
> +        if (some =3D=3D oprsz) {
> +            break;
> +        }
> +        dofs +=3D some;
> +        aofs +=3D some;
> +        bofs +=3D some;
> +        oprsz -=3D some;
> +        maxsz -=3D some;
> +        /* fallthru */
> +    case TCG_TYPE_V128:
> +        expand_3i_vec(g->vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V12=
8,
> +                      c, g->load_dest, g->fniv);
> +        break;
> +    case TCG_TYPE_V64:
> +        expand_3i_vec(g->vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64,
> +                      c, g->load_dest, g->fniv);
> +        break;
> +
> +    case 0:
> +        if (g->fni8 && check_size_impl(oprsz, 8)) {
> +            expand_3i_i64(dofs, aofs, bofs, oprsz, c, g->load_dest, g->f=
ni8);
> +        } else if (g->fni4 && check_size_impl(oprsz, 4)) {
> +            expand_3i_i32(dofs, aofs, bofs, oprsz, c, g->load_dest, g->f=
ni4);
> +        } else {
> +            assert(g->fno !=3D NULL);
> +            tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, c, g->fno=
);
> +            return;
> +        }
> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    if (oprsz < maxsz) {
> +        expand_clr(dofs + oprsz, maxsz - oprsz);
> +    }
> +}
> +

My only slight concern is this is effectively a c&p of the helper above.
However I can't really see any way to DRY so:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>  /* Expand a vector four-operand operation.  */
>  void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_=
t cofs,
>                      uint32_t oprsz, uint32_t maxsz, const GVecGen4 *g)


--
Alex Benn=C3=A9e

