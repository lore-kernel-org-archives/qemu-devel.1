Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC6AC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3AA62076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="tYTlxTHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AA62076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThXs-0005uo-JQ
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jTh8n-0003uQ-6t
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jTh8m-0001fm-Jd
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:28:20 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:57580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jTh8j-0001TZ-S2; Wed, 29 Apr 2020 03:28:18 -0400
Received: from [172.17.10.6] (unknown [172.17.10.6])
 by beetle.greensocs.com (Postfix) with ESMTPSA id CC6A996EF0;
 Wed, 29 Apr 2020 07:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1588145296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmGDo8BRETGZBlkt2JiIXD8QKpYsSIx2sNRNaCHh0Vg=;
 b=tYTlxTHiDsgfPhsKhhSta3a5l/HW5ZQuM5y35yVbzLYXrCrrY8zUfHQoV2qEuyEC6ykkXH
 pRGCHTXXrdGU4389sLSEGGyfd+FAT1ULUFcNqRhtp00y1dO1DOi2pJLpxvMVdi7MDJ8NsR
 w5eJazblQsw0nT9R2ODQshqicR0+jso=
Subject: Re: [PATCH v1 07/11] hw/arm: versal: Embedd the APUs into the SoC type
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-8-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <bf2493aa-853d-6b2b-efaa-6b8084a71270@greensocs.com>
Date: Wed, 29 Apr 2020 09:28:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427181649.26851-8-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1588145296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmGDo8BRETGZBlkt2JiIXD8QKpYsSIx2sNRNaCHh0Vg=;
 b=y6eLxXDl4A/HHELAZV2BKWw7tq6W55yGgmBuJxOCRwe+xz59wiT85laEnbqe3CbXj4mLR+
 CvynaQZXEN6WCbEc8sOwZj6BFk4k6mqObQLScGiFmuq9t0sxQfbUUkJcXO4xPCVPB564hv
 FMHR5UJpEO4uSO2XDwNGaqaVAIQUTFU=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1588145296; a=rsa-sha256; cv=none;
 b=G5VVo4St3h4Tp+JhALwpozYaWovt8bc/Ge0SI1x0tRHLKPoYepG5Fu2v6IUhKqsG0j4XGg
 pIQz0wCfI2bHJnRoDKvol1aOmB5t5qWmbT+ReZIuGFEJWrThzCWudVwoJ7fgL+Q1dEkb+F
 p3UKkzBHQys0//VLrruEkSvIUMOyGKU=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 03:23:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 5.135.226.135
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 8:16 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Embedd the APUs into the SoC type.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/xlnx-versal-virt.c    |  4 ++--
>  hw/arm/xlnx-versal.c         | 19 +++++--------------
>  include/hw/arm/xlnx-versal.h |  2 +-
>  3 files changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 8a608074d1..d7be1ad494 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -469,9 +469,9 @@ static void versal_virt_init(MachineState *machine)
>      s->binfo.get_dtb = versal_virt_get_dtb;
>      s->binfo.modify_dtb = versal_virt_modify_dtb;
>      if (machine->kernel_filename) {
> -        arm_load_kernel(s->soc.fpd.apu.cpu[0], machine, &s->binfo);
> +        arm_load_kernel(&s->soc.fpd.apu.cpu[0], machine, &s->binfo);
>      } else {
> -        AddressSpace *as = arm_boot_address_space(s->soc.fpd.apu.cpu[0],
> +        AddressSpace *as = arm_boot_address_space(&s->soc.fpd.apu.cpu[0],
>                                                    &s->binfo);
>          /* Some boot-loaders (e.g u-boot) don't like blobs at address 0 (NULL).
>           * Offset things by 4K.  */
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index ebd2dc51be..c8a296e2e0 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -31,19 +31,11 @@ static void versal_create_apu_cpus(Versal *s)
>  
>      for (i = 0; i < ARRAY_SIZE(s->fpd.apu.cpu); i++) {
>          Object *obj;
> -        char *name;
> -
> -        obj = object_new(XLNX_VERSAL_ACPU_TYPE);
> -        if (!obj) {
> -            error_report("Unable to create apu.cpu[%d] of type %s",
> -                         i, XLNX_VERSAL_ACPU_TYPE);
> -            exit(EXIT_FAILURE);
> -        }
> -
> -        name = g_strdup_printf("apu-cpu[%d]", i);
> -        object_property_add_child(OBJECT(s), name, obj, &error_fatal);
> -        g_free(name);
>  
> +        object_initialize_child(OBJECT(s), "apu-cpu[*]",
> +                                &s->fpd.apu.cpu[i], sizeof(s->fpd.apu.cpu[i]),
> +                                XLNX_VERSAL_ACPU_TYPE, &error_abort, NULL);
> +        obj = OBJECT(&s->fpd.apu.cpu[i]);
>          object_property_set_int(obj, s->cfg.psci_conduit,
>                                  "psci-conduit", &error_abort);
>          if (i) {
> @@ -57,7 +49,6 @@ static void versal_create_apu_cpus(Versal *s)
>          object_property_set_link(obj, OBJECT(&s->fpd.apu.mr), "memory",
>                                   &error_abort);
>          object_property_set_bool(obj, true, "realized", &error_fatal);
> -        s->fpd.apu.cpu[i] = ARM_CPU(obj);
>      }
>  }
>  
> @@ -95,7 +86,7 @@ static void versal_create_apu_gic(Versal *s, qemu_irq *pic)
>      }
>  
>      for (i = 0; i < nr_apu_cpus; i++) {
> -        DeviceState *cpudev = DEVICE(s->fpd.apu.cpu[i]);
> +        DeviceState *cpudev = DEVICE(&s->fpd.apu.cpu[i]);
>          int ppibase = XLNX_VERSAL_NR_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
>          qemu_irq maint_irq;
>          int ti;
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 94b7826fd4..426b66449d 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -36,7 +36,7 @@ typedef struct Versal {
>      struct {
>          struct {
>              MemoryRegion mr;
> -            ARMCPU *cpu[XLNX_VERSAL_NR_ACPUS];
> +            ARMCPU cpu[XLNX_VERSAL_NR_ACPUS];
>              GICv3State gic;
>          } apu;
>      } fpd;
> 

