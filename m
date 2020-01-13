Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA57DC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6654D2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNfAJNim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6654D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3Gx-0007oi-EU
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1ir3G0-0006dX-Ve
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1ir3Fy-0004De-PA
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:12:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24587
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ir3Fy-0004CL-L3
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578935521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JTvzr1U9spQQEraqEuMqJVoyZ5jAedmvm2710v5L41c=;
 b=UNfAJNimhcF9zsWYwmYgcXx2MbRIRFC4xTBVmODJYqqIo/qc7E8pjDe4cA46U8qPYM4+cM
 R0Yj2TBv+dKIkt74vIl1blrDRwgWkOMCG2Dn/wkyw5hk/Yfuy7rgC9qH6wWDyUUS5oHIzW
 zGPeC9JqyPw0osy0ZAu7ZazzeKJMou0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-N30PB-G3MI628e9mpuRupQ-1; Mon, 13 Jan 2020 12:11:57 -0500
X-MC-Unique: N30PB-G3MI628e9mpuRupQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25A4280268E;
 Mon, 13 Jan 2020 17:11:55 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A6F119C5B;
 Mon, 13 Jan 2020 17:11:49 +0000 (UTC)
Date: Mon, 13 Jan 2020 18:11:47 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 05/16] arm/arm64: ITS: Introspection
 tests
Message-ID: <20200113171147.j6c5zaz5nmkx3uws@kamzik.brq.redhat.com>
References: <20200110145412.14937-1-eric.auger@redhat.com>
 <20200110145412.14937-6-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110145412.14937-6-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Fri, Jan 10, 2020 at 03:54:01PM +0100, Eric Auger wrote:
