Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087F6C74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83C52064A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSYR0bxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83C52064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJ1H-0005wg-RK
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54430)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <skrtbhtngr@gmail.com>) id 1hlIzY-00051j-Se
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <skrtbhtngr@gmail.com>) id 1hlIzV-00008M-VW
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:15:04 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
 id 1hlIzP-0008Nk-83
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:14:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id a15so3513813wmj.5
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 13:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R5REUIuvmrAf05yv9w23eMYuDHdrYi2w7YQy3pJhKh0=;
 b=tSYR0bxWh03JUjDL3qGzAtkeP2A1ACf7p/RXSks5Q3iSHb2QttQamDZ20xNbS00mHr
 dx+16WwNIOBW6klTpOQqLd2A3yAVHL1mZJCYyFrLY2qWKseSZVnOya2Vh5cAs0mdCuoI
 pL4kqEpHxdDPiZMhIdZFO7lsDGLrE8dhAtNqxDluSUsI6hMb68rj8MmTWLYYPRbBDjQ9
 7U4hbrkt7Q1ryxTAZvc87tS4kDX5GXAI23xy03wELovIEQVfaYtvmXuchm5YGmbuBBk3
 aWXLOtWmHsR7dTftUa1at70mRcX9n37nM3MxcgZFRKVhDt7xHhHxXBTDIKcXmr6cz820
 Wayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R5REUIuvmrAf05yv9w23eMYuDHdrYi2w7YQy3pJhKh0=;
 b=pCU9yHK8ABPPvzcAVYd6Ii60qXLFxIf0U9teUaP/JdrDCcGwjCCKKp6SxFUHhcHERt
 n1U8DxcSHVeIq2faHtW9HuKy9vQLlv/eFD6kl6hIioWKsyEoOESAmIAbiiNmwZHL5CWT
 JfMYye+teGGV46N5eC+WNwnI01PXDvm4T+L1lwJtG/GUreBOCG+/VByjQrIraLolxcRu
 owwv93iV5JIAPeLSTGeMXtpV7BrcHHw8luWBIX+7hiD9JiPCBm037HaocXNxfamaQArs
 huyAaeFVahZpy9Klt0cjPVyaQom6pspm1qcF8rUKH9mCbE6ZX1pC32cBKJ2hx4UaB/dI
 9g6Q==
X-Gm-Message-State: APjAAAW9P4bAqwR658JdzYQwryJKljVjEKkjrBBza5o4YxYzTanEqgvS
 206YLjRCsnFZbPIfiCGxsLnOMn/f+rXn0AJfVx4=
X-Google-Smtp-Source: APXvYqymvud4iJD6A1NoeBoQxQ9B9trrR+kHBQiscyifck72wPCA0dM1Tvy74QoP04BEfWgZYYjZebTU+tG6MjzGcs4=
X-Received: by 2002:a1c:1d4f:: with SMTP id d76mr7025835wmd.127.1562789690507; 
 Wed, 10 Jul 2019 13:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190706040940.7884-1-skrtbhtngr@gmail.com>
 <20190706040940.7884-3-skrtbhtngr@gmail.com>
 <20190708051338.GA5441@lap1>
In-Reply-To: <20190708051338.GA5441@lap1>
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Date: Thu, 11 Jul 2019 01:44:36 +0530
Message-ID: <CAMzgYoOaARVJ1C0a2i5iGpULZk7xqmQq5XdRj7EEzWtG-AMdKA@mail.gmail.com>
To: Yuval Shaia <yuval.shaia@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC v2 2/2] hw/pvrdma: add live migration support
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jul 2019 at 10:43, Yuval Shaia <yuval.shaia@oracle.com> wrote:
>
> On Sat, Jul 06, 2019 at 09:39:40AM +0530, Sukrit Bhatnagar wrote:
> > Use VMStateDescription for migrating device state. Currently,
>
> What do you mean by 'Currently'?

I meant that 'vmstate_pvrdma' will contain more fields later. This is
how it looks till now.

