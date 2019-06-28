Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F83C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5E42083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5E42083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqeW-0001Ry-UB
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39755)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hgqCR-0003oA-TF
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hgqCQ-0007na-9M
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:41:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hgqCQ-0007ma-0a
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:41:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D73185540;
 Fri, 28 Jun 2019 11:26:41 +0000 (UTC)
Received: from work-vm (ovpn-116-169.ams2.redhat.com [10.36.116.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C0DA10018F9;
 Fri, 28 Jun 2019 11:26:36 +0000 (UTC)
Date: Fri, 28 Jun 2019 12:26:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190628112634.GB2987@work-vm>
References: <20190621144541.13770-1-skrtbhtngr@gmail.com>
 <20190621144541.13770-2-skrtbhtngr@gmail.com>
 <20190625153253.GA10458@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625153253.GA10458@lap1>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 28 Jun 2019 11:26:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 1/1] hw/pvrdma: Add live migration support
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
Cc: Sukrit Bhatnagar <skrtbhtngr@gmail.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yuval Shaia (yuval.shaia@oracle.com) wrote:
> On Fri, Jun 21, 2019 at 08:15:41PM +0530, Sukrit Bhatnagar wrote:
> > Define and register SaveVMHandlers pvrdma_save and
> > pvrdma_load for saving and loading the device state,
> > which currently includes only the dma, command slot
> > and response slot addresses.
> > 
> > Remap the DSR, command slot and response slot upon
> > loading the addresses in the pvrdma_load function.
> > 
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Cc: Yuval Shaia <yuval.shaia@oracle.com>
> > Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> > ---
> >  hw/rdma/vmw/pvrdma_main.c | 56 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> > 
> > diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> > index adcf79cd63..cd8573173c 100644
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
> > @@ -592,9 +593,62 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
> >      pvrdma_fini(pci_dev);
> >  }
> >  
> > +static void pvrdma_save(QEMUFile *f, void *opaque)
> > +{
> > +    PVRDMADev *dev = PVRDMA_DEV(opaque);
> > +
> > +    qemu_put_be64(f, dev->dsr_info.dma);
> > +    qemu_put_be64(f, dev->dsr_info.dsr->cmd_slot_dma);
> > +    qemu_put_be64(f, dev->dsr_info.dsr->resp_slot_dma);
> > +}
> > +
> > +static int pvrdma_load(QEMUFile *f, void *opaque, int version_id)
> > +{
> > +    PVRDMADev *dev = PVRDMA_DEV(opaque);
> > +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> > +
> > +    // Remap DSR
> > +    dev->dsr_info.dma = qemu_get_be64(f);
> > +    dev->dsr_info.dsr = rdma_pci_dma_map(pci_dev, dev->dsr_info.dma,
> > +                                    sizeof(struct pvrdma_device_shared_region));
> > +    if (!dev->dsr_info.dsr) {
> > +        rdma_error_report("Failed to map to DSR");
> > +        return -1;
> > +    }
> > +    qemu_log("pvrdma_load: successfully remapped to DSR\n");
> > +
> > +    // Remap cmd slot
> > +    dev->dsr_info.dsr->cmd_slot_dma = qemu_get_be64(f);
> > +    dev->dsr_info.req = rdma_pci_dma_map(pci_dev, dev->dsr_info.dsr->cmd_slot_dma,
> > +                                     sizeof(union pvrdma_cmd_req));
> > +    if (!dev->dsr_info.req) {
> 
> So this is where you hit the error, right?
> All looks good to me, i wonder why the first pci_dma_map works fine but
> second fails where the global BounceBuffer is marked as used.
> 
> Anyone?

I've got a few guesses:
  a) My reading of address_space_map is that it gives a bounce buffer
pointer and then it has to be freed; so if it's going wrong and using a
bounce buffer, then the 1st call would work and only the 2nd would fail.

  b) Perhaps the dma address read from the stream is bad, and isn't
pointing into RAM properly - and that's why you're getting a bounce
buffer.

  c) Do you have some ordering problems? i.e. is this code happening
before some other device has been loaded/initialised?  If you're relying
on some other state, then perhaps the right thing is to perform these
mappings later, at the end of migration, not during the loading itself.

Other notes:
  d) Use VMSTATE macros and structures rather than open-coding qemu_get
calls.

  e) QEMU normally uses /* comments */ rather than //

Dave

> > +        rdma_error_report("Failed to map to command slot address");
> > +        return -1;
> > +    }
> > +    qemu_log("pvrdma_load: successfully remapped to cmd slot\n");
> > +
> > +    // Remap rsp slot
> 
> btw, this is RFC so we are fine but try to avoid such way of comments.
> 
> > +    dev->dsr_info.dsr->resp_slot_dma = qemu_get_be64(f);
> > +    dev->dsr_info.rsp = rdma_pci_dma_map(pci_dev, dev->dsr_info.dsr->resp_slot_dma,
> > +                                     sizeof(union pvrdma_cmd_resp));
> > +    if (!dev->dsr_info.rsp) {
> > +        rdma_error_report("Failed to map to response slot address");
> > +        return -1;
> > +    }
> > +    qemu_log("pvrdma_load: successfully remapped to rsp slot\n");
> > +
> > +    return 0;
> > +}
> > +
> > +static SaveVMHandlers savevm_pvrdma = {
> > +    .save_state = pvrdma_save,
> > +    .load_state = pvrdma_load,
> > +};
> > +
> >  static void pvrdma_realize(PCIDevice *pdev, Error **errp)
> >  {
> >      int rc = 0;
> > +    DeviceState *s = DEVICE(pdev);
> >      PVRDMADev *dev = PVRDMA_DEV(pdev);
> >      Object *memdev_root;
> >      bool ram_shared = false;
> > @@ -666,6 +720,8 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
> >      dev->shutdown_notifier.notify = pvrdma_shutdown_notifier;
> >      qemu_register_shutdown_notifier(&dev->shutdown_notifier);
> >  
> > +    register_savevm_live(s, "pvrdma", -1, 1, &savevm_pvrdma, dev);
> > +
> >  out:
> >      if (rc) {
> >          pvrdma_fini(pdev);
> > -- 
> > 2.21.0
> > 
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

