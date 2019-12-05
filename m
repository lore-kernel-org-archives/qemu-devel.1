Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EDEC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12B822525
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zok+uz4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12B822525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvxL-00021b-RB
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1icvvk-0001T7-Ay
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1icvvi-00082K-CM
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:32:47 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1icvvg-00080v-UK
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:32:45 -0500
Received: by mail-oi1-x242.google.com with SMTP id 6so3666034oix.7
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 10:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fo78LySk+IDjHJmOYFaESpk0uW4l7d7VSVykxo1MFYI=;
 b=zok+uz4GuyolOqem9+ituSa4mJxRpP4Baj0B9R9dNwdGTomF5SOyvNSTGkpy7bIX3k
 3eDPSksWNCgnyJTwh48YE3tnW48xZ67H2xg/O0tXRP33L4NDNQ4mio75LW6mbkYbtpYM
 UOdUuNhyeczdFJ6u/Ndxsojau2KpWHsGIbgb7aGFwU0N+nDROs1BiueQSypHpnxN+fHF
 pN09mUJ+7p2XnhXWBll22+UcfNm4D7gpUTEvDmez+OL1RYFBqnnIYEBjNpeJoXgxxemP
 t8GnY9Uk1CImxIwhr2PQnZ5sjf1weiOLvB8u9n6hM9eUleorbAZl2ZeiMDVpj+JDMmlP
 GChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fo78LySk+IDjHJmOYFaESpk0uW4l7d7VSVykxo1MFYI=;
 b=ddQ5K8f7wxGkgCPAG/rx52o6VPSYjAApD09chdzSzSvOFfgCVab8crEqHxS6dA+Oii
 oBp5S+aF/snHkS+gd8T4bKBLYj2/KdNft5MUTG9lisNbYs1AMrCQUGnmZSDYaWIzEeys
 mk5duT5oXSyHXNdIJdMI+BkuoBcpcRHZz36houzB6HK1kCUe/6qOqjVoHJPgG2KVnoou
 IsIqAk6JJmr3FENNrt9IDAq8IUHulDX37RBeScAA7PdilMIth5UAs6a6njm1qO5xjceM
 LCVlX8jATwbww60/JrUODopMYxQWrQvQ93LTr9JR+nmBQl2JsMmpGZELgcAu6elJ2ILB
 38rQ==
X-Gm-Message-State: APjAAAXsqx74WivY+mmq0EI/h2sV7LFmo9Vokj1wH/y1NAQ6PmUrkv/E
 OqPaiojIqS28x96uQ7rk9wF1SC/xjCuAvK/KlG26kg==
X-Google-Smtp-Source: APXvYqx4W0hD3SZOGmrfMuHkD1IEodWRg+9Hf/ZCYhSrdcYHyrMWDp5hWm+p2ctXmqJTRG2mgiDPp2FlVdxtGRWCJts=
X-Received: by 2002:aca:f5cc:: with SMTP id t195mr8680471oih.163.1575570762676; 
 Thu, 05 Dec 2019 10:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-20-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2019 18:32:31 +0000
Message-ID: <CAFEAcA-2uT9Pj=HCP+ZrCy2GygNy+BhME0o5P8OQReEdKJgscg@mail.gmail.com>
Subject: Re: [PATCH v5 19/22] target/arm: Cache the Tagged bit for a page in
 MemTxAttrs
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 at 14:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This "bit" is a particular value of the page's MemAttr.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index e988398fce..17981d7c48 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -9609,6 +9609,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>      uint64_t descaddrmask;
>      bool aarch64 = arm_el_is_aa64(env, el);
>      bool guarded = false;
> +    uint8_t memattr;
>
>      /* TODO:
>       * This code does not handle the different format TCR for VTCR_EL2.
> @@ -9836,17 +9837,21 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>          txattrs->target_tlb_bit0 = true;
>      }
>
> +    if (mmu_idx == ARMMMUIdx_S2NS) {
> +        memattr = convert_stage2_attrs(env, extract32(attrs, 0, 4));
> +    } else {
> +        /* Index into MAIR registers for cache attributes */
> +        uint64_t mair = env->cp15.mair_el[el];
> +        memattr = extract64(mair, extract32(attrs, 0, 3) * 8, 8);
> +    }
> +
> +    /* When in aarch64 mode, and MTE is enabled, remember Tagged in IOTLB.  */
> +    if (aarch64 && memattr == 0xf0 && cpu_isar_feature(aa64_mte, cpu)) {
> +        txattrs->target_tlb_bit1 = true;
> +    }

A comment somewhere saying that 0xf0 is the "Tagged Normal Memory"
attribute would probably be helpful.

> +
>      if (cacheattrs != NULL) {
> -        if (mmu_idx == ARMMMUIdx_S2NS) {
> -            cacheattrs->attrs = convert_stage2_attrs(env,
> -                                                     extract32(attrs, 0, 4));
> -        } else {
> -            /* Index into MAIR registers for cache attributes */
> -            uint8_t attrindx = extract32(attrs, 0, 3);
> -            uint64_t mair = env->cp15.mair_el[regime_el(env, mmu_idx)];
> -            assert(attrindx <= 7);
> -            cacheattrs->attrs = extract64(mair, attrindx * 8, 8);
> -        }
> +        cacheattrs->attrs = memattr;
>          cacheattrs->shareability = extract32(attrs, 6, 2);
>      }

Don't we also need to care about the stage 2 attributes
somewhere ? If the combo of stage 1 + stage 2 doesn't
say it's Normal Inner&OuterShareable WB NT RA WA then
it shouldn't be Tagged even if the stage 1 attributes ask
for that.

There's also the special case for "stage 1 translation
disabled" -- depends on HCR_EL2.DC and HCR_EL2.DCT.

thanks
-- PMM

