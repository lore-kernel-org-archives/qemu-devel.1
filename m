Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251D7C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 20:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025B02388E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 20:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeNLozAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025B02388E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMGYB-0004Ns-1F
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 16:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMGXU-0003sz-AF; Sat, 26 Sep 2020 16:11:24 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMGXS-0008LR-E8; Sat, 26 Sep 2020 16:11:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id q9so2575904wmj.2;
 Sat, 26 Sep 2020 13:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N7JJ2ELI7NTs30q+e7+u/Osr0OGMCRpCEyAb3VLMJkg=;
 b=jeNLozAYq23h2+V1+8CwWtqa/so5LENZrRoTNRZcn/dHrMERNKBUiHfjoAnicV2xW5
 VWiIvCwFIvPl6t3Xi/aTW2Sn2kpFtVcbiWuGzj7xL5EDAGL8PwTSqwU+jdADleYQcow+
 PVstynG2D4fg7y1XrtI/sacqTNIO4Xbxhr0GZ6b4FYSswgJtELPL/dZMeWCoImMpXDj9
 tOr8iVUaFtInZ9xKJHOo+HidFqjQTcMawgtH5nuKqrlgqVtOnY+f03YMmG++Q4xoTbEp
 llaXyhOboo6jIxk3atL0sWNBq4HCZUkC8tIqFHYBrZYVHUS94WAg4P2YHJJ3gSdLdH8N
 vGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=N7JJ2ELI7NTs30q+e7+u/Osr0OGMCRpCEyAb3VLMJkg=;
 b=s3iycGuYKAJO4rUWBuDhg6gRwKS5l5wbv9Q3fHOdwPWbRUz/3/k5QzYr9sFOaMhORj
 hd3l5nuMBmICZIoeQqroI4RgIZ3SVah0ClDOVWXpipxmI4tMcv1uzMz73woCtTKgpIFq
 pgx3DB0WMus8GphA4hibZIML4KVwxMjH9+JQ2YYk/3bxufjryarWKv0onnhxWDEyoFCy
 8XjtIOZPmeKUVDX4ThPBjHjM3dcgQ0no5EA9smYricO3iu3z62A7vT3ghskIHU9uWf3o
 eaC6p50Mxhmdf0Q0fKBOek1oGalXrLHvpZ3tFPW3t0TV1f4MjG0mw+8jS4tDA0dzTAlk
 RKow==
X-Gm-Message-State: AOAM531WOw9J7EiPSCsVFSm0Hl7fAIIsiu8wAeQ93QBPiavew1I3RWdK
 HRatW7YEisZUD0+a11+V8JCAbKd68sM=
X-Google-Smtp-Source: ABdhPJwfD/nbz9Ag+GfkDNv6qUxX6Aq0Hm8hWQBlm/iuCYW+jLFHPw7HLT9UlF79WCHYtSVzNxCL+g==
X-Received: by 2002:a1c:7912:: with SMTP id l18mr3856019wme.124.1601151079650; 
 Sat, 26 Sep 2020 13:11:19 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id l8sm7671599wrx.22.2020.09.26.13.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 13:11:18 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] sparc32-ledma: don't reference nd_table directly
 within the device
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, armbru@redhat.com,
 david@gibson.dropbear.id.au, atar4qemu@gmail.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20200926140216.7368-1-mark.cave-ayland@ilande.co.uk>
 <20200926140216.7368-5-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <63b68364-672c-1401-fe10-f674b2dae037@amsat.org>
