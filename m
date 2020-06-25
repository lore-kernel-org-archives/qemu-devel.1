Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50B5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EECC20767
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8NVeYDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EECC20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTaT-0004Cf-Nr
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joTZU-0003Xs-MR
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:13:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joTZS-0005BV-0u
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:13:48 -0400
Received: by mail-ot1-x341.google.com with SMTP id m2so5542739otr.12
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4tnlDch3t3FkKDJqfHzh2a/y8QHemcuTIVsbVvfOu3o=;
 b=F8NVeYDYFll5ZT42l6nY8loyX5Tno4wZrb4Iws076gYRrEhW9oztZMV0a8Gtv3RpZA
 mN4X4tKotjM0nxJk/jBwXZzlJHkpuPWGmaXuiqbLqFNuG5pztu8fGsUpJDI+OB+7gK5d
 yf8W0Css/ETIaUV90FDLTCXELDfEuklQa1TMQ3crpE3mCVLgx1IyT7tI0N6K+g6AgZT/
 pz9ZMxJyJSQ5Kzfgn16qh68wvXTT410iDTYheKjFbZWezdJyAgCoxkYlWhM0khwaCuef
 CCG1VHN7cWbP6WbgWKjqyAv3D+YHRQIPNUvAg//e9LXEviDAPvztdWeNsETDwtfT4Vh1
 4BPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4tnlDch3t3FkKDJqfHzh2a/y8QHemcuTIVsbVvfOu3o=;
 b=UlGul9zMmA5Eey7ORDfRrrcKGElgcz4tywmfAGcYnR65WMU0KOCuOxiF7mQMBkzfqI
 OxKkhav6oFJm+YWhEzo8ggxkPJqX4LrXy5TcdLVgYk33KmV7KWsTkRlUQsNiI0zibkf6
 vlvZgPZf2cvlBMm5SwmsF9kr1I7agA/vawYsVKTPvMXJezdobYhFhbabMn8zv+QArVCJ
 Rt1WiMs+lCjVA3ohnD2KT26DLdu2lA/cd4RtSHGgKng0hrZGTfK3y/VjnZcEbcqwKRzL
 xToi++Q5N0uy3s8SBcAqh2Z3cCkSpgLwye8FBErXpfFgaYdK1ZI5UkoKsEVnhSb3Bxyk
 /mvQ==
X-Gm-Message-State: AOAM531Kxx6cg8vHFvONxw9F/6Il4BgM/ry42iHN7NV7o0Fhn4hCIQpT
 ipTRXFVn+h4c5ggehyfW33bbospvl5kuWvENHhIsLg==
X-Google-Smtp-Source: ABdhPJydXmbhDXm5Fd6wLRl9VAn5VahHyvafAzTaSxufZwHYpf19gj4ECqzEY2L6h4CfRW0l4V6YfsA27QbQkuIkIds=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr27956501ooi.85.1593098023221; 
 Thu, 25 Jun 2020 08:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200611161500.23580-1-eric.auger@redhat.com>
 <20200611161500.23580-5-eric.auger@redhat.com>
In-Reply-To: <20200611161500.23580-5-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 16:13:32 +0100
Message-ID: <CAFEAcA9BR4KJQP-M5QswYkWAmTy5OsAdOa6wF3oPMa_EbeBXPg@mail.gmail.com>
Subject: Re: [PATCH RESEND 4/9] hw/arm/smmu: Introduce SMMUTLBEntry for PTW
 and IOTLB value
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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

On Thu, 11 Jun 2020 at 17:15, Eric Auger <eric.auger@redhat.com> wrote:
>
> Introduce a specialized SMMUTLBEntry to store the result of
> the PTW and cache in the IOTLB. This structure extends the
> generic IOMMUTLBEntry struct with the level of the entry and
> the granule size.
>
> Those latter will be useful when implementing range invalidation.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/hw/arm/smmu-common.h | 14 +++++++++++---
>  hw/arm/smmu-common.c         | 30 ++++++++++++++++--------------
>  hw/arm/smmuv3.c              | 10 +++++-----
>  3 files changed, 32 insertions(+), 22 deletions(-)
>
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 7b9d2f0eb7..f6ee78e16c 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -52,6 +52,14 @@ typedef struct SMMUTransTableInfo {
>      uint8_t granule_sz;        /* granule page shift */
>  } SMMUTransTableInfo;
>
> +struct SMMUTLBEntry {
> +    IOMMUTLBEntry entry;
> +    uint8_t level;
> +    uint8_t granule;
> +};
> +
> +typedef struct SMMUTLBEntry SMMUTLBEntry;

Every other typedef in this header uses
  typedef struct Foo {
      ...
  } Foo;

rather than a separate typedef line; could we be consistent with that?

> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 3101043540..aa88b62efb 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -47,11 +47,11 @@ uint64_t smmu_get_iotlb_key(uint16_t asid, uint64_t iova)
>      return iova >> 12 | (uint64_t)(asid) << SMMU_IOTLB_ASID_SHIFT;
>  }
>
> -IOMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> +SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>                                   hwaddr iova)

Indent on this second line needs to move in one space now.

>  {
>      uint64_t key = smmu_get_iotlb_key(cfg->asid, iova);
> -    IOMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
> +    SMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
>
>      if (entry) {
>          cfg->iotlb_hits++;

> @@ -303,7 +305,7 @@ error:
>   * return 0 on success
>   */
>  inline int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
> -             IOMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
> +             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)

might as well fix this indent while we're editing the line...


>  {
>      if (!cfg->aa64) {
>          /*

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

