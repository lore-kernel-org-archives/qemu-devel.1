Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A82EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E542072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E542072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihQKM-0003nT-2z
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 22:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1ihQIx-0002cC-Q6
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1ihQIw-0005cq-8Z
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:47:19 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59690 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1ihQIl-00051v-52; Tue, 17 Dec 2019 22:47:09 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 6ABE29A27480C7A027BF;
 Wed, 18 Dec 2019 11:46:44 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Dec 2019
 11:46:36 +0800
Subject: Re: [kvm-unit-tests PATCH 05/16] arm/arm64: ITS: Introspection tests
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20191216140235.10751-1-eric.auger@redhat.com>
 <20191216140235.10751-6-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <c133ebe6-10f4-2ff7-f75f-75b755397785@huawei.com>
Date: Wed, 18 Dec 2019 11:46:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191216140235.10751-6-eric.auger@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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

I have to admit that this is the first time I've looked into
the kvm-unit-tests code, so only some minor comments inline :)

On 2019/12/16 22:02, Eric Auger wrote:
> Detect the presence of an ITS as part of the GICv3 init
> routine, initialize its base address and read few registers
> the IIDR, the TYPER to store its dimensioning parameters.
> 
> This is our first ITS test, belonging to a new "its" group.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

[...]

> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
> new file mode 100644
> index 0000000..2ce483e
> --- /dev/null
> +++ b/lib/arm/asm/gic-v3-its.h
> @@ -0,0 +1,116 @@
> +/*
> + * All ITS* defines are lifted from include/linux/irqchip/arm-gic-v3.h
> + *
> + * Copyright (C) 2016, Red Hat Inc, Andrew Jones <drjones@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.
> + */
> +#ifndef _ASMARM_GIC_V3_ITS_H_
> +#define _ASMARM_GIC_V3_ITS_H_
> +
> +#ifndef __ASSEMBLY__
> +
> +#define GITS_CTLR			0x0000
> +#define GITS_IIDR			0x0004
> +#define GITS_TYPER			0x0008
> +#define GITS_CBASER			0x0080
> +#define GITS_CWRITER			0x0088
> +#define GITS_CREADR			0x0090
> +#define GITS_BASER			0x0100
> +
> +#define GITS_TYPER_PLPIS                (1UL << 0)
> +#define GITS_TYPER_IDBITS_SHIFT         8
> +#define GITS_TYPER_DEVBITS_SHIFT        13
> +#define GITS_TYPER_DEVBITS(r)           ((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
> +#define GITS_TYPER_PTA                  (1UL << 19)
> +#define GITS_TYPER_HWCOLLCNT_SHIFT      24
> +
> +#define GITS_CTLR_ENABLE                (1U << 0)
> +
> +#define GITS_CBASER_VALID                       (1UL << 63)
> +#define GITS_CBASER_SHAREABILITY_SHIFT          (10)
> +#define GITS_CBASER_INNER_CACHEABILITY_SHIFT    (59)
> +#define GITS_CBASER_OUTER_CACHEABILITY_SHIFT    (53)
> +#define GITS_CBASER_SHAREABILITY_MASK                                   \
> +	GIC_BASER_SHAREABILITY(GITS_CBASER, SHAREABILITY_MASK)
> +#define GITS_CBASER_INNER_CACHEABILITY_MASK                             \
> +	GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, MASK)
> +#define GITS_CBASER_OUTER_CACHEABILITY_MASK                             \
> +	GIC_BASER_CACHEABILITY(GITS_CBASER, OUTER, MASK)
> +#define GITS_CBASER_CACHEABILITY_MASK GITS_CBASER_INNER_CACHEABILITY_MASK
> +
> +#define GITS_CBASER_InnerShareable                                      \
> +	GIC_BASER_SHAREABILITY(GITS_CBASER, InnerShareable)
> +
> +#define GITS_CBASER_nCnB        GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, nCnB)
> +#define GITS_CBASER_nC          GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, nC)
> +#define GITS_CBASER_RaWt        GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, RaWt)
> +#define GITS_CBASER_RaWb        GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, RaWt)

s/RaWt/RaWb/