Date: Sat, 26 Sep 2020 22:11:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200926140216.7368-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.213,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/20 4:02 PM, Mark Cave-Ayland wrote:
> Instead use qdev_set_nic_properties() to configure the on-board NIC at the
> sun4m machine level.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/dma/sparc32_dma.c |  5 -----
>  hw/sparc/sun4m.c     | 21 +++++++++++++--------
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index 2cbe331959..b643b413c5 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -342,12 +342,7 @@ static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
>  {
>      LEDMADeviceState *s = SPARC32_LEDMA_DEVICE(dev);
>      SysBusPCNetState *lance = SYSBUS_PCNET(&s->lance);
> -    NICInfo *nd = &nd_table[0];
>  
> -    /* FIXME use qdev NIC properties instead of nd_table[] */
> -    qemu_check_nic_model(nd, TYPE_LANCE);
> -
> -    qdev_set_nic_properties(DEVICE(lance), nd);
>      object_property_set_link(OBJECT(lance), "dma", OBJECT(dev), &error_abort);
>      sysbus_realize(SYS_BUS_DEVICE(lance), &error_fatal);
>  }
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 54a2b2f9ef..6765982fe9 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -319,7 +319,7 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
>  
>  static void *sparc32_dma_init(hwaddr dma_base,
>                                hwaddr esp_base, qemu_irq espdma_irq,
> -                              hwaddr le_base, qemu_irq ledma_irq)
> +                              hwaddr le_base, qemu_irq ledma_irq, NICInfo *nd)
>  {
>      DeviceState *dma;
>      ESPDMADeviceState *espdma;
> @@ -328,16 +328,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
>      SysBusPCNetState *lance;
>  
>      dma = qdev_new(TYPE_SPARC32_DMA);
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
> -
>      espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
>                                     OBJECT(dma), "espdma"));
>      sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
>  
>      esp = ESP(object_resolve_path_component(OBJECT(espdma), "esp"));
> -    sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
> -    scsi_bus_legacy_handle_cmdline(&esp->esp.bus);
>  
>      ledma = SPARC32_LEDMA_DEVICE(object_resolve_path_component(
>                                   OBJECT(dma), "ledma"));
> @@ -345,6 +340,14 @@ static void *sparc32_dma_init(hwaddr dma_base,
>  
>      lance = SYSBUS_PCNET(object_resolve_path_component(
>                           OBJECT(ledma), "lance"));
> +    qdev_set_nic_properties(DEVICE(lance), nd);

There is smth odd in how lance is created. It would be clearer to
create TYPE_SPARC32_LEDMA_DEVICE instance_init() of TYPE_SPARC32_DMA.

Can be cleared later, so:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
> +    scsi_bus_legacy_handle_cmdline(&esp->esp.bus);
> +
>      sysbus_mmio_map(SYS_BUS_DEVICE(lance), 0, le_base);
>  
>      return dma;
> @@ -850,6 +853,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>      unsigned int max_cpus = machine->smp.max_cpus;
>      Object *ram_memdev = object_resolve_path_type(machine->ram_memdev_id,
>                                                    TYPE_MEMORY_BACKEND, NULL);
> +    NICInfo *nd = &nd_table[0];
>  
>      if (machine->ram_size > hwdef->max_mem) {
>          error_report("Too much memory for this machine: %" PRId64 ","
> @@ -910,9 +914,10 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>                          hwdef->iommu_pad_base, hwdef->iommu_pad_len);
>      }
>  
> +    qemu_check_nic_model(nd, TYPE_LANCE);
>      sparc32_dma_init(hwdef->dma_base,
>                       hwdef->esp_base, slavio_irq[18],
> -                     hwdef->le_base, slavio_irq[16]);
> +                     hwdef->le_base, slavio_irq[16], nd);
>  
>      if (graphic_depth != 8 && graphic_depth != 24) {
>          error_report("Unsupported depth: %d", graphic_depth);
> @@ -1043,7 +1048,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>                                      machine->initrd_filename,
>                                      machine->ram_size, &initrd_size);
>  
> -    nvram_init(nvram, (uint8_t *)&nd_table[0].macaddr, machine->kernel_cmdline,
> +    nvram_init(nvram, (uint8_t *)&nd->macaddr, machine->kernel_cmdline,
>                 machine->boot_order, machine->ram_size, kernel_size,
>                 graphic_width, graphic_height, graphic_depth,
>                 hwdef->nvram_machine_id, "Sun4m");
> 


