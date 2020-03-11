Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69695C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43286208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43286208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBxNi-0002DH-Gy
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 05:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1jBxMh-0001Nv-99
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1jBxMf-0008Ff-QB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:09:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3275 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1jBxMc-0008B4-E7; Wed, 11 Mar 2020 05:09:18 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D9CCC96868EE027D56DF;
 Wed, 11 Mar 2020 17:09:13 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Mar 2020
 17:09:04 +0800
Subject: Re: [kvm-unit-tests PATCH v5 09/13] arm/arm64: ITS: Commands
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20200310145410.26308-1-eric.auger@redhat.com>
 <20200310145410.26308-10-eric.auger@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <ad7d4011-0b8e-978d-54e7-d44cd4e34ed7@huawei.com>
Date: Wed, 11 Mar 2020 17:09:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200310145410.26308-10-eric.auger@redhat.com>
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
> Implement main ITS commands. The code is largely inherited from
> the ITS driver.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v3 -> v4:
> - device's itt now is a VGA
> - pass verbose to choose whether we shall print the cmd
> - use printf instead of report_info
> 
> v2 -> v3:
> - do not use report() anymore
> - assert if cmd_write exceeds the queue capacity
> 
> v1 -> v2:
> - removed its_print_cmd_state
> ---
>   arm/Makefile.arm64         |   2 +-
>   lib/arm64/asm/gic-v3-its.h |  57 +++++
>   lib/arm64/gic-v3-its-cmd.c | 463 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 521 insertions(+), 1 deletion(-)
>   create mode 100644 lib/arm64/gic-v3-its-cmd.c
> 
> diff --git a/arm/Makefile.arm64 b/arm/Makefile.arm64
> index 60182ae..dfd0c56 100644
> --- a/arm/Makefile.arm64
> +++ b/arm/Makefile.arm64
> @@ -19,7 +19,7 @@ endef
>   cstart.o = $(TEST_DIR)/cstart64.o
>   cflatobjs += lib/arm64/processor.o
>   cflatobjs += lib/arm64/spinlock.o
> -cflatobjs += lib/arm64/gic-v3-its.o
> +cflatobjs += lib/arm64/gic-v3-its.o lib/arm64/gic-v3-its-cmd.o
>   
>   OBJDIRS += lib/arm64
>   
> diff --git a/lib/arm64/asm/gic-v3-its.h b/lib/arm64/asm/gic-v3-its.h
> index 3da548b..889d6ce 100644
> --- a/lib/arm64/asm/gic-v3-its.h
> +++ b/lib/arm64/asm/gic-v3-its.h
> @@ -102,6 +102,28 @@ extern struct its_data its_data;
>   #define GITS_BASER_TYPE_DEVICE		1
>   #define GITS_BASER_TYPE_COLLECTION	4
>   
> +/*
> + * ITS commands
> + */
> +#define GITS_CMD_MAPD			0x08
> +#define GITS_CMD_MAPC			0x09
> +#define GITS_CMD_MAPTI			0x0a
> +/* older GIC documentation used MAPVI for this command */
> +#define GITS_CMD_MAPVI			GITS_CMD_MAPTI

You can drop it.