> +#define GITS_CBASER_WaWt        GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, WaWt)
> +#define GITS_CBASER_WaWb        GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, WaWb)
> +#define GITS_CBASER_RaWaWt      GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, RaWaWt)
> +#define GITS_CBASER_RaWaWb      GIC_BASER_CACHEABILITY(GITS_CBASER, INNER, RaWaWb)
> +
> +#define GITS_BASER_NR_REGS              8
> +
> +#define GITS_BASER_VALID                        (1UL << 63)
> +#define GITS_BASER_INDIRECT                     (1ULL << 62)
> +
> +#define GITS_BASER_INNER_CACHEABILITY_SHIFT     (59)
> +#define GITS_BASER_OUTER_CACHEABILITY_SHIFT     (53)
> +#define GITS_BASER_CACHEABILITY_MASK		0x7
> +
> +#define GITS_BASER_nCnB         GIC_BASER_CACHEABILITY(GITS_BASER, INNER, nCnB)
> +
> +#define GITS_BASER_TYPE_SHIFT                   (56)
> +#define GITS_BASER_TYPE(r)              (((r) >> GITS_BASER_TYPE_SHIFT) & 7)
> +#define GITS_BASER_ENTRY_SIZE_SHIFT             (48)
> +#define GITS_BASER_ENTRY_SIZE(r)        ((((r) >> GITS_BASER_ENTRY_SIZE_SHIFT) & 0x1f) + 1)
> +#define GITS_BASER_SHAREABILITY_SHIFT   (10)
> +#define GITS_BASER_InnerShareable                                       \
> +	GIC_BASER_SHAREABILITY(GITS_BASER, InnerShareable)
> +#define GITS_BASER_PAGE_SIZE_SHIFT      (8)
> +#define GITS_BASER_PAGE_SIZE_4K         (0UL << GITS_BASER_PAGE_SIZE_SHIFT)
> +#define GITS_BASER_PAGE_SIZE_16K        (1UL << GITS_BASER_PAGE_SIZE_SHIFT)
> +#define GITS_BASER_PAGE_SIZE_64K        (2UL << GITS_BASER_PAGE_SIZE_SHIFT)
> +#define GITS_BASER_PAGE_SIZE_MASK       (3UL << GITS_BASER_PAGE_SIZE_SHIFT)
> +#define GITS_BASER_PAGES_MAX            256
> +#define GITS_BASER_PAGES_SHIFT          (0)
> +#define GITS_BASER_NR_PAGES(r)          (((r) & 0xff) + 1)
> +#define GITS_BASER_PHYS_ADDR_MASK	0xFFFFFFFFF000
> +
> +#define GITS_BASER_TYPE_NONE            0
> +#define GITS_BASER_TYPE_DEVICE          1
> +#define GITS_BASER_TYPE_VCPU            2
> +#define GITS_BASER_TYPE_CPU             3

'3' is one of the reserved values of the GITS_BASER.Type field, and
what do we expect with a "GITS_BASER_TYPE_CPU" table type? ;-)

I think we can copy (and might update in the future) all these
macros against the latest Linux kernel.

> +#define GITS_BASER_TYPE_COLLECTION      4
> +
> +#define ITS_FLAGS_CMDQ_NEEDS_FLUSHING           (1ULL << 0) > +
> +struct its_typer {
> +	unsigned int ite_size;
> +	unsigned int eventid_bits;
> +	unsigned int deviceid_bits;
> +	unsigned int collid_bits;
> +	unsigned int hw_collections;
> +	bool pta;
> +	bool cil;
> +	bool cct;
> +	bool phys_lpi;
> +	bool virt_lpi;
> +};
> +
> +struct its_data {
> +	void *base;
> +	struct its_typer typer;
> +};
> +
> +extern struct its_data its_data;
> +
> +#define gicv3_its_base()		(its_data.base)
> +
> +extern void its_parse_typer(void);
> +extern void its_init(void);
> +
> +#endif /* !__ASSEMBLY__ */
> +#endif /* _ASMARM_GIC_V3_ITS_H_ */
> diff --git a/lib/arm/asm/gic.h b/lib/arm/asm/gic.h
> index 55dd84b..b44da9c 100644
> --- a/lib/arm/asm/gic.h
> +++ b/lib/arm/asm/gic.h
> @@ -40,6 +40,7 @@
>   
>   #include <asm/gic-v2.h>
>   #include <asm/gic-v3.h>
> +#include <asm/gic-v3-its.h>
>   
>   #define PPI(irq)			((irq) + 16)
>   #define SPI(irq)			((irq) + GIC_FIRST_SPI)
> diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
> new file mode 100644
> index 0000000..34f4d0e
> --- /dev/null
> +++ b/lib/arm/gic-v3-its.c
> @@ -0,0 +1,41 @@
> +/*
> + * Copyright (C) 2016, Red Hat Inc, Eric Auger <eric.auger@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.
> + */
> +#include <asm/gic.h>
> +
> +struct its_data its_data;
> +
> +void its_parse_typer(void)
> +{
> +	u64 typer = readq(gicv3_its_base() + GITS_TYPER);
> +
> +	its_data.typer.ite_size = ((typer >> 4) & 0xf) + 1;
> +	its_data.typer.pta = typer & GITS_TYPER_PTA;
> +	its_data.typer.eventid_bits =
> +		((typer >> GITS_TYPER_IDBITS_SHIFT) & 0x1f) + 1;
> +	its_data.typer.deviceid_bits = GITS_TYPER_DEVBITS(typer) + 1;

No need to '+1'. As GITS_TYPER_DEVBITS already helps us to calculate
the implemented DeviceID bits.

> +
> +	its_data.typer.cil = (typer >> 36) & 0x1;
> +	if (its_data.typer.cil)
> +		its_data.typer.collid_bits = ((typer >> 32) & 0xf) + 1;
> +	else
> +		its_data.typer.collid_bits = 16;
> +
> +	its_data.typer.hw_collections =
> +		(typer >> GITS_TYPER_HWCOLLCNT_SHIFT) & 0xff;
> +
> +	its_data.typer.cct = typer & 0x4;
> +	its_data.typer.virt_lpi = typer & 0x2;
> +	its_data.typer.phys_lpi = typer & GITS_TYPER_PLPIS;

Personally, mix using of GITS_TYPER_* macros and some magic constants to
parse the TYPER makes it a bit difficult to review the code. Maybe we
can have more such kinds of macros in the header file and get rid of all
hardcoded numbers?


Thanks,
Zenghui


