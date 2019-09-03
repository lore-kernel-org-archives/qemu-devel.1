Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B97C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AAD217D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 11:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg/M5xZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AAD217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i56eH-0001T4-O0
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 07:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <skrtbhtngr@gmail.com>) id 1i56dZ-00011l-DR
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <skrtbhtngr@gmail.com>) id 1i56dY-0000yv-6j
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:06:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
 id 1i56dY-0000xl-0M
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 07:06:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id r195so1451893wme.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZQpan4Ceh87r7qtgmPZ7unAJ7HVgPrOUBdfCKgEtu8U=;
 b=Kg/M5xZG0rvyRhPZfcCDTtBQYvcFnmoGNGdQz7wnHqNjmY2RUuV84h1zSmBlK8+RWL
 IU43ukMAmJhh38C+eUB+a8MTWCYDpzzuw02C1lYtbxJfERmym0HsimTWJrGf2LN+7EPI
 LnkTPgAg4CSJAw1JijGkxDf0EnuILg69wyWy3YpDdRpXghzJsXQdxpTPd2gCMrJV/Yv7
 lqErQQRAijfXZXZ2HdSIYpurfTP8NGPXUWBOsi86FWDe1Ubh2eRwO3YI6p9R0Xf6/jEX
 ByLurm09YpQOfiIsEX4gITvvvIUrmuAeEytVBGPja/030e1yVh2zvcaEIWDMMBVk4hiq
 F+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZQpan4Ceh87r7qtgmPZ7unAJ7HVgPrOUBdfCKgEtu8U=;
 b=l9eQ0S/xojGeviHYCaQM8Mqn/350uQ+GcnQ9T3cSikmj1FHvrppi3JGPejBM0kI33g
 FPSKo4JJxtsvD6mNk99ohLFBKaHm3i+uNmKAUDfllFxW6ppSyzJlT+T9FPJhTkgO8Wlb
 bpYH9sPYWXpH+3SCVyQwzkD0DsQTdxlCpN7s0aZBm4BRGPWUCclvDuAljF5Ep9n+PDO2
 Xq9TJlBgynHnwwckT3LeBimyAUSZRN7ehMenbZFvHPm8x5YcJ7iJ7MLzR2sLWRLe2n9k
 pZKriRufWdBggxjsT6NPjwTK9pN2bnosDai9cx4zSHd7TCKpGC+ULvBBiRuzwFzCo3au
 XtUg==
X-Gm-Message-State: APjAAAV6rn3HgCtdCom3R4qxGsNo4G2nJniaynAEmcnZrTO+bxqXTwu+
 0zk6hDVulW6fsH6qRXVdXuTe0FTE/ejkWsYKl9I=
X-Google-Smtp-Source: APXvYqzV5oURO9dUxdFz0ljKXSFi6rhHv4xLrPCoUIA7HORTobivrTRBnPahpnO+lKFpXxWqmRBdq/eJQpX1DvQWI2I=
X-Received: by 2002:a1c:a713:: with SMTP id q19mr5998487wme.127.1567508770024; 
 Tue, 03 Sep 2019 04:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190828142328.24561-1-skrtbhtngr@gmail.com>
 <20190828142328.24561-3-skrtbhtngr@gmail.com>
 <710966e9-d1ac-3c55-0a12-02ff19005531@gmail.com>
