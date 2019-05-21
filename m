Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32814C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DED8F21479
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED8F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50295 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1Lc-0000yc-89
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 05:46:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hT1Kk-0000Yj-LX
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hT1Ki-0002HJ-MF
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:45:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hT1Kg-0002Ei-Ig
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:45:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B975CC049D67
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 09:45:16 +0000 (UTC)
Received: from work-vm (ovpn-117-210.ams2.redhat.com [10.36.117.210])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F1F4E19C71;
	Tue, 21 May 2019 09:45:07 +0000 (UTC)
Date: Tue, 21 May 2019 10:45:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190521094504.GB2915@work-vm>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517125820.2885-4-jfreimann@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 21 May 2019 09:45:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] net/virtio: add failover support
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
	mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org,
	laine@redhat.com, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jens Freimann (jfreimann@redhat.com) wrote:
> This patch adds support to handle failover device pairs of a virtio-net
> device and a vfio-pci device, where the virtio-net acts as the standby
> device and the vfio-pci device as the primary.
> 
> The general idea is that we have a pair of devices, a vfio-pci and a
> emulated (virtio-net) device. Before migration the vfio device is
> unplugged and data flows to the emulated device, on the target side
> another vfio-pci device is plugged in to take over the data-path. In the
> guest the net_failover module will pair net devices with the same MAC
> address.
> 
> To achieve this we need:
> 
> 1. Provide a callback function for the should_be_hidden DeviceListener.
>    It is called when the primary device is plugged in. Evaluate the QOpt
>    passed in to check if it is the matching primary device. It returns
>    two values:
>      - one to signal if the device to be added is the matching
>        primary device
>      - another one to signal to qdev if it should actually
>        continue with adding the device or skip it.
> 
>    In the latter case it stores the device options in the VirtioNet
>    struct and the device is added once the VIRTIO_NET_F_STANDBY feature is
>    negotiated during virtio feature negotiation.
> 
> 2. Register a callback for migration status notifier. When called it
>    will unplug its primary device before the migration happens.
> 
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>  hw/net/virtio-net.c            | 117 +++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-net.h |  12 ++++
>  2 files changed, 129 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index ffe0872fff..120eccbb98 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/atomic.h"
>  #include "qemu/iov.h"
>  #include "hw/virtio/virtio.h"
>  #include "net/net.h"
> @@ -19,6 +20,10 @@
>  #include "net/tap.h"
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
> +#include "qemu/option.h"
> +#include "qemu/option_int.h"
> +#include "qemu/config-file.h"
> +#include "qapi/qmp/qdict.h"
>  #include "hw/virtio/virtio-net.h"
>  #include "net/vhost_net.h"
>  #include "net/announce.h"
> @@ -29,6 +34,8 @@
>  #include "migration/misc.h"
>  #include "standard-headers/linux/ethtool.h"
>  #include "trace.h"
> +#include "monitor/qdev.h"
> +#include "hw/pci/pci.h"
>  
>  #define VIRTIO_NET_VM_VERSION    11
>  
> @@ -364,6 +371,9 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
>      }
>  }
>  
> +
> +static void virtio_net_primary_plug_timer(void *opaque);
> +
>  static void virtio_net_set_link_status(NetClientState *nc)
>  {
>      VirtIONet *n = qemu_get_nic_opaque(nc);
> @@ -786,6 +796,14 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
>      } else {
>          memset(n->vlans, 0xff, MAX_VLAN >> 3);
>      }
> +
> +    if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
> +        atomic_set(&n->primary_should_be_hidden, false);
> +        if (n->primary_device_timer)
> +            timer_mod(n->primary_device_timer,
> +                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> +                4000);
> +    }

What's this magic timer constant and why?

