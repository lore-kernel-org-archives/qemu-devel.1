Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9C1C73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 14:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD0D20844
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 14:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD0D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkr2N-0008To-5P
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 10:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57679)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hkr0x-0006wK-QM
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 10:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hkr0w-000156-9I
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 10:22:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13631)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hkr0t-000128-U5
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 10:22:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4325C9FFC9;
 Tue,  9 Jul 2019 14:22:22 +0000 (UTC)
Received: from work-vm (ovpn-117-75.ams2.redhat.com [10.36.117.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CA0C5DD7F;
 Tue,  9 Jul 2019 14:22:14 +0000 (UTC)
Date: Tue, 9 Jul 2019 15:22:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>, stefanha@redhat.com,
 mst@redhat.com
Message-ID: <20190709142211.GF2725@work-vm>
References: <20190627131252.GA14795@olga.proxmox.com>
 <20190702102108.GA29267@olga.proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702102108.GA29267@olga.proxmox.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 09 Jul 2019 14:22:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] balloon config change seems to break live
 migration from 3.0.1 to 4.0
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wolfgang Bumiller (w.bumiller@proxmox.com) wrote:
> On Thu, Jun 27, 2019 at 03:12:52PM +0200, Wolfgang Bumiller wrote:
> > While testing with 4.0 we've run into issues with live migration from
> > 3.0.1 to 4.0 when a balloon device was involved.
> > 
> > We'd see the following error on the destination:
> >   qemu-system-x86_64: get_pci_config_device: Bad config data: i=0x10 read: a1 device: 1 cmask: ff wmask: c0 w1cmask:0 
> >   qemu-system-x86_64: Failed to load PCIDevice:config 
> >   qemu-system-x86_64: Failed to load virtio-balloon:virtio 
> >   qemu-system-x86_64: error while loading state for instance 0x0 of device '0000:00:03.0/virtio-balloon' 
> >   qemu-system-x86_64: load of migration failed: Invalid argument
> 
> So if I'm not mistaken this seems to cover the BAR containing the mapped
> address, which now has a stricter alignment requirement (since the
> config space crossed the 32 byte boundary and now is now 64 bytes and
> therefor requires a 64 byte alignment).
> (This in turn means that it only affects guests where the balloon's
> mapping isn't already 64 byte aligned.)

Right, I agree; thanks for figuring this out.

> I tested with the changes below meant to use the old configuration size
> for machines depending on their machine version... This seems to fix the
> problem for me here.

OK, can you post this as a separate mail please; cc'ing all who I've
added on this list.

> With this changing compatibility options I'm not sure if this is a
> desired upstream change since 4.0 is already released?

There's no great answer here - one of them is going to stay broken;
we can either fix migration earlier 4.0 and break migration to 4.0
or leave migration from earlier broken.
Let's add the  property at least - downstream I know I'll need
it.

As for your actual patch; it's way bigger than I expected - can't you
just use DEFINE_PROP - like for exmaple the 'disable-modern' in
virtio/virtio-pci.c ?

Stefan/mst: What do you reckon - should we:
   a) Fix it so migration with older qemu's works but break 4.0
   b) Or leave 4.0 working and keep older broken.

Dave

