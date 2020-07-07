Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AED0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E715020674
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ea+m2LES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E715020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspAS-00037X-7U
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsp9I-0000sj-Pd
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:04:44 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsp9G-0002zJ-Uw
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:04:44 -0400
Received: by mail-ot1-x342.google.com with SMTP id n24so32324141otr.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2UIlbewbFnqix9Ab4uKlGbhHQ0KV8VVWbaPyTU80Prw=;
 b=Ea+m2LESZXpIbmo4LIp3VivVNVWvAWd8xPKbIZUWRztzkUmmSMOMc+HYcDjgRI0U2s
 JLtK7P6g+y9qiQ8sggnnrICRiO9W+Bq8MqlGQtjZX0S1TibOcQ6Eg7mZUTQbmaN/dgso
 D9JjmB98qtCE4sUMtEQaWZG4IvgmeIWkrMjYKghnTjUzmX2CC1ZFH9/dJ2LVqoS4FdBb
 uSLKMAMDfVTfeCepC2ACFvssJ9C2zXSmZTFmZTvqW6n4c9mtGxosEWG+7+rC21PEVEEj
 VS5zITTTtejRH8hJw07OyBly1Ps13ekq5yKT24CYxtcGonNRxisjp9YTMiKB9lrv6jl2
 ObYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2UIlbewbFnqix9Ab4uKlGbhHQ0KV8VVWbaPyTU80Prw=;
 b=njx0UX/CtFAg3/E4wTE9chEvDFZhMefGOetayM1rSAgAO6kNWEUbuOJouVlmSXuNUL
 lJwCfqGzQlJ997uHHZLaGzqHZLg4U2t727q/xxCoWLIZEdh57BERAHI7cOzEkK+Zcjmh
 9/B26uoKUJwGLQAs8DbVFUg2MkOg8ocIOOckGYKCSo57HZBIIYD1a8UByYNo0jbNSvld
 MiCC9rmHY7ag+4ZkDDE7/5AJmCX7rTvU/0dre3AHyGAaXtlBNp+I/pTUL7tiOhEOL+JG
 vss4jPDMnVfDJ1mJHm47/SlsFHbpC4Ph50upuxdSWZY9aBMd83G0sLP2jvi1zjaCdnl9
 AZqA==
X-Gm-Message-State: AOAM5303whQQKuuWvZWJhK9dKAwKMQhDFcfd4T9Xp+0npniPBjaU7wB+
 Z5LYULjQ206ZHrjV9KVv8Bm1LLREDxjjPO2P1xlGCA==
X-Google-Smtp-Source: ABdhPJxwrWko/SpIUfz3mmRS0ZOV9umgZDPwMUB/VPjHlUy9LUUOZ7yTgj6CBqJ6JCPNoDyOvfho7H5oZFNf7TF0uK4=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr38724672oto.135.1594134281409; 
 Tue, 07 Jul 2020 08:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200702152659.8522-1-eric.auger@redhat.com>
 <20200702152659.8522-7-eric.auger@redhat.com>
In-Reply-To: <20200702152659.8522-7-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jul 2020 16:04:29 +0100
Message-ID: <CAFEAcA_v7_arUY3mpi=8icJdj83VQsyPc-vC8x=AegkfdpBLBA@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] hw/arm/smmu-common: Manage IOTLB block entries
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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

On Thu, 2 Jul 2020 at 16:27, Eric Auger <eric.auger@redhat.com> wrote:
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

>  SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> -                                hwaddr iova)
> +                                SMMUTransTableInfo *tt, hwaddr iova)
>  {
> -    SMMUIOTLBKey key = smmu_get_iotlb_key(cfg->asid, iova);
> -    SMMUTLBEntry *entry = g_hash_table_lookup(bs->iotlb, &key);
> +    uint8_t tg = (tt->granule_sz - 10) / 2;
> +    uint8_t inputsize = 64 - tt->tsz;
> +    uint8_t stride = tt->granule_sz - 3;
> +    uint8_t level = 4 - (inputsize - 4) / stride;
> +    SMMUTLBEntry *entry = NULL;
> +
> +    while (level <= 3) {
> +        uint64_t subpage_size = 1ULL << level_shift(level, tt->granule_sz);
> +        uint64_t mask = subpage_size - 1;
> +        SMMUIOTLBKey key;
> +
> +        key = smmu_get_iotlb_key(cfg->asid, iova & ~mask, tg, level);
> +        entry = g_hash_table_lookup(bs->iotlb, &key);
> +        if (entry) {
> +            break;
> +        }
> +        level++;
> +    }

So, this next bit is something of a digression:

Effectively what we're doing here is "look up in the hash
table for each of the 3 possible page sizes this could be
for this TG". I've had suggested to me a possible alternative
data structure:
 * hash on the asid (and vmid eventually?) to get...
 * a sorted list of (start, length) ranges representing
   the TLB for that asid ...
 * which we can binary-search to find the matching range
   (and the associated info)

The theoretical benefit is that we don't need to do three
hash table lookups for each iotlb_lookup, and that it can
support arbitrary-length ranges (so we could honour the Contiguous
bit hint in the page tables, for instance). But to avoid 3 hash
lookups it's probably not worth doing a complete rework of
the data structures.


> -inline void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova)
> +static gboolean smmu_hash_remove_by_asid_iova(gpointer key, gpointer value,
> +                                         gpointer user_data)
>  {
> -    SMMUIOTLBKey key = smmu_get_iotlb_key(asid, iova);
> +    SMMUTLBEntry *iter = (SMMUTLBEntry *)value;
> +    IOMMUTLBEntry *entry = &iter->entry;
> +    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
> +    uint64_t *iotlb_key = (uint64_t *)key;
> +
> +    if (info->asid >= 0) {
> +        return (info->asid == SMMU_IOTLB_ASID(*iotlb_key)) &&
> +                ((info->iova & ~entry->addr_mask) == entry->iova);
> +    } else {
> +        return (info->iova & ~entry->addr_mask) == entry->iova;
> +    }

Since the iova comparison logic is the same in both branches
of this if(), you can write

    if (info->asid >= 0 && info->asid != SMMU_IOTLB_ASID(*iotlb_key)) {
        return false;
    }
    return (info->iova & ~entry->addr_mask) == entry->iova;

This seems particularly worthwhile given that a later patch
makes the iova comparison logic more complicated.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