>  }
>  
>  static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
> @@ -2626,6 +2644,87 @@ void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
>      n->netclient_type = g_strdup(type);
>  }
>  
> +static void virtio_net_primary_plug_timer(void *opaque)
> +{
> +    VirtIONet *n = opaque;
> +    Error *err = NULL;
> +
> +    if (n->primary_device_dict)
> +        n->primary_device_opts = qemu_opts_from_qdict(qemu_find_opts("device"),
> +            n->primary_device_dict, &err);
> +    if (n->primary_device_opts) {
> +        n->primary_dev = qdev_device_add(n->primary_device_opts, &err);
> +        error_setg(&err, "virtio_net: couldn't plug in primary device");
> +        return;
> +    }
> +    if (!n->primary_device_dict && err) {
> +        if (n->primary_device_timer) {
> +            timer_mod(n->primary_device_timer,
> +                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> +                100);

same here.


> +        }
> +    }
> +}
> +
> +static void virtio_net_handle_migration_primary(VirtIONet *n,
> +                                                MigrationState *s)
> +{
> +    Error *err = NULL;
> +    bool should_be_hidden = atomic_read(&n->primary_should_be_hidden);
> +
> +    n->primary_dev = qdev_find_recursive(sysbus_get_default(),
> +            n->primary_device_id);
> +    if (!n->primary_dev) {
> +        error_setg(&err, "virtio_net: couldn't find primary device");

There's something broken with the error handling in this function - the
'err' never goes anywhere - I don't think it ever gets printed or
reported or stops the migration.

> +    }
> +    if (migration_in_setup(s) && !should_be_hidden && n->primary_dev) {
> +        qdev_unplug(n->primary_dev, &err);

Not knowing unplug well; can you just explain - is that device hard
unplugged and it's gone by the time this function returns or is it still
hanging around for some indeterminate time?

> +        if (!err) {
> +            atomic_set(&n->primary_should_be_hidden, true);
> +            n->primary_dev = NULL;
> +        }
> +    } else if (migration_has_failed(s)) {
> +        if (should_be_hidden && !n->primary_dev) {
> +            /* We already unplugged the device let's plugged it back */
> +            n->primary_dev = qdev_device_add(n->primary_device_opts, &err);
> +        }
> +    }
> +}
> +
> +static void migration_state_notifier(Notifier *notifier, void *data)
> +{
> +    MigrationState *s = data;
> +    VirtIONet *n = container_of(notifier, VirtIONet, migration_state);
> +    virtio_net_handle_migration_primary(n, s);
> +}
> +
> +static void virtio_net_primary_should_be_hidden(DeviceListener *listener,
> +            QemuOpts *device_opts, bool *match_found, bool *res)
> +{
> +    VirtIONet *n = container_of(listener, VirtIONet, primary_listener);
> +
> +    if (device_opts) {
> +        n->primary_device_dict = qemu_opts_to_qdict(device_opts,
> +                n->primary_device_dict);
> +    }
> +    g_free(n->standby_id);
> +    n->standby_id = g_strdup(qdict_get_try_str(n->primary_device_dict,
> +                             "standby"));
> +    if (n->standby_id) {
> +        *match_found = true;
> +    }
> +    /* primary_should_be_hidden is set during feature negotiation */
> +    if (atomic_read(&n->primary_should_be_hidden) && *match_found) {
> +        *res = true;
> +    } else if (*match_found)  {
> +        n->primary_device_dict = qemu_opts_to_qdict(device_opts,
> +                n->primary_device_dict);
> +        *res = false;
> +    }
> +    g_free(n->primary_device_id);
> +    n->primary_device_id = g_strdup(device_opts->id);
> +}
> +
>  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> @@ -2656,6 +2755,18 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>          n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
>      }
>  
> +    if (n->failover) {
> +        n->primary_listener.should_be_hidden =
> +            virtio_net_primary_should_be_hidden;
> +        atomic_set(&n->primary_should_be_hidden, true);
> +        device_listener_register(&n->primary_listener);
> +        n->migration_state.notify = migration_state_notifier;
> +        add_migration_state_change_notifier(&n->migration_state);
> +        n->host_features |= (1ULL << VIRTIO_NET_F_STANDBY);
> +        n->primary_device_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
> +                                     virtio_net_primary_plug_timer, n);
> +    }
> +
>      virtio_net_set_config_size(n, n->host_features);
>      virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);
>  
> @@ -2778,6 +2889,11 @@ static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
>      g_free(n->mac_table.macs);
>      g_free(n->vlans);
>  
> +    g_free(n->primary_device_id);
> +    g_free(n->standby_id);
> +    qobject_unref(n->primary_device_dict);
> +    n->primary_device_dict = NULL;
> +
>      max_queues = n->multiqueue ? n->max_queues : 1;
>      for (i = 0; i < max_queues; i++) {
>          virtio_net_del_queue(n, i);
> @@ -2885,6 +3001,7 @@ static Property virtio_net_properties[] = {
>                       true),
>      DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
>      DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
> +    DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index b96f0c643f..c2bb6ada44 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -18,6 +18,7 @@
>  #include "standard-headers/linux/virtio_net.h"
>  #include "hw/virtio/virtio.h"
>  #include "net/announce.h"
> +#include "qemu/option_int.h"
>  
>  #define TYPE_VIRTIO_NET "virtio-net-device"
>  #define VIRTIO_NET(obj) \
> @@ -43,6 +44,7 @@ typedef struct virtio_net_conf
>      int32_t speed;
>      char *duplex_str;
>      uint8_t duplex;
> +    char *primary_id_str;
>  } virtio_net_conf;
>  
>  /* Coalesced packets type & status */
> @@ -185,6 +187,16 @@ struct VirtIONet {
>      AnnounceTimer announce_timer;
>      bool needs_vnet_hdr_swap;
>      bool mtu_bypass_backend;
> +    QemuOpts *primary_device_opts;
> +    QDict *primary_device_dict;
> +    DeviceState *primary_dev;
> +    char *primary_device_id;
> +    char *standby_id;
> +    bool primary_should_be_hidden;
> +    bool failover;
> +    DeviceListener primary_listener;
> +    QEMUTimer *primary_device_timer;
> +    Notifier migration_state;
>  };
>  
>  void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
> -- 
> 2.21.0
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

