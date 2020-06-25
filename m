Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4CFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549C0208C9
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbdgHb55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549C0208C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUQT-0006P3-Km
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joTto-0004ip-Pf
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:34:48 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joTtl-0004ed-Sm
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:34:48 -0400
Received: by mail-oi1-x244.google.com with SMTP id l63so5291428oih.13
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eIx4b9nqclWsVVEQtsc7PEI14eNY0OylDfgl0jr6N+o=;
 b=CbdgHb555xsXFY5UWwnXn6lKmeKjA1ZuREZdNIduU6dv9W74Or0kOnVxcK5AWdf5Y8
 POOkAfQrCr/HaMSo1EdOtnN2NIU5wiYghWHUVGcVBilfEfVVJ3MNsafXMj46NnwjyAkC
 53m1amDRyClkRiecb0stFaIx4MiBdV1uhH+EIYQgDrLnzJyBoYW2G9SmR7lPR25WHmov
 q3Wjg+Aen9OWwvMdCQewqeSLbriEyY2KS0B3+ULhVzLpjvCIbK4dIti84CWwTK9sbZDq
 cydQTAkZXscaOckJW+1whY0xRGYF/FTqpTp7iLx8FlO7yERM1/PJY6AsNSAmKxpCU0BT
 XDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eIx4b9nqclWsVVEQtsc7PEI14eNY0OylDfgl0jr6N+o=;
 b=I/0SEsBGhvvZQYCe8L549w8mi/bFoApFu4Rbh8vLH4wz9mD5GNG1MdWHY+OAeBp3oZ
 oivZ+LqoefCRor8TbC0UBNCuoBKINmZwFwY7YkBWjRvD6MuUheZ/1uINpFQDL9AXOF1a
 u41kaBxpZWSNzmco7xnSNH+j2U9irc+eLsF6hX/2n8EAV8tL0gZAeq1oKz5tfczuvmMc
 B/gasYj3327o5iMud5jK8hSDSh+1H/igkwW7biFKFnIKeG7Ae9CP2imutYQi+UeY0LxZ
 4ZrQQJkAH210WfNGCOl1df9yqcmzmF5KhqXQweSSq24F8l5N+3MKBs+WLb0nnvkff8Ob
 yPmQ==
X-Gm-Message-State: AOAM531A5j1pyF2GN/63jF4R/BBtqqAcU3oUQz1tiJ2vpjYwZGZgn6Re
 Qq/dVJhNHsh6Bcled6kFqjnHSvd5MsrP6PcVjuLDYA==
X-Google-Smtp-Source: ABdhPJxSlEFHkwj/qGX24FqBRHIexIpzb38mixeneEuipSeigHBSgdja/AWLAtyTmvNkLPhOlclYpX6G/7uS/7PfmcU=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr2722313oia.163.1593099284476; 
 Thu, 25 Jun 2020 08:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200611161500.23580-1-eric.auger@redhat.com>
 <20200611161500.23580-8-eric.auger@redhat.com>
In-Reply-To: <20200611161500.23580-8-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 16:34:33 +0100
Message-ID: <CAFEAcA9W9XA6SA1XGnMxC4A91S65K1DRxPeV_VZ_N73iE31wKg@mail.gmail.com>
Subject: Re: [PATCH RESEND 7/9] hw/arm/smmuv3: Introduce
 smmuv3_s1_range_inval() helper
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
> Let's introduce an helper for S1 IOVA range invalidation.
> This will be used for NH_VA and NH_VAA commands. It decodes
> the same fields, trace, calls the UNMAP notifiers and
> invalidate the corresponding IOTLB entries.
>
> At the moment, we do not support 3.2 range invalidation yet.
> So it reduces to a single IOVA invalidation.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3.c     | 36 +++++++++++++++++-------------------
>  hw/arm/trace-events |  3 +--
>  2 files changed, 18 insertions(+), 21 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 931a2b6872..4eda16be7b 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -840,6 +840,22 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova)
>      }
>  }
>
> +static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
> +{
> +    dma_addr_t addr = CMD_ADDR(cmd);
> +    uint8_t type = CMD_TYPE(cmd);
> +    uint16_t vmid = CMD_VMID(cmd);
> +    bool leaf = CMD_LEAF(cmd);

We used to only read the leaf bit for
CMD_TLBI_NH_VA, but now we read it also for
CMD_TLBI_NH_VAA. That's OK because:
 * the leaf bit really does exist on  both commands
 * the only thing we do with it is print it in the trace
   message, so this isn't fixing a bug

But you could mention it in the commit message.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

