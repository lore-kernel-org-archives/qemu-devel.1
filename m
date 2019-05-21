Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC771C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7613A216B7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7613A216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51729 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT32i-0003uy-NE
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 07:34:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT31w-0003b6-8V
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT31u-0004Cm-T5
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:34:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hT31u-0004C5-OF
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:34:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id h1so20044934qtp.1
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 04:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=7a1654hj8+rZFR93PFTKCCrdgA7klDX6vkpcxDqSjTA=;
	b=oCZ3X0zK4+69mcVAfwzubmxRCOcBM1ebBAPKDwZIbmu/stoE8AHUHWAaMHu1rZpXT6
	FmJL8clFAy5x1JP/p4BIQEOHs7pMURa0ft2nmu1Le3HDIpe4az7M2vnKmjachN4TRTvy
	OwCgzEeHMk/ZT1v9caKbmv97GuI32/2vlJNyTMQydAp6LjeawkWIZ7KFpOH++Sf8DrMy
	GJ/kbVEkMlfvUnGc3Yuoo8PmoiuajXXb6EGhCqbrAfKiIlq8oWA96GCj6P7FCRy9wgUW
	nOxcud0Z/Bg0OAq7eA/1sle7qCynB+Pgojmwuje1vH3p0UCRQxYi0Qjz3OEPSo/OqkYm
	PA4g==
X-Gm-Message-State: APjAAAVpZWrIaG+Ql9UIw7XKABr6lgnmKbuJ6HW47gfeD+cQwmKpGoOn
	8Y2u/Vi3WVyqNWvGXKeSXl1WrA==
X-Google-Smtp-Source: APXvYqztZZouB+2nA76b/bbDu1sqMdr0NSytVWI0Dvl2UTzxpm1R4O7K1qZ5DtNLGn1VIDOeGoTB3A==
X-Received: by 2002:ac8:74d4:: with SMTP id j20mr66834306qtr.372.1558438441952;
	Tue, 21 May 2019 04:34:01 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	q56sm12947564qtk.72.2019.05.21.04.33.59
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 21 May 2019 04:34:00 -0700 (PDT)
Date: Tue, 21 May 2019 07:33:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190521073055-mutt-send-email-mst@kernel.org>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-3-jfreimann@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517125820.2885-3-jfreimann@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.193
Subject: Re: [Qemu-devel] [PATCH 2/4] qdev/qbus: Add hidden device support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
	aadam@redhat.com, qemu-devel@nongnu.org, laine@redhat.com, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 17, 2019 at 02:58:18PM +0200, Jens Freimann wrote:
> This adds support for hiding a device to the qbus and qdev APIs.
> qdev_device_add() is modified to check for a standby argument in the
> option string. A DeviceListener callback should_be_hidden() is added. It
> can be used by a standby device to inform qdev that this device should
> not be added now. The standby device handler can store the device
> options to plug the device in at a later point in time.
> 
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>


I really like this approach. I think is has value beyond failover:
e.g. if the PCI bus is powered off then devices on it should
also be invisible. Right now we kind of work around this
but we could switch to this API down the road.

