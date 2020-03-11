Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771A4C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BDC2222C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDC2222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0A9-0004cm-HL
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1jC09S-0003yc-W5
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1jC09R-0008Sb-Kh
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:07:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48868 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1jC09O-0008JW-C5; Wed, 11 Mar 2020 08:07:50 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 3F3F463669F3BC720716;
 Wed, 11 Mar 2020 20:07:45 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Mar 2020
 20:07:36 +0800
Subject: Re: [kvm-unit-tests PATCH v5 13/13] arm/arm64: ITS: pending table
 migration test
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20200310145410.26308-1-eric.auger@redhat.com>
 <20200310145410.26308-14-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <54139b63-3a1d-7276-4d0b-4d38f9901536@huawei.com>
Date: Wed, 11 Mar 2020 20:07:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200310145410.26308-14-eric.auger@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
> Add two new migration tests. One testing the migration of
> a topology where collection were unmapped. The second test
> checks the migration of the pending table.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v4 -> v5:
> - move stub from header to arm/gic.c
> 
> v3 -> v4:
> - do not talk about odd/even CPUs, use pe0 and pe1
> - comment the delay
> 
> v2 -> v3:
> - tests belong to both its and migration groups
> - use LPI(i)
> - gicv3_lpi_set_pending_table_bit renamed into gicv3_lpi_set_clr_pending
> ---
>   arm/gic.c         | 146 ++++++++++++++++++++++++++++++++++++++++++++++
>   arm/unittests.cfg |  16 +++++
>   2 files changed, 162 insertions(+)
> 
> diff --git a/arm/gic.c b/arm/gic.c
> index b8fbc13..e6ffbc3 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -193,6 +193,7 @@ static void lpi_handler(struct pt_regs *regs __unused)
>   	smp_rmb(); /* pairs with wmb in lpi_stats_expect */
>   	lpi_stats.observed.cpu_id = smp_processor_id();
>   	lpi_stats.observed.lpi_id = irqnr;
> +	acked[lpi_stats.observed.cpu_id]++;
>   	smp_wmb(); /* pairs with rmb in check_lpi_stats */
>   }
>   
> @@ -236,6 +237,22 @@ static void secondary_lpi_test(void)
>   	while (1)
>   		wfi();
>   }
> +
> +static void check_lpi_hits(int *expected, const char *msg)
> +{
> +	bool pass = true;
> +	int i;
> +
> +	for (i = 0; i < nr_cpus; i++) {
> +		if (acked[i] != expected[i]) {
> +			report_info("expected %d LPIs on PE #%d, %d observed",
> +				    expected[i], i, acked[i]);
> +			pass = false;
> +			break;
> +		}
> +	}
> +	report(pass, "%s", msg);
> +}
>   #endif
>   
>   static void gicv2_ipi_send_self(void)
> @@ -591,6 +608,8 @@ static void gic_test_mmio(void)
>   static void test_its_introspection(void) {}
>   static void test_its_trigger(void) {}
>   static void test_its_migration(void) {}
> +static void test_its_pending_migration(void) {}
> +static void test_migrate_unmapped_collection(void) {}
>   
>   #else /* __aarch64__ */
>   
> @@ -659,6 +678,17 @@ static int its_prerequisites(int nb_cpus)
>   	return 0;
>   }
>   
> +static void set_lpi(struct its_device *dev, u32 eventid, u32 physid,
> +		    struct its_collection *col)
> +{
> +	assert(dev && col);
> +
> +	its_send_mapti(dev, physid, eventid, col);
> +
> +	gicv3_lpi_set_config(physid, LPI_PROP_DEFAULT);
> +	its_send_invall(col);

Again, the col hasn't been mapped currently.

> +}
> +
>   /*
>    * Setup the configuration for those mappings:
>    * dev_id=2 event=20 -> vcpu 3, intid=8195
> @@ -799,6 +829,114 @@ static void test_its_migration(void)
>   	its_send_int(dev7, 255);
>   	check_lpi_stats("dev7/eventid=255 triggers LPI 8196 on PE #2 after migration");
>   }
> +
> +static void test_migrate_unmapped_collection(void)
> +{
> +	struct its_collection *col;
> +	struct its_device *dev2, *dev7;
> +	int pe0 = nr_cpus - 1;
> +	u8 config;
> +
> +	if (its_setup1())
> +		return;
> +
> +	col = its_create_collection(pe0, pe0);
> +	dev2 = its_get_device(2);
> +	dev7 = its_get_device(7);
> +
> +	/* MAPTI with the collection unmapped */
> +	set_lpi(dev2, 0, 8192, col);
> +
> +	puts("Now migrate the VM, then press a key to continue...\n");
> +	(void)getchar();
> +	report_info("Migration complete");
> +
> +	/* on the destination, map the collection */
> +	its_send_mapc(col, true);
> +
> +	lpi_stats_expect(2, 8196);
> +	its_send_int(dev7, 255);
> +	check_lpi_stats("dev7/eventid= 255 triggered LPI 8196 on PE #2");
> +
> +	config = gicv3_lpi_get_config(8192);
> +	report(config == LPI_PROP_DEFAULT,
> +	       "Config of LPI 8192 was properly migrated");
> +
> +	lpi_stats_expect(pe0, 8192);
> +	its_send_int(dev2, 0);
> +	check_lpi_stats("dev2/eventid = 0 triggered LPI 8192 on PE0");
> +
> +	/* unmap the collection */
> +	its_send_mapc(col, false);