> +#define GITS_CMD_MAPI			0x0b
> +#define GITS_CMD_MOVI			0x01
> +#define GITS_CMD_DISCARD		0x0f
> +#define GITS_CMD_INV			0x0c
> +#define GITS_CMD_MOVALL			0x0e
> +#define GITS_CMD_INVALL			0x0d
> +#define GITS_CMD_INT			0x03
> +#define GITS_CMD_CLEAR			0x04
> +#define GITS_CMD_SYNC			0x05
> +
> +struct its_cmd_block {
> +	u64 raw_cmd[4];
> +};
> +
>   extern void its_parse_typer(void);
>   extern void its_init(void);
>   extern int its_baser_lookup(int i, struct its_baser *baser);
> @@ -109,4 +131,39 @@ extern void its_enable_defaults(void);
>   extern struct its_device *its_create_device(u32 dev_id, int nr_ites);
>   extern struct its_collection *its_create_collection(u32 col_id, u32 target_pe);
>   
> +extern void __its_send_mapd(struct its_device *dev, int valid, bool verbose);
> +extern void __its_send_mapc(struct its_collection *col, int valid, bool verbose);
> +extern void __its_send_mapti(struct its_device *dev, u32 irq_id, u32 event_id,
> +			     struct its_collection *col, bool verbose);
> +extern void __its_send_int(struct its_device *dev, u32 event_id, bool verbose);
> +extern void __its_send_inv(struct its_device *dev, u32 event_id, bool verbose);
> +extern void __its_send_discard(struct its_device *dev, u32 event_id, bool verbose);
> +extern void __its_send_clear(struct its_device *dev, u32 event_id, bool verbose);
> +extern void __its_send_invall(struct its_collection *col, bool verbose);
> +extern void __its_send_movi(struct its_device *dev, struct its_collection *col,
> +			    u32 id, bool verbose);
> +extern void __its_send_sync(struct its_collection *col, bool verbose);
> +
> +#define its_send_mapd(dev, valid)			__its_send_mapd(dev, valid, true)
> +#define its_send_mapc(col, valid)			__its_send_mapc(col, valid, true)
> +#define its_send_mapti(dev, irqid, eventid, col)	__its_send_mapti(dev, irqid, eventid, col, true)
> +#define its_send_int(dev, eventid)			__its_send_int(dev, eventid, true)
> +#define its_send_inv(dev, eventid)			__its_send_inv(dev, eventid, true)
> +#define its_send_discard(dev, eventid)			__its_send_discard(dev, eventid, true)
> +#define its_send_clear(dev, eventid)			__its_send_clear(dev, eventid, true)
> +#define its_send_invall(col)				__its_send_invall(col, true)
> +#define its_send_movi(dev, col, id)			__its_send_movi(dev, col, id, true)
> +#define its_send_sync(col)				__its_send_sync(col, true)
> +
> +#define its_send_mapd_nv(dev, valid)			__its_send_mapd(dev, valid, false)
> +#define its_send_mapc_nv(col, valid)			__its_send_mapc(col, valid, false)
> +#define its_send_mapti_nv(dev, irqid, eventid, col)	__its_send_mapti(dev, irqid, eventid, col, false)
> +#define its_send_int_nv(dev, eventid)			__its_send_int(dev, eventid, false)
> +#define its_send_inv_nv(dev, eventid)			__its_send_inv(dev, eventid, false)
> +#define its_send_discard_nv(dev, eventid)		__its_send_discard(dev, eventid, false)
> +#define its_send_clear_nv(dev, eventid)			__its_send_clear(dev, eventidn false)
> +#define its_send_invall_nv(col)				__its_send_invall(col, false)
> +#define its_send_movi_nv(dev, col, id)			__its_send_movi(dev, col, id, false)
> +#define its_send_sync_nv(col)				__its_send_sync(col, false)

(not verbose? Naming is always difficult ;-).)

[...]

> +
> +static void its_build_invall_cmd(struct its_cmd_block *cmd,
> +			      struct its_cmd_desc *desc)
> +{
> +	its_encode_cmd(cmd, GITS_CMD_INVALL);
> +	its_encode_collection(cmd, desc->its_invall_cmd.col->col_id);
> +	its_fixup_cmd(cmd);
> +	if (desc->verbose)
> +		printf("INVALL col_id=%d\n", desc->its_invall_cmd.col->col_id);
> +}
> +
> +static void its_build_clear_cmd(struct its_cmd_block *cmd,
> +				struct its_cmd_desc *desc)
> +{
> +	its_encode_cmd(cmd, GITS_CMD_CLEAR);
> +	its_encode_devid(cmd, desc->its_clear_cmd.dev->device_id);
> +	its_encode_event_id(cmd, desc->its_clear_cmd.event_id);
> +	its_fixup_cmd(cmd);
> +	if (desc->verbose)
> +		printf("CLEAR col_id=%d\n", desc->its_invall_cmd.col->col_id);

its_invall_cmd.col->col_id?

Don't you want to print the arguments (DeviceID and EventID) as you've
done for other commands?

> +}
> +
> +static void its_build_discard_cmd(struct its_cmd_block *cmd,
> +				  struct its_cmd_desc *desc)
> +{
> +	its_encode_cmd(cmd, GITS_CMD_DISCARD);
> +	its_encode_devid(cmd, desc->its_discard_cmd.dev->device_id);
> +	its_encode_event_id(cmd, desc->its_discard_cmd.event_id);
> +	its_fixup_cmd(cmd);
> +	if (desc->verbose)
> +		printf("DISCARD col_id=%d\n", desc->its_invall_cmd.col->col_id);

The same question here.

[...]

And afaict, there's some fixes for the Linux ITS driver since the RFC
version of this series. Please have a check if you can.


Thanks,
Zenghui


