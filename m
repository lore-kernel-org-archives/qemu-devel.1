Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EADC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 20:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E25320878
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 20:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E25320878
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTWbr-00017s-Ht
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 16:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTWVS-0007k1-Bv; Fri, 16 Oct 2020 16:39:18 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:37948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTWUO-00013y-DZ; Fri, 16 Oct 2020 16:39:17 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9613574761F;
 Fri, 16 Oct 2020 22:38:02 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7197C7475FA; Fri, 16 Oct 2020 22:38:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 708AD746383;
 Fri, 16 Oct 2020 22:38:02 +0200 (CEST)
Date: Fri, 16 Oct 2020 22:38:02 +0200 (CEST)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 4/5] ppc405_boards: use qdev properties instead of legacy
 m48t59_init() function
In-Reply-To: <20201016182739.22875-5-mark.cave-ayland@ilande.co.uk>
Message-ID: <653bf315-d1e4-4dc9-dac8-1e859a2ad4d1@eik.bme.hu>
References: <20201016182739.22875-1-mark.cave-ayland@ilande.co.uk>
 <20201016182739.22875-5-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, f4bug@amsat.org,
 qemu-ppc@nongnu.org, hpoussin@reactos.org, atar4qemu@gmail.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Fri, 16 Oct 2020, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
> hw/ppc/ppc405_boards.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 6198ec1035..4687715b15 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -28,6 +28,8 @@
> #include "qemu-common.h"
> #include "cpu.h"
> #include "hw/ppc/ppc.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> #include "ppc405.h"
> #include "hw/rtc/m48t59.h"
> #include "hw/block/flash.h"
> @@ -145,6 +147,8 @@ static void ref405ep_init(MachineState *machine)
>     char *filename;
>     ppc4xx_bd_info_t bd;
>     CPUPPCState *env;
> +    DeviceState *dev;
> +    SysBusDevice *s;
>     qemu_irq *pic;
>     MemoryRegion *bios;
>     MemoryRegion *sram = g_new(MemoryRegion, 1);
> @@ -227,7 +231,11 @@ static void ref405ep_init(MachineState *machine)
>     /* Register FPGA */
>     ref405ep_fpga_init(sysmem, 0xF0300000);
>     /* Register NVRAM */
> -    m48t59_init(NULL, 0xF0000000, 0, 8192, 1968, 8);
> +    dev = qdev_new("sysbus-m48t08");
> +    qdev_prop_set_int32(dev, "base-year", 1968);

Is there anything that uses other than 1968 as base year? If not this 
could be the default in the device so you don't need these set prop calls 
here and in sun machines.

The only other place this device is used seems to be ppc/prep machine that 
uses the isa version but does not set a base year. Is that a bug? The 
original prep machine removed in b2ce76a0730 used 2000 but that's unlikely 
as well as these machines predate that. Anyway, the sysbus and isa 
versions are different so their default base-year could be set 
independently and then boards won't need to set this propery and may be 
could use qdev_create_simple instead or whatever that was renamed to.

Regards,
BALATON Zoltan

> +    s = SYS_BUS_DEVICE(dev);
> +    sysbus_realize_and_unref(s, &error_fatal);
> +    sysbus_mmio_map(s, 0, 0xF0000000);
>     /* Load kernel */
>     linux_boot = (kernel_filename != NULL);
>     if (linux_boot) {
>