> ---
>  hw/core/qdev.c         | 19 +++++++++++++++++++
>  hw/vfio/pci.c          |  1 +
>  hw/vfio/pci.h          |  1 +
>  include/hw/qdev-core.h |  9 +++++++++
>  qdev-monitor.c         | 41 ++++++++++++++++++++++++++++++++++++++---
>  vl.c                   |  6 ++++--
>  6 files changed, 72 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 98cdaa6bf7..d55fe00ae7 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -211,6 +211,25 @@ void device_listener_unregister(DeviceListener *listener)
>      QTAILQ_REMOVE(&device_listeners, listener, link);
>  }
>  
> +bool qdev_should_hide_device(QemuOpts *opts, Error **errp)
> +{
> +    bool res = false;
> +    bool match_found = false;
> +
> +    DeviceListener *listener;
> +
> +    QTAILQ_FOREACH(listener, &device_listeners, link) {
> +       if (listener->should_be_hidden) {
> +            listener->should_be_hidden(listener, opts, &match_found, &res);
> +        }
> +
> +        if (match_found) {
> +            break;
> +        }
> +    }
> +    return res;
> +}
> +
>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>                                   int required_for_version)
>  {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 8cecb53d5c..835249c61d 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3215,6 +3215,7 @@ static Property vfio_pci_dev_properties[] = {
>                              display, ON_OFF_AUTO_OFF),
>      DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
>      DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
> +    DEFINE_PROP_STRING("standby", VFIOPCIDevice, standby),
>      DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
>                         intx.mmap_timeout, 1100),
>      DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index cfcd1a81b8..1a87f91889 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -135,6 +135,7 @@ typedef struct VFIOPCIDevice {
>      PCIHostDeviceAddress host;
>      EventNotifier err_notifier;
>      EventNotifier req_notifier;
> +    char *standby;
>      int (*resetfn)(struct VFIOPCIDevice *);
>      uint32_t vendor_id;
>      uint32_t device_id;
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 5437395779..d54d3ae62a 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -158,6 +158,13 @@ struct DeviceState {
>  struct DeviceListener {
>      void (*realize)(DeviceListener *listener, DeviceState *dev);
>      void (*unrealize)(DeviceListener *listener, DeviceState *dev);
> +    /*
> +     * This callback is called just upon init of the DeviceState
> +     * and can be used by a standby device for informing qdev if this
> +     * device should be hidden by checking the device opts
> +     */
> +    void (*should_be_hidden)(DeviceListener *listener, QemuOpts *device_opts,
> +            bool *match_found, bool *res);
>      QTAILQ_ENTRY(DeviceListener) link;
>  };
>  
> @@ -454,4 +461,6 @@ static inline bool qbus_is_hotpluggable(BusState *bus)
>  void device_listener_register(DeviceListener *listener);
>  void device_listener_unregister(DeviceListener *listener);
>  
> +bool qdev_should_hide_device(QemuOpts *opts, Error **errp);
> +
>  #endif
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 9cce8b93c2..a81226529a 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -32,8 +32,10 @@
>  #include "qemu/help_option.h"
>  #include "qemu/option.h"
>  #include "qemu/qemu-print.h"
> +#include "qemu/option_int.h"
>  #include "sysemu/block-backend.h"
>  #include "migration/misc.h"
> +#include "migration/migration.h"
>  
>  /*
>   * Aliases were a bad idea from the start.  Let's keep them
> @@ -561,14 +563,45 @@ void qdev_set_id(DeviceState *dev, const char *id)
>      }
>  }
>  
> +static int is_failover_device(void *opaque, const char *name, const char *value,
> +                        Error **errp)
> +{
> +    if (strcmp(name, "standby") == 0) {
> +        QemuOpts *opts = (QemuOpts *)opaque;
> +
> +        if (qdev_should_hide_device(opts, errp) && errp && !*errp) {
> +            return 1;
> +        } else if (errp && *errp) {
> +            return -1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static bool should_hide_device(QemuOpts *opts, Error **err)
> +{
> +    if (qemu_opt_foreach(opts, is_failover_device, opts, err) == 0) {
> +        return false;
> +    }
> +    return true;
> +}
> +
>  DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>  {
>      DeviceClass *dc;
>      const char *driver, *path;
> -    DeviceState *dev;
> +    DeviceState *dev = NULL;
>      BusState *bus = NULL;
>      Error *err = NULL;
>  
> +    if (opts && should_hide_device(opts, &err)) {
> +        if (err) {
> +            goto err_del_dev;
> +        }
> +        return NULL;
> +    }
> +
>      driver = qemu_opt_get(opts, "driver");
>      if (!driver) {
>          error_setg(errp, QERR_MISSING_PARAMETER, "driver");
> @@ -640,8 +673,10 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>  
>  err_del_dev:
>      error_propagate(errp, err);
> -    object_unparent(OBJECT(dev));
> -    object_unref(OBJECT(dev));
> +    if (dev) {
> +        object_unparent(OBJECT(dev));
> +        object_unref(OBJECT(dev));
> +    }
>      return NULL;
>  }
>  
> diff --git a/vl.c b/vl.c
> index b6709514c1..4b5b878275 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2355,10 +2355,12 @@ static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
>      DeviceState *dev;
>  
>      dev = qdev_device_add(opts, errp);
> -    if (!dev) {
> +    if (!dev && *errp) {
> +        error_report_err(*errp);
>          return -1;
> +    } else if (dev) {
> +        object_unref(OBJECT(dev));
>      }
> -    object_unref(OBJECT(dev));
>      return 0;
>  }
>  
> -- 
> 2.21.0

