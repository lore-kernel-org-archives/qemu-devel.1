Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D011C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC13920715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p4rjFTP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC13920715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j01cu-0005LY-75
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jean-philippe@linaro.org>) id 1j01bz-0004UH-AH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jean-philippe@linaro.org>) id 1j01bx-0003tN-Rf
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:15:51 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51321)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jean-philippe@linaro.org>)
 id 1j01bx-0003l9-Gy
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:15:49 -0500
Received: by mail-wm1-x341.google.com with SMTP id t23so2179252wmi.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=xYHv67DNi+rWOfFB5R5A2NkRt+ZhFgdMt32AuWdLHs4=;
 b=p4rjFTP/RXexqif0CgWYpyXIW0tii/JBhxwizecG5YBCa18kKE5t50OmUW3RMOJ07w
 xNKX9oKFsLOtkaNG3cbKKCr+yubl8BoxcVorDt5+bQDfBBIvGT7O/THJLCiSv6QrFmdv
 jNNmg3V1yfuG9TjWDvsHP9UnG8tMljrimzQtyWUAVlPubc7Eluxu+p+VKlvRnhLM0Qe0
 wc/NdTev34c9xr9Wqh3jztYRrv2dAVOCWtOlWng+fkkDKNoYxmOeXIaEvosyTFaSlt+n
 0RkbMhLZtrZxOPS/szdUvF0vJWW9ISxqat3SsK8InyQz86gSXLA56GvTjv7UMqVn0fQU
 yWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xYHv67DNi+rWOfFB5R5A2NkRt+ZhFgdMt32AuWdLHs4=;
 b=eyUVqMqMDvjsO+Cbo6mmbrAkrB4pnQtqQTWvCEBmIcaHiRH6SjngzCnrpuMwSLBId4
 LUgSd1+tmj6mfUumSoDfZjkqlaRsn2qZnRUYFv3hJd2YocbwJ2/EkS7Q7z9L3shjunkJ
 Fat9L+pwZdLKwYCjhGjpvQdNtu3CnGGDP4VJtIv2OnEbEUGTA4pSbzKbqSa98QFvzUga
 tJPHMNwmkLeRxTeclCKTJ8DpAQDcuHfE/GB4jj7k+8GTwV4lxC821CAL/ENGcybW04On
 Kzizx3ImlDDejeE6UGO1ZlUaaYRhKuCDtWbz9Hq34SyWs13FG+9pZehKGVHNNlLTOAhn
 HLdQ==
X-Gm-Message-State: APjAAAU5EeP7gsq7EmP9OTM1sWCth4ynhjUlO5LH6193aFTZUkvBCexS
 HJJHuK4odDUz4b1qMdSC0XSWZQ==
X-Google-Smtp-Source: APXvYqyah83o24vvoyS7+XA1QXhqziSFAKxrL8A5+RYbqyG+ZpaNajvqSKk+YofpBELqAdFsBbpuag==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr4061796wmk.5.1581074147694;
 Fri, 07 Feb 2020 03:15:47 -0800 (PST)