Again, behavior is unpredictable.

> +
> +	lpi_stats_expect(-1, -1);
> +	its_send_int(dev2, 0);
> +	check_lpi_stats("no LPI triggered after collection unmapping");
> +}
> +
> +static void test_its_pending_migration(void)
> +{
> +	struct its_device *dev;
> +	struct its_collection *collection[2];
> +	int *expected = malloc(nr_cpus * sizeof(int));
> +	int pe0 = nr_cpus - 1, pe1 = nr_cpus - 2;
> +	u64 pendbaser;
> +	void *ptr;
> +	int i;
> +
> +	if (its_prerequisites(4))
> +		return;
> +
> +	dev = its_create_device(2 /* dev id */, 8 /* nb_ites */);
> +	its_send_mapd(dev, true);
> +
> +	collection[0] = its_create_collection(pe0, pe0);
> +	collection[1] = its_create_collection(pe1, pe1);
> +	its_send_mapc(collection[0], true);
> +	its_send_mapc(collection[1], true);
> +
> +	/* disable lpi at redist level */
> +	gicv3_lpi_rdist_disable(pe0);
> +	gicv3_lpi_rdist_disable(pe1);
> +
> +	/* lpis are interleaved inbetween the 2 PEs */
> +	for (i = 0; i < 256; i++) {
> +		struct its_collection *col = i % 2 ? collection[0] :
> +						     collection[1];
> +		int vcpu = col->target_address >> 16;
> +
> +		its_send_mapti(dev, LPI(i), i, col);
> +		gicv3_lpi_set_config(LPI(i), LPI_PROP_DEFAULT);
> +		gicv3_lpi_set_clr_pending(vcpu, LPI(i), true);
> +	}
> +	its_send_invall(collection[0]);
> +	its_send_invall(collection[1]);
> +
> +	/* Set the PTZ bit on each pendbaser */

'Clear' the PTZ.

Otherwise looks good!

> +
> +	expected[pe0] = 128;
> +	expected[pe1] = 128;
> +
> +	ptr = gicv3_data.redist_base[pe0] + GICR_PENDBASER;
> +	pendbaser = readq(ptr);
> +	writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
> +
> +	ptr = gicv3_data.redist_base[pe1] + GICR_PENDBASER;
> +	pendbaser = readq(ptr);
> +	writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
> +
> +	gicv3_lpi_rdist_enable(pe0);
> +	gicv3_lpi_rdist_enable(pe1);
> +
> +	puts("Now migrate the VM, then press a key to continue...\n");
> +	(void)getchar();
> +	report_info("Migration complete");
> +
> +	/* let's wait for the 256 LPIs to be handled */
> +	mdelay(1000);
> +
> +	check_lpi_hits(expected, "128 LPIs on both PE0 and PE1 after migration");
> +}

Thanks,
Zenghui


