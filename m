Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906EFC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 21:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF3C206D7
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 21:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cm6zZbMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF3C206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpIev-00048x-MQ
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 17:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpIdM-000382-P4
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 17:45:12 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:43253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpIdJ-0003Vw-KK
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 17:45:12 -0400
Received: by mail-oi1-x22c.google.com with SMTP id x83so3632630oif.10
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 14:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=okvuMa1UEyNGcGy4gqYKwG2ikzR/9xrkEZmK8NwINLc=;
 b=cm6zZbMiODlGQq24h4XBe6kLoLv+Tfi5ueUp8rMc02lFCq6/K44SfEGV/VEMSmJCzD
 1dvTrz2g/th8SbOTjtUt45zXXwcNeBmtj0Bise1J3l6TnZuBSDIxOB+sqNMrMXbb/lII
 v6M+AY7w338BFc98jYsc/nPl1eXUp1BbXZR6TKKjL9ojPvjdXQ2eBKNBcx6qNS0JuV5F
 BrseCYulARAatqzs7k3wT+KBwpb1CyoiL34QBlkOf5d2JD1M4+iTVOQW9jPQJrcRaMWA
 W8VdX0P0MlA/jNNCPkU8UW9Wl0oocfqDano021RhULUPR8g4viWQMCTJ5SFpaODmVLIr
 jbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=okvuMa1UEyNGcGy4gqYKwG2ikzR/9xrkEZmK8NwINLc=;
 b=rLfz4n2YKahZQD0yz75BKDLYGsygQWdEtJw2LBIpuY5eULL89aMxs2LrdXjlx8urp6
 0WJRnAGnJR1TiT7+SOTdP0ncp1I8LepJUzDlLzL7cWsqNZF+dyaUzKY3PFdprOCgliPr
 SmlpHlQZdBRHo/FHvxIepnYbvPSBk6kbOrYBEe32YhD80p7a4i/3nfbzT3CZ8W2LRYJD
 J5plAWd4hcEDSb88gytwaE0sjElSBwgM9WRtFGxks1DFOagmSroZ4CYaNQ+RabCcmXr1
 z1Qk73J50IfkJ3nsLe1EFGANBYsNoBzZF5x22+Aa5wArDcoI7UX3YEkJuLzyMQDs/XV0
 P9Kw==
X-Gm-Message-State: AOAM53383jNiuQ0MuPe7OvbbFS18UG1sx9tP7bdJXRVs2h9J7FzGosh4
 F1PYmc2TLfZAjADBCpDFEmISfLT2dSdcuO0R8ts8OWcl7zQ=
X-Google-Smtp-Source: ABdhPJxMVbz1258+aon1sjaVndVggmvBkiAIrG7kQr+glQ1axzra8GI6u5X3Kse03j0MTunWPFJv6a69Dt34AHXQ3y0=
X-Received: by 2002:aca:2819:: with SMTP id 25mr1843771oix.48.1593294307458;
 Sat, 27 Jun 2020 14:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200626151424.30117-1-peter.maydell@linaro.org>
 <20200626151424.30117-50-peter.maydell@linaro.org>
In-Reply-To: <20200626151424.30117-50-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 27 Jun 2020 22:44:56 +0100
Message-ID: <CAFEAcA-0sq0hZX6CpFetTtCcuyUuCWD=iyjGRgX6GYwf9pZ=hw@mail.gmail.com>
Subject: Re: [PULL 49/57] target/arm: Add mte helpers for sve scatter/gather
 memory ops
To: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 16:15, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Richard Henderson <richard.henderson@linaro.org>
>
> Because the elements are non-sequential, we cannot eliminate many
> tests straight away like we can for sequential operations.  But
> we often have the PTE details handy, so we can test for Tagged.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20200626033144.790098-38-richard.henderson@linaro.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Hi; Coverity points out that something went wrong here
(CID 1429996):

> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -5261,7 +5261,7 @@ static bool trans_ST_zpri(DisasContext *s, arg_rpri_store *a)
>   */
>
>  static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
> -                       int scale, TCGv_i64 scalar, int msz,
> +                       int scale, TCGv_i64 scalar, int msz, bool is_write,
>                         gen_helper_gvec_mem_scatter *fn)
>  {
>      unsigned vsz = vec_full_reg_size(s);
> @@ -5269,8 +5269,16 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
>      TCGv_ptr t_pg = tcg_temp_new_ptr();
>      TCGv_ptr t_zt = tcg_temp_new_ptr();
>      TCGv_i32 t_desc;
> -    int desc;
> +    int desc = 0;
>
> +    if (s->mte_active[0]) {
> +        desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
> +        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
> +        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
> +        desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
> +        desc = FIELD_DP32(desc, MTEDESC, ESIZE, 1 << msz);
> +        desc <<= SVE_MTEDESC_SHIFT;

We carefully set up desc here...

> +    }
>      desc = simd_desc(vsz, vsz, scale);

...but immediately overwrite it. Should desc have been an input here somewhere?

>      t_desc = tcg_const_i32(desc);

thanks
-- PMM

