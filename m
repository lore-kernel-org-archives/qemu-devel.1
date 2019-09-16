Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A40C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA9420644
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA9420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9lOY-0003gu-V5
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 03:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i9lMi-00021v-Hs
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i9lMh-0007l6-Bt
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:24:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i9lMh-0007kr-3l
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:24:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5991F10B78;
 Mon, 16 Sep 2019 07:24:02 +0000 (UTC)
Received: from [10.36.116.33] (ovpn-116-33.ams2.redhat.com [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE7C55D9E1;
 Mon, 16 Sep 2019 07:23:49 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190812074531.28970-1-peterx@redhat.com>
 <20190812074531.28970-3-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a8d4d0b7-8d2b-119f-f74e-81104db70945@redhat.com>
Date: Mon, 16 Sep 2019 09:23:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190812074531.28970-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 16 Sep 2019 07:24:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC 2/4] qdev/machine: Introduce
 hotplug_allowed hook
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Bandan Das <bsd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 8/12/19 9:45 AM, Peter Xu wrote:
> Introduce this new per-machine hook to give any machine class a chance
> to do a sanity check on the to-be-hotplugged device as a sanity test.
> This will be used for x86 to try to detect some illegal configuration
> of devices, e.g., possible conflictions between vfio-pci and x86
conflicts
> vIOMMU.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/core/qdev.c         | 17 +++++++++++++++++
>  include/hw/boards.h    |  9 +++++++++
>  include/hw/qdev-core.h |  1 +
>  qdev-monitor.c         |  7 +++++++
>  4 files changed, 34 insertions(+)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 94ebc0a4a1..d792b43c37 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -236,6 +236,23 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
>      return NULL;
>  }
>  
> +bool qdev_hotplug_allowed(DeviceState *dev, Error **errp)
> +{
> +    MachineState *machine;
> +    MachineClass *mc;
> +    Object *m_obj = qdev_get_machine();
> +
> +    if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
> +        machine = MACHINE(m_obj);
> +        mc = MACHINE_GET_CLASS(machine);
> +        if (mc->hotplug_allowed) {
> +            return mc->hotplug_allowed(machine, dev, errp);
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
>  {
>      if (dev->parent_bus) {
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index a71d1a53a5..1cf63be45d 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -166,6 +166,13 @@ typedef struct {
>   *    The function pointer to hook different machine specific functions for
>   *    parsing "smp-opts" from QemuOpts to MachineState::CpuTopology and more
>   *    machine specific topology fields, such as smp_dies for PCMachine.
> + * @hotplug_allowed:
> + *    If the hook is provided, then it'll be called for each device
> + *    hotplug to check whether the device hotplug is allowed.  Return
> + *    true to grant allowance or false to reject the hotplug.  When
> + *    false is returned, an error must be set to show the reason of
> + *    the rejection.  If the hook is not provided, all hotplug will be
> + *    allowed.
>   */
>  struct MachineClass {
>      /*< private >*/
> @@ -223,6 +230,8 @@ struct MachineClass {
>  
>      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>                                             DeviceState *dev);
> +    bool (*hotplug_allowed)(MachineState *state, DeviceState *dev,
> +                            Error **errp);
>      CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *machine,
>                                                           unsigned cpu_index);
>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 136df7774c..88e7ec4b60 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -284,6 +284,7 @@ void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>                                   int required_for_version);
>  HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
>  HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
> +bool qdev_hotplug_allowed(DeviceState *dev, Error **errp);
>  /**
>   * qdev_get_hotplug_handler: Get handler responsible for device wiring
>   *
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 58222c2211..6c80602771 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -614,6 +614,13 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>      /* create device */
>      dev = DEVICE(object_new(driver));
>  
> +    /* Check whether the hotplug is allowed by the machine */
> +    if (qdev_hotplug && !qdev_hotplug_allowed(dev, &err)) {
> +        /* Error must be set in the machine hook */
> +        assert(err);
> +        goto err_del_dev;
> +    }
> +
>      if (bus) {
>          qdev_set_parent_bus(dev, bus);
>      } else if (qdev_hotplug && !qdev_get_machine_hotplug_handler(dev)) {
> 