Received: from myrica ([2001:171b:c9ad:af70:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y20sm3084781wmi.23.2020.02.07.03.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 03:15:47 -0800 (PST)
Date: Fri, 7 Feb 2020 12:15:38 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v14 08/11] virtio-iommu-pci: Introduce the x-dt-binding
 option
Message-ID: <20200207111538.GB1999431@myrica>
References: <20200207093203.3788-1-eric.auger@redhat.com>
 <20200207093203.3788-9-eric.auger@redhat.com>
 <20200207052214-mutt-send-email-mst@kernel.org>
 <25d39300-46b9-571c-6fa6-44c5f8d0be99@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d39300-46b9-571c-6fa6-44c5f8d0be99@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 "Michael S. Tsirkin" <mst@redhat.com>, quintela@redhat.com,
 dgilbert@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 11:51:55AM +0100, Auger Eric wrote:
> Hi,
> 
> On 2/7/20 11:23 AM, Michael S. Tsirkin wrote:
> > On Fri, Feb 07, 2020 at 10:32:00AM +0100, Eric Auger wrote:
> >> At the moment, the kernel only supports device tree
> >> integration of the virtio-iommu. DT bindings between the
> >> PCI root complex and the IOMMU must be created by the machine
> >> in conformance to:
> >>
> >> Documentation/devicetree/bindings/virtio/iommu.txt.
> >>
> >> To make sure the end-user is aware of this, force him to use the
> >> temporary device option "x-dt-binding" and also double check the
> >> machine has a hotplug handler for the virtio-iommu-pci device.
> >> This hotplug handler is in charge of creating those DT bindings.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > how about setting it by default from machine class?
> Do you mean in ARM virt machine class? But this wouldn't prevent a user
> from launching an ACPI booted guest. I thought you wanted the end-user
> to know what he does.
> 
> I don't figure out a way to know if the guest is booted in dt or acpi
> mode. I can get access to those info:
> - whether acpi is enabled

That's the default on virt machine right?  Then if there is a FW it can
choose either ACPI or DT?

> - whether a FW is loaded
> 
> But a FW can be loaded, acpi enabled and eventually the guest is DT
> booted with acpi=off in kernel opts.
> 
> Maybe at this point I could only support the case where no FW is loaded.
> In machvirt I would not register the virtio-iommu-pci hotplug handler in
> case a FW is loaded. Then I could get rid of the new x-dt-binding prop.
> 
> Thoughts?

Yes, I'm hoping we can get the topology description into next version of
Linux, and it would be nicer not to introduce backward-compatible baggage
for something that should be solved within a few months. If we have to
warn the user then checking the FW seems like a good compromise, and easy
to remove later.

Thanks,
Jean

> 
> Eric
> > See
> > [PATCH 1/2] spapr: Disable legacy virtio devices for pseries-5.0 and later
> > [PATCH 2/2] spapr: Enable virtio iommu_platform=on by default
> > which does it for spapr.
> 
> > 
> >> ---
> >>
> >> May be squashed with previous patch
> >> ---
> >>  hw/virtio/virtio-iommu-pci.c | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
> >> index d539fcce75..3d06e14000 100644
> >> --- a/hw/virtio/virtio-iommu-pci.c
> >> +++ b/hw/virtio/virtio-iommu-pci.c
> >> @@ -14,6 +14,7 @@
> >>  #include "virtio-pci.h"
> >>  #include "hw/virtio/virtio-iommu.h"
> >>  #include "hw/qdev-properties.h"
> >> +#include "qapi/error.h"
> >>  
> >>  typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
> >>  
> >> @@ -27,10 +28,12 @@ typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
> >>  struct VirtIOIOMMUPCI {
> >>      VirtIOPCIProxy parent_obj;
> >>      VirtIOIOMMU vdev;
> >> +    bool dt_binding;
> >>  };
> >>  
> >>  static Property virtio_iommu_pci_properties[] = {
> >>      DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> >> +    DEFINE_PROP_BOOL("x-dt-binding", VirtIOIOMMUPCI, dt_binding, false),
> >>      DEFINE_PROP_END_OF_LIST(),
> >>  };
> >>  
> >> @@ -39,6 +42,21 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> >>      VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(vpci_dev);
> >>      DeviceState *vdev = DEVICE(&dev->vdev);
> >>  
> >> +    if (!dev->dt_binding) {
> >> +        error_setg(errp,
> >> +                   "Instantiation currently only is possible if the machine "
> >> +                   "creates device tree iommu-map bindings, ie. ACPI is not "
> >> +                   "yet supported");
> >> +        error_append_hint(errp, "use -virtio-iommu-pci,x-dt-binding\n");
> >> +        return;
> >> +    }
> >> +
> >> +    if (!qdev_get_machine_hotplug_handler(DEVICE(vpci_dev))) {
> >> +        error_setg(errp,
> >> +                   "The machine does not implement a virtio-iommu-pci hotplug "
> >> +                   " handler that creates the device tree iommu-map bindings");
> >> +       return;
> >> +    }
> >>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> >>      object_property_set_link(OBJECT(dev),
> >>                               OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
> >> -- 
> >> 2.20.1
> > 
> 

