Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DE1C3F68F
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188DB22527
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188DB22527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iziGF-000695-Ab
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1iziFU-0005b1-Fj
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1iziFT-000378-GF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:35:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2698 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1iziFQ-0002fb-Oh; Thu, 06 Feb 2020 09:35:17 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D4F307895B7640D4A8E2;
 Thu,  6 Feb 2020 22:35:08 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Feb 2020
 22:35:02 +0800
Subject: Re: [kvm-unit-tests PATCH v3 04/14] arm/arm64: gicv3: Add some
 re-distributor defines
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20200128103459.19413-1-eric.auger@redhat.com>
 <20200128103459.19413-5-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <22a3b0f5-febd-f9e0-4404-7b01643e57b1@huawei.com>
Date: Thu, 6 Feb 2020 22:35:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200128103459.19413-5-eric.auger@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: andre.przywara@arm.com, drjones@redhat.com, alexandru.elisei@arm.com,
 thuth@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On 2020/1/28 18:34, Eric Auger wrote:
> PROPBASER, PENDBASE and GICR_CTRL will be used for LPI management.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   lib/arm/asm/gic-v3.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
> index 6beeab6..ffb2e26 100644
> --- a/lib/arm/asm/gic-v3.h
> +++ b/lib/arm/asm/gic-v3.h
> @@ -18,6 +18,7 @@
>    * We expect to be run in Non-secure mode, thus we define the
>    * group1 enable bits with respect to that view.
>    */
> +#define GICD_CTLR			0x0000
>   #define GICD_CTLR_RWP			(1U << 31)
>   #define GICD_CTLR_ARE_NS		(1U << 4)
>   #define GICD_CTLR_ENABLE_G1A		(1U << 1)
> @@ -36,6 +37,11 @@
>   #define GICR_ICENABLER0			GICD_ICENABLER
>   #define GICR_IPRIORITYR0		GICD_IPRIORITYR
>   
> +#define GICR_PROPBASER                  0x0070
> +#define GICR_PENDBASER                  0x0078

nit: we'd better use tab instead of space.

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

> +#define GICR_CTLR			GICD_CTLR
> +#define GICR_CTLR_ENABLE_LPIS		(1UL << 0)
> +
>   #define ICC_SGI1R_AFFINITY_1_SHIFT	16
>   #define ICC_SGI1R_AFFINITY_2_SHIFT	32
>   #define ICC_SGI1R_AFFINITY_3_SHIFT	48
> 


