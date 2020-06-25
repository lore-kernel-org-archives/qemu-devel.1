Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6490DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C67E2082F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXdVeJdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C67E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUNf-0003PU-Dl
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joTq2-0007in-Cl
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:30:56 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joTps-0001oG-12
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:30:48 -0400
Received: by mail-oi1-x244.google.com with SMTP id a3so5328521oid.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hdm/Nd7h1S6To48RIP0gmlLEp+EWkwiRjc1SbDsj7Pg=;
 b=DXdVeJdSPF1BQEZHoKiP9HEBerfaz/7fiC4m7l8meo/XOx0qk/cYXNNRf3RXAaBFOH
 EMFygDR1cioYesZl2mFnGfadZoWOfffQZpRg7/MkYd0s7EjVhUxFkrKRxfroi3fF4/sl
 5NF+uifRITt9sqmfQjVcPv94m45E2oB3bmqKCEXJvtfbVv/KyyLAvLfoEa1FCSk3sBDe
 hDZZyvmaaDLw5kkWusAuPWQwGHPQ8F/u0TSQILabDA3kJUONnBcfz9ZVc9bFM7V9jJaA
 iMquvDxsBDnoPr3kd1e+kSjUoKLEptqtPJl4WZnUqX8df9vhIvDjzD8s4Llt49FfDyv9
 MenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hdm/Nd7h1S6To48RIP0gmlLEp+EWkwiRjc1SbDsj7Pg=;
 b=Zd+scx3C0Cp+ttaeZIsduPVHq2sro1zp4mUMCTNIadibVLVKHrB+KZEVDweMbvGBjX
 OweJyE4sBN1D7TGx1guSfOE0X5m+ZUsXyCuzlrBXl9GVG3QcPj/fIvUWlZM3lUM4xT9v
 Euayczdy3G7mpl1rvBsrrr/ir3QKirA1vbqWmEz0PH/syUmNOJvIE/OR/oV29SAgCr5T
 HJsT/sM4b3LGMBEa3Jk8dXCeEWlOeNGWX/sNZLMjukdwIWp4rGPiwy3lvcVVSlUiEM5t
 IUYeFWLMzr0bQ44CsU7jgAZppFMRvmivfHok1iSFXcjpKzTZJZkV07pHR196TvDKHQ17
 tlpg==
X-Gm-Message-State: AOAM532MjZq4xI51xkuGWNcs4kQDT3wm8GR1hbxGxDIhviQunqlfLLPg
 7+eqkF+cgBNpGlTidW4rwUFcJ9TBXAIbZfI+Q0qLkg==
X-Google-Smtp-Source: ABdhPJxWjpYDRDVGMXNkLq3WryuNn2/9KciN4wzsXsiBb6ZLj5exSLq754WKnKu3jJIpx0yYUCLXzNm1Y4HCka2YidI=
X-Received: by 2002:aca:568c:: with SMTP id k134mr2516852oib.48.1593099041976; 
 Thu, 25 Jun 2020 08:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200611161500.23580-1-eric.auger@redhat.com>
 <20200611161500.23580-7-eric.auger@redhat.com>
In-Reply-To: <20200611161500.23580-7-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 16:30:30 +0100
Message-ID: <CAFEAcA9FZV=jSk_9aJ_tHy=KLy+YrTFNoiqvCv7BMs0dWrHWFA@mail.gmail.com>
Subject: Re: [PATCH RESEND 6/9] hw/arm/smmu-common: Manage IOTLB block entries
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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

On Thu, 11 Jun 2020 at 17:16, Eric Auger <eric.auger@redhat.com> wrote:
>
> At the moment each entry in the IOTLB corresponds to a page sized
> mapping (4K, 16K or 64K), even if the page belongs to a mapped
> block. In case of block mapping this unefficiently consume IOTLB
> entries.
>
> Change the value of the entry so that it reflects the actual
> mapping it belongs to (block or page start address and size).
>
> Also the level/tg of the entry is encoded in the key. In subsequent
> patches we will enable range invalidation. This latter is able
> to provide the level/tg of the entry.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>


> -uint64_t smmu_get_iotlb_key(uint16_t asid, uint64_t iova)
> +uint64_t smmu_get_iotlb_key(uint16_t asid, uint64_t iova,
> +                            uint8_t tg, uint8_t level)
>  {
> -    return iova >> 12 | (uint64_t)(asid) << SMMU_IOTLB_ASID_SHIFT;
> +    return iova >> 12 | (uint64_t)(asid) << SMMU_IOTLB_ASID_SHIFT |
> +           (uint64_t)(level) << SMMU_IOTLB_LEVEL_SHIFT |
> +           (uint64_t)(tg) << SMMU_IOTLB_TG_SHIFT;
>  }

>  SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> -                                 hwaddr iova)
> +                                SMMUTransTableInfo *tt, hwaddr iova)
>  {
> -    uint64_t key = smmu_get_iotlb_key(cfg->asid, iova);
> -    SMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
> +    uint8_t tg = (tt->granule_sz - 10) / 2;
> +    int level = tt->starting_level;
> +    SMMUTLBEntry *entry = NULL;
> +
> +    while (level <= 3) {
> +        uint64_t subpage_size = 1ULL << level_shift(level, tt->granule_sz);
> +        uint64_t mask = subpage_size - 1;
> +        uint64_t key;
> +
> +        key = smmu_get_iotlb_key(cfg->asid, iova & ~mask, tg, level);
> +        entry = g_hash_table_lookup(bs->iotlb, &key);
> +        if (entry) {
> +            break;
> +        }
> +        level++;

Rather than looping around doing multiple hash table lookups like
this, why not just avoid including the tg and level in the
key equality test?

If I understand the range-based-invalidation feature correctly,
the only time we care about the TG/LVL is if we're processing
an invalidate-range command that specifies them. But in that
case there should never be multiple entries in the bs->iotlb
with the same iova, so we can just check whether the entry
matches the requested TG/LVL once we've pulled it out of the
hash table. (Or we could architecturally validly just blow
it away regardless of requested TG/LVL -- they are only hints,
not required-to-match.)

thanks
-- PMM

