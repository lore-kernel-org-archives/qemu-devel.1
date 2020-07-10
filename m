Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1168CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC6AE207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7NRI3g1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6AE207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtp0E-0001XK-28
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtozf-0000zu-Ty
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:06:55 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtoze-0001m9-F7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:06:55 -0400
Received: by mail-oi1-x241.google.com with SMTP id l63so4202105oih.13
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 02:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MV7vJr246FQWCSU872RsoS5wCj76WAaTBzc75YR+XMw=;
 b=V7NRI3g1nuxWmZ9oTBcK6YehxkXosAnbQEf9ZOg8DKoXKr+uBtzhD6g46D+tvbXr5l
 d5QVUdUV4WH/aTeI9BygnHTaQ3NKo7UWnYGZBH1C8WsCh8ZeB4wW8G9CHTYTLfJwUm18
 FA3yEix4v5HTM+xG7YuH1f56RcFHD/7blSeBo9vejtzmYH8B+tIx7Rd9NOow6x11BOZZ
 UVo4df5KiJz3LhoVQm4ibROPMFpIC8EsRRXKwQ+jmaZYt2ineeuBDqfYJQCRRXAzsAn/
 DoVuFFqs6GesY05WnjzHKPJ/xsvgtSV5I07V/8AoKgkagRtO+Uj3Sj8f0xwTpSGumWKQ
 SbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MV7vJr246FQWCSU872RsoS5wCj76WAaTBzc75YR+XMw=;
 b=hwjkVaDKo8YGCnk1JacIW6amTxedODbYORhHePJBYRceiRiroWyb34ZOcf1cpqkcX8
 VgzTHfl/FfyOVYCmtZ3oNkVsNrfSvWVcY17WdkaayOyAGrAExgkwAYFuOsYpa4WS4Pb6
 Lh50gQeTWCGE6VrcPfzKd1EXVqkZa8gX3SN2+tWelkoXyo+AX+T/1ALU7wE8rOP7nPdl
 CselFawlBTHiK3UzucqBJfJaAdqtZ/Jf9DOZ0+EdO0Hb+VTlE6n6ocfTrBFJ9EylzZyg
 GvKdR/wqAamzzjGePFN0YDjuGCG4d1wiNRCpBmyVP0Ao20Nt2PLooK4eYrEdT5z1Sq52
 aUnw==
X-Gm-Message-State: AOAM533y03ea5B79Knc7zN0dSplILKuiX86Ul9UMQ1BF8yQ7xhJ+u+A4
 E6psUpwweSyRQeJNXiV7A6Iw66vv8rNbIwPqoGGhxg==
X-Google-Smtp-Source: ABdhPJz3XiorrnaXPVzGkKG22JJ1KKDvC+DCNE5Xa8F95zBsaM6KmJsfPcCmbrBi6fE2D2F3vB3dK3MYGNBgBalxbnk=
X-Received: by 2002:aca:2819:: with SMTP id 25mr3229291oix.48.1594372013403;
 Fri, 10 Jul 2020 02:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200708141856.15776-1-eric.auger@redhat.com>
 <20200708141856.15776-8-eric.auger@redhat.com>
In-Reply-To: <20200708141856.15776-8-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 10:06:42 +0100
Message-ID: <CAFEAcA_81kxFhJeLTBKvvg7Vn75g1wrjq=wb7Wc+EAY9X1VT0A@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] hw/arm/smmuv3: Get prepared for range
 invalidation
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 zhangfei.gao@foxmail.com, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jul 2020 at 15:19, Eric Auger <eric.auger@redhat.com> wrote:
>
> Enhance the smmu_iotlb_inv_iova() helper with range invalidation.
> This uses the new fields passed in the NH_VA and NH_VAA commands:
> the size of the range, the level and the granule.
>
> As NH_VA and NH_VAA both use those fields, their decoding and
> handling is factorized in a new smmuv3_s1_range_inval() helper.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---

> -inline void smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova)
> +inline void
> +smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova,
> +                    uint8_t tg, uint64_t num_pages, uint8_t ttl)
>  {
> -    SMMUIOTLBPageInvInfo info = {.asid = asid, .iova = iova};
> +    if (ttl && (num_pages == 1)) {
> +        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, iova, tg, ttl);
>
> -    trace_smmu_iotlb_inv_iova(asid, iova);
> -    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_iova, &info);
> +        g_hash_table_remove(s->iotlb, &key);
> +    } else {
> +            /* if tg is not set we use 4KB range invalidation */

Over-indented here.

> +            uint8_t granule = tg ? tg * 2 + 10 : 12;
> +
> +            SMMUIOTLBPageInvInfo info = {
> +                 .asid = asid, .iova = iova,
> +                 .mask = (num_pages * 1 << granule) - 1};
> +
> +            g_hash_table_foreach_remove(s->iotlb,
> +                                        smmu_hash_remove_by_asid_iova,
> +                                        &info);
> +    }
>

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

