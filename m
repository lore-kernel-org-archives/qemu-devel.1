Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B752DC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83AAD20715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUlRyWDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83AAD20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02xO-0003Gq-Nn
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j02wn-0002mi-MT
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j02wl-0006wa-Md
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:41:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20251
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j02wk-0006vf-AI
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581079282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jekBhkDKUDW/HdvYc4nFBVt1gZ8ZA3cNzhKmGx21BcU=;
 b=ZUlRyWDBUHMmUTlMQbB5SMYWUchT1hctIkLjNYUt7whCBVMuXoN/Y08bQV7rVvOiDszajf
 KIPQW3tYDHBcoF5rJSh+Lxol1hweXhWqHhUvR9eHIX+zoqcNSJEyUOghB1qz79tDiYWY2n
 FuTK1cE08UFP8mvCTnr4AXP7tt+ED4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-CS3g7-frPAC93Tllq8U3SQ-1; Fri, 07 Feb 2020 07:41:18 -0500
X-MC-Unique: CS3g7-frPAC93Tllq8U3SQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C79FD86A060;
 Fri,  7 Feb 2020 12:41:15 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C13787B11;
 Fri,  7 Feb 2020 12:41:10 +0000 (UTC)
Date: Fri, 7 Feb 2020 13:41:08 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 08/14] arm/arm64: ITS:
 its_enable_defaults
Message-ID: <20200207124108.wtgghuwoka42oj4i@kamzik.brq.redhat.com>
References: <20200128103459.19413-1-eric.auger@redhat.com>
 <20200128103459.19413-9-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128103459.19413-9-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Tue, Jan 28, 2020 at 11:34:53AM +0100, Eric Auger wrote:
> its_enable_defaults() is the top init function that allocates the
> command queue and all the requested tables (device, collection,
> lpi config and pending tables), enable LPIs at distributor level
> and ITS level.
> 
> gicv3_enable_defaults must be called before.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - introduce its_setup_baser in this patch
> - squash "arm/arm64: ITS: Init the command queue" in this patch.
> ---
>  lib/arm/asm/gic-v3-its.h |  8 ++++
>  lib/arm/gic-v3-its.c     | 89 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
> index 815c515..fe73c04 100644
> --- a/lib/arm/asm/gic-v3-its.h
> +++ b/lib/arm/asm/gic-v3-its.h
> @@ -36,6 +36,8 @@ struct its_data {
>  	void *base;
>  	struct its_typer typer;
>  	struct its_baser baser[GITS_BASER_NR_REGS];
> +	struct its_cmd_block *cmd_base;
> +	struct its_cmd_block *cmd_write;
>  };
>  
>  extern struct its_data its_data;
> @@ -88,10 +90,16 @@ extern struct its_data its_data;
>  #define GITS_BASER_TYPE_DEVICE		1
>  #define GITS_BASER_TYPE_COLLECTION	4
>  
> +
> +struct its_cmd_block {
> +	u64 raw_cmd[4];
> +};
> +
>  extern void its_parse_typer(void);
>  extern void its_init(void);
>  extern int its_parse_baser(int i, struct its_baser *baser);
>  extern struct its_baser *its_lookup_baser(int type);
> +extern void its_enable_defaults(void);
>  
>  #else /* __arm__ */
>  
> diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
> index 2c0ce13..d1e7e52 100644
> --- a/lib/arm/gic-v3-its.c
> +++ b/lib/arm/gic-v3-its.c
> @@ -86,3 +86,92 @@ void its_init(void)
>  		its_parse_baser(i, &its_data.baser[i]);
>  }
>  
> +static void its_setup_baser(int i, struct its_baser *baser)
> +{
> +	unsigned long n = (baser->nr_pages * baser->psz) >> PAGE_SHIFT;
> +	unsigned long order = is_power_of_2(n) ? fls(n) : fls(n) + 1;
> +	u64 val;
> +
> +	baser->table_addr = (u64)virt_to_phys(alloc_pages(order));
> +
> +	val = ((u64)baser->table_addr					|
> +		((u64)baser->type	<< GITS_BASER_TYPE_SHIFT)	|
> +		((u64)(baser->esz - 1)	<< GITS_BASER_ENTRY_SIZE_SHIFT)	|
> +		((baser->nr_pages - 1)	<< GITS_BASER_PAGES_SHIFT)	|
> +		(u64)baser->indirect	<< 62				|
> +		(u64)baser->valid	<< 63);

 << GITS_BASER_INDIRECT
 << GITS_BASER_VALID

> +
> +	switch (baser->psz) {
> +	case SZ_4K:
> +		val |= GITS_BASER_PAGE_SIZE_4K;
> +		break;
> +	case SZ_16K:
> +		val |= GITS_BASER_PAGE_SIZE_16K;
> +		break;
> +	case SZ_64K:
> +		val |= GITS_BASER_PAGE_SIZE_64K;
> +		break;
> +	}
> +
> +	writeq(val, gicv3_its_base() + GITS_BASER + i * 8);
> +}
> +
> +/**
> + * init_cmd_queue: Allocate the command queue and initialize
> + * CBASER, CREADR, CWRITER
> + */
> +static void its_cmd_queue_init(void)
> +{
> +	unsigned long n = SZ_64K >> PAGE_SHIFT;
> +	unsigned long order = fls(n);
> +	u64 cbaser;
> +
> +	its_data.cmd_base = (void *)virt_to_phys(alloc_pages(order));
> +
> +	cbaser = ((u64)its_data.cmd_base | (SZ_64K / SZ_4K - 1)	| GITS_CBASER_VALID);
> +
> +	writeq(cbaser, its_data.base + GITS_CBASER);
> +
> +	its_data.cmd_write = its_data.cmd_base;
> +	writeq(0, its_data.base + GITS_CWRITER);
> +}
> +
> +void its_enable_defaults(void)
> +{
> +	unsigned int i;
> +
> +	its_parse_typer();
> +
> +	/* Allocate BASER tables (device and collection tables) */
> +	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
> +		struct its_baser *baser = &its_data.baser[i];
> +		int ret;
> +
> +		ret = its_parse_baser(i, baser);
> +		if (ret)
> +			continue;

Didn't we already parse typer and baser at its_init time? How/why would
its_parse_baser fail? Should we assert when it does?

> +
> +		switch (baser->type) {
> +		case GITS_BASER_TYPE_DEVICE:
> +			baser->valid = true;
> +			its_setup_baser(i, baser);
> +			break;
> +		case GITS_BASER_TYPE_COLLECTION:
> +			baser->valid = true;
> +			its_setup_baser(i, baser);
> +			break;
> +		default:
> +			break;

assert() ?

> +		}
> +	}
> +
> +	/* Allocate LPI config and pending tables */
> +	gicv3_lpi_alloc_tables();
> +
> +	its_cmd_queue_init();
> +
> +	for (i = 0; i < nr_cpus; i++)
> +		gicv3_lpi_rdist_ctrl(i, true);
> +
> +	writel(GITS_CTLR_ENABLE, its_data.base + GITS_CTLR);
> +}
> -- 
> 2.20.1
> 
>

It's looking like we don't have a clean separation between its_init and
its_enable_defaults. I'd expect its_init to do all the allocating of
memory and its_enable_defaults to do all the write's to the device.
We should only do its_init once and its_enable should be something
we can do again (after a disable, on reset, etc.). Is that not possible
with the ITS device?

Thanks,
drew


