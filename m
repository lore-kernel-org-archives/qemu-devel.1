Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2E4C43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0DF21BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQaYgTiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0DF21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKIaB-0007n1-J8
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 05:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKIZX-0007BC-Hj; Mon, 21 Sep 2020 05:57:23 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKIZV-0004j3-Py; Mon, 21 Sep 2020 05:57:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id d4so11492036wmd.5;
 Mon, 21 Sep 2020 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GcMjtlI+P2B/XqlHcq35F91kq62v1kAMu9scNKn/YxQ=;
 b=oQaYgTizxHF0j+bNrBeTVem5deGeXsJBbjeVoS/Jm21r/gDg/Ntwi14N8iDC6oqmz1
 lp3lG1cZyFQShjNlS2NcEmD34H3BT/dARZkekqMn77uwDbv2H/W8QdTes/qOejhpI0IF
 yIyYwYVjUF8m1J+mBoSP+HCB7hiChs9JwKiDlf19zGgXcB5clSbpYTPnFeTkMYQmJIn2
 jRqYSfFLWJFLp2IlPIPblJNkcAYjm9nLWU/tlQgtidHdLOqXCzxY080Bay8Vg8qMyvMi
 ddS/F5bFFTyGPzsRCAjNfLUGoKWL2ZArvMaABmuxIBU8SAYVyN4JIb5rK4d4yeADua7t
 dG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GcMjtlI+P2B/XqlHcq35F91kq62v1kAMu9scNKn/YxQ=;
 b=WAqkYpUmTt8moD3+O+ZdO+bhoSgRHm1Lvo6/FQgF0E7tQWLE+Khy60e4U/HUWzilnh
 wIODJT/0s3D9KQR5YE9akynLKFqIABXzM86YskCYCJCuBS4Fl+fhqHuVdJzXpU3a8do+
 tz0903y7+Z1nil1Vl8iuK16+mJkAPvNrEpB5JQ7g7QT5yrKXrplLLWWTp/85CwHEemHe
 FWPg899TGiYtV5Col5uf+Z66eh+mLqR6z0o6NP8oFMhL8IyJBsHYUQ8vaBVCtKOQNm7g
 K4vtqL+k1qATIpQQsQuwb6g5c92BwZP3T90u2KqZw5DAJFHsfzHeinAovWEfqunHUzJC
 wOGw==
X-Gm-Message-State: AOAM533hPY4I7LCNIw7Z6xJSwP1wohDqWkw7T6YqH+UlqIu1CuPLU/jN
 ef3lwY4lySLAykBXpxIAPyp6Tw/VZm0=
X-Google-Smtp-Source: ABdhPJxZOrKfbEShQFKvsONddvHETd8pFKukXr9L8ejb+Uwgw1ULmD1cCYupqUwa3SUkl+IcFQwzpw==
X-Received: by 2002:a7b:c749:: with SMTP id w9mr27680000wmk.29.1600682239032; 
 Mon, 21 Sep 2020 02:57:19 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l18sm19839086wrp.84.2020.09.21.02.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 02:57:18 -0700 (PDT)
Subject: Re: [PATCH 4/6] sparc32-ledma: don't reference nd_table directly
 within the device
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, armbru@redhat.com,
 david@gibson.dropbear.id.au, atar4qemu@gmail.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20200920082018.16135-1-mark.cave-ayland@ilande.co.uk>
 <20200920082018.16135-5-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0ea7090a-34f0-d437-1c7d-34570b529943@amsat.org>
Date: Mon, 21 Sep 2020 11:57:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200920082018.16135-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Mark,

On 9/20/20 10:20 AM, Mark Cave-Ayland wrote:
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
> index 947b69d159..ed5f3ccd9f 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -319,7 +319,7 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
>  
>  static void *sparc32_dma_init(hwaddr dma_base,
>                                hwaddr esp_base, qemu_irq espdma_irq,
> -                              hwaddr le_base, qemu_irq ledma_irq)
> +                              hwaddr le_base, qemu_irq ledma_irq, NICInfo *nd)

Instead of passing NICInfo to sparc32_dma_init,
shouldn't you extract the lance code from it?

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
> @@ -854,6 +857,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>      unsigned int max_cpus = machine->smp.max_cpus;
>      Object *ram_memdev = object_resolve_path_type(machine->ram_memdev_id,
>                                                    TYPE_MEMORY_BACKEND, NULL);
> +    NICInfo *nd = &nd_table[0];
>  
>      if (machine->ram_size > hwdef->max_mem) {
>          error_report("Too much memory for this machine: %" PRId64 ","
> @@ -914,9 +918,10 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
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
> @@ -1047,7 +1052,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>                                      machine->initrd_filename,
>                                      machine->ram_size, &initrd_size);
>  
> -    nvram_init(nvram, (uint8_t *)&nd_table[0].macaddr, machine->kernel_cmdline,
> +    nvram_init(nvram, (uint8_t *)&nd->macaddr, machine->kernel_cmdline,
>                 machine->boot_order, machine->ram_size, kernel_size,
>                 graphic_width, graphic_height, graphic_depth,
>                 hwdef->nvram_machine_id, "Sun4m");
> 