> Detect the presence of an ITS as part of the GICv3 init
> routine, initialize its base address and read few registers
> the IIDR, the TYPER to store its dimensioning parameters.
> 
> This is our first ITS test, belonging to a new "its" group.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - clean GITS_TYPER macros and unused fields in typer struct
> - remove memory attribute related macros
> ---
>  arm/Makefile.common        |  1 +
>  arm/gic.c                  | 34 ++++++++++++++++
>  arm/unittests.cfg          |  6 +++
>  lib/arm/asm/gic-v3-its.h   | 81 ++++++++++++++++++++++++++++++++++++++
>  lib/arm/asm/gic.h          |  1 +
>  lib/arm/gic-v3-its.c       | 39 ++++++++++++++++++
>  lib/arm/gic.c              | 31 ++++++++++++---
>  lib/arm64/asm/gic-v3-its.h |  1 +
>  8 files changed, 189 insertions(+), 5 deletions(-)
>  create mode 100644 lib/arm/asm/gic-v3-its.h
>  create mode 100644 lib/arm/gic-v3-its.c
>  create mode 100644 lib/arm64/asm/gic-v3-its.h
> 
> diff --git a/arm/Makefile.common b/arm/Makefile.common
> index b8988f2..1aae5a3 100644
> --- a/arm/Makefile.common
> +++ b/arm/Makefile.common
> @@ -52,6 +52,7 @@ cflatobjs += lib/arm/psci.o
>  cflatobjs += lib/arm/smp.o
>  cflatobjs += lib/arm/delay.o
>  cflatobjs += lib/arm/gic.o lib/arm/gic-v2.o lib/arm/gic-v3.o
> +cflatobjs += lib/arm/gic-v3-its.o
>  
>  OBJDIRS += lib/arm
>  
> diff --git a/arm/gic.c b/arm/gic.c
> index ba43ae5..adeb981 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -506,6 +506,36 @@ static void gic_test_mmio(void)
>  		test_targets(nr_irqs);
>  }
>  
> +static void test_its_introspection(void)
> +{
> +	struct its_typer *typer = &its_data.typer;
> +
> +	if (!gicv3_its_base()) {
> +		report_skip("No ITS, skip ...");
> +		return;
> +	}
> +
> +	/* IIDR */
> +	report(test_readonly_32(gicv3_its_base() + GITS_IIDR, false),
> +	       "GITS_IIDR is read-only"),
> +
> +	/* TYPER */
> +	report(test_readonly_32(gicv3_its_base() + GITS_TYPER, false),
> +	       "GITS_TYPER is read-only");
> +
> +	report(typer->phys_lpi, "ITS supports physical LPIs");
> +	report_info("vLPI support: %s", typer->virt_lpi ? "yes" : "no");
> +	report_info("ITT entry size = 0x%x", typer->ite_size);
> +	report_info("Bit Count: EventID=%d DeviceId=%d CollId=%d",
> +		    typer->eventid_bits, typer->deviceid_bits,
> +		    typer->collid_bits);
> +	report(typer->eventid_bits && typer->deviceid_bits &&
> +	       typer->collid_bits, "ID spaces");
> +	report(!typer->hw_collections, "collections only in ext memory");
> +	report_info("Target address format %s",
> +			typer->pta ? "Redist basse address" : "PE #");
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	if (!gic_init()) {
> @@ -537,6 +567,10 @@ int main(int argc, char **argv)
>  		report_prefix_push(argv[1]);
>  		gic_test_mmio();
>  		report_prefix_pop();
> +	} else if (strcmp(argv[1], "its-introspection") == 0) {
> +		report_prefix_push(argv[1]);
> +		test_its_introspection();
> +		report_prefix_pop();
>  	} else {
>  		report_abort("Unknown subtest '%s'", argv[1]);
>  	}
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index daeb5a0..bd20460 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -122,6 +122,12 @@ smp = $MAX_SMP
>  extra_params = -machine gic-version=3 -append 'active'
>  groups = gic
>  
> +[its-introspection]
> +file = gic.flat
> +smp = $MAX_SMP
> +extra_params = -machine gic-version=3 -append 'its-introspection'
> +groups = its
> +
>  # Test PSCI emulation
>  [psci]
>  file = psci.flat
> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
> new file mode 100644
> index 0000000..8816d57
> --- /dev/null
> +++ b/lib/arm/asm/gic-v3-its.h
> @@ -0,0 +1,81 @@
> +/*
> + * All ITS* defines are lifted from include/linux/irqchip/arm-gic-v3.h
> + *
> + * Copyright (C) 2016, Red Hat Inc, Andrew Jones <drjones@redhat.com>

I don't recall writing this file. Well, I guess it was four years ago, so
I probably just forgot :-)

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
> +#define GITS_TYPER_PLPIS                BIT(0)
> +#define GITS_TYPER_VLPIS		BIT(1)
> +#define GITS_TYPER_ITT_ENTRY_SIZE	GENMASK_ULL(7, 4)
> +#define GITS_TYPER_ITT_ENTRY_SIZE_SHIFT	4
> +#define GITS_TYPER_IDBITS		GENMASK_ULL(8, 12)
> +#define GITS_TYPER_IDBITS_SHIFT         8
> +#define GITS_TYPER_DEVBITS		GENMASK_ULL(13, 17)
> +#define GITS_TYPER_DEVBITS_SHIFT        13
> +#define GITS_TYPER_PTA                  BIT(19)
> +#define GITS_TYPER_CIDBITS		GENMASK_ULL(32, 35)
> +#define GITS_TYPER_CIDBITS_SHIFT	32
> +#define GITS_TYPER_CIL			BIT(36)
> +
> +#define GITS_CTLR_ENABLE		(1U << 0)
> +
> +#define GITS_CBASER_VALID		(1UL << 63)
> +
> +#define GITS_BASER_NR_REGS              8
> +#define GITS_BASER_VALID		BIT(63)
> +#define GITS_BASER_INDIRECT		BIT(62)
> +#define GITS_BASER_TYPE_SHIFT		(56)
> +#define GITS_BASER_TYPE(r)		(((r) >> GITS_BASER_TYPE_SHIFT) & 7)
> +#define GITS_BASER_ENTRY_SIZE_SHIFT	(48)
> +#define GITS_BASER_ENTRY_SIZE(r)	((((r) >> GITS_BASER_ENTRY_SIZE_SHIFT) & 0x1f) + 1)
> +#define GITS_BASER_PAGE_SIZE_SHIFT	(8)
> +#define GITS_BASER_PAGE_SIZE_4K		(0UL << GITS_BASER_PAGE_SIZE_SHIFT)
> +#define GITS_BASER_PAGE_SIZE_16K	(1UL << GITS_BASER_PAGE_SIZE_SHIFT)
> +#define GITS_BASER_PAGE_SIZE_64K	(2UL << GITS_BASER_PAGE_SIZE_SHIFT)
> +#define GITS_BASER_PAGE_SIZE_MASK	(3UL << GITS_BASER_PAGE_SIZE_SHIFT)
> +#define GITS_BASER_PAGES_MAX		256
> +#define GITS_BASER_PAGES_SHIFT		(0)
> +#define GITS_BASER_NR_PAGES(r)		(((r) & 0xff) + 1)
> +#define GITS_BASER_PHYS_ADDR_MASK	0xFFFFFFFFF000
> +#define GITS_BASER_TYPE_NONE		0
> +#define GITS_BASER_TYPE_DEVICE		1
> +#define GITS_BASER_TYPE_COLLECTION	4
> +
> +struct its_typer {
> +	unsigned int ite_size;
> +	unsigned int eventid_bits;
> +	unsigned int deviceid_bits;
> +	unsigned int collid_bits;
> +	bool pta;
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
>  #include <asm/gic-v2.h>
>  #include <asm/gic-v3.h>
> +#include <asm/gic-v3-its.h>
>  
>  #define PPI(irq)			((irq) + 16)
>  #define SPI(irq)			((irq) + GIC_FIRST_SPI)
> diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
> new file mode 100644
> index 0000000..ce607bb
> --- /dev/null
> +++ b/lib/arm/gic-v3-its.c
> @@ -0,0 +1,39 @@
> +/*
> + * Copyright (C) 2016, Red Hat Inc, Eric Auger <eric.auger@redhat.com>

2016? Time flies...

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
> +	its_data.typer.ite_size = ((typer & GITS_TYPER_ITT_ENTRY_SIZE) >>
> +					GITS_TYPER_ITT_ENTRY_SIZE_SHIFT) + 1;
> +	its_data.typer.pta = typer & GITS_TYPER_PTA;
> +	its_data.typer.eventid_bits = ((typer & GITS_TYPER_IDBITS) >>
> +						GITS_TYPER_IDBITS_SHIFT) + 1;
> +	its_data.typer.deviceid_bits = ((typer & GITS_TYPER_DEVBITS) >>
> +						GITS_TYPER_DEVBITS_SHIFT) + 1;
> +
> +	if (typer & GITS_TYPER_CIL)
> +		its_data.typer.collid_bits = ((typer & GITS_TYPER_CIDBITS) >>
> +						GITS_TYPER_CIDBITS_SHIFT) + 1;
> +	else
> +		its_data.typer.collid_bits = 16;
> +
> +	its_data.typer.virt_lpi = typer & GITS_TYPER_VLPIS;
> +	its_data.typer.phys_lpi = typer & GITS_TYPER_PLPIS;
> +}
> +
> +void its_init(void)
> +{
> +	if (!its_data.base)
> +		return;
> +
> +	its_parse_typer();
> +}
> +
> diff --git a/lib/arm/gic.c b/lib/arm/gic.c
> index 8416dde..f9a6f57 100644
> --- a/lib/arm/gic.c
> +++ b/lib/arm/gic.c
> @@ -6,6 +6,7 @@
>  #include <devicetree.h>
>  #include <asm/gic.h>
>  #include <asm/io.h>
> +#include <asm/gic-v3-its.h>
>  
>  struct gicv2_data gicv2_data;
>  struct gicv3_data gicv3_data;
> @@ -44,12 +45,14 @@ static const struct gic_common_ops gicv3_common_ops = {
>   * Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>   */
>  static bool
> -gic_get_dt_bases(const char *compatible, void **base1, void **base2)
> +gic_get_dt_bases(const char *compatible, void **base1, void **base2,
> +		 void **base3)
>  {
>  	struct dt_pbus_reg reg;
> -	struct dt_device gic;
> +	struct dt_device gic, its;
>  	struct dt_bus bus;
> -	int node, ret, i;
> +	int node, subnode, ret, i, len;
> +	const void *fdt = dt_fdt();
>  
>  	dt_bus_init_defaults(&bus);
>  	dt_device_init(&gic, &bus, NULL);
> @@ -74,19 +77,36 @@ gic_get_dt_bases(const char *compatible, void **base1, void **base2)
>  		base2[i] = ioremap(reg.addr, reg.size);
>  	}
>  
> +	if (base3 && !strcmp(compatible, "arm,gic-v3")) {
> +		dt_for_each_subnode(node, subnode) {
> +			const struct fdt_property *prop;
> +
> +			prop = fdt_get_property(fdt, subnode,
> +						"compatible", &len);
> +			if (!strcmp((char *)prop->data, "arm,gic-v3-its")) {
> +				dt_device_bind_node(&its, subnode);
> +				ret = dt_pbus_translate(&its, 0, &reg);
> +				assert(ret == 0);
> +				*base3 = ioremap(reg.addr, reg.size);
> +				break;
> +			}
> +		}
> +
> +	}
> +
>  	return true;
>  }
>  
>  int gicv2_init(void)
>  {
>  	return gic_get_dt_bases("arm,cortex-a15-gic",
> -			&gicv2_data.dist_base, &gicv2_data.cpu_base);
> +			&gicv2_data.dist_base, &gicv2_data.cpu_base, NULL);
>  }
>  
>  int gicv3_init(void)
>  {
>  	return gic_get_dt_bases("arm,gic-v3", &gicv3_data.dist_base,
> -			&gicv3_data.redist_bases[0]);
> +			&gicv3_data.redist_bases[0], &its_data.base);
>  }
>  
>  int gic_version(void)
> @@ -104,6 +124,7 @@ int gic_init(void)
>  		gic_common_ops = &gicv2_common_ops;
>  	else if (gicv3_init())
>  		gic_common_ops = &gicv3_common_ops;
> +	its_init();
>  	return gic_version();
>  }
>  
> diff --git a/lib/arm64/asm/gic-v3-its.h b/lib/arm64/asm/gic-v3-its.h
> new file mode 100644
> index 0000000..083cba4
> --- /dev/null
> +++ b/lib/arm64/asm/gic-v3-its.h
> @@ -0,0 +1 @@
> +#include "../../arm/asm/gic-v3-its.h"
> -- 
> 2.20.1
> 