> > 'vmstate_pvrdma' describes the PCI and MSIX state for pvrdma and
> > 'vmstate_pvrdma_dsr_dma' describes a temporary state containing
> > some values obtained only after mapping to dsr in the source.
> > Since the dsr will not be available on dest until we map to the
> > dma address we had on source, these values cannot be migrated
> > directly.
> >
> > Add PVRDMAMigTmp to store this temporary state which consists of
> > dma addresses and ring page information. The 'parent' member is
> > used to refer to the device state (PVRDMADev) so that parent PCI
> > device object is accessible, which is needed to remap to DSR.
> >
> > pvrdma_dsr_dma_pre_save() saves the dsr state into this temporary
> > representation and pvrdma_dsr_dma_post_load() loads it back.
> > This load function also remaps to the dsr and and calls
> > load_dsr() for further map and ring init operations.
> >
> > Please note that this call to load_dsr() can be removed from the
> > migration flow and included in pvrdma_regs_write() to perform a
> > lazy load.
>
> The lazy load was suggested to overcome a potential problem with mapping to
> addresses while still in migration process. With that been solved i would
> suggest to drop the idea of lazy load.
>
> > As of now, migration will fail if there in an error in load_dsr().
> > Also, there might be a considerable amount of pages in the rings,
> > which will have dma map operations when the init functions are
> > called.
> > If this takes noticeable time, it might be better to have lazy
> > load instead.
>
> Yeah, make sense but i hope we will not get to this.
>
> >
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Cc: Yuval Shaia <yuval.shaia@oracle.com>
> > Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> > ---
> >  hw/rdma/vmw/pvrdma_main.c | 87 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >
> > diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> > index 6c90db96f9..4a10bd2fc7 100644
> > --- a/hw/rdma/vmw/pvrdma_main.c
> > +++ b/hw/rdma/vmw/pvrdma_main.c
> > @@ -28,6 +28,7 @@
> >  #include "sysemu/sysemu.h"
> >  #include "monitor/monitor.h"
> >  #include "hw/rdma/rdma.h"
> > +#include "migration/register.h"
> >
> >  #include "../rdma_rm.h"
> >  #include "../rdma_backend.h"
> > @@ -593,6 +594,91 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
> >      pvrdma_fini(pci_dev);
> >  }
> >
> > +struct PVRDMAMigTmp {
> > +    PVRDMADev *parent;
> > +    uint64_t dma;
> > +    uint64_t cmd_slot_dma;
> > +    uint64_t resp_slot_dma;
> > +    uint32_t cq_ring_pages_num_pages;
> > +    uint64_t cq_ring_pages_pdir_dma;
> > +    uint32_t async_ring_pages_num_pages;
> > +    uint64_t async_ring_pages_pdir_dma;
> > +};
> > +
> > +static int pvrdma_dsr_dma_pre_save(void *opaque)
> > +{
> > +    struct PVRDMAMigTmp *tmp = opaque;
>
> For me tmp sounds like a very bad name, if it is the convention then i can
> live with that, anyways suggesting something like mig_tmp_info or something
> like that.

It doesn't seem like a convention, but this is how it is named
in other places in the source. But sure, I'll change it to a more
meaningful name, if it is needed.

> > +    DSRInfo *dsr_info = &tmp->parent->dsr_info;
>
> Can you shad some light on how the parent field is initialized with the
> pointer to the device object?

TL;DR
The trick is on line 567 in migration/vmstate-types.c in the
function 'put_tmp'.


Each VMStateDescription has one or more VMStateField values
which are used to define members of the device state for migration.

VMSTATE_WITH_TMP is a macro which defines a VMStateField for
those types of device state which need an intermediate representation
and cannot be migrated directly. In our case, this might apply to the
dma addresses and pdir information stored within dsr.

Each VMStateField has a corresponding VMStateInfo, which basically
is an interface declaring two functions, get and put. These functions are
used to describe how this certain type of VMStateField has to be
saved/loaded during migration.

VMSTATE_WITH_TMP has its VMStateInfo set to 'vmstate_info_tmp',
which assigns the functions 'put_tmp' and 'get_tmp' for save/load logic.

Lets consider state save during migration.
All the state saving work is done inside 'vmstate_save_state_v'.
It takes a VMStateDescription as 2nd argument and an opaque type
as 3rd argument.

When 'vmstate_save_state_v' is first called during migration, the
VMStateDescription argument is set to 'vmstate_pvrdma', and
opaque is set to our instance of PVRDMADev.

This function iteratively saves the VMStateFields; PCI then MSIX
then the WITH_TMP.
When it reaches WITH_TMP, it falls through the if-else conditions,
and finally reaches field->info->put. [migration/vmstate.c:386]
This put function is set to 'put_tmp' mentioned above.

Now, the 'put_tmp' function is called, with 'pv' parameter set to the
'parent' field of PVRDMAMigTmp, and 'field' set to our WITH_TMP.
This is because 'parent' is the first member of PVRDMAMigTmp,
and both first_elem and curr_elem (inside 'vmstate_save_state_v')
will point to it when the while loop reaches WITH_TMP field.

'put_tmp' will set the first element of 'tmp' to 'pv' and call
'vmstate_save_state*' with opaque parameter set to this 'tmp', and
the VMStateDescription set to 'vmstate_pvrdma_dsr_dma'.

> > +    struct pvrdma_device_shared_region *dsr = dsr_info->dsr;
> > +
> > +    tmp->dma = dsr_info->dma;
> > +    tmp->cmd_slot_dma = dsr->cmd_slot_dma;
> > +    tmp->resp_slot_dma = dsr->resp_slot_dma;
> > +    tmp->cq_ring_pages_num_pages = dsr->cq_ring_pages.num_pages;
> > +    tmp->cq_ring_pages_pdir_dma = dsr->cq_ring_pages.pdir_dma;
> > +    tmp->async_ring_pages_num_pages = dsr->async_ring_pages.num_pages;
> > +    tmp->async_ring_pages_pdir_dma = dsr->async_ring_pages.pdir_dma;
> > +
> > +    return 0;
> > +}
> > +
> > +static int pvrdma_dsr_dma_post_load(void *opaque, int version_id)
> > +{
> > +    struct PVRDMAMigTmp *tmp = opaque;
> > +    PVRDMADev *dev = tmp->parent;
> > +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> > +    DSRInfo *dsr_info = &dev->dsr_info;
> > +    struct pvrdma_device_shared_region *dsr;
> > +
> > +    dsr_info->dma = tmp->dma;
> > +    dsr_info->dsr = rdma_pci_dma_map(pci_dev, dsr_info->dma,
> > +                                sizeof(struct pvrdma_device_shared_region));
> > +    if (!dsr_info->dsr) {
> > +        rdma_error_report("Failed to map to DSR");
> > +        return -ENOMEM;
>
> Will this cause the VM on source host to continue functioning besides
> failing the migration?

No, the VM on the source halts.

> > +    }
> > +
> > +    dsr = dsr_info->dsr;
> > +    dsr->cmd_slot_dma = tmp->cmd_slot_dma;
> > +    dsr->resp_slot_dma = tmp->resp_slot_dma;
> > +    dsr->cq_ring_pages.num_pages = tmp->cq_ring_pages_num_pages;
> > +    dsr->cq_ring_pages.pdir_dma = tmp->cq_ring_pages_pdir_dma;
> > +    dsr->async_ring_pages.num_pages = tmp->async_ring_pages_num_pages;
> > +    dsr->async_ring_pages.pdir_dma = tmp->async_ring_pages_pdir_dma;
>
> I expect the above 6 fields to be already populated with the correct values
> as we just map to driver's DSR that should be migrated as part of memory
> copy of source to dest host.
> Can you verify it and if my assumptions are correct to remove these
> assignments (and the corresponding from pre_save)?

Yes, you are right. We do not need these 6 fields. In fact, we don't need
vmstate_pvrdma_dsr_dma and PVRDMAMigTmp as of now; we just need the
save/load logic in vmstate_pvrdma.

I had added these fields based on the BounceBuffer issue we had earlier.

> > +
> > +    return load_dsr(dev);
> > +}
> > +
> > +static const VMStateDescription vmstate_pvrdma_dsr_dma = {
> > +    .name = "pvrdma-dsr-dma",
> > +    .pre_save = pvrdma_dsr_dma_pre_save,
> > +    .post_load = pvrdma_dsr_dma_post_load,
>
> I'm looking for a hook that is triggered just before leaving the source
> host so we can do some needed cleanups such as unmapping the DSR, removing
> IP addresses from the host etc.

There is a 'post_save' function available which is called on the src when
the fields are saved into the migration stream. We can try that.

> > +    .fields = (VMStateField[]) {
> > +            VMSTATE_UINT64(dma, struct PVRDMAMigTmp),
> > +            VMSTATE_UINT64(cmd_slot_dma, struct PVRDMAMigTmp),
> > +            VMSTATE_UINT64(resp_slot_dma, struct PVRDMAMigTmp),
> > +            VMSTATE_UINT32(async_ring_pages_num_pages, struct PVRDMAMigTmp),
> > +            VMSTATE_UINT64(async_ring_pages_pdir_dma, struct PVRDMAMigTmp),
> > +            VMSTATE_UINT32(cq_ring_pages_num_pages, struct PVRDMAMigTmp),
> > +            VMSTATE_UINT64(cq_ring_pages_pdir_dma, struct PVRDMAMigTmp),
> > +            VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static const VMStateDescription vmstate_pvrdma = {
> > +    .name = "pvrdma",
>
> Suggesting to use the already defined constant PVRDMA_HW_NAME.

Noted.

> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
>
> Hmmm...interesting, what's the use of these fields?

These are used to indicate any major changes to the device state
for migration such that if versions do not match at all, migration
will fail for the device.
Removing these also does not make any difference in the behaviour
of our migration, since we are implementing it from scratch currently.
I had added these because it seemed like convention.

> > +    .fields = (VMStateField[]) {
> > +            VMSTATE_PCI_DEVICE(parent_obj, PVRDMADev),
> > +            VMSTATE_MSIX(parent_obj, PVRDMADev),
> > +            VMSTATE_WITH_TMP(PVRDMADev,
> > +                             struct PVRDMAMigTmp,
> > +                             vmstate_pvrdma_dsr_dma),
> > +            VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  static void pvrdma_realize(PCIDevice *pdev, Error **errp)
> >  {
> >      int rc = 0;
> > @@ -688,6 +774,7 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
> >
> >      dc->desc = "RDMA Device";
> >      dc->props = pvrdma_dev_properties;
> > +    dc->vmsd = &vmstate_pvrdma;
> >      set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
>
> Besides the above comments looks like a great job, thanks!
>
> >
> >      ir->print_statistics = pvrdma_print_statistics;
> > --
> > 2.21.0
> >
> >

