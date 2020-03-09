Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EADAC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3909620675
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTokeT7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3909620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBGcg-0008LQ-Cr
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 07:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jBGZo-0003RY-Uf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1jBGZm-0007mp-Bq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:28:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21231
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1jBGZm-0007ln-71
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583753280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXvdMJEgW8utCn7FonEpgPrYzs7ym8h0kN9CF9LzEks=;
 b=JTokeT7KtOy+cVUGRP1YI4a10OKWBua8eWkMi4iCiE2x6rAZnTj73d6rQfDYvVjVH9AzLi
 nZHQbnN7MwLcEShY2xNkcEGmzcJJwXHHkEklHykFf+ZHN+Cda5oHpZzRjqzakceyUOTJnC
 JC+sFQa3fwqFGCBNSliQ7DSBISDwJHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-QqAxODeTNq2CiixcGg8blg-1; Mon, 09 Mar 2020 07:27:58 -0400
X-MC-Unique: QqAxODeTNq2CiixcGg8blg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD7408017CC;
 Mon,  9 Mar 2020 11:27:56 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31C031001DC2;
 Mon,  9 Mar 2020 11:27:51 +0000 (UTC)
Date: Mon, 9 Mar 2020 12:27:49 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 07/13] arm/arm64: ITS:
 its_enable_defaults
Message-ID: <20200309112749.jeatdhajxqght7so@kamzik.brq.redhat.com>
References: <20200309102420.24498-1-eric.auger@redhat.com>
 <20200309102420.24498-8-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309102420.24498-8-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, yuzenghui@huawei.com, alexandru.elisei@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 11:24:14AM +0100, Eric Auger wrote:
> its_enable_defaults() enable LPIs at distributor level
> and ITS level.
> 
> gicv3_enable_defaults must be called before.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v3 -> v4:
> - use GITS_BASER_INDIRECT & GITS_BASER_VALID in its_setup_baser()
> - don't parse BASERs again in its_enable_defaults
> - rename its_setup_baser into its_baser_alloc_table
> - All allocations moved to the init function
> - squashed "arm/arm64: gicv3: Enable/Disable LPIs at re-distributor level"
>   into this patch
> - introduce gicv3_lpi_rdist_enable and gicv3_lpi_rdist_disable
> - pend and prop table bases stored as virt addresses
> - move some init functions from enable() to its_init
> - removed GICR_PROPBASER_IDBITS_MASK
> - introduced LPI_OFFSET
> - lpi_prop becomes u8 *
> - gicv3_lpi_set_config/get_config became macro
> - renamed gicv3_lpi_set_pending_table_bit into gicv3_lpi_set_clr_pending
> 
> v2 -> v3:
> - introduce its_setup_baser in this patch
> - squash "arm/arm64: ITS: Init the command queue" in this patch.
> ---
>  lib/arm/asm/gic-v3.h       | 28 +++++++++++------
>  lib/arm/gic-v3.c           | 64 ++++++++++++++++++++++----------------
>  lib/arm64/asm/gic-v3-its.h |  1 +
>  lib/arm64/gic-v3-its.c     | 16 ++++++++--
>  4 files changed, 71 insertions(+), 38 deletions(-)
> 
> diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
> index 12134ef..ea9ae8e 100644
> --- a/lib/arm/asm/gic-v3.h
> +++ b/lib/arm/asm/gic-v3.h
> @@ -50,15 +50,16 @@
>  #define MPIDR_TO_SGI_AFFINITY(cluster_id, level) \
>  	(MPIDR_AFFINITY_LEVEL(cluster_id, level) << ICC_SGI1R_AFFINITY_## level ## _SHIFT)
>  
> -#define GICR_PROPBASER_IDBITS_MASK                      (0x1f)
> +#define GICR_PENDBASER_PTZ		BIT_ULL(62)
>  
> -#define GICR_PENDBASER_PTZ                              BIT_ULL(62)
> +#define LPI_PROP_GROUP1			(1 << 1)
> +#define LPI_PROP_ENABLED		(1 << 0)
> +#define LPI_PROP_DEFAULT_PRIO		0xa0
> +#define LPI_PROP_DEFAULT		(LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1 | LPI_PROP_ENABLED)
>  
> -#define LPI_PROP_GROUP1		(1 << 1)
> -#define LPI_PROP_ENABLED	(1 << 0)
> -#define LPI_PROP_DEFAULT_PRIO   0xa0
> -#define LPI_PROP_DEFAULT	(LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1 | \
> -				 LPI_PROP_ENABLED)

