Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE26C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696BA20720
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696BA20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsTsF-0002UC-Gb
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robin.murphy@arm.com>)
 id 1jsTp0-0001j0-9l; Mon, 06 Jul 2020 12:18:22 -0400
Received: from foss.arm.com ([217.140.110.172]:46000)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robin.murphy@arm.com>)
 id 1jsTox-0006LI-Sx; Mon, 06 Jul 2020 12:18:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B49C21FB;
 Mon,  6 Jul 2020 09:18:16 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF3B23F68F;
 Mon,  6 Jul 2020 09:18:14 -0700 (PDT)
Subject: Re: [PATCH v2 9/9] hw/arm/smmuv3: Advertise SMMUv3.2 range
 invalidation
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 peterx@redhat.com
References: <20200702152659.8522-1-eric.auger@redhat.com>
 <20200702152659.8522-10-eric.auger@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <10bafac8-a230-c545-662c-bcbd9f3902dc@arm.com>
Date: Mon, 6 Jul 2020 17:18:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702152659.8522-10-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=robin.murphy@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 12:18:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: jean-philippe@linaro.org, robh@kernel.org, mst@redhat.com,
 zhangfei.gao@foxmail.com, shameerali.kolothum.thodi@huawei.com,
 will@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-07-02 16:26, Eric Auger wrote:
> Expose the RIL bit so that the guest driver uses range
> invalidation.

Hmm, this is a v3.2 feature... so strictly, in order to advertise it you 
would need to claim at least v3.1 in SMMU_AIDR and implement all the 
mandatory v3.1 behaviour ;)

Robin.

> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/smmuv3-internal.h | 1 +
>   hw/arm/smmuv3.c          | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 5babf72f7d..4e7ec252ed 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -54,6 +54,7 @@ REG32(IDR1,                0x4)
>   
>   REG32(IDR2,                0x8)
>   REG32(IDR3,                0xc)
> +    FIELD(IDR3, RIL,          10, 1);
>   REG32(IDR4,                0x10)
>   REG32(IDR5,                0x14)
>        FIELD(IDR5, OAS,         0, 3);
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 89ab11fc36..add4ba4543 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -254,6 +254,8 @@ static void smmuv3_init_regs(SMMUv3State *s)
>       s->idr[1] = FIELD_DP32(s->idr[1], IDR1, EVENTQS, SMMU_EVENTQS);
>       s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
>   
> +    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
> +
>      /* 4K and 64K granule support */
>       s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
>       s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
> 

