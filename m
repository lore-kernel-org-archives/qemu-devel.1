Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD047C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88269206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl/YPtzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88269206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWJ1r-0007Bs-P1
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1jWJ1G-0006lV-MU; Wed, 06 May 2020 08:19:22 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1jWJ1D-0004fj-Jo; Wed, 06 May 2020 08:19:22 -0400
Received: by mail-wm1-x344.google.com with SMTP id k12so2340965wmj.3;
 Wed, 06 May 2020 05:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q5Os8dyJUPDIZSodvUQVJilx4gN1PaRSjUCuQBbM0mQ=;
 b=Zl/YPtzCbjnKh6wZrq+ztO4RT2QB7HVj/Fm35cN0vmJFvqFi13cmxN5LIsm5d03CLI
 fu0+rrx1Vna/2asInbpRTI7RCxeXJxZP0zCB3nZd5VQhDpxdoXdyVeiO1IB9OQH13UYd
 NYEvcWGgcIQpfRFnxGg8STfhlrXBReejpxNtxUS+nmDTHfwJe6j00fFUYhxDcBQeH2bn
 pdy77N2b5mgi6C04szucCsLccyVT2OOlGN7ebAjodQWwjdo00MAXtUcmlZP3oYtz89pt
 iKd/8rTY2QlN0FnxTaFVTQzzm2qN6TTpzHTpF51Phw/g/i0Wn1opMGqz8Yh8AHFYdY94
 lirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q5Os8dyJUPDIZSodvUQVJilx4gN1PaRSjUCuQBbM0mQ=;
 b=RyKh+xrJvcUeXwqUsGMALacTgxT7/ZW4oX3G9T78MDo8HgwejxZlKnL8lBPjbq8gl6
 HWI+lc1Fi1Ub9a7mX34IZBrlaHWIyRs3pGUKx64Fj04+zQZn7G6EzSPqnh5s29t6LT9f
 pF4DVx+GRAQzfqeJUK47daH0pC/7jXpdqy1KcUTECkwMMCesbNxZfTnh978ddQNRYpfd
 0OhrJqQsX0OZEZ5tOE9eru6/5tiemqzX8Zgk4YKyKBK7n3gsPCTCgoee875aYYq49U3/
 w3d56bVaG4iP9dLnaC3Nb4LTn5S3nYPKHZ3R2QUCfB2lRu4eCW22GxeWrHqnZLOvF5on
 oiIA==
X-Gm-Message-State: AGi0PuZ/pIYCaQ7EzyzqWOII4D7fBvYNsHtrORW9PCeXJo/H6K4s9+Y9
 ifs/SgxyhzQAvqVnxgOxzgzZFe83rhCgzxhZVm4=
X-Google-Smtp-Source: APiQypLeVpH913RfqJfPYP+brXYqrIS3pVomgf/Ib0DVEAcv2ZzAJrpwgG3sdpFOPJ5/HfFPbqmzCByzbt0QkhZ5Ytk=
X-Received: by 2002:a1c:3c08:: with SMTP id j8mr4111430wma.30.1588767557342;
 Wed, 06 May 2020 05:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200506094948.76388-1-david@redhat.com>
 <20200506094948.76388-16-david@redhat.com>