This reformatting should be squashed into 5/13.

> +#define LPI_ID_BASE			8192
> +#define LPI(lpi)			((lpi) + LPI_ID_BASE)
> +#define LPI_OFFSET(intid)		((intid) - LPI_ID_BASE)
>  
>  #include <asm/arch_gicv3.h>
>  
> @@ -76,7 +77,7 @@ struct gicv3_data {
>  	void *dist_base;
>  	void *redist_bases[GICV3_NR_REDISTS];
>  	void *redist_base[NR_CPUS];
> -	void *lpi_prop;
> +	u8 *lpi_prop;
>  	void *lpi_pend[NR_CPUS];
>  	unsigned int irq_nr;
>  };
> @@ -96,8 +97,10 @@ extern void gicv3_ipi_send_mask(int irq, const cpumask_t *dest);
>  extern void gicv3_set_redist_base(size_t stride);
>  extern void gicv3_lpi_set_config(int n, u8 val);
>  extern u8 gicv3_lpi_get_config(int n);
> -extern void gicv3_lpi_set_pending_table_bit(int rdist, int n, bool set);
> +extern void gicv3_lpi_set_clr_pending(int rdist, int n, bool set);
>  extern void gicv3_lpi_alloc_tables(void);
> +extern void gicv3_lpi_rdist_enable(int redist);
> +extern void gicv3_lpi_rdist_disable(int redist);
>  
>  static inline void gicv3_do_wait_for_rwp(void *base)
>  {
> @@ -143,5 +146,12 @@ static inline u64 mpidr_uncompress(u32 compressed)
>  	return mpidr;
>  }
>  
> +#define gicv3_lpi_set_config(intid, value) ({		\
> +	gicv3_data.lpi_prop[LPI_OFFSET(intid)] = value; \
> +})
> +
> +#define gicv3_lpi_get_config(intid) (gicv3_data.lpi_prop[LPI_OFFSET(intid)])
> +
> +
>  #endif /* !__ASSEMBLY__ */
>  #endif /* _ASMARM_GIC_V3_H_ */
> diff --git a/lib/arm/gic-v3.c b/lib/arm/gic-v3.c
> index 949a986..a3b55b2 100644
> --- a/lib/arm/gic-v3.c
> +++ b/lib/arm/gic-v3.c
> @@ -150,7 +150,14 @@ void gicv3_ipi_send_single(int irq, int cpu)
>  }
>  
>  #if defined(__aarch64__)
> -/* alloc_lpi_tables: Allocate LPI config and pending tables */
> +
> +/**

*

> + * alloc_lpi_tables - Allocate LPI config and pending tables
> + * and set PROPBASER (shared by all rdistributors) and per
> + * redistributor PENDBASER.
> + *
> + * gicv3_set_redist_base() must be called before

How about asserting gicv3_redist_base() isn't NULL?

> + */
>  void gicv3_lpi_alloc_tables(void)
>  {
>  	unsigned long n = SZ_64K >> PAGE_SHIFT;
> @@ -161,13 +168,9 @@ void gicv3_lpi_alloc_tables(void)
>  	gicv3_data.lpi_prop = alloc_pages(order);
>  
>  	/* ID bits = 13, ie. up to 14b LPI INTID */
> -	prop_val = (u64)virt_to_phys(gicv3_data.lpi_prop) | 13;
> +	prop_val = (u64)(virt_to_phys(gicv3_data.lpi_prop)) | 13;
>  
> -	/*
> -	 * Allocate pending tables for each redistributor
> -	 * and set PROPBASER and PENDBASER
> -	 */
> -	for_each_present_cpu(cpu) {
> +	for (cpu = 0; cpu < nr_cpus; cpu++) {
>  		u64 pend_val;
>  		void *ptr;
>  
> @@ -176,30 +179,14 @@ void gicv3_lpi_alloc_tables(void)
>  		writeq(prop_val, ptr + GICR_PROPBASER);
>  
>  		gicv3_data.lpi_pend[cpu] = alloc_pages(order);
> -
> -		pend_val = (u64)virt_to_phys(gicv3_data.lpi_pend[cpu]);
> -
> +		pend_val = (u64)(virt_to_phys(gicv3_data.lpi_pend[cpu]));
>  		writeq(pend_val, ptr + GICR_PENDBASER);
>  	}
>  }
>  
> -void gicv3_lpi_set_config(int n, u8 value)
> +void gicv3_lpi_set_clr_pending(int rdist, int n, bool set)
>  {
> -	u8 *entry = (u8 *)(gicv3_data.lpi_prop + (n - 8192));
> -
> -	*entry = value;
> -}
> -
> -u8 gicv3_lpi_get_config(int n)
> -{
> -	u8 *entry = (u8 *)(gicv3_data.lpi_prop + (n - 8192));
> -
> -	return *entry;
> -}
> -
> -void gicv3_lpi_set_pending_table_bit(int rdist, int n, bool set)
> -{
> -	u8 *ptr = phys_to_virt((phys_addr_t)gicv3_data.lpi_pend[rdist]);
> +	u8 *ptr = gicv3_data.lpi_pend[rdist];
>  	u8 mask = 1 << (n % 8), byte;
>  
>  	ptr += (n / 8);
> @@ -210,4 +197,29 @@ void gicv3_lpi_set_pending_table_bit(int rdist, int n, bool set)
>  		byte &= ~mask;
>  	*ptr = byte;
>  }
> +
> +static void gicv3_lpi_rdist_ctrl(u32 redist, bool set)
> +{
> +	void *ptr;
> +	u64 val;
> +
> +	assert(redist < nr_cpus);
> +
> +	ptr = gicv3_data.redist_base[redist];
> +	val = readl(ptr + GICR_CTLR);
> +	if (set)
> +		val |= GICR_CTLR_ENABLE_LPIS;
> +	else
> +		val &= ~GICR_CTLR_ENABLE_LPIS;
> +	writel(val,  ptr + GICR_CTLR);
> +}
> +
> +void gicv3_lpi_rdist_enable(int redist)
> +{
> +	gicv3_lpi_rdist_ctrl(redist, true);
> +}
> +void gicv3_lpi_rdist_disable(int redist)
> +{
> +	gicv3_lpi_rdist_ctrl(redist, false);
> +}
>  #endif /* __aarch64__ */
> diff --git a/lib/arm64/asm/gic-v3-its.h b/lib/arm64/asm/gic-v3-its.h
> index 331ba0e..1e95977 100644
> --- a/lib/arm64/asm/gic-v3-its.h
> +++ b/lib/arm64/asm/gic-v3-its.h
> @@ -88,5 +88,6 @@ extern struct its_data its_data;
>  extern void its_parse_typer(void);
>  extern void its_init(void);
>  extern int its_baser_lookup(int i, struct its_baser *baser);
> +extern void its_enable_defaults(void);
>  
>  #endif /* _ASMARM64_GIC_V3_ITS_H_ */
> diff --git a/lib/arm64/gic-v3-its.c b/lib/arm64/gic-v3-its.c
> index 23b0d06..2f480ae 100644
> --- a/lib/arm64/gic-v3-its.c
> +++ b/lib/arm64/gic-v3-its.c
> @@ -94,9 +94,19 @@ void its_init(void)
>  	its_baser_alloc_table(&its_data.device_baser, SZ_64K);
>  	its_baser_alloc_table(&its_data.coll_baser, SZ_64K);
>  
> -	/* Allocate LPI config and pending tables */
> -	gicv3_lpi_alloc_tables();
> -
>  	its_cmd_queue_init();
>  }
>  
> +/* must be called after gicv3_enable_defaults */
> +void its_enable_defaults(void)
> +{
> +	int i;
> +
> +	/* Allocate LPI config and pending tables */
> +	gicv3_lpi_alloc_tables();
> +
> +	for (i = 0; i < nr_cpus; i++)
> +		gicv3_lpi_rdist_enable(i);
> +
> +	writel(GITS_CTLR_ENABLE, its_data.base + GITS_CTLR);
> +}
> -- 
> 2.20.1
> 


