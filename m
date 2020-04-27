Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A363EC81CFF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 22:30:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6784D206D9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 22:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUoLXUMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6784D206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTCH5-0003eb-G2
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 18:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTCFF-0000kL-2X
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 18:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTCFE-0004pX-Dh
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 18:28:56 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:43218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jTCFE-0004gG-0X; Mon, 27 Apr 2020 18:28:56 -0400
Received: by mail-io1-xd42.google.com with SMTP id 19so20692996ioz.10;
 Mon, 27 Apr 2020 15:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ju2jKZ21QV29q1siA4KW+cjXBNIc1W7uUcHg60LkNr8=;
 b=NUoLXUMfTK7614ppGI9bD6QBXFJFKXxwC6hG4gLr1J10PQsHNTDXUcTV45JLYME5Np
 pJWoVQ5vuNbQfHFrxJGjypMhmbymw3N2a6mdIliaELtkjFBz6aUiZc8ORFmgbmoSK0VP
 C+sSGdyD0rzgER7fyEf134TKLfGommfyv7pvW6i5TQxuZS5GrF09tSAxMH+pJv0+hU2p
 elcUEesbHcNszBgapJYs/1LSLZwCPZu3ayjsaAivE/0GI1GjWPIvBjil7S8G3PxL4q4r
 zkwS/fZeTKMzSt3Z5h9VUl+chIRapNon69WPLefeviIKfZX5LYYrVzWor52SJxjXr41Y
 OmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ju2jKZ21QV29q1siA4KW+cjXBNIc1W7uUcHg60LkNr8=;
 b=tmdPfJFTiC1nbZKce2HtHNfYLIjTpiVSTYZU3ElOycMauH7JXsrZIFtGO8+Z3v926L
 fb4MKL+aVZZRUVFdYosB1uy/WTJybxaqncxJuVZ8JjPlNOs85BEwVcVQmlyrcyWXzf8k
 H0iLDR6ji0l89fWSo4ETDstdZ7Ye5glMfoIdDVIH9VEZ0goG+RFTRWlDm4+1z9d4I7Dc
 lHRX0ZoIfMhS19Nq/A5CQkGvTKWHfGrO5W1r4G8G3PtTH46tZJ69WXDLoeb9AatFVU8X
 q5FZRuMLlzJaXXCc/s3EqcHYjd/5CxfPMc4li6wFJ1itHKWGHkzLLv3fImDEsqyy5qtO
 WqFQ==
X-Gm-Message-State: AGi0PuZgMsTY7TpGYX3sDL3j4JfeWdPwKczXJrzEd8gA1YbhPtxb2uws
 EWg3MTwWfeFIFkkR/Vv+K1aC7tzp9VwsfwpmdPk=
X-Google-Smtp-Source: APiQypJfMoK2Ru5LVJhQr4GO4P4xkBe2wHbvbngn2cFN/Ca+U3Mom4OBtQBd6QkcT+t7VpWzXl7BIEIIEwPQ9qizL/g=
X-Received: by 2002:a05:6602:d:: with SMTP id
 b13mr23423004ioa.176.1588026534550; 
 Mon, 27 Apr 2020 15:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-8-edgar.iglesias@gmail.com>
In-Reply-To: <20200427181649.26851-8-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 Apr 2020 15:20:16 -0700
Message-ID: <CAKmqyKMoXWg-2gWX9-p3zqH3Dh=27-aGwELgzE-Juie2vdc1XA@mail.gmail.com>
Subject: Re: [PATCH v1 07/11] hw/arm: versal: Embedd the APUs into the SoC type
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 11:20 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Embedd the APUs into the SoC type.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> --
> 2.20.1
>
>