In-Reply-To: <710966e9-d1ac-3c55-0a12-02ff19005531@gmail.com>
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Date: Tue, 3 Sep 2019 16:35:58 +0530
Message-ID: <CAMzgYoN0i4cUTDuRztpRvdvGp68TKJ074v=jkzy22ZSsFCtBmg@mail.gmail.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v1 2/2] hw/pvrdma: add live migration
 support
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
Cc: qemu-devel@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 1 Sep 2019 at 01:15, Marcel Apfelbaum
<marcel.apfelbaum@gmail.com> wrote:
>
>
>
> On 8/28/19 5:23 PM, Sukrit Bhatnagar wrote:
> > vmstate_pvrdma describes the PCI and MSIX states as well as the dma
> > address for dsr and the gid table of device.
> > vmstate_pvrdma_gids describes each gid in the gid table.
> >
> > pvrdma_post_save() does the job of unregistering gid entries from the
> > backend device in the source host.
> >
> > pvrdma_post_load() maps to dsr using the loaded dma address, registers
> > each loaded gid into the backend device, and finally calls load_dsr()
> > to perform other mappings and ring init operations.
> >
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Cc: Yuval Shaia <yuval.shaia@oracle.com>
> > Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> > ---
> >   hw/rdma/vmw/pvrdma_main.c | 77 +++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 77 insertions(+)
> >
> > diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> > index 6c90db96f9..6f8b56dea3 100644
> > --- a/hw/rdma/vmw/pvrdma_main.c
> > +++ b/hw/rdma/vmw/pvrdma_main.c
> > @@ -28,6 +28,7 @@
> >   #include "sysemu/sysemu.h"
> >   #include "monitor/monitor.h"
> >   #include "hw/rdma/rdma.h"
> > +#include "migration/register.h"
> >
> >   #include "../rdma_rm.h"
> >   #include "../rdma_backend.h"
> > @@ -593,6 +594,81 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
> >       pvrdma_fini(pci_dev);
> >   }
> >
> > +static int pvrdma_post_save(void *opaque)
> > +{
> > +    int i, rc;
> > +    PVRDMADev *dev = opaque;
> > +
> > +    for (i = 0; i < MAX_GIDS; i++) {
> > +
>
> No need for the extra line
> > +        if (!dev->rdma_dev_res.port.gid_tbl[i].gid.global.interface_id) {
> > +            continue;
> > +        }
> > +        rc = rdma_backend_del_gid(&dev->backend_dev,
> > +                                   dev->backend_eth_device_name,
> > +                                   &dev->rdma_dev_res.port.gid_tbl[i].gid);
> > +        if (rc) {
> > +            return -EINVAL;
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int pvrdma_post_load(void *opaque, int version_id)
> > +{
> > +    int i, rc;
> > +    PVRDMADev *dev = opaque;
> > +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> > +    DSRInfo *dsr_info = &dev->dsr_info;
> > +
> > +    dsr_info->dsr = rdma_pci_dma_map(pci_dev, dsr_info->dma,
> > +                                sizeof(struct pvrdma_device_shared_region));
> > +    if (!dsr_info->dsr) {
> > +        rdma_error_report("Failed to map to DSR");
> > +        return -ENOMEM;
> > +    }
> > +
> > +    for (i = 0; i < MAX_GIDS; i++) {
> > +
>
> The same here
>
> > +        if (!dev->rdma_dev_res.port.gid_tbl[i].gid.global.interface_id) {
> > +            continue;
> > +        }
> > +
> > +        rc = rdma_backend_add_gid(&dev->backend_dev,
> > +                                  dev->backend_eth_device_name,
> > +                                  &dev->rdma_dev_res.port.gid_tbl[i].gid);
> > +        if (rc) {
> > +            return -EINVAL;
> > +        }
> > +    }
> > +
> > +    return load_dsr(dev);
> > +}
> > +
> > +static const VMStateDescription vmstate_pvrdma_gids = {
> > +    .name = "pvrdma-gids",
> > +    .fields = (VMStateField[]) {
> > +            VMSTATE_UINT8_ARRAY_V(gid.raw, RdmaRmGid, 16, 0),
>
> Is 16 the array length? If yes, do we have same macro definition?

16 here represents the number of bytes in a GID.
This comes from the verbs definition of ibv_gid

union ibv_gid {
    uint8_t         raw[16];
    struct {
        __be64  subnet_prefix;
        __be64  interface_id;
    } global;
};

I suppose there is no macro for this but we can declare
our own (something like IBV_GID_SIZE).

> > +            VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static const VMStateDescription vmstate_pvrdma = {
> > +    .name = PVRDMA_HW_NAME,
> > +    .post_save = pvrdma_post_save,
> > +    .post_load = pvrdma_post_load,
> > +    .fields = (VMStateField[]) {
> > +            VMSTATE_PCI_DEVICE(parent_obj, PVRDMADev),
> > +            VMSTATE_MSIX(parent_obj, PVRDMADev),
> > +            VMSTATE_UINT64(dsr_info.dma, PVRDMADev),
> > +            VMSTATE_STRUCT_ARRAY(rdma_dev_res.port.gid_tbl, PVRDMADev,
> > +                                 MAX_PORT_GIDS, 0, vmstate_pvrdma_gids,
> > +                                 RdmaRmGid),
> > +            VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >   static void pvrdma_realize(PCIDevice *pdev, Error **errp)
> >   {
> >       int rc = 0;
> > @@ -688,6 +764,7 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
> >
> >       dc->desc = "RDMA Device";
> >       dc->props = pvrdma_dev_properties;
> > +    dc->vmsd = &vmstate_pvrdma;
> >       set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> >
> >       ir->print_statistics = pvrdma_print_statistics;
>
> Very simple an elegant.
> If I understand correctly the live migration of a pvrdma device with no
> active workloads works with this patch, right?

Yes.

> If yes, I think we should consider merging this code already.
> Yuval, do you agree?
>
> Thanks,
> Marcel
>
>

