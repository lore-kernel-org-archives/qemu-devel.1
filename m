Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25EFC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 17:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0512075B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 17:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0512075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40281 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGS9k-0001rZ-Oj
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 13:46:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hGS8R-00017C-Qn
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hGS8P-0000IR-R9
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:44:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hGS8P-0000HV-HO
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:44:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so80408wmj.3
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 10:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Bq00CJtLI8I61lu1wtwWM736TU2yvwe2CldKn7p8VMo=;
	b=uZKvDI8iZ7mn63SMsgKhrDnEM9dB46llDMR5Y8E95hGIgziTlnMTq0U3NSbhe3Gaa2
	vZOQnKJOHjUVhMetVp5gDKpoO0N65ICkafZ1a+PTgVlQwWxEfbXwBUKdaX+IO1bxSHo2
	yYD8PleKSkdFz1bXRaP0HET4B99dyUUSJpmsO72QEEiU1BF6641FyRtzA6jmdlGsyU0H
	zkNli+a9ueZ0+Btpfms+IAq3R6X7n3P2quCGzNPFZrVelVm9M0Jq1oaPzr/YPnMBV3tL
	5fQoCC++hGGxAoKK4ahGOcx3qh+gROYmXXlcDyguzeh432loQ3X3sCWe9Cyq3Uju9rkv
	ZtOA==
X-Gm-Message-State: APjAAAWbDhiotyA3/Cy7B+cQBWCsN4QXum2zHpTUwiBRobmcc5CTjg/t
	TW6/g4dxYnxO/EsyPzkYsVD+uQ==
X-Google-Smtp-Source: APXvYqw4ytepuT7ADggmCyfgE3Mjm4PorxqayTbVwjU/tZQJNDViumOoDP8L3vysxY0Oy8nj5EMjEw==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr29669360wme.24.1555436680159;
	Tue, 16 Apr 2019 10:44:40 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	y5sm43184858wrw.23.2019.04.16.10.44.38
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 10:44:39 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190416091348.26075-1-armbru@redhat.com>
	<20190416091348.26075-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <03ecf4b0-c665-9677-b166-4d68f50cd70b@redhat.com>
Date: Tue, 16 Apr 2019 19:44:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416091348.26075-3-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
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
	mreitz@redhat.com, qemu-arm@nongnu.org, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416174438.OdRATXn5_PFQkRtSIzmypPN52loEtUh6Ai0TVoi9XVY@z>

On 4/16/19 11:13 AM, Markus Armbruster wrote:
> Factored out of pc_system_firmware_init() so the next commit can reuse
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

You can now remove the '#include "qemu/option.h"' in this file.

With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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

