Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D732C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138C1206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138C1206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJzGW-0007Rs-WB
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 08:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iJz4D-0001qe-99
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iJz4A-0000QM-35
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:03:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iJz49-0000Nd-Qa
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:03:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB85130842B0;
 Mon, 14 Oct 2019 12:03:07 +0000 (UTC)
Received: from localhost (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18F535DAAE;
 Mon, 14 Oct 2019 12:02:59 +0000 (UTC)
Date: Mon, 14 Oct 2019 14:02:58 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 01/10] qdev/qbus: add hidden device support
Message-ID: <20191014120258.sjpe4tfhueag72f6@jenstp.localdomain>
References: <20191011112015.11785-1-jfreimann@redhat.com>
 <20191011112015.11785-2-jfreimann@redhat.com>
 <20191014114622.6dcd9f90.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191014114622.6dcd9f90.cohuck@redhat.com>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 14 Oct 2019 12:03:07 +0000 (UTC)
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

On Mon, Oct 14, 2019 at 11:46:22AM +0200, Cornelia Huck wrote:
>On Fri, 11 Oct 2019 13:20:06 +0200
>Jens Freimann <jfreimann@redhat.com> wrote:
>
>> This adds support for hiding a device to the qbus and qdev APIs.  The
>> first user of this will be the virtio-net failover feature but the API
>> introduced with this patch could be used to implement other features as
>> well, for example hiding pci devices when a pci bus is powered off.
>>
>> qdev_device_add() is modified to check for a net_failover_pair_id
>> argument in the option string. A DeviceListener callback
>> should_be_hidden() is added. It can be used by a standby device to
>> inform qdev that this device should not be added now. The standby device
>> handler can store the device options to plug the device in at a later
>> point in time.
>>
>> One reason for hiding the device is that we don't want to expose both
>> devices to the guest kernel until the respective virtio feature bit
>> VIRTIO_NET_F_STANDBY was negotiated and we know that the devices will be
>> handled correctly by the guest.
>>
>> More information on the kernel feature this is using:
>>  https://www.kernel.org/doc/html/latest/networking/net_failover.html
>>
>> An example where the primary device is a vfio-pci device and the standby
>> device is a virtio-net device:
>>
>> A device is hidden when it has an "net_failover_pair_id" option, e.g.
>>
>>  -device virtio-net-pci,...,failover=on,...
>>  -device vfio-pci,...,net_failover_pair_id=net1,...
>>
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>> ---
>>  hw/core/qdev.c         | 19 +++++++++++++++++++
>>  include/hw/qdev-core.h |  9 +++++++++
>>  qdev-monitor.c         | 43 ++++++++++++++++++++++++++++++++++++++----
>>  vl.c                   |  6 ++++--
>>  4 files changed, 71 insertions(+), 6 deletions(-)
>>
>
>(...)
>
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index aa123f88cb..b61cf82ded 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -154,6 +154,13 @@ struct DeviceState {
>>  struct DeviceListener {
>>      void (*realize)(DeviceListener *listener, DeviceState *dev);
>>      void (*unrealize)(DeviceListener *listener, DeviceState *dev);
>> +    /*
>> +     * This callback is called just upon init of the DeviceState
>> +     * and can be used by a standby device for informing qdev if this
>> +     * device should be hidden by checking the device opts
>> +     */
>
>Maybe tweak this comment a bit:
>
>/*
> * This callback is called upon init of the DeviceState and allows to
> * inform qdev that a device should be hidden, depending on the device
> * opts, for example, to hide a standby device.
> */
>
>This makes it clearer that this interface could be reused for other
>purposes.

Sounds good. 
>
>> +    void (*should_be_hidden)(DeviceListener *listener, QemuOpts *device_opts,
>> +            bool *match_found, bool *res);
>>      QTAILQ_ENTRY(DeviceListener) link;
>>  };
>>
>> @@ -451,4 +458,6 @@ static inline bool qbus_is_hotpluggable(BusState *bus)
>>  void device_listener_register(DeviceListener *listener);
>>  void device_listener_unregister(DeviceListener *listener);
>>
>> +bool qdev_should_hide_device(QemuOpts *opts, Error **errp);
>> +
>>  #endif
>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>> index 148df9cacf..9fc8331157 100644
>> --- a/qdev-monitor.c
>> +++ b/qdev-monitor.c
>> @@ -32,9 +32,11 @@
>>  #include "qemu/help_option.h"
>>  #include "qemu/option.h"
>>  #include "qemu/qemu-print.h"
>> +#include "qemu/option_int.h"
>>  #include "sysemu/block-backend.h"
>>  #include "sysemu/sysemu.h"
>>  #include "migration/misc.h"
>> +#include "migration/migration.h"
>>
>>  /*
>>   * Aliases were a bad idea from the start.  Let's keep them
>> @@ -562,14 +564,45 @@ void qdev_set_id(DeviceState *dev, const char *id)
>>      }
>>  }
>>
>> +static int is_failover_device(void *opaque, const char *name, const char *value,
>> +                        Error **errp)
>> +{
>> +    if (strcmp(name, "net_failover_pair_id") == 0) {
>> +        QemuOpts *opts = (QemuOpts *)opaque;
>> +
>> +        if (qdev_should_hide_device(opts, errp) && errp && !*errp) {
>> +            return 1;
>> +        } else if (errp && *errp) {
>> +            return -1;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static bool should_hide_device(QemuOpts *opts, Error **err)
>> +{
>> +    if (qemu_opt_foreach(opts, is_failover_device, opts, err) == 0) {
>> +        return false;
>
>Maybe turn that check around? I.e. return true if the failover property
>is present, else return false. Makes it easier to add checks for other
>properties in the future.

Done.

>> +    }
>> +    return true;
>> +}
>> +
>>  DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>>  {
>>      DeviceClass *dc;
>>      const char *driver, *path;
>> -    DeviceState *dev;
>> +    DeviceState *dev = NULL;
>>      BusState *bus = NULL;
>>      Error *err = NULL;
>>
>> +    if (opts && should_hide_device(opts, &err)) {
>> +        if (err) {
>> +            goto err_del_dev;
>> +        }
>> +        return NULL;
>> +    }
>> +
>>      driver = qemu_opt_get(opts, "driver");
>>      if (!driver) {
>>          error_setg(errp, QERR_MISSING_PARAMETER, "driver");
>> @@ -648,8 +681,10 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>>
>>  err_del_dev:
>>      error_propagate(errp, err);
>> -    object_unparent(OBJECT(dev));
>> -    object_unref(OBJECT(dev));
>> +    if (dev) {
>> +        object_unparent(OBJECT(dev));
>> +        object_unref(OBJECT(dev));
>> +    }
>>      return NULL;
>>  }
>>
>> @@ -818,7 +853,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>>          return;
>>      }
>>
>> -    if (!migration_is_idle()) {
>> +    if (!migration_is_idle() && !migration_in_setup(migrate_get_current())) {
>
>Hm, should that hunk go into another patch?

Yes it should :)

Thanks for the review!

regards,
Jens 

