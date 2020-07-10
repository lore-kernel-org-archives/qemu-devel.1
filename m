Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F28C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9B2206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Atvmp7ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9B2206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtovz-0006C7-5k
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtovM-0005dI-TO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:02:28 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtovK-000123-Ui
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:02:28 -0400
Received: by mail-ot1-x344.google.com with SMTP id 18so3703202otv.6
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 02:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2q2sMMvB5ZCaxfYoolKsd+GrRnkPmJuPApQ3PnGZ3Zo=;
 b=Atvmp7ug7BzRIyKLMo62OOqZgBvSwEzNGWFcHC7R8RvIKCRxKLRFwNiseVM7xbRh4H
 RVUEcbctgpWoDR47cctC4lbKFyUKTcHxrar9cfnrn03Lliyjq4SEPm3V4550uEifhcyl
 c5b7uk28JGU/jCUuu22uq0DN2b87iZTgSjd/xEPrvhSFOKc+5nw19aGB29FF2EhJ5m1a
 V/WJycSDSLkn+fFGjYQBGAemROih9K1GaGLKkaXhVozoZt/zIef5D7b7gOUtzHo7vpxe
 tCAhfWJB36mJuT7RJx83eSbwENz70BKoRo7HpliuzRVvOilv8749w+Zaxjjwd5Yz7EKg
 U9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2q2sMMvB5ZCaxfYoolKsd+GrRnkPmJuPApQ3PnGZ3Zo=;
 b=e1KAVdQkYzwED7j/2Ybx5NVEwfcAP3373t1cfrgxkmvQJOS1uSLes2l6XDllZQgdYZ
 CGm1Ks9M58uu43v2tKb2cIerJTrjpwq3BGepcSNkNekOFCvBOHxR3ufqnNl5aUVAcwRh
 vZYdcgNj5C88sfY9pQfmsugbYYnkV1xXHEE1yA5qiBzPQOH5qPdHGcuRAIDNTpM3Uy3G
 z+o+MK3LC6DRHZ0fS1zzZkGdb7wqbxGcUiTGEVM9Y5BJs5cMBIo1LUIDB47+zsbefSRB
 ufLkalVaNpdamkWnTZOFMoAQQ2MFZKnB3mb0MOeIn8VMh3f50ss1PQflSvRYJuJhDR+e
 /srA==
X-Gm-Message-State: AOAM530VWfCT/LhAVtaWok8pUHnhs66uJmTBPfrrYG+ohH3RLn+deycd
 HL9vfwACrtuC1x00CmTlNYXCNY7NegA4JFKOu5emAw==
X-Google-Smtp-Source: ABdhPJxRrZEh6/tjOImacQ+X5cPjBvV7Zor2p4NiPc8E0z+AzT4bNOIpduMeUKZF5+H5lq/LlmN8gLsW1+JQ8Ga1um4=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr50540854oto.135.1594371746037; 
 Fri, 10 Jul 2020 02:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200708141856.15776-1-eric.auger@redhat.com>
 <20200708141856.15776-6-eric.auger@redhat.com>
In-Reply-To: <20200708141856.15776-6-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 10:02:14 +0100
Message-ID: <CAFEAcA-gmQ841XqGL=sbMAPoXr9EAqH=0Gud=4daBPKKR3DpJw@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] hw/arm/smmu-common: Manage IOTLB block entries
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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

Oh yes, and indentation looks a bit off in a couple of places:

>  void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
> -SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova);
> +SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova,
> +                               uint8_t tg, uint8_t level);

here ^^


> -inline void smmu_iotlb_inv_iova(SMMUState *s, uint16_t asid, dma_addr_t iova)
> +static gboolean smmu_hash_remove_by_asid_iova(gpointer key, gpointer value,
> +                                         gpointer user_data)

and here ^^


thanks
-- PMM

