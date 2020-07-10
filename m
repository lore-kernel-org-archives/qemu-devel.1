Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0EDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528332077D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lsH1N3Bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528332077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtp4E-00040d-Jh
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtp3S-0003Sa-09
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:10:50 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtp3Q-0002FK-74
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:10:49 -0400
Received: by mail-ot1-x342.google.com with SMTP id g37so3714643otb.9
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 02:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0sKLuAGm/07zoHFve/EB/qSwfzst4W9hReel6UkuZH4=;
 b=lsH1N3BuuhS7re4J4dRC5Ok3CMIuYWhT0eO4OP71qvBGAE0puguVILUc66vERYcxIR
 LPej1vc4e1bVTRcBTFZnyY0Qlhq8C5NH9Su49ZRMqGi+Z6pbM7xuROLLrNMdZW7A+UIL
 qBq6/EuVyN4cz8NRbTbKQW4UfO0QQsNu0BahFO+BId1rVdyu1lKSkVToAYm6mNiAX4yX
 NMxZpAuPh83Ms89v3+BjE6iU0gu0gdHCtmD4StbJah7P+nQYWPKynTKQqvkz4vEwQinj
 1kAvC9EAnKIWG6dqAlM/b7A/c3uulBOoAmX3m9iyWat8BtYOXRMX0OnagV+6WA/2xxIY
 bxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0sKLuAGm/07zoHFve/EB/qSwfzst4W9hReel6UkuZH4=;
 b=mgslsF7hRAD783iNmyi2+DPsut+Qavpf4Hn6hxfryvoTgJy2K4goIXTGnh/E2VEGu2
 xbCOpxLWObByPyXH8vLWMn5Q1TBMCvuyZ2jWA7hR+G0M7zQTNezahl9mCFNYiWl5NskN
 r5nZSsO6b0JB5WML6xLad+ncRL4rx55UnV0tvkfsRJyl/dsRHDWxklKbV5uwVwD8qlpx
 TdKiclAt1Ooadin1qPJjZuCrkmXOy56KnEKJFvzK6tidLDGYBagZ1T0tDwpFzkdUtNCk
 mc7t+GMh4I0L10SXhH7FLxb7Bu5LrqfwWNtA77qTdOFZqs62mTm4ktfhyTIusTnCbfL+
 sulA==
X-Gm-Message-State: AOAM532GPWzZJAkLYjqy3CX5yvZKuZaEw57reo1N+/H1sFUixB8bYmgz
 nZeZX5DGIkwYSorVL9bSP0J+Ef7YKUTJ1vmlyW2j3Q==
X-Google-Smtp-Source: ABdhPJyIbKRWCvyPkauwqdOFwlQ64s5L4clomUVeyhhQPB3uWfzpKk2nzUh9mq9B8I+ewJT962ZaWiEfmLoAiARPIho=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr49698179otk.221.1594372246886; 
 Fri, 10 Jul 2020 02:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200708141856.15776-1-eric.auger@redhat.com>
 <20200708141856.15776-10-eric.auger@redhat.com>
In-Reply-To: <20200708141856.15776-10-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 10:10:35 +0100
Message-ID: <CAFEAcA8H_wOCDdoSeTALXV_QArm6EjCdHiUZYW3ezTW287V28Q@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] hw/arm/smmuv3: Let AIDR advertise SMMUv3.0
 support
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

On Wed, 8 Jul 2020 at 15:20, Eric Auger <eric.auger@redhat.com> wrote:
>
> Add the support for AIDR register. It currently advertises
> SMMU V3.0 spec.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
> ---
>  hw/arm/smmuv3-internal.h | 1 +
>  include/hw/arm/smmuv3.h  | 1 +
>  hw/arm/smmuv3.c          | 3 +++
>  3 files changed, 5 insertions(+)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index ef093eaff5..6296235020 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -64,6 +64,7 @@ REG32(IDR5,                0x14)
>  #define SMMU_IDR5_OAS 4
>
>  REG32(IIDR,                0x18)
> +REG32(AIDR,                0x1C)

Rest of file uses lowercase letters for hex values, so "0x1c".

>  REG32(CR0,                 0x20)
>      FIELD(CR0, SMMU_ENABLE,   0, 1)
>      FIELD(CR0, EVENTQEN,      2, 1)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

