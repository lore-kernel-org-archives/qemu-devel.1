Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33D4C33CAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A305720678
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Me0gyCKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A305720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itL31-0002IN-I1
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 19:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itL2M-0001nJ-Oc
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itL2L-000349-Kc
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:35:26 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:34014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itL2L-00033b-BU
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:35:25 -0500
Received: by mail-lf1-x144.google.com with SMTP id l18so22635336lfc.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2020 16:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Tm5kUsA2Esbm0WeQH1wD0c2sJwCx3FbbG5u78C+Gh7o=;
 b=Me0gyCKkDxHe03RZg6XVLfDnx48ogySQWKBXtjoavh09autApwThJC6RCRp3iG5Fgh
 3Cro753wBCE4uZYwlh7X1ukAKVoNb0OikA9+pWUi1c1MYIftdb+53NJKjL9JqsY6LUHb
 cUD7nDzXe6RTiS0eZ260+pFmDwVpz91CgIjUoHW5ZOYRDeKk09rLDjyT1Jr4CVqx1kjw
 LD1hI2laHTr4Dg9Ra5RdkEp+1L7DtBaol/laKCupYz5iXzM1fptdiZ8HV0nAPBviSFIA
 4VEprDqTRBFEexWGdl+vr0WqducjgtkhNPFW7vqRLH3oygmQ65Tm7YblQVMnBHFkidhk
 d9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Tm5kUsA2Esbm0WeQH1wD0c2sJwCx3FbbG5u78C+Gh7o=;
 b=OW0DihLq9CIy35+boXGvxmtuFNTnlrUTwE86a4RtNznfUo9/COytz6unPLRPE03Gpt
 8X/Um3L8V9o6Q2aaz7K0Kki1eZ48y03Uw15DSynkAldCM5n8jyPoKVEiHRcF3PFwZH/4
 pYg84psGZloj8gRVxaWlTxwu4hcDxgZhrROt6qN7fH7M6cMtCj3I9Flc3B2h3gblxOKT
 5HbrKeoIMSSoHU/xh1H+4mgiMCz+LmKNbFsS9OgEkiCyA7o3ZIsZmIEPxK6fvmZVF1BW
 H9jC/k2huJVvasxwJA0GQFCxoWR9saJE3JO7DwrH29ZpUf9zbk/bMd9rklrI0FBcuJk4
 uHtQ==
X-Gm-Message-State: APjAAAUQHGwYqlsagTwCymv13ONOmRnjNGLbXPFxCxuVUCNv+oCDiegn
 spmiEVMBuAGsb/NB2sWqQEU4tkDbSrx3Ia/fISI=
X-Google-Smtp-Source: APXvYqyahiYTVYUS3UR56H9hM9G0ErPvPTH0hCX5Jdhf8QOX/B7EEf17oAJxY24ZY64djjfC/XqtWTvG1dw9bxFCoYk=
X-Received: by 2002:ac2:5f68:: with SMTP id c8mr11469830lfc.196.1579480523623; 
 Sun, 19 Jan 2020 16:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-2-richard.henderson@linaro.org>
In-Reply-To: <20200109024907.2730-2-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Jan 2020 10:34:56 +1000
Message-ID: <CAKmqyKOdAF+ruzdqWFYR7WvgYYx95fg-ByFQgqF8CgtGw2RAoA@mail.gmail.com>
Subject: Re: [PATCH 1/9] cputlb: Merge tlb_table_flush_by_mmuidx into
 tlb_flush_one_mmuidx_locked
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 9, 2020 at 12:49 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There is only one caller for tlb_table_flush_by_mmuidx.  Place
> the result at the earlier line number, due to an expected user
> in the near future.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  accel/tcg/cputlb.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index a991ea2964..1a81886e58 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -224,11 +224,16 @@ static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
>      }
>  }
>
> -static inline void tlb_table_flush_by_mmuidx(CPUArchState *env, int mmu_idx)
> +static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
>  {
>      tlb_mmu_resize_locked(env, mmu_idx);
> -    memset(env_tlb(env)->f[mmu_idx].table, -1, sizeof_tlb(env, mmu_idx));
>      env_tlb(env)->d[mmu_idx].n_used_entries = 0;
> +    env_tlb(env)->d[mmu_idx].large_page_addr = -1;
> +    env_tlb(env)->d[mmu_idx].large_page_mask = -1;
> +    env_tlb(env)->d[mmu_idx].vindex = 0;
> +    memset(env_tlb(env)->f[mmu_idx].table, -1, sizeof_tlb(env, mmu_idx));
> +    memset(env_tlb(env)->d[mmu_idx].vtable, -1,
> +           sizeof(env_tlb(env)->d[0].vtable));
>  }
>
>  static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
> @@ -289,16 +294,6 @@ void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
>      *pelide = elide;
>  }
>
> -static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
> -{
> -    tlb_table_flush_by_mmuidx(env, mmu_idx);
> -    env_tlb(env)->d[mmu_idx].large_page_addr = -1;
> -    env_tlb(env)->d[mmu_idx].large_page_mask = -1;
> -    env_tlb(env)->d[mmu_idx].vindex = 0;
> -    memset(env_tlb(env)->d[mmu_idx].vtable, -1,
> -           sizeof(env_tlb(env)->d[0].vtable));
> -}
> -
>  static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
>  {
>      CPUArchState *env = cpu->env_ptr;
> --
> 2.20.1
>
>

