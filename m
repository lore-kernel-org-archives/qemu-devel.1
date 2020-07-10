Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4235C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D63206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEtswf/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D63206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtouc-0004qA-8g
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtotk-0004Gv-UD
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:00:48 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtoti-0000kF-Mq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:00:48 -0400
Received: by mail-ot1-x343.google.com with SMTP id a21so3686850otq.8
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 02:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ujs5s6dq+LXHgg/Ip1yjMFs8rA0xMczLbD0RicGjPrc=;
 b=FEtswf/4qTRuU8KQsh2QCzyn6gbv0vfuaUl9GVYnE8QE6S+YBz4km57AqeA67ZvnE0
 t0POKr9xF5jaGn5iuZkV/fo75a4qSoERCRG1vbsxOKIOqEQ6hr9zFSHnYw9P9OKwfuV/
 j+UKnxGM886PUO6+1mQPmh0LyQSXo+HcILuaaipR7NSr6PC/6pMCFAbilhxrhYtYjhL4
 OwROaVZSjiFhHjpmWMMEevw6Hr+XEPbzJmQBfj0j1HP+HHELPrhiILrWeTLmcYWoeDek
 hqFdSs1mziurGV1SxVJD+vccn+WJRyq1ZXDgoI5c/HLxsqCxkUM0jYwAWGqB59Lvq343
 nfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ujs5s6dq+LXHgg/Ip1yjMFs8rA0xMczLbD0RicGjPrc=;
 b=T+0DGGys3RIkl1o6zM2ZFsfWaaFo/99d4rhhP0LWJypM97yLEA6Dzn178xW1M8PDXW
 r0ejg8cdrUi0bPfZ/QYfgWzLlSD3UR5cipQd9pcUQ7WTijfZGT+oMdf1koKz54ofxE6R
 tS+RGxtUrnJ2wghFUqoQ6dlDtCXEJ4Np7OMjS34tD1QWHdK/+2AS7Dn/6s8Zh2z69gUE
 5pcQCjAJ2U9+ZqoBwaXt2EV1t/orR90JKGT0+CzSRNGC1P3lBlOBumUKeQ1s2zCpwser
 UAe/Gi59m+LKpZ6YQlGcBZfz6SpNrnB9MgH9mK9bVC0CSzD9x7Fp3lfpk7XBc4Qd8Q5f
 VN7g==
X-Gm-Message-State: AOAM530szXe++XkKcYGQoE9eWum7MXNAUKRPsC3AimFMWGqv8B5TncgD
 IMaGkEDSOQD3mOpl5vX+dZ0KH7vKwY+QyatwVopkgQ==
X-Google-Smtp-Source: ABdhPJxfMq4XlkryjjWrnUe6t3fo3EHAWZI3yt6WiGxovnE23UhpVr8Y3LUysJPiQu1qQexLj8HmEEm4mI3k+qCAfEI=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr50533620oto.135.1594371645160; 
 Fri, 10 Jul 2020 02:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200708141856.15776-1-eric.auger@redhat.com>
 <20200708141856.15776-6-eric.auger@redhat.com>
In-Reply-To: <20200708141856.15776-6-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 10:00:34 +0100
Message-ID: <CAFEAcA84TctpCs7i-o-H2=FY9O6fuCc_A4OnWoRX2bg8attgiQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] hw/arm/smmu-common: Manage IOTLB block entries
To: Eric Auger <eric.auger@redhat.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> At the moment each entry in the IOTLB corresponds to a page sized
> mapping (4K, 16K or 64K), even if the page belongs to a mapped
> block. In case of block mapping this unefficiently consumes IOTLB
> entries.
>
> Change the value of the entry so that it reflects the actual
> mapping it belongs to (block or page start address and size).
>
> Also the level/tg of the entry is encoded in the key. In subsequent
> patches we will enable range invalidation. This latter is able
> to provide the level/tg of the entry.
>
> Encoding the level/tg directly in the key will allow to invalidate
> using g_hash_table_remove() when num_pages equals to 1.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
> v2 -> v3:
> - simplify the logic in smmu_hash_remove_by_asid_iova as
>   suggested by Peter
> - the key is a struct. We take into account the lvl in the
>   jenkins hash function. Also the equal function is updated.
>
> v1 -> v2:
> - recompute starting_level
> ---
>  hw/arm/smmu-internal.h       |  7 ++++
>  include/hw/arm/smmu-common.h | 10 ++++--
>  hw/arm/smmu-common.c         | 66 +++++++++++++++++++++++++-----------
>  hw/arm/smmuv3.c              |  6 ++--
>  hw/arm/trace-events          |  2 +-
>  5 files changed, 65 insertions(+), 26 deletions(-)
>
> diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
> index 3104f768cd..55147f29be 100644
> --- a/hw/arm/smmu-internal.h
> +++ b/hw/arm/smmu-internal.h
> @@ -97,4 +97,11 @@ uint64_t iova_level_offset(uint64_t iova, int inputsize,
>  }
>
>  #define SMMU_IOTLB_ASID(key) ((key).asid)
> +
> +typedef struct SMMUIOTLBPageInvInfo {
> +    int asid;
> +    uint64_t iova;
> +    uint64_t mask;
> +} SMMUIOTLBPageInvInfo;
> +
>  #endif
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 79c2c6486a..8b13ab0951 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -97,6 +97,8 @@ typedef struct SMMUPciBus {
>  typedef struct SMMUIOTLBKey {
>      uint64_t iova;
>      uint16_t asid;
> +    uint8_t tg;
> +    uint8_t level;
>  } SMMUIOTLBKey;
>
>  typedef struct SMMUState {
> @@ -159,12 +161,14 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
>
>  #define SMMU_IOTLB_MAX_SIZE 256
>
> -SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg, hwaddr iova);
> +SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> +                                SMMUTransTableInfo *tt, hwaddr iova);
>  void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
> -SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova);
> +SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova,
> +                               uint8_t tg, uint8_t level);
>  void smmu_iotlb_inv_all(SMMUState *s);
>  void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
> -void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova);
> +void smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova);
>
>  /* Unmap the range of all the notifiers registered to any IOMMU mr */
>  void smmu_inv_notifiers_all(SMMUState *s);
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 398e958bb4..d373e30aa5 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -39,7 +39,7 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
>
>      /* Jenkins hash */
>      a = b = c = JHASH_INITVAL + sizeof(*key);
> -    a += key->asid;
> +    a += key->asid + key->level;

What's the rationale for putting the level into the hash
but not the tg?

>      b += extract64(key->iova, 0, 32);
>      c += extract64(key->iova, 32, 32);
>
> @@ -51,24 +51,38 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
>
>  static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
>  {
> -    const SMMUIOTLBKey *k1 = v1;
> -    const SMMUIOTLBKey *k2 = v2;
> -
> -    return (k1->asid == k2->asid) && (k1->iova == k2->iova);
> +    return !memcmp(v1, v2, sizeof(SMMUIOTLBKey));

Won't this also compare the padding at the end of the struct
(which isn't guaranteed to be the same)? I think just comparing
all the fields would be safer...

>  }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

