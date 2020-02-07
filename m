Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04FEC2D0B1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 05:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84EF7222C2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 05:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EF7222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izwPi-0004Ng-O3
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 00:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1izwP7-0003t8-BS
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 00:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1izwP6-0006MH-67
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 00:42:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46034 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1izwP3-00062M-7n; Fri, 07 Feb 2020 00:42:09 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A8F7D8F5FD0ADFE965E5;
 Fri,  7 Feb 2020 13:42:01 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 7 Feb 2020
 13:41:54 +0800
Subject: Re: [kvm-unit-tests PATCH v3 09/14] arm/arm64: ITS: Device and
 collection Initialization
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20200128103459.19413-1-eric.auger@redhat.com>
 <20200128103459.19413-10-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <42a8964a-af3d-0117-bfac-5db6b7b832dd@huawei.com>
Date: Fri, 7 Feb 2020 13:41:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200128103459.19413-10-eric.auger@redhat.com>
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

On 2020/1/28 18:34, Eric Auger wrote:
> Introduce an helper functions to register
> - a new device, characterized by its device id and the
>    max number of event IDs that dimension its ITT (Interrupt
>    Translation Table).  The function allocates the ITT.
> 
> - a new collection, characterized by its ID and the
>    target processing engine (PE).
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - s/report_abort/assert
> 
> v1 -> v2:
> - s/nb_/nr_
> ---
>   lib/arm/asm/gic-v3-its.h | 20 +++++++++++++++++-
>   lib/arm/gic-v3-its.c     | 44 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
> index fe73c04..acd97a9 100644
> --- a/lib/arm/asm/gic-v3-its.h
> +++ b/lib/arm/asm/gic-v3-its.h
> @@ -31,6 +31,19 @@ struct its_baser {
>   };
>   
>   #define GITS_BASER_NR_REGS              8
> +#define GITS_MAX_DEVICES		8
> +#define GITS_MAX_COLLECTIONS		8
> +
> +struct its_device {
> +	u32 device_id;	/* device ID */
> +	u32 nr_ites;	/* Max Interrupt Translation Entries */
> +	void *itt;	/* Interrupt Translation Table GPA */
> +};
> +
> +struct its_collection {
> +	u64 target_address;
> +	u16 col_id;
> +};
>   
>   struct its_data {
>   	void *base;
> @@ -38,6 +51,10 @@ struct its_data {
>   	struct its_baser baser[GITS_BASER_NR_REGS];
>   	struct its_cmd_block *cmd_base;
>   	struct its_cmd_block *cmd_write;
> +	struct its_device devices[GITS_MAX_DEVICES];
> +	u32 nr_devices;		/* Allocated Devices */
> +	struct its_collection collections[GITS_MAX_COLLECTIONS];
> +	u32 nr_collections;	/* Allocated Collections */
>   };
>   
>   extern struct its_data its_data;
> @@ -90,7 +107,6 @@ extern struct its_data its_data;
>   #define GITS_BASER_TYPE_DEVICE		1
>   #define GITS_BASER_TYPE_COLLECTION	4
>   
> -
>   struct its_cmd_block {
>   	u64 raw_cmd[4];
>   };
> @@ -100,6 +116,8 @@ extern void its_init(void);
>   extern int its_parse_baser(int i, struct its_baser *baser);
>   extern struct its_baser *its_lookup_baser(int type);
>   extern void its_enable_defaults(void);
> +extern struct its_device *its_create_device(u32 dev_id, int nr_ites);
> +extern struct its_collection *its_create_collection(u32 col_id, u32 target_pe);
>   
>   #else /* __arm__ */
>   
> diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
> index d1e7e52..c2dcd01 100644
> --- a/lib/arm/gic-v3-its.c
> +++ b/lib/arm/gic-v3-its.c
> @@ -175,3 +175,47 @@ void its_enable_defaults(void)
>   
>   	writel(GITS_CTLR_ENABLE, its_data.base + GITS_CTLR);
>   }
> +
> +struct its_device *its_create_device(u32 device_id, int nr_ites)
> +{
> +	struct its_baser *baser;
> +	struct its_device *new;
> +	unsigned long n, order;
> +
> +	assert(its_data.nr_devices < GITS_MAX_DEVICES);
> +


> +	baser = its_lookup_baser(GITS_BASER_TYPE_DEVICE);
> +	if (!baser)
> +		return NULL;

I think there's no need to lookup the device baser here. As the
device baser should have already been setup at initialization
time (i.e. in its_enable_defaults). And anyway, 'baser' is not
being used in this function.


Thanks,
Zenghui

> +
> +	new = &its_data.devices[its_data.nr_devices];
> +
> +	new->device_id = device_id;
> +	new->nr_ites = nr_ites;
> +
> +	n = (its_data.typer.ite_size * nr_ites) >> PAGE_SHIFT;
> +	order = is_power_of_2(n) ? fls(n) : fls(n) + 1;
> +	new->itt = (void *)virt_to_phys(alloc_pages(order));
> +
> +	its_data.nr_devices++;
> +	return new;
> +}
> +
> +struct its_collection *its_create_collection(u32 col_id, u32 pe)
> +{
> +	struct its_collection *new;
> +
> +	assert(its_data.nr_collections < GITS_MAX_COLLECTIONS);
> +
> +	new = &its_data.collections[its_data.nr_collections];
> +
> +	new->col_id = col_id;
> +
> +	if (its_data.typer.pta)
> +		new->target_address = (u64)gicv3_data.redist_base[pe];
> +	else
> +		new->target_address = pe << 16;
> +
> +	its_data.nr_collections++;
> +	return new;
> +}
> 


