Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F1CC74A21
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 15:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8FB20645
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 15:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8FB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlETX-0000xs-Lq
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 11:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39547)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hlESp-0000RC-5R
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hlESn-00061R-Ru
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:24:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hlESn-00060y-JU
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:24:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 74359308330C;
 Wed, 10 Jul 2019 15:24:56 +0000 (UTC)
Received: from work-vm (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B241F2B5AB;
 Wed, 10 Jul 2019 15:24:50 +0000 (UTC)
Date: Wed, 10 Jul 2019 16:24:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190710152447.GE2682@work-vm>
References: <20190710141440.27635-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710141440.27635-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 10 Jul 2019 15:24:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] virtio-balloon: fix QEMU 4.0 config size
 migration incompatibility
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
Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> The virtio-balloon config size changed in QEMU 4.0 even for existing
> machine types.  Migration from QEMU 3.1 to 4.0 can fail in some
> circumstances with the following error:
> 
>   qemu-system-x86_64: get_pci_config_device: Bad config data: i=0x10 read: a1 device: 1 cmask: ff wmask: c0 w1cmask:0
> 
> This happens because the virtio-balloon config size affects the VIRTIO
> Legacy I/O Memory PCI BAR size.
> 
> Introduce a qdev property called "qemu-4-0-config-size" and enable it
> only for the QEMU 4.0 machine types.  This way <4.0 machine types use
> the old size, 4.0 uses the larger size, and >4.0 machine types use the
> appropriate size depending on enabled virtio-balloon features.
> 
> Live migration to and from old QEMUs to QEMU 4.1 works again as long as
> a versioned machine type is specified (do not use just "pc"!).
> 
> Originally-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Tested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
   Tried 3.1->head and back
   Tried head<->head (default options)
     in both cases I tried ballooning the guest up and down

Dave


> ---
>  include/hw/virtio/virtio-balloon.h |  2 ++
>  hw/core/machine.c                  |  2 ++
>  hw/virtio/virtio-balloon.c         | 28 +++++++++++++++++++++++++---
>  3 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index 1afafb12f6..5a99293a45 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -71,6 +71,8 @@ typedef struct VirtIOBalloon {
>      int64_t stats_poll_interval;
>      uint32_t host_features;
>      PartiallyBalloonedPage *pbp;
> +
> +    bool qemu_4_0_config_size;
>  } VirtIOBalloon;
>  
>  #endif
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 2be19ec0cd..c4ead16010 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -34,6 +34,7 @@ GlobalProperty hw_compat_4_0[] = {
>      { "virtio-vga",     "edid", "false" },
>      { "virtio-gpu-pci", "edid", "false" },
>      { "virtio-device", "use-started", "false" },
> +    { "virtio-balloon-device", "qemu-4-0-config-size", "true" },
>  };
>  const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
>  
> @@ -49,6 +50,7 @@ GlobalProperty hw_compat_3_1[] = {
>      { "usb-tablet", "serial", "42" },
>      { "virtio-blk-device", "discard", "false" },
>      { "virtio-blk-device", "write-zeroes", "false" },
> +    { "virtio-balloon-device", "qemu-4-0-config-size", "false" },
>  };
>  const size_t hw_compat_3_1_len = G_N_ELEMENTS(hw_compat_3_1);
>  
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 11fad86d64..e85d1c0d5c 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -615,6 +615,22 @@ virtio_balloon_free_page_report_notify(NotifierWithReturn *n, void *data)
>      return 0;
>  }
>  
> +static size_t virtio_balloon_config_size(VirtIOBalloon *s)
> +{
> +    uint64_t features = s->host_features;
> +
> +    if (s->qemu_4_0_config_size) {
> +        return sizeof(struct virtio_balloon_config);
> +    }
> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
> +        return sizeof(struct virtio_balloon_config);
> +    }
> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> +        return offsetof(struct virtio_balloon_config, poison_val);
> +    }
> +    return offsetof(struct virtio_balloon_config, free_page_report_cmd_id);
> +}
> +
>  static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>  {
>      VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
> @@ -635,7 +651,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>      }
>  
>      trace_virtio_balloon_get_config(config.num_pages, config.actual);
> -    memcpy(config_data, &config, sizeof(struct virtio_balloon_config));
> +    memcpy(config_data, &config, virtio_balloon_config_size(dev));
>  }
>  
>  static int build_dimm_list(Object *obj, void *opaque)
> @@ -679,7 +695,7 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
>      uint32_t oldactual = dev->actual;
>      ram_addr_t vm_ram_size = get_current_ram_size();
>  
> -    memcpy(&config, config_data, sizeof(struct virtio_balloon_config));
> +    memcpy(&config, config_data, virtio_balloon_config_size(dev));
>      dev->actual = le32_to_cpu(config.actual);
>      if (dev->actual != oldactual) {
>          qapi_event_send_balloon_change(vm_ram_size -
> @@ -766,7 +782,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>      int ret;
>  
>      virtio_init(vdev, "virtio-balloon", VIRTIO_ID_BALLOON,
> -                sizeof(struct virtio_balloon_config));
> +                virtio_balloon_config_size(s));
>  
>      ret = qemu_add_balloon_handler(virtio_balloon_to_target,
>                                     virtio_balloon_stat, s);
> @@ -897,6 +913,12 @@ static Property virtio_balloon_properties[] = {
>                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>      DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> +    /* QEMU 4.0 accidentally changed the config size even when free-page-hint
> +     * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
> +     * property retains this quirk for QEMU 4.1 machine types.
> +     */
> +    DEFINE_PROP_BOOL("qemu-4-0-config-size", VirtIOBalloon,
> +                     qemu_4_0_config_size, false),
>      DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
>                       IOThread *),
>      DEFINE_PROP_END_OF_LIST(),
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

