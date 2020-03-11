Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AE5C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCAB02192A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAB02192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBv5e-0005ek-37
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1jBv4y-00058n-MN
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1jBv4x-0001Bw-ES
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:42:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3272 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1jBv4u-00016N-B2; Wed, 11 Mar 2020 02:42:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id EC7167B4F0923BCCC96B;
 Wed, 11 Mar 2020 14:42:45 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Mar 2020
 14:42:39 +0800
Subject: Re: [kvm-unit-tests PATCH v5 05/13] arm/arm64: gicv3: Set the LPI
 config and pending tables
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20200310145410.26308-1-eric.auger@redhat.com>
 <20200310145410.26308-6-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <cd3bab7d-a585-b091-621c-0ae712b82b3c@huawei.com>
Date: Wed, 11 Mar 2020 14:42:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200310145410.26308-6-eric.auger@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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

On 2020/3/10 22:54, Eric Auger wrote:
> Allocate the LPI configuration and per re-distributor pending table.
> Set redistributor's PROPBASER and PENDBASER. The LPIs are enabled
> by default in the config table.
> 
> Also introduce a helper routine that allows to set the pending table
> bit for a given LPI.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v4 -> v5:
> - Moved some reformattings previously done in
>    "arm/arm64: ITS: its_enable_defaults", in this patch
> - added assert(!gicv3_redist_base()) in gicv3_lpi_alloc_tables()
> - revert for_each_present_cpu() change
> 
> v2 -> v3:
> - Move the helpers in lib/arm/gic-v3.c and prefix them with "gicv3_"
>    and add _lpi prefix too
> 
> v1 -> v2:
> - remove memory attributes
> ---
>   lib/arm/asm/gic-v3.h | 15 +++++++++++++
>   lib/arm/gic-v3.c     | 53 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 68 insertions(+)
> 
> diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
> index 47df051..064cc68 100644
> --- a/lib/arm/asm/gic-v3.h
> +++ b/lib/arm/asm/gic-v3.h
> @@ -50,6 +50,15 @@
>   #define MPIDR_TO_SGI_AFFINITY(cluster_id, level) \
>   	(MPIDR_AFFINITY_LEVEL(cluster_id, level) << ICC_SGI1R_AFFINITY_## level ## _SHIFT)
>   
> +#define GICR_PROPBASER_IDBITS_MASK	(0x1f)

Again this can be dropped, but not a problem.

> +
> +#define GICR_PENDBASER_PTZ		BIT_ULL(62)
> +
> +#define LPI_PROP_GROUP1			(1 << 1)
> +#define LPI_PROP_ENABLED		(1 << 0)
> +#define LPI_PROP_DEFAULT_PRIO		0xa0
> +#define LPI_PROP_DEFAULT		(LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1 | LPI_PROP_ENABLED)
> +
>   #include <asm/arch_gicv3.h>
>   
>   #ifndef __ASSEMBLY__
> @@ -66,6 +75,8 @@ struct gicv3_data {
>   	void *dist_base;
>   	void *redist_bases[GICV3_NR_REDISTS];
>   	void *redist_base[NR_CPUS];
> +	u8 *lpi_prop;
> +	void *lpi_pend[NR_CPUS];
>   	unsigned int irq_nr;
>   };
>   extern struct gicv3_data gicv3_data;
> @@ -82,6 +93,10 @@ extern void gicv3_write_eoir(u32 irqstat);
>   extern void gicv3_ipi_send_single(int irq, int cpu);
>   extern void gicv3_ipi_send_mask(int irq, const cpumask_t *dest);
>   extern void gicv3_set_redist_base(size_t stride);
> +extern void gicv3_lpi_set_config(int n, u8 val);
> +extern u8 gicv3_lpi_get_config(int n);

These two declarations can be dropped, and I think it's better to
move their macro implementations here (they're now in patch #7).
But also not a problem.

> +extern void gicv3_lpi_set_clr_pending(int rdist, int n, bool set);
> +extern void gicv3_lpi_alloc_tables(void);
>   
>   static inline void gicv3_do_wait_for_rwp(void *base)
>   {
> diff --git a/lib/arm/gic-v3.c b/lib/arm/gic-v3.c
> index feecb5e..d752bd4 100644
> --- a/lib/arm/gic-v3.c
> +++ b/lib/arm/gic-v3.c
> @@ -5,6 +5,7 @@
>    */
>   #include <asm/gic.h>
>   #include <asm/io.h>
> +#include <alloc_page.h>
>   
>   void gicv3_set_redist_base(size_t stride)
>   {
> @@ -147,3 +148,55 @@ void gicv3_ipi_send_single(int irq, int cpu)
>   	cpumask_set_cpu(cpu, &dest);
>   	gicv3_ipi_send_mask(irq, &dest);
>   }
> +
> +#if defined(__aarch64__)
> +
> +/*
> + * alloc_lpi_tables - Allocate LPI config and pending tables
> + * and set PROPBASER (shared by all rdistributors) and per
> + * redistributor PENDBASER.
> + *
> + * gicv3_set_redist_base() must be called before
> + */
> +void gicv3_lpi_alloc_tables(void)
> +{
> +	unsigned long n = SZ_64K >> PAGE_SHIFT;
> +	unsigned long order = fls(n);
> +	u64 prop_val;
> +	int cpu;
> +
> +	assert(!gicv3_redist_base());

I guess you wanted assert(gicv3_redist_base())? With this confirmed,

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>


Thanks

> +
> +	gicv3_data.lpi_prop = alloc_pages(order);
> +
> +	/* ID bits = 13, ie. up to 14b LPI INTID */
> +	prop_val = (u64)(virt_to_phys(gicv3_data.lpi_prop)) | 13;
> +
> +	for_each_present_cpu(cpu) {
> +		u64 pend_val;
> +		void *ptr;
> +
> +		ptr = gicv3_data.redist_base[cpu];
> +
> +		writeq(prop_val, ptr + GICR_PROPBASER);
> +
> +		gicv3_data.lpi_pend[cpu] = alloc_pages(order);
> +		pend_val = (u64)(virt_to_phys(gicv3_data.lpi_pend[cpu]));
> +		writeq(pend_val, ptr + GICR_PENDBASER);
> +	}
> +}
> +
> +void gicv3_lpi_set_clr_pending(int rdist, int n, bool set)
> +{
> +	u8 *ptr = gicv3_data.lpi_pend[rdist];
> +	u8 mask = 1 << (n % 8), byte;
> +
> +	ptr += (n / 8);
> +	byte = *ptr;
> +	if (set)
> +		byte |=  mask;
> +	else
> +		byte &= ~mask;
> +	*ptr = byte;
> +}
> +#endif /* __aarch64__ */
> 


