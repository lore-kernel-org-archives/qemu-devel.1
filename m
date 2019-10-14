Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D32C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B20A207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B20A207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJxGX-00023J-9N
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iJxEr-0000Sc-SC
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iJxEq-0006u8-J3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:06:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30166)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iJxEq-0006s9-9Q
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:06:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D02578AC700;
 Mon, 14 Oct 2019 10:06:02 +0000 (UTC)
Received: from gondolin (dhcp-192-233.str.redhat.com [10.33.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D63417ADC;
 Mon, 14 Oct 2019 10:05:29 +0000 (UTC)
Date: Mon, 14 Oct 2019 12:05:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v3 10/10] vfio: unplug failover primary device before
 migration
Message-ID: <20191014120527.30bca7e1.cohuck@redhat.com>
In-Reply-To: <20191011112015.11785-11-jfreimann@redhat.com>
References: <20191011112015.11785-1-jfreimann@redhat.com>
 <20191011112015.11785-11-jfreimann@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Mon, 14 Oct 2019 10:06:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: parav@mellanox.com, mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 ailan@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 13:20:15 +0200
Jens Freimann <jfreimann@redhat.com> wrote:

> As usual block all vfio-pci devices from being migrated, but make an
> exception for failover primary devices. This is achieved by setting
> unmigratable to 0 but also add a migration blocker for all vfio-pci
> devices except failover primary devices. These will be unplugged before
> migration happens by the migration handler of the corresponding
> virtio-net standby device.
> 
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>  hw/vfio/pci.c | 35 ++++++++++++++++++++++++++++++++++-
>  hw/vfio/pci.h |  2 ++
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c5e6fe61cb..64cf8e07d9 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -40,6 +40,9 @@
>  #include "pci.h"
>  #include "trace.h"
>  #include "qapi/error.h"
> +#include "migration/blocker.h"
> +#include "qemu/option.h"
> +#include "qemu/option_int.h"
>  
>  #define TYPE_VFIO_PCI "vfio-pci"
>  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
> @@ -2698,6 +2701,12 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>      vdev->req_enabled = false;
>  }
>  
> +static int has_net_failover_arg(void *opaque, const char *name,
> +                           const char *value, Error **errp)
> +{
> +    return (strcmp(name, "net_failover_pair_id") == 0);
> +}
> +
>  static void vfio_realize(PCIDevice *pdev, Error **errp)
>  {
>      VFIOPCIDevice *vdev = PCI_VFIO(pdev);
> @@ -2710,6 +2719,20 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      int groupid;
>      int i, ret;
>      bool is_mdev;
> +    uint16_t class_id;
> +
> +    if (qemu_opt_foreach(pdev->qdev.opts, has_net_failover_arg,
> +                         (void *) pdev->qdev.opts, &err) == 0) {
> +        error_setg(&vdev->migration_blocker,
> +                "VFIO device doesn't support migration");
> +        ret = migrate_add_blocker(vdev->migration_blocker, &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            error_free(vdev->migration_blocker);
> +        }

Do we really want to continue here if adding the migration blocker
failed? Previously, adding the vmsd with unmigratable=1 would have
prevented realization of the device if --only-migratable was specified;
I guess we should keep that behaviour and just bail out here?

> +    } else {
> +        pdev->qdev.allow_unplug_during_migration = true;
> +    }
>  
>      if (!vdev->vbasedev.sysfsdev) {
>          if (!(~vdev->host.domain || ~vdev->host.bus ||
> @@ -2812,6 +2835,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          goto error;
>      }
>  
> +    if (vdev->net_failover_pair_id != NULL) {
> +        class_id = pci_get_word(pdev->config + PCI_CLASS_DEVICE);
> +        if (class_id != PCI_CLASS_NETWORK_ETHERNET) {
> +            error_setg(errp, "failover device is not an Ethernet device");
> +            goto error;
> +        }
> +    }
> +
>      /* vfio emulates a lot for us, but some bits need extra love */
>      vdev->emulated_config_bits = g_malloc0(vdev->config_size);
>  
> @@ -3110,6 +3141,8 @@ static Property vfio_pci_dev_properties[] = {
>                              display, ON_OFF_AUTO_OFF),
>      DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
>      DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
> +    DEFINE_PROP_STRING("net_failover_pair_id", VFIOPCIDevice,
> +            net_failover_pair_id),
>      DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
>                         intx.mmap_timeout, 1100),
>      DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
> @@ -3152,7 +3185,7 @@ static Property vfio_pci_dev_properties[] = {
>  
>  static const VMStateDescription vfio_pci_vmstate = {
>      .name = "vfio-pci",
> -    .unmigratable = 1,
> +    .unmigratable = 0,

Is this vmsd useful in any way with that change anymore?

>  };
>  

(...)

