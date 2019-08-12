Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D69C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 21:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C9420684
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 21:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C9420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxHnJ-0001df-34
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 17:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42692)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hxHmT-0000mN-LT
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 17:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hxHmS-0003aj-1N
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 17:23:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hxHmQ-0003ZZ-Ek
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 17:23:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CBBEB3064FCF
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 21:23:01 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A0766A237;
 Mon, 12 Aug 2019 21:22:53 +0000 (UTC)
Date: Mon, 12 Aug 2019 15:22:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190812152252.2578e60c@x1.home>
In-Reply-To: <20190812171854.1c47ddfa.cohuck@redhat.com>
References: <20190802150605.5880-1-jfreimann@redhat.com>
 <20190802150605.5880-4-jfreimann@redhat.com>
 <20190812171854.1c47ddfa.cohuck@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 12 Aug 2019 21:23:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/9] vfio: unplug failover primary device
 before migration
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org, laine@redhat.com,
 Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Aug 2019 17:18:54 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri,  2 Aug 2019 17:05:59 +0200
> Jens Freimann <jfreimann@redhat.com> wrote:
> 
> > As usual block all vfio-pci devices from being migrated, but make an
> > exception for failover primary devices. This is achieved by setting
> > unmigratable to 0 but also add a migration blocker for all vfio-pci
> > devices except failover primary devices. These will be unplugged before
> > migration happens by the migration handler of the corresponding
> > virtio-net standby device.
> > 
> > Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> > ---
> >  hw/vfio/pci.c | 24 +++++++++++++++++++++++-
> >  hw/vfio/pci.h |  1 +
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index d6ae9bd4ac..398d26669b 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -35,6 +35,9 @@
> >  #include "pci.h"
> >  #include "trace.h"
> >  #include "qapi/error.h"
> > +#include "migration/blocker.h"
> > +#include "qemu/option.h"
> > +#include "qemu/option_int.h"
> >  
> >  #define TYPE_VFIO_PCI "vfio-pci"
> >  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
> > @@ -2693,6 +2696,12 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
> >      vdev->req_enabled = false;
> >  }
> >  
> > +static int has_standby_arg(void *opaque, const char *name,
> > +                           const char *value, Error **errp)
> > +{
> > +    return strcmp(name, "standby") == 0;
> > +}
> > +
> >  static void vfio_realize(PCIDevice *pdev, Error **errp)
> >  {
> >      VFIOPCIDevice *vdev = PCI_VFIO(pdev);
> > @@ -2706,6 +2715,19 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
> >      int i, ret;
> >      bool is_mdev;
> >  
> > +    if (qemu_opt_foreach(pdev->qdev.opts, has_standby_arg,
> > +                         (void *) pdev->qdev.opts, &err) == 0) {
> > +        error_setg(&vdev->migration_blocker,
> > +                "VFIO device doesn't support migration");
> > +        ret = migrate_add_blocker(vdev->migration_blocker, &err);
> > +        if (err) {
> > +            error_propagate(errp, err);
> > +            error_free(vdev->migration_blocker);
> > +        }
> > +    } else {
> > +        pdev->qdev.allow_unplug_during_migration = true;  
> 
> I think you add this only in the next patch?
> 
> > +    }
> > +
> >      if (!vdev->vbasedev.sysfsdev) {
> >          if (!(~vdev->host.domain || ~vdev->host.bus ||
> >                ~vdev->host.slot || ~vdev->host.function)) {
> > @@ -3148,7 +3170,7 @@ static Property vfio_pci_dev_properties[] = {
> >  
> >  static const VMStateDescription vfio_pci_vmstate = {
> >      .name = "vfio-pci",
> > -    .unmigratable = 1,
> > +    .unmigratable = 0,
> >  };
> >  
> >  static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
> > diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> > index 27d58fc55b..0f6f8cb395 100644
> > --- a/hw/vfio/pci.h
> > +++ b/hw/vfio/pci.h
> > @@ -169,6 +169,7 @@ typedef struct VFIOPCIDevice {
> >      bool no_vfio_ioeventfd;
> >      bool enable_ramfb;
> >      VFIODisplay *dpy;
> > +    Error *migration_blocker;
> >  } VFIOPCIDevice;
> >  
> >  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);  
> 
> This patch interacts with support for vfio migration (last posted in
> <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>, I've not seen
> a later version yet.)
> 
> With that, we'd have three cases to consider:
> 1) device is a failover primary
> 2) device has a migration region
> 3) none of the above
> 
> Can 1) and 2) happen simultaneously? If yes, what should take
> precedence?

Great questions.  I would assume that a user specifying this option
intends the behavior here regardless of the device's support for
migration, which could be made more clear and easier to test by adding
this option to other, otherwise migratable, QEMU NICs.

Also, I thought we agreed that "standby" was not a sufficiently
descriptive name for this device option and that this option would be
rejected with an error on non-Ethernet class devices[1].  Thanks,

Alex

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg04727.html

