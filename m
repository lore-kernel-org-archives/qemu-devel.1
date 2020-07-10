Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDA9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6276207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIyymd/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6276207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtp2Y-0002pd-4D
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtp1q-0002Hz-FN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:09:10 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtp1o-0001yC-TN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:09:10 -0400
Received: by mail-ot1-x343.google.com with SMTP id 5so3689586oty.11
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NFlTUurTb7NC3EwCFkAS7OGriVpClScNo0C60XFKlEM=;
 b=OIyymd/Q4ENsB3X2C3veJSHK2avBcFATGF+65QXQWoSMr06Ncxy8usi171nRJc2XXS
 jhl/r3FNKdARYK+9H6j4KUJHGx90hyz9bQXJioRk4jUNbjD7gLLw78epzCgsfFUSw+cA
 +0f4L5OfVpHIFNSwHhbYW1QvQ9/OqIjCGE6lztr2REtazdU1wiWycnAmw/qvD6UGR2VK
 YwNAii79NVJsYeqWWownJ19JEk1AtXPIA+M2yaRX1pO6k/jym1HvaKkRs9M5JmYLevZ8
 Mli8iUE0KYLCkkWJLwhAA4PZs/RQfEO25AvwoGQAwPDMBMY+vsUqHiUUf3ooQXrJc+gR
 gXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NFlTUurTb7NC3EwCFkAS7OGriVpClScNo0C60XFKlEM=;
 b=WU1B5e5wQSY2o0nTAlcjj9FHlgQvLoRy9HdoFWCSLaBgVXw6etzSDkBOFTrqj+7tFl
 6lVhcr9QmCeoGRYDYWX97hUhIpTMkf4A3YfzCD4xlbTWtpPkEf4uKbCPr7297EA+AXXw
 ZrNduNQAQMuAsejDx4LElpuP6pp9V1vNMZohXvCSPSf4Q+8Txx4WZe3wOpaxJ32Ct1E2
 cBVzpBI5sIMQWyhrumTYptTF8IZzM84gQtnG3QAXVWqzu3MnBgF+KZQ3kFY9m1HYaUS9
 ky8/Df2Osxvl/QqwCqfdUd2jGMJmn8+s3Kcxxx3wBwi3vIck/DXUD2zBkKoW2pvGqRN9
 1aiw==
X-Gm-Message-State: AOAM5315NZ9kyy2C2/n2o7/rZd64tn77//4c6p3h4g3W83ydTFLyvV3A
 cdoLSsAfLdyo7RcVFoyV1dfIFVoeie83kVhNw22lgw==
X-Google-Smtp-Source: ABdhPJwpHVFFfNsNEJQjjXOrekdaw6W920ax+NqkoBiqGmYNq7riq0+l7ibMrdbbah0/TPuc2Gx9S/dWe205YMT47RI=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr50564976oto.135.1594372147592; 
 Fri, 10 Jul 2020 02:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200708141856.15776-1-eric.auger@redhat.com>
 <20200708141856.15776-9-eric.auger@redhat.com>
In-Reply-To: <20200708141856.15776-9-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 10:08:56 +0100
Message-ID: <CAFEAcA-2MyyVmfTPKUH7NBXEkMokaNGnbhK+v9MB2kL1UP+tpw@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] hw/arm/smmuv3: Fix IIDR offset
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
> The SMMU IIDR register is at 0x018 offset.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Fixes: 10a83cb9887 ("hw/arm/smmuv3: Skeleton")
> ---
>  hw/arm/smmuv3-internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 5babf72f7d..ef093eaff5 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -63,7 +63,7 @@ REG32(IDR5,                0x14)
>
>  #define SMMU_IDR5_OAS 4
>
> -REG32(IIDR,                0x1c)
> +REG32(IIDR,                0x18)
>  REG32(CR0,                 0x20)
>      FIELD(CR0, SMMU_ENABLE,   0, 1)
>      FIELD(CR0, EVENTQEN,      2, 1)
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