> ---8<---
> From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
> From: Wolfgang Bumiller <w.bumiller@proxmox.com>
> Date: Tue, 2 Jul 2019 09:23:43 +0200
> Subject: [PATCH] virtio-balloon: use smaller config on older guests
> 
> The increased config size changes its alignment requirements
> preventing guests from migrating from old qemu versions if
> their balloon mapping isn't stricter aligned.
> So base the default config size on the machine version.
> 
> Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> ---
>  hw/i386/pc.c                       |  2 ++
>  hw/virtio/virtio-balloon.c         | 52 +++++++++++++++++++++++++++---
>  include/hw/virtio/virtio-balloon.h |  1 +
>  3 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 652eb72b2b..3676187a19 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -77,6 +77,7 @@
>  #include "hw/i386/intel_iommu.h"
>  #include "hw/net/ne2000-isa.h"
>  #include "standard-headers/asm-x86/bootparam.h"
> +#include "hw/virtio/virtio-balloon.h"
>  
>  /* debug PC/ISA interrupts */
>  //#define DEBUG_IRQ
> @@ -137,6 +138,7 @@ GlobalProperty pc_compat_3_1[] = {
>      { "Icelake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
>      { "Cascadelake-Server" "-" TYPE_X86_CPU, "stepping", "5" },
>      { TYPE_X86_CPU, "x-intel-pt-auto-level", "off" },
> +    { TYPE_VIRTIO_BALLOON, "x-use-large-balloon-config", "off" },
>  };
>  const size_t pc_compat_3_1_len = G_N_ELEMENTS(pc_compat_3_1);
>  
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index d96e4aa96f..cd0f124fbb 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -328,6 +328,28 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
>      balloon_stats_change_timer(s, 0);
>  }
>  
> +static void balloon_get_large_config(Object *obj, Visitor *v,
> +                                     const char *name, void *opaque,
> +                                     Error **errp)
> +{
> +    VirtIOBalloon *s = opaque;
> +    visit_type_bool(v, name, &s->use_large_config, errp);
> +}
> +
> +static void balloon_set_large_config(Object *obj, Visitor *v,
> +                                     const char *name, void *opaque,
> +                                     Error **errp)
> +{
> +    VirtIOBalloon *s = opaque;
> +    DeviceState *dev = DEVICE(s);
> +
> +    if (dev->realized) {
> +        error_setg(errp, "balloon config size cannot be changed at runtime");
> +    } else {
> +        visit_type_bool(v, name, &s->use_large_config, errp);
> +    }
> +}
> +
>  static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  {
>      VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
> @@ -526,6 +548,17 @@ static bool virtio_balloon_free_page_support(void *opaque)
>      return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
>  }
>  
> +static size_t virtio_balloon_config_size(void *opaque)
> +{
> +    VirtIOBalloon *s = opaque;
> +
> +    if (s->use_large_config) {
> +        return sizeof(struct virtio_balloon_config);
> +    } else {
> +        return offsetof(struct virtio_balloon_config, free_page_report_cmd_id);
> +    }
> +}
> +
>  static void virtio_balloon_free_page_start(VirtIOBalloon *s)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(s);
> @@ -635,7 +668,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>      }
>  
>      trace_virtio_balloon_get_config(config.num_pages, config.actual);
> -    memcpy(config_data, &config, sizeof(struct virtio_balloon_config));
> +    memcpy(config_data, &config, virtio_balloon_config_size(dev));
>  }
>  
>  static int build_dimm_list(Object *obj, void *opaque)
> @@ -679,7 +712,7 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
>      uint32_t oldactual = dev->actual;
>      ram_addr_t vm_ram_size = get_current_ram_size();
>  
> -    memcpy(&config, config_data, sizeof(struct virtio_balloon_config));
> +    memcpy(&config, config_data, virtio_balloon_config_size(dev));
>      dev->actual = le32_to_cpu(config.actual);
>      if (dev->actual != oldactual) {
>          qapi_event_send_balloon_change(vm_ram_size -
> @@ -795,7 +828,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>      int ret;
>  
>      virtio_init(vdev, "virtio-balloon", VIRTIO_ID_BALLOON,
> -                sizeof(struct virtio_balloon_config));
> +                virtio_balloon_config_size(s));
>  
>      ret = qemu_add_balloon_handler(virtio_balloon_to_target,
>                                     virtio_balloon_stat, s);
> @@ -820,7 +853,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>          s->free_page_report_notify.notify =
>                                         virtio_balloon_free_page_report_notify;
>          precopy_add_notifier(&s->free_page_report_notify);
> -        if (s->iothread) {
> +        if (s->iothread && s->use_large_config) {
>              object_ref(OBJECT(s->iothread));
>              s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
>                                         virtio_ballloon_get_free_page_hints, s);
> @@ -833,6 +866,11 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>              virtio_error(vdev, "iothread is missing");
>          }
>      }
> +
> +    if (!s->use_large_config) {
> +        s->host_features &= ~(1 << VIRTIO_BALLOON_F_PAGE_POISON);
> +    }
> +
>      reset_stats(s);
>  }
>  
> @@ -909,6 +947,12 @@ static void virtio_balloon_instance_init(Object *obj)
>                          balloon_stats_get_poll_interval,
>                          balloon_stats_set_poll_interval,
>                          NULL, s, NULL);
> +
> +    s->use_large_config = true;
> +    object_property_add(obj, "x-use-large-balloon-config", "bool",
> +                        balloon_get_large_config,
> +                        balloon_set_large_config,
> +                        NULL, s, NULL);
>  }
>  
>  static const VMStateDescription vmstate_virtio_balloon = {
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index 1afafb12f6..f212c08bd7 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -45,6 +45,7 @@ enum virtio_balloon_free_page_report_status {
>  typedef struct VirtIOBalloon {
>      VirtIODevice parent_obj;
>      VirtQueue *ivq, *dvq, *svq, *free_page_vq;
> +    bool use_large_config;
>      uint32_t free_page_report_status;
>      uint32_t num_pages;
>      uint32_t actual;
> -- 
> 2.20.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