In-Reply-To: <20200506094948.76388-16-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 6 May 2020 14:19:06 +0200
Message-ID: <CAM9Jb+gZGjWUthoU4E3U4nAowa2Kr8_5PWBZ0VkdAtL86TPE2A@mail.gmail.com>
Subject: Re: [PATCH v1 15/17] pc: Support for virtio-mem-pci
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Let's wire it up similar to virtio-pmem. Also disallow unplug, so it's
> harder for users to shoot themselves into the foot.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/i386/Kconfig |  1 +
>  hw/i386/pc.c    | 49 ++++++++++++++++++++++++++++---------------------
>  2 files changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index c93f32f657..03e347b207 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -35,6 +35,7 @@ config PC
>      select ACPI_PCI
>      select ACPI_VMGENID
>      select VIRTIO_PMEM_SUPPORTED
> +    select VIRTIO_MEM_SUPPORTED
>
>  config PC_PCI
>      bool
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f6b8431c8b..588804f895 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -86,6 +86,7 @@
>  #include "hw/net/ne2000-isa.h"
>  #include "standard-headers/asm-x86/bootparam.h"
>  #include "hw/virtio/virtio-pmem-pci.h"
> +#include "hw/virtio/virtio-mem-pci.h"
>  #include "hw/mem/memory-device.h"
>  #include "sysemu/replay.h"
>  #include "qapi/qmp/qerror.h"
> @@ -1654,8 +1655,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      numa_cpu_pre_plug(cpu_slot, dev, errp);
>  }
>
> -static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
> -                                        DeviceState *dev, Error **errp)
> +static void pc_virtio_md_pci_pre_plug(HotplugHandler *hotplug_dev,
> +                                      DeviceState *dev, Error **errp)
>  {
>      HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
>      Error *local_err = NULL;
> @@ -1666,7 +1667,8 @@ static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
>           * order. This should never be the case on x86, however better add
>           * a safety net.
>           */
> -        error_setg(errp, "virtio-pmem-pci not supported on this bus.");
> +        error_setg(errp,
> +                   "virtio based memory devices not supported on this bus.");
>          return;
>      }
>      /*
> @@ -1681,8 +1683,8 @@ static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
>      error_propagate(errp, local_err);
>  }
>
> -static void pc_virtio_pmem_pci_plug(HotplugHandler *hotplug_dev,
> -                                    DeviceState *dev, Error **errp)
> +static void pc_virtio_md_pci_plug(HotplugHandler *hotplug_dev,
> +                                  DeviceState *dev, Error **errp)
>  {
>      HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
>      Error *local_err = NULL;
> @@ -1700,17 +1702,17 @@ static void pc_virtio_pmem_pci_plug(HotplugHandler *hotplug_dev,
>      error_propagate(errp, local_err);
>  }
>
> -static void pc_virtio_pmem_pci_unplug_request(HotplugHandler *hotplug_dev,
> -                                              DeviceState *dev, Error **errp)
> +static void pc_virtio_md_pci_unplug_request(HotplugHandler *hotplug_dev,
> +                                            DeviceState *dev, Error **errp)
>  {
> -    /* We don't support virtio pmem hot unplug */
> -    error_setg(errp, "virtio pmem device unplug not supported.");
> +    /* We don't support hot unplug of virtio based memory devices */
> +    error_setg(errp, "virtio based memory devices cannot be unplugged.");
>  }
>
> -static void pc_virtio_pmem_pci_unplug(HotplugHandler *hotplug_dev,
> -                                      DeviceState *dev, Error **errp)
> +static void pc_virtio_md_pci_unplug(HotplugHandler *hotplug_dev,
> +                                    DeviceState *dev, Error **errp)
>  {
> -    /* We don't support virtio pmem hot unplug */
> +    /* We don't support hot unplug of virtio based memory devices */
>  }
>
>  static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> @@ -1720,8 +1722,9 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>          pc_memory_pre_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_pre_plug(hotplug_dev, dev, errp);
> -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
> -        pc_virtio_pmem_pci_pre_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
> +               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> +        pc_virtio_md_pci_pre_plug(hotplug_dev, dev, errp);
>      }
>  }
>
> @@ -1732,8 +1735,9 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>          pc_memory_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_plug(hotplug_dev, dev, errp);
> -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
> -        pc_virtio_pmem_pci_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
> +               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> +        pc_virtio_md_pci_plug(hotplug_dev, dev, errp);
>      }
>  }
>
> @@ -1744,8 +1748,9 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>          pc_memory_unplug_request(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
> -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
> -        pc_virtio_pmem_pci_unplug_request(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
> +               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> +        pc_virtio_md_pci_unplug_request(hotplug_dev, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug request for not supported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -1759,8 +1764,9 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
>          pc_memory_unplug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_unplug_cb(hotplug_dev, dev, errp);
> -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
> -        pc_virtio_pmem_pci_unplug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
> +               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> +        pc_virtio_md_pci_unplug(hotplug_dev, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug for not supported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -1772,7 +1778,8 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
>          object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
> -        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
>          return HOTPLUG_HANDLER(machine);
>      }
>
> --

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.25.3
>
>

