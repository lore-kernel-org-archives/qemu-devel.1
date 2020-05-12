Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85FFC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C96206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b97vLdKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C96206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVgV-0001uf-L6
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVfn-0001QG-DX
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:14:19 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVfm-0001UJ-F5
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:14:19 -0400
Received: by mail-oi1-x242.google.com with SMTP id r66so18328043oie.5
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 07:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gU23hqCPAuPrENFPe+0Y2Vzl8LEx5LPzoF5nteNvbWI=;
 b=b97vLdKgzHdXy2oST4VYGyL6W+Q7aakVPrEQdKx98iRIO6k6/dI7qkHZvxqPrdEyvc
 JErieMCrdXuyLD9+awW5lh3vTE+4C/yrdiApCZ7VLmA7AjuBfCnhlQHDsDGCZkcdVDvR
 qHao9AD8y6QwxwlNz9WnDpNxqXvjOcxlnCkjXPMnazP69QWip1LD8wIbYVOEM2mPybfQ
 JuFF2619fDj0WbjwIB+yOQhXn4u+H16pK2lDcbdRw7czth0UAb5VhMVUmuvX40At1wt1
 PPHmuez/CCqy5TNunipLZ/Gj/JXU2/I5u9UlUZcIjLZ8BQ9qC633RKC2u7PkoWuOLr98
 bQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gU23hqCPAuPrENFPe+0Y2Vzl8LEx5LPzoF5nteNvbWI=;
 b=AFXzY7mMZePMyK9pHhMUm3IS0LFtGpgSN+MyhGpcOG8tMFEY+3CEyT2Rr7Qvwf4RH3
 /fqUSy74WR2stuzYUeUNQmW7hvAIPwjzHXgjhWM0b1pQAYS2VUaGQxGUMmtVQiAUPbk+
 BW1CApehYSmaCnLymAj87oFrp/kzPuUDpcybzPvb+cXcyVk2EzShMpqnsgjkoDc/syMf
 uAAfLAOr35ORhnjbnITvYFazdcZzHWBKfwg3d6i3xxyynhqVlDk+N8OnIZAdTSAfCH1W
 MT0BV6XjK73VgtjSNd9Zqbx+cNPQM4iZMx6l9BcxJp6DE5CtharSGewl3RbFGzkYe4Fr
 9MiA==
X-Gm-Message-State: AGi0Pua8NRd330E1hHqhqPJqLdZIJ47lIwQUejpFk1HOaRsBp5OsflnW
 UoDVE1h7tIK/Xo5Xv6INyaJrVvhrd1DNMmhhFmpXDQ==
X-Google-Smtp-Source: APiQypKAd8B5qWXmDcfMhNE5+UX48UJn3XSXKY7tuD4OYVw/c5i0NtVXqkhucqfK1mtSFpl8TU0eOIQCAh+spu8dxTo=
X-Received: by 2002:aca:895:: with SMTP id 143mr23525546oii.163.1589292857202; 
 Tue, 12 May 2020 07:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-9-richard.henderson@linaro.org>
In-Reply-To: <20200508152200.6547-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 15:14:06 +0100
Message-ID: <CAFEAcA8hG+qZ_iRd+Da6H9xmWnwQK=bP_aWJt0Z9EcBuK7TaZA@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] target/arm: Swap argument order for VSHL during
 decode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rather than perform the argument swap during code generation,
> perform it during decode.  This means it doesn't have to be
> special cased later, and we can share code with aarch64 code
> generation.  Hopefully the decode comment addresses any confusion
> that might arise in between.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/neon-dp.decode       | 9 +++++++--
>  target/arm/translate-neon.inc.c | 3 +--
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
> index ec3a92fe75..6b0b6566d6 100644
> --- a/target/arm/neon-dp.decode
> +++ b/target/arm/neon-dp.decode
> @@ -65,8 +65,13 @@ VCGT_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 0 .... @3same
>  VCGE_S_3s        1111 001 0 0 . .. .... .... 0011 . . . 1 .... @3same
>  VCGE_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 1 .... @3same
>
> -VSHL_S_3s        1111 001 0 0 . .. .... .... 0100 . . . 0 .... @3same
> -VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same
> +# The shift operations are of the form Vd = Vm << Vn.
> +# By reversing the names of the fields here, we can use standard expanders.

My work-in-progress v2 of the neon decodetree stuff has a slightly more
expanded comment for @3same_rev:

# The _rev suffix indicates that Vn and Vm are reversed. This is
# the case for shifts. In the Arm ARM these insns are documented
# with the Vm and Vn fields in their usual places, but in the
# assembly the operands are listed "backwards", ie in the order
# Dd, Dm, Dn where other insns use Dd, Dn, Dm. For QEMU we choose
# to consider Vm and Vm as being in different fields in the insn,
# which allows us to avoid special-casing shifts in the trans_
# function code (where we would otherwise need to manually swap
# the operands over to call Neon helper functions that are shared
# with AArch64 which does not have this odd reversed-operand situation).

> +@3same_rev       .... ... . . . size:2 .... .... .... . q:1 . . .... \
> +                 &3same vn=%vm_dp vm=%vn_dp vd=%vd_dp
> +
> +VSHL_S_3s        1111 001 0 0 . .. .... .... 0100 . . . 0 .... @3same_rev
> +VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same_rev
>
>  VMAX_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 0 .... @3same
>  VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
> diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
> index aefeff498a..416302bcc7 100644
> --- a/target/arm/translate-neon.inc.c
> +++ b/target/arm/translate-neon.inc.c
> @@ -692,8 +692,7 @@ static bool trans_VMUL_p_3s(DisasContext *s, arg_3same *a)
>                                  uint32_t rn_ofs, uint32_t rm_ofs,       \
>                                  uint32_t oprsz, uint32_t maxsz)         \
>      {                                                                   \
> -        /* Note the operation is vshl vd,vm,vn */                       \
> -        tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs,                          \
> +        tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,                          \
>                         oprsz, maxsz, &OPARRAY[vece]);                   \
>      }                                                                   \
>      DO_3SAME(INSN, gen_##INSN##_3s)
> --
> 2.20.1

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

