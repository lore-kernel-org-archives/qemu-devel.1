Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB5CC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 07:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CBD3207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 07:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBD3207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9knU-0004aF-Fd
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 02:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j9kmt-0003r4-C9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 02:19:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j9kmr-0000Fw-TA
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 02:19:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37732 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j9kmr-000089-HK
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 02:19:17 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D4DA7D618F8887097F14;
 Thu,  5 Mar 2020 15:19:11 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 5 Mar 2020
 15:19:03 +0800
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
To: <qemu-devel@nongnu.org>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <4729be78-23b6-48cf-f492-0ec53c764096@huawei.com>
Date: Thu, 5 Mar 2020 15:18:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200305065422.12707-3-pannengyuan@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
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
Cc: peter.maydell@linaro.org, Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>,
 zhang.zhanghailiang@huawei.com, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/5/2020 2:54 PM, Pan Nengyuan wrote:
> This patch fix a bug in mac_via where it failed to actually realize devices it was using.
> And move the init codes which inits the mos6522 objects and properties on them from realize()
> into init(). However, we keep qdev_set_parent_bus in realize(), otherwise it will cause
> device-introspect-test test fail. Then do the realize mos6522 device in the mac_vir_realize.
> 
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
> v4->v3:
> - split v3 into two patches, this patch fix incorrect creation of mos6522, move inits and props
>   from realize into init. The v3 is:
>   https://patchwork.kernel.org/patch/11407635/
> ---
>  hw/misc/mac_via.c | 43 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index b7d0012794..4c5ad08805 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -868,24 +868,24 @@ static void mac_via_reset(DeviceState *dev)
>  static void mac_via_realize(DeviceState *dev, Error **errp)
>  {
>      MacVIAState *m = MAC_VIA(dev);
> -    MOS6522State *ms;
>      struct tm tm;
>      int ret;
> +    Error *err = NULL;
>  
> -    /* Init VIAs 1 and 2 */
> -    sysbus_init_child_obj(OBJECT(dev), "via1", &m->mos6522_via1,
> -                          sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VIA1);
> +    qdev_set_parent_bus(DEVICE(&m->mos6522_via1), sysbus_get_default());
> +    qdev_set_parent_bus(DEVICE(&m->mos6522_via2), sysbus_get_default());
>  
> -    sysbus_init_child_obj(OBJECT(dev), "via2", &m->mos6522_via2,
> -                          sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA2);
> +    object_property_set_bool(OBJECT(&m->mos6522_via1), true, "realized", &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>  
> -    /* Pass through mos6522 output IRQs */
> -    ms = MOS6522(&m->mos6522_via1);
> -    object_property_add_alias(OBJECT(dev), "irq[0]", OBJECT(ms),
> -                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
> -    ms = MOS6522(&m->mos6522_via2);
> -    object_property_add_alias(OBJECT(dev), "irq[1]", OBJECT(ms),
> -                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
> +    object_property_set_bool(OBJECT(&m->mos6522_via2), true, "realized", &err);
> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>  
>      /* Pass through mos6522 input IRQs */
>      qdev_pass_gpios(DEVICE(&m->mos6522_via1), dev, "via1-irq");
> @@ -932,6 +932,7 @@ static void mac_via_init(Object *obj)
>  {
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>      MacVIAState *m = MAC_VIA(obj);
> +    MOS6522State *ms;
>  
>      /* MMIO */
>      memory_region_init(&m->mmio, obj, "mac-via", 2 * VIA_SIZE);
> @@ -948,6 +949,22 @@ static void mac_via_init(Object *obj)
>      /* ADB */
>      qbus_create_inplace((BusState *)&m->adb_bus, sizeof(m->adb_bus),
>                          TYPE_ADB_BUS, DEVICE(obj), "adb.0");
> +
> +    /* Init VIAs 1 and 2 */
> +    object_initialize_child(OBJECT(m), "via1", &m->mos6522_via1, 

Sorry, one more space at the end of the above line, and fail to run checkpatch.


