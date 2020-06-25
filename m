Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28DAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634BE20768
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUGx6bB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634BE20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTDc-0003PC-Mt
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joTCU-0002mU-6O
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:50:02 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joTCR-0000Cg-9L
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:50:01 -0400
Received: by mail-ot1-x342.google.com with SMTP id n6so5529776otl.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sOEbjCQLqCivzNz5CXSxvHveIDvkoCbJH5t+ZKxBjT8=;
 b=YUGx6bB+hy74kpeNTE3bpUAbpG7P8tO6BR7HjHW8rcIsHp5dGky1k+QopHAU6jThOE
 YdO9J1LqVJ0o/yOLrTLzvIPG4/+/PZITkgJeFxpgNI+ScG71lY+pZaruE6Dedn89S5kV
 ezEteA6JrlojbFFubcGTQfAgfL3yg8Gd6QX2DTEThd009E+uzkH1VKqSvYXoo3UQo4Qj
 69AS0jKZb/uUzRJi2939BnZs7uy5D+5o1Cl8eSaT2IeBD5B9/eRE+2S2aAq2NVPI97gw
 vdf/D4cePC8i9RuR3jTxJEnVDHR+iSYROtMQF6nI5MxeOZori3mCZyJvWSQm7dUf57Ot
 nOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sOEbjCQLqCivzNz5CXSxvHveIDvkoCbJH5t+ZKxBjT8=;
 b=kqDWhyNefkYIoDog5i2ccBttWyGRBuLA82fMDr5GX08bMbqW+VePVfZnFGIhXntqIa
 gwHGduEiOAgbYtvAfXOiQXUtjr4ijyjNRtwsz5XXhoOGdgIxndpYVwdeyeE5dYTqBt8P
 Kuh0one9MSx1rQ+8q7LzzL3buFGjKkAqDdv6J8AdYOU3BK8naJI0J2QvnPkO35rgIiZA
 xVJrvle6hl2HqI12k8KWNPYYzHUQf3HO66Y+8821isl5Nb8epnDYpUrywgLBKCpoq516
 K4QjrATNRzUMvr+2Qg1XGKYlbhMFAT1g0E5k3omg7PHbJJg9jkyvuYAiyON7N9AvCgYV
 ZVsA==
X-Gm-Message-State: AOAM532EDOgt9uRSKeFdKp4u61uxxl6UNB8H+rAoRHISCrOf7djbLtTF
 VPBm9UcaFwJ1i17s5uA1inxvO2hG3zb4/w+AGOsSIA==
X-Google-Smtp-Source: ABdhPJyqM6xGdtvAHdo9n5ayS7PFlxYFZ9ZL13stiis4JtxHz6X/oaJVzC3zOHH3CG4DH6u47C7ewv8Aet97DPuiZjk=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr25854303otn.221.1593096597475; 
 Thu, 25 Jun 2020 07:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200611161500.23580-1-eric.auger@redhat.com>
 <20200611161500.23580-2-eric.auger@redhat.com>
In-Reply-To: <20200611161500.23580-2-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 15:49:45 +0100
Message-ID: <CAFEAcA-8EjTYGb-RCp6=znbpWUS7rZZuCHTFtPSmQ6NzMM2mXg@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/9] hw/arm/smmu-common: Factorize some code in
 smmu_ptw_64()
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

On Thu, 11 Jun 2020 at 17:15, Eric Auger <eric.auger@redhat.com> wrote:
>
> Page and block PTE decoding can share some code. Let's
> first handle table PTE and factorize some code shared by
> page and block PTEs.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmu-common.c | 51 ++++++++++++++++----------------------------
>  1 file changed, 18 insertions(+), 33 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index e13a5f4a7c..f2de2be527 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -186,12 +186,12 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
>          uint64_t subpage_size = 1ULL << level_shift(level, granule_sz);
>          uint64_t mask = subpage_size - 1;
>          uint32_t offset = iova_level_offset(iova, inputsize, level, granule_sz);
> -        uint64_t pte;
> +        uint64_t pte, gpa;
>          dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
>          uint8_t ap;
>
>          if (get_pte(baseaddr, offset, &pte, info)) {
> -                goto error;
> +            break;

get_pte() fills in info->type (to SMMU_PTW_ERR_WALK_EABT) on
error; changing this from "goto error" to "break" means we'll
now execute the "info->type = SMMU_PTW_ERR_TRANSLATION" that
comes between the end of the while loop and the error: label,
overwriting the wrong error type.

thanks
-- PMM

