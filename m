Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00ACC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B792205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B792205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36901 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGO8O-0003Q6-Mw
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:28:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hGNs9-0007d3-CZ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hGNs8-0004OR-9i
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:11:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>)
	id 1hGNs3-0004KL-73; Tue, 16 Apr 2019 09:11:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67704319939C;
	Tue, 16 Apr 2019 13:11:30 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-171.rdu2.redhat.com
	[10.10.120.171])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 55A3C608A4;
	Tue, 16 Apr 2019 13:11:24 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190416091348.26075-1-armbru@redhat.com>
	<20190416091348.26075-3-armbru@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f5ea42df-e9e0-7cbe-7a83-6a83911ee0a4@redhat.com>
Date: Tue, 16 Apr 2019 15:11:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190416091348.26075-3-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 16 Apr 2019 13:11:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/3] pflash_cfi01: New
 pflash_cfi01_legacy_drive()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org,
	mreitz@redhat.com, qemu-arm@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416131119.hoqkjgN3lIEONY16LR6_UGxlX4taFbd4zKyHuGh70Pg@z>

On 04/16/19 11:13, Markus Armbruster wrote:
> Factored out of pc_system_firmware_init() so the next commit can reuse

s/Factored/Factor/

(no need to repost, can be done in the PULL)

with that:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo

> it in hw/arm/virt.c.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/block/pflash_cfi01.c  | 28 ++++++++++++++++++++++++++++
>  hw/i386/pc_sysfw.c       | 16 ++--------------
>  include/hw/block/flash.h |  1 +
>  3 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 16dfae14b8..333b736277 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -44,9 +44,12 @@
>  #include "qapi/error.h"
>  #include "qemu/timer.h"
>  #include "qemu/bitops.h"
> +#include "qemu/error-report.h"
>  #include "qemu/host-utils.h"
>  #include "qemu/log.h"
> +#include "qemu/option.h"
>  #include "hw/sysbus.h"
> +#include "sysemu/blockdev.h"
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
>  
> @@ -968,6 +971,31 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl)
>      return &fl->mem;
>  }
>  
> +/*
> + * Handle -drive if=pflash for machines that use properties.
> + * If @dinfo is null, do nothing.
> + * Else if @fl's property "drive" is already set, fatal error.
> + * Else set it to the BlockBackend with @dinfo.
> + */
> +void pflash_cfi01_legacy_drive(PFlashCFI01 *fl, DriveInfo *dinfo)
> +{
> +    Location loc;
> +
> +    if (!dinfo) {
> +        return;
> +    }
> +
> +    loc_push_none(&loc);
> +    qemu_opts_loc_restore(dinfo->opts);
> +    if (fl->blk) {
> +        error_report("clashes with -machine");
> +        exit(1);
> +    }
> +    qdev_prop_set_drive(DEVICE(fl), "drive",
> +                        blk_by_legacy_dinfo(dinfo), &error_fatal);
> +    loc_pop(&loc);
> +}
> +
>  static void postload_update_cb(void *opaque, int running, RunState state)
>  {
>      PFlashCFI01 *pfl = opaque;
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 75925f5d3f..751fcafa12 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -269,9 +269,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
>  {
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>      int i;
> -    DriveInfo *pflash_drv;
>      BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
> -    Location loc;
>  
>      if (!pcmc->pci_enabled) {
>          old_pc_system_rom_init(rom_memory, true);
> @@ -280,18 +278,8 @@ void pc_system_firmware_init(PCMachineState *pcms,
>  
>      /* Map legacy -drive if=pflash to machine properties */
>      for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
> -        pflash_drv = drive_get(IF_PFLASH, 0, i);
> -        if (pflash_drv) {
> -            loc_push_none(&loc);
> -            qemu_opts_loc_restore(pflash_drv->opts);
> -            if (pflash_cfi01_get_blk(pcms->flash[i])) {
> -                error_report("clashes with -machine");
> -                exit(1);
> -            }
> -            qdev_prop_set_drive(DEVICE(pcms->flash[i]), "drive",
> -                                blk_by_legacy_dinfo(pflash_drv), &error_fatal);
> -            loc_pop(&loc);
> -        }
> +        pflash_cfi01_legacy_drive(pcms->flash[i],
> +                                  drive_get(IF_PFLASH, 0, i));
>          pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
>      }
>  
> diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
> index a0f488732a..1acaf7de80 100644
> --- a/include/hw/block/flash.h
> +++ b/include/hw/block/flash.h
> @@ -24,6 +24,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
>                                     int be);
>  BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl);
>  MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
> +void pflash_cfi01_legacy_drive(PFlashCFI01 *dev, DriveInfo *dinfo);
>  
>  /* pflash_cfi02.c */
>  
> 


