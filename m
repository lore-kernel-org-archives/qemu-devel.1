Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22671C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3EE2084C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAxqsLKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3EE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqvwg-0004bm-7Y
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqvuY-0002ae-Iy
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:53:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37163
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqvuW-0007C0-VS
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593683620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O26eO9dww7SoZj+u4N4xZ3FyGyXieM9XWjJjsAoiUAw=;
 b=ZAxqsLKJklWWKXrSMknWvnL38HyHJgyexcLQCY6F8QmaTy+oQ21l/1qGNwghbLlBsgT/UT
 AbTniOziSIvwMeyfP0ZabfgqkCK/pcScHtpoWlpy/HikD0CVO3Mje6d6T9N6Spwr3zm+Xv
 nFzKVyVGXAzT7hcrGXa0bPnMHnT/AQs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-by4Z-72nOeWI8o6lpJQFCg-1; Thu, 02 Jul 2020 05:53:38 -0400
X-MC-Unique: by4Z-72nOeWI8o6lpJQFCg-1
Received: by mail-wm1-f69.google.com with SMTP id g138so18899010wme.7
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 02:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O26eO9dww7SoZj+u4N4xZ3FyGyXieM9XWjJjsAoiUAw=;
 b=leWcCaFJ+5rJ0S7b8ozU+oSUuGC4m3Q8txAO3qcdNigsy/nD7KI7O8URLB6LSRLcbk
 MAgvuwERuUH+XZGxIblzSf9e4MMegSDH5v6WwEKEd/N2l0ns1xycJ9f69NPAyVqVsC0l
 JrsYNAjKQBVjt581XG788/auREbB/NTFuaHp5pY+B8rotifAMYMJaammNH56SQ5tYjiJ
 P8Gp34Xx4ZAykrTgTvfP9HKsMKdDFbbMeQbGS3jPYOi0bypF4q7dS1DNH8BSzbshI3FJ
 UrikbJJO9qAdznm/ubWWm8nL6EvzRLXBOq8KEH1mXQ9UVPkquuLnyjE/xvGm39NmOlIP
 s5zw==
X-Gm-Message-State: AOAM5314HKf5nZfZB+SAHd2zPIVCaarNB6d0ZaOROUcx9ju373HkIdp4
 p0LCYq0qNfkkvjr1AWAt7KZ6GoODLcj8TrqEK9yx+umM2fAChfm9xMXcQzgH1HVkJXq7qZ0fGoS
 5o5Y1nCkySxLbt3E=
X-Received: by 2002:a7b:c185:: with SMTP id y5mr32069307wmi.85.1593683617231; 
 Thu, 02 Jul 2020 02:53:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZo9eVf1robnTalfkW8acuZDzuyGpZMGiCg4UylNcT7p/f66302iEKqhRfZO8ShVFD/fvE5w==
X-Received: by 2002:a7b:c185:: with SMTP id y5mr32069273wmi.85.1593683616997; 
 Thu, 02 Jul 2020 02:53:36 -0700 (PDT)
Received: from redhat.com ([93.157.82.4])
 by smtp.gmail.com with ESMTPSA id d13sm10213851wrq.89.2020.07.02.02.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 02:53:36 -0700 (PDT)
Date: Thu, 2 Jul 2020 05:53:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 3/4] hw/arm/virt-acpi-build: Only expose flash on older
 machine types
Message-ID: <20200702055245-mutt-send-email-mst@kernel.org>
References: <20200629140938.17566-1-drjones@redhat.com>
 <20200629140938.17566-4-drjones@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200629140938.17566-4-drjones@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, eric.auger@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
 ard.biesheuvel@arm.com, imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 04:09:37PM +0200, Andrew Jones wrote:
> The flash device is exclusively for the host-controlled firmware, so
> we should not expose it to the OS. Exposing it risks the OS messing
> with it, which could break firmware runtime services and surprise the
> OS when all its changes disappear after reboot.
> 
> As firmware needs the device and uses DT, we leave the device exposed
> there. It's up to firmware to remove the nodes from DT before sending
> it on to the OS. However, there's no need to force firmware to remove
> tables from ACPI (which it doesn't know how to do anyway), so we
> simply don't add the tables in the first place. But, as we've been
> adding the tables for quite some time and don't want to change the
> default hardware exposed to versioned machines, then we only stop
> exposing the flash device tables for 5.1 and later machine types.
> 
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Andrew Jones <drjones@redhat.com>

So who's merging this? Mostly ACPI things so I guess my tree?
If so can I get acks from ARM maintainers pls?

Thanks!

> ---
>  hw/arm/virt-acpi-build.c | 5 ++++-
>  hw/arm/virt.c            | 3 +++
>  include/hw/arm/virt.h    | 1 +
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 1384a2cf2ab4..91f0df7b13a3 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -749,6 +749,7 @@ static void build_fadt_rev5(GArray *table_data, BIOSLinker *linker,
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>      Aml *scope, *dsdt;
>      MachineState *ms = MACHINE(vms);
>      const MemMapEntry *memmap = vms->memmap;
> @@ -767,7 +768,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      acpi_dsdt_add_cpus(scope, vms->smp_cpus);
>      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
>                         (irqmap[VIRT_UART] + ARM_SPI_BASE));
> -    acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> +    if (vmc->acpi_expose_flash) {
> +        acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> +    }
>      acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
>      acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
>                      (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index cd0834ce7faf..5adc9ff799ef 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2482,9 +2482,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
>  
>  static void virt_machine_5_0_options(MachineClass *mc)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
>      virt_machine_5_1_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
>      mc->numa_mem_supported = true;
> +    vmc->acpi_expose_flash = true;
>  }
>  DEFINE_VIRT_MACHINE(5, 0)
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 31878ddc7223..c65be5fe0bb6 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -119,6 +119,7 @@ typedef struct {
>      bool no_highmem_ecam;
>      bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device */
>      bool kvm_no_adjvtime;
> +    bool acpi_expose_flash;
>  } VirtMachineClass;
>  
>  typedef struct {
> -- 
> 2.25.4


