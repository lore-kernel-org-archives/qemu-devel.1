Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAEBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E4A20767
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6OW4iyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E4A20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTfH-0002Tt-Se
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joTbT-0005tc-AU
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:15:51 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joTbQ-0006GE-Ac
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:15:50 -0400
Received: by mail-ot1-x343.google.com with SMTP id 64so5577739oti.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M5QBnNRu+wYkAt0WX7yc0inn3gIJTC9kDhApF5BKicY=;
 b=Z6OW4iyTpR7WQF6YNbvYNh5edEvXyID5xxaIPXsfjBz9G0RMYXCRueJjes8WIadhGF
 fp2XaZWCUowS6rITA2RSArx/8GKVwxe9T/M6US4eoXoxWPEfRp2tGig5LwtK4CNJ0ZSn
 Uvr8tK0wRm9/I+n3DsD954Qtcrt2N99AOD5EHSXnoyxke8Z+9DYuQ1Jpc/E96NunJ2R5
 wUbhDSXxjmbYrWAdBkMG0zNy8c+XQmWAKaE2OizrUA2M3NzzTn9iSfrw32NesbmC1iLT
 OVJqoQQLkXTBmnRylmBm9J9mHQThcMkSkyANAbAexFMiDuK2UAdISXQXlBqkm3uMl4BE
 QmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M5QBnNRu+wYkAt0WX7yc0inn3gIJTC9kDhApF5BKicY=;
 b=pXnFnjaxBsZRiv5i1gHayK3L6Bi7cBC2AhBgY8JZdSpY2C9Ae9oRpnr6DMADAAhmmY
 91cZaGap9Ggipx3ofVTUcpk/D5oBeLFWV5vf0+wIpMbXBh2oIbCQuBd6yzM7nvXUkqtJ
 fcWXpsCl4zYpHK6+toYVpXLwOnF1sVCFJuRyc+TEVgCs2iWngbQTSGiE5PXvZIgD60c1
 mRHPqxHR/tWdK0dgqvlqCvKFuGmyA5knO8HMkxrma/26ubb/pisyajxD3nn+GNw9ygle
 JTO38tIemvdBu1WD4PCsBW+bFGM5RK4twgC8YnxHM/smiCGsluhIZUcp2lpzvEKccras
 KIqg==
X-Gm-Message-State: AOAM531eDseDdm7OIARmskw3ZB1nKYuXHwfYf6OSjer5jhHnpR/NuiqI
 ifXgYPY5QrsuBspWi/YC9OA/59NLxwXaZOjqTOA3+A==
X-Google-Smtp-Source: ABdhPJybATndcc72rvEn8MgWkGZoTgclx/sMyKqDecxrNoRPS6QHp3UMbXeN507iQ7UKss09l1noX8W7N0mgbr1vRmA=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr13363317oth.135.1593098146973; 
 Thu, 25 Jun 2020 08:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200611161500.23580-1-eric.auger@redhat.com>
 <20200611161500.23580-6-eric.auger@redhat.com>
In-Reply-To: <20200611161500.23580-6-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 16:15:35 +0100
Message-ID: <CAFEAcA9vMXtj-fiEB_FRHnau+K-XFf--i=3-KYTjNncc_9dgPg@mail.gmail.com>
Subject: Re: [PATCH RESEND 5/9] hw/arm/smmuv3: Store the starting level in
 SMMUTransTableInfo
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
> Compute the starting level on CD decoding and store it
> into SMMUTransTableInfo. We will need this information
> on IOTLB lookup so let's avoid to recompute it each time.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -224,7 +224,7 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
>      granule_sz = tt->granule_sz;
>      stride = granule_sz - 3;
>      inputsize = 64 - tt->tsz;
> -    level = 4 - (inputsize - 4) / stride;
> +    level = tt->starting_level;

"4 - (x - 4) / y" doesn't really seem like it's complicated
enough to be worth caching given everything else we do on
a page table walk. Do you have perf figures to indicate that
this change is worthwhile?

thanks
-- PMM

