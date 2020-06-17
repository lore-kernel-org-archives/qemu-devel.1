Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C643C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E2D21527
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E2D21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlbAB-0001zB-F0
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jlb8w-0000Tv-6h
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:42:30 -0400
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:59223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jlb8s-0005J4-2B
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:42:29 -0400
Received: from player798.ha.ovh.net (unknown [10.110.171.227])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 9F9AA16CB5C
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 18:42:23 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player798.ha.ovh.net (Postfix) with ESMTPSA id 5C1C5139391D0;
 Wed, 17 Jun 2020 16:42:13 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006778cf0ea-3aef-4ffb-9c1b-112d4f892549,ABECD89738EEB0C75E5395B338997A57DB3A3EEE)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 11/12] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org,
 joel@jms.id.au
References: <20200611223016.259837-1-hskinnemoen@google.com>
 <20200611223016.259837-12-hskinnemoen@google.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <69a4b9c8-0ae0-96e2-8b46-cc89c9acbc9a@kaod.org>
Date: Wed, 17 Jun 2020 18:42:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611223016.259837-12-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5183361699602271145
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudejvddguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.72.216; envelope-from=clg@kaod.org;
 helo=16.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 12:42:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/12/20 12:30 AM, Havard Skinnemoen wrote:
> This allows these NPCM7xx-based boards to boot from a flash image, e.g.
> one built with OpenBMC. For example like this:
> 
> IMAGE=${OPENBMC}/build/tmp/deploy/images/gsj/image-bmc

could you put the image on some site when ready ? 

> qemu-system-arm -machine quanta-gsj -nographic \
> 	-bios ~/qemu/bootrom/npcm7xx_bootrom.bin \
> 	-drive file=${IMAGE},if=mtd,bus=0,unit=0,format=raw,snapshot=on
> 
> Change-Id: I158a4d9952c0e90f2b1b7280443a7305b6ae57cf
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>  hw/arm/npcm7xx_boards.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
> index 86e18af2d7..1ec772fa59 100644
> --- a/hw/arm/npcm7xx_boards.c
> +++ b/hw/arm/npcm7xx_boards.c
> @@ -18,6 +18,7 @@
>  #include "hw/arm/boot.h"
>  #include "hw/arm/npcm7xx.h"
>  #include "hw/core/cpu.h"
> +#include "hw/qdev-properties.h"
>  #include "qapi/error.h"
>  #include "qemu/units.h"
>  
> @@ -40,6 +41,20 @@ static void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
>      arm_load_kernel(&soc->cpu[0], machine, &npcm7xx_binfo);
>  }
>  
> +static void npcm7xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
> +                                  const char *flash_type, DriveInfo *dinfo) {
> +    DeviceState *flash;
> +    qemu_irq flash_cs;
> +
> +    flash = ssi_create_slave_no_init(fiu->spi, flash_type);
> +    qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo),
> +                        &error_abort);
> +    qdev_init_nofail(flash);
> +
> +    flash_cs = qdev_get_gpio_in_named(flash, SSI_GPIO_CS, 0);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(fiu), cs_no, flash_cs);
> +}
> +
>  static NPCM7xxState *npcm7xx_create_soc(MachineState *machine)
>  {
>      NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_GET_CLASS(machine);
> @@ -57,18 +72,30 @@ static NPCM7xxState *npcm7xx_create_soc(MachineState *machine)
>  static void npcm750_evb_init(MachineState *machine)
>  {
>      NPCM7xxState *soc;
> +    DriveInfo *dinfo;
>  
>      soc = npcm7xx_create_soc(machine);
>  
> +    dinfo = drive_get(IF_MTD, 0, 0);
> +    if (dinfo) {
> +        npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", dinfo);
> +    }
> +
>      npcm7xx_load_kernel(machine, soc);
>  }
>  
>  static void quanta_gsj_init(MachineState *machine)
>  {
>      NPCM7xxState *soc;
> +    DriveInfo *dinfo;
>  
>      soc = npcm7xx_create_soc(machine);
>  
> +    dinfo = drive_get(IF_MTD, 0, 0);
> +    if (dinfo) {
> +        npcm7xx_connect_flash(&soc->fiu[0], 0, "mx25l25635e", dinfo);
> +    }
> +
>      npcm7xx_load_kernel(machine, soc);
>  }
>  
> 


