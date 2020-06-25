Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CF5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE162204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aANHhREW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE162204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRe0-0008UK-W4
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRTX-0001nG-3j
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:59:31 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRTV-0004IW-F9
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:59:30 -0400
Received: by mail-ot1-x343.google.com with SMTP id m2so5104722otr.12
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 05:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q6MosTpj0KYh6C5cIssDj8St0IhW66gRZAKbDZaqO7M=;
 b=aANHhREWKc5pGrdwknAJhQIC4q5evhN/auv3seX4ZChGrODEOKXWgmxVS00GiHnVr5
 6gk1GLY5E0I5pvSlV4NAtLRyBocEVb5oh0HwpLjB3VhI2VK0UZ9Vg38z8mon6P7tnudh
 92FNQ8Fr6WxCURWUEyAYsePOSBq9a7aLwmimAYovmwMS1JwKbH77u6jhJMFegg5jZYpB
 fZ4plpm19B/BM/5YG8Q57ehvtKX0HtWc/ZoYOuC+YTGEr0UGPaJj8Kz2zVL+191qgWVQ
 A5bfzo3XEWJUdEEbmImLi4Y5YNUy0PS6LHQtjUXru1HnMCY/uOBepln9FO68gTzcQ/+M
 XW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q6MosTpj0KYh6C5cIssDj8St0IhW66gRZAKbDZaqO7M=;
 b=YfrXPbnTFzth9WpxaDaFNMthNkC4zQ/tdowI4ddHGCJA6TlMtBNV4K7CpFdJZHGtWm
 MHsSSNx4Mx6ukOY1fkWAewQT6r6Qt/lNATzHN0asClfeIM1e7wND6l3ycp9e+GBAu8nI
 kNNdFcQXMclION/oWlFPuO1KRtrUiOYWVZLk2ChfHBh+in2rMxRsvzWz2cR7gwEvQq8n
 EzdCnPf/QpImWGmhU0peih4QabV+zJQX0MtGbLh72L3tAxn4VjU5WFcA2wK93l3SDQeo
 9zVafHdgVg/oZvpOvAnnycRZWtOZWLQ5WqHwFj1f22BNhSdnS72bI1oiU4lvABu+UUWV
 KK0g==
X-Gm-Message-State: AOAM533wzNdTLLF/4U6jfXeZ2T27YOgmHZbvkVKxPjxPC51QPfa6yBOY
 sxZrMjrSWYj4SWtaBwTXkXtYOl8pzl4x7EALYUhw2w==
X-Google-Smtp-Source: ABdhPJziTDryHuTqh24ZyhJ+LmI5NGbUKxJlkUkmLmSNjTVVtFrWSxA5AsE+Nc9B+P2fCFP24OKK4xaCCcS26lIyI4U=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr26466760oto.91.1593089968354; 
 Thu, 25 Jun 2020 05:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-43-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-43-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 13:59:17 +0100
Message-ID: <CAFEAcA838PPdJp6JROufjZ0bhtKQFBVQxym74Z6vqAVFdF+ZwQ@mail.gmail.com>
Subject: Re: [PATCH v8 42/45] target/arm: Cache the Tagged bit for a page in
 MemTxAttrs
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This "bit" is a particular value of the page's MemAttr.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v6: Test HCR_EL2.{DC,DCT}; test Stage2 attributes.
> v8: Fill in cacheattrs for S1 disabled; retain tagging when
>     combining attributes; set mte_tagging in arm_cpu_tlb_fill.
> ---
>  target/arm/helper.c     | 48 ++++++++++++++++++++++++++++++++++++++---
>  target/arm/tlb_helper.c |  5 +++++
>  2 files changed, 50 insertions(+), 3 deletions(-)

> +        } else if (access_type == MMU_INST_FETCH) {
> +            if (regime_sctlr(env, mmu_idx) & SCTLR_I) {
> +                memattr = 0xee;  /* Normal, WT, RA, NT */
> +            } else {
> +                memattr = 0x44;  /* Normal, NC, No */
> +            }
> +            cacheattrs->shareability = 2; /* outersharable */

"outer shareable"

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

