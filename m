Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17FBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 03:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C80A206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 03:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C80A206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4yqw-0000eI-IY
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 23:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.zeng@intel.com>)
 id 1k4yqI-0000D1-Mn
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 23:51:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:31358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.zeng@intel.com>)
 id 1k4yqF-0002En-K0
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 23:51:22 -0400
IronPort-SDR: oRXgVIiJ4+pXFQb2hx3IcHmpf0hR2Jww66aUJoW7Injq+sgRCsphj6wd+hvqz9Q40/xRWxxdBc
 fpZAe3tteOmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="141079509"
X-IronPort-AV: E=Sophos;i="5.75,456,1589266800"; d="scan'208";a="141079509"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2020 20:51:11 -0700
IronPort-SDR: KA+klxrJvDDb+XYF52wcEDST1C2eJOvc9bmwDrNN3y5RLznN5OTaRqwOOeeQaQhMW+cNudvG8Y
 ZM7n7HpTXazg==
X-IronPort-AV: E=Sophos;i="5.75,456,1589266800"; d="scan'208";a="468897194"
Received: from x48.bj.intel.com (HELO x48) ([10.238.157.64])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2020 20:51:08 -0700
Date: Mon, 10 Aug 2020 11:50:59 +0800
From: Jason Zeng <jason.zeng@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 30/32] vfio-pci: save and restore
Message-ID: <20200810035059.GA3463@x48>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-31-git-send-email-steven.sistare@oracle.com>
 <20200806102259.GA25634@x48>
 <5d2e3c90-eb8c-569f-ef4a-5016756725c7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d2e3c90-eb8c-569f-ef4a-5016756725c7@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=jason.zeng@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 23:51:12
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Jason Zeng <jason.zeng@linux.intel.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 07, 2020 at 04:38:12PM -0400, Steven Sistare wrote:
> On 8/6/2020 6:22 AM, Jason Zeng wrote:
> > Hi Steve,
> > 
> > On Thu, Jul 30, 2020 at 08:14:34AM -0700, Steve Sistare wrote:
> >> @@ -3182,6 +3207,51 @@ static Property vfio_pci_dev_properties[] = {
> >>      DEFINE_PROP_END_OF_LIST(),
> >>  };
> >>  
> >> +static int vfio_pci_post_load(void *opaque, int version_id)
> >> +{
> >> +    int vector;
> >> +    MSIMessage msg;
> >> +    Error *err = 0;
> >> +    VFIOPCIDevice *vdev = opaque;
> >> +    PCIDevice *pdev = &vdev->pdev;
> >> +
> >> +    if (msix_enabled(pdev)) {
> >> +        vfio_msix_enable(vdev);
> >> +        pdev->msix_function_masked = false;
> >> +
> >> +        for (vector = 0; vector < vdev->pdev.msix_entries_nr; vector++) {
> >> +            if (!msix_is_masked(pdev, vector)) {
> >> +                msg = msix_get_message(pdev, vector);
> >> +                vfio_msix_vector_use(pdev, vector, msg);
> >> +            }
> >> +        }
> > 
> > It looks to me MSIX re-init here may lose device IRQs and impact
> > device hardware state?
> > 
> > The re-init will cause the kernel vfio driver to connect the device
> > MSIX vectors to new eventfds and KVM instance. But before that, device
> > IRQs will be routed to previous eventfd. Looks these IRQs will be lost.
> 
> Thanks Jason, that sounds like a problem.  I could try reading and saving an 
> event from eventfd before shutdown, and injecting it into the eventfd after
> restart, but that would be racy unless I disable interrupts.  Or, unconditionally
> inject a spurious interrupt after restart to kick it, in case an interrupt 
> was lost.
> 
> Do you have any other ideas?

Maybe we can consider to also hand over the eventfd file descriptor, or
even the KVM fds to the new Qemu?

If the KVM fds can be preserved, we will just need to restore Qemu KVM
side states. But not sure how complicated the implementation would be.

If we only preserve the eventfd fd, we can attach the old eventfd to
vfio devices. But looks it may turn out we always inject an interrupt
unconditionally, because kernel KVM irqfd eventfd handling is a bit
different than normal user land eventfd read/write. It doesn't decrease
the counter in the eventfd context. So if we read the eventfd from new
Qemu, it looks will always have a non-zero counter, which requires an
interrupt injection.

> 
> > And the re-init will make the device go through the procedure of
> > disabling MSIX, enabling INTX, and re-enabling MSIX and vectors.
> > So if the device is active, its hardware state will be impacted?
> 
> Again thanks.  vfio_msix_enable() does indeed call vfio_disable_interrupts().
> For a quick experiment, I deleted that call in for the post_load code path, and 
> it seems to work fine, but I need to study it more.

vfio_msix_vector_use() will also trigger this procedure in the kernel.

Looks we shouldn't trigger any kernel vfio actions here? Because we
preserve vfio fds, so its kernel state shouldn't be touched. Here we
may only need to restore Qemu states. Re-connect to KVM instance should
be done automatically when we setup the KVM irqfds with the same eventfd.

BTW, if I remember correctly, it is not enough to only save MSIX state
in the snapshot. We should also save the Qemu side pci config space
cache to the snapshot, because Qemu's copy is not exactly the same as
the kernel's copy. I encountered this before, but I don't remember which
field it was.

And another question, why don't we support MSI? I see the code only
handles MSIX?

Thanks,
Jason


> 
> - Steve
>  
> >> +
> >> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
> >> +        vfio_intx_enable(vdev, &err);
> >> +        if (err) {
> >> +            error_report_err(err);
> >> +        }
> >> +    }
> >> +
> >> +    vdev->vbasedev.group->container->reused = false;
> >> +    vdev->pdev.reused = false;
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static const VMStateDescription vfio_pci_vmstate = {
> >> +    .name = "vfio-pci",
> >> +    .unmigratable = 1,
> >> +    .mode_mask = VMS_RESTART,
> >> +    .version_id = 0,
> >> +    .minimum_version_id = 0,
> >> +    .post_load = vfio_pci_post_load,
> >> +    .fields = (VMStateField[]) {
> >> +        VMSTATE_MSIX(pdev, VFIOPCIDevice),
> >> +        VMSTATE_END_OF_LIST()
> >> +    }
> >> +};
> >> +
> >>  static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
> >>  {
> >>      DeviceClass *dc = DEVICE_CLASS(klass);
> >> @@ -3189,6 +3259,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
> >>  
> >>      dc->reset = vfio_pci_reset;
> >>      device_class_set_props(dc, vfio_pci_dev_properties);
> >> +    dc->vmsd = &vfio_pci_vmstate;
> >>      dc->desc = "VFIO-based PCI device assignment";
> >>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> >>      pdc->realize = vfio_realize;
> >> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> >> index ac2cefc..e6e1a5d 100644
> >> --- a/hw/vfio/platform.c
> >> +++ b/hw/vfio/platform.c
> >> @@ -592,7 +592,7 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
> >>              return -EBUSY;
> >>          }
> >>      }
> >> -    ret = vfio_get_device(group, vbasedev->name, vbasedev, errp);
> >> +    ret = vfio_get_device(group, vbasedev->name, vbasedev, 0, errp);
> >>      if (ret) {
> >>          vfio_put_group(group);
> >>          return ret;
> >> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> >> index bd07c86..c926a24 100644
> >> --- a/include/hw/pci/pci.h
> >> +++ b/include/hw/pci/pci.h
> >> @@ -358,6 +358,7 @@ struct PCIDevice {
> >>  
> >>      /* ID of standby device in net_failover pair */
> >>      char *failover_pair_id;
> >> +    bool reused;
> >>  };
> >>  
> >>  void pci_register_bar(PCIDevice *pci_dev, int region_num,
> >> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> >> index c78f3ff..4e2a332 100644
> >> --- a/include/hw/vfio/vfio-common.h
> >> +++ b/include/hw/vfio/vfio-common.h
> >> @@ -73,6 +73,8 @@ typedef struct VFIOContainer {
> >>      unsigned iommu_type;
> >>      Error *error;
> >>      bool initialized;
> >> +    bool reused;
> >> +    int cid;
> >>      unsigned long pgsizes;
> >>      QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
> >>      QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
> >> @@ -177,7 +179,7 @@ void vfio_reset_handler(void *opaque);
> >>  VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
> >>  void vfio_put_group(VFIOGroup *group);
> >>  int vfio_get_device(VFIOGroup *group, const char *name,
> >> -                    VFIODevice *vbasedev, Error **errp);
> >> +                    VFIODevice *vbasedev, bool *reused, Error **errp);
> >>  
> >>  extern const MemoryRegionOps vfio_region_ops;
> >>  typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
> >> diff --git a/migration/savevm.c b/migration/savevm.c
> >> index 881dc13..2606cf0 100644
> >> --- a/migration/savevm.c
> >> +++ b/migration/savevm.c
> >> @@ -1568,7 +1568,7 @@ static int qemu_savevm_state(QEMUFile *f, VMStateMode mode, Error **errp)
> >>          return -EINVAL;
> >>      }
> >>  
> >> -    if (migrate_use_block()) {
> >> +    if ((mode & (VMS_SNAPSHOT | VMS_MIGRATE)) && migrate_use_block()) {
> >>          error_setg(errp, "Block migration and snapshots are incompatible");
> >>          return -EINVAL;
> >>      }
> >> -- 
> >> 1.8.3.1
> >>
> >>

