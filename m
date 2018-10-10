Received: from eggs.gnu.org ([2001:4830:134:3::10]:33882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gACw7-00033N-7V
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gACw4-0004Br-0o
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:45:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38082
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gACw3-0004BN-Jj
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:45:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9ABj5OJ061239
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 07:45:50 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2n1fksk8nw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 07:45:50 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 10 Oct 2018 12:45:47 +0100
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-5-akrowiak@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 10 Oct 2018 13:45:41 +0200
MIME-Version: 1.0
In-Reply-To: <20181009175226.22138-5-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <11c6c775-e025-4f9a-80f2-65c1bb570156@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v10 4/6] s390x/ap: base
 Adjunct Processor (AP) object model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com



On 10/09/2018 07:52 PM, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces the base object model for virtualizing AP devices.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

> ---
>  MAINTAINERS                  | 12 ++++++
>  hw/s390x/Makefile.objs       |  2 +
>  hw/s390x/ap-bridge.c         | 78 ++++++++++++++++++++++++++++++++++++
>  hw/s390x/ap-device.c         | 39 ++++++++++++++++++
>  hw/s390x/s390-virtio-ccw.c   |  4 ++
>  include/hw/s390x/ap-bridge.h | 19 +++++++++
>  include/hw/s390x/ap-device.h | 23 +++++++++++
>  7 files changed, 177 insertions(+)
>  create mode 100644 hw/s390x/ap-bridge.c
>  create mode 100644 hw/s390x/ap-device.c
>  create mode 100644 include/hw/s390x/ap-bridge.h
>  create mode 100644 include/hw/s390x/ap-device.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d12518c08f10..97e8ed808bc0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1199,6 +1199,18 @@ F: include/hw/s390x/s390-ccw.h
>  T: git git://github.com/cohuck/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>  
> +vfio-ap
> +M: Christian Borntraeger <borntraeger@de.ibm.com>
> +M: Tony Krowiak <akrowiak@linux.ibm.com>
> +M: Halil Pasic <pasic@linux.ibm.com>
> +M: Pierre Morel <pmorel@linux.ibm.com>
> +S: Supported
> +F: hw/s390x/ap-device.c
> +F: hw/s390x/ap-bridge.c
> +F: include/hw/s390x/ap-device.h
> +F: include/hw/s390x/ap-bridge.h
> +L: qemu-s390x@nongnu.org
> +
>  vhost
>  M: Michael S. Tsirkin <mst@redhat.com>
>  S: Supported
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index 93282f7c593c..add89b150d90 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -20,3 +20,5 @@ obj-$(CONFIG_TCG) += tod-qemu.o
>  obj-$(CONFIG_KVM) += s390-skeys-kvm.o
>  obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
>  obj-y += s390-ccw.o
> +obj-y += ap-device.o
> +obj-y += ap-bridge.o
> diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
> new file mode 100644
> index 000000000000..3795d30dd7c9
> --- /dev/null
> +++ b/hw/s390x/ap-bridge.c
> @@ -0,0 +1,78 @@
> +/*
> + * ap bridge
> + *
> + * Copyright 2018 IBM Corp.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "qemu/bitops.h"
> +#include "hw/s390x/ap-bridge.h"
> +#include "cpu.h"
> +
> +static char *ap_bus_get_dev_path(DeviceState *dev)
> +{
> +    /* at most one */
> +    return g_strdup_printf("/1");
> +}
> +
> +static void ap_bus_class_init(ObjectClass *oc, void *data)
> +{
> +    BusClass *k = BUS_CLASS(oc);
> +
> +    k->get_dev_path = ap_bus_get_dev_path;
> +    /* More than one ap device does not make sense */
> +    k->max_dev = 1;
> +}
> +
> +static const TypeInfo ap_bus_info = {
> +    .name = TYPE_AP_BUS,
> +    .parent = TYPE_BUS,
> +    .instance_size = 0,
> +    .class_init = ap_bus_class_init,
> +};
> +
> +void s390_init_ap(void)
> +{
> +    DeviceState *dev;
> +
> +    /* If no AP instructions then no need for AP bridge */
> +    if (!s390_has_feat(S390_FEAT_AP)) {
> +        return;
> +    }
> +
> +    /* Create bridge device */
> +    dev = qdev_create(NULL, TYPE_AP_BRIDGE);
> +    object_property_add_child(qdev_get_machine(), TYPE_AP_BRIDGE,
> +                              OBJECT(dev), NULL);
> +    qdev_init_nofail(dev);
> +
> +    /* Create bus on bridge device */
> +    qbus_create(TYPE_AP_BUS, dev, TYPE_AP_BUS);
> + }
> +
> +static void ap_bridge_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +}
> +
> +static const TypeInfo ap_bridge_info = {
> +    .name          = TYPE_AP_BRIDGE,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = 0,
> +    .class_init    = ap_bridge_class_init,
> +};
> +
> +static void ap_register(void)
> +{
> +    type_register_static(&ap_bridge_info);
> +    type_register_static(&ap_bus_info);
> +}
> +
> +type_init(ap_register)
> diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
> new file mode 100644
> index 000000000000..fb6e35024c82
> --- /dev/null
> +++ b/hw/s390x/ap-device.c
> @@ -0,0 +1,39 @@
> +/*
> + * Adjunct Processor (AP) matrix device
> + *
> + * Copyright 2018 IBM Corp.
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "hw/qdev.h"
> +#include "hw/s390x/ap-device.h"
> +
> +static void ap_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "AP device class";
> +    dc->hotpluggable = false;
> +}
> +
> +static const TypeInfo ap_device_info = {
> +    .name = AP_DEVICE_TYPE,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(APDevice),
> +    .class_size = sizeof(DeviceClass),
> +    .class_init = ap_class_init,
> +    .abstract = true,
> +};
> +
> +static void ap_device_register(void)
> +{
> +    type_register_static(&ap_device_info);
> +}
> +
> +type_init(ap_device_register)
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index f0f7fdcaddf2..3c100c24f3e8 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -32,6 +32,7 @@
>  #include "ipl.h"
>  #include "hw/s390x/s390-virtio-ccw.h"
>  #include "hw/s390x/css-bridge.h"
> +#include "hw/s390x/ap-bridge.h"
>  #include "migration/register.h"
>  #include "cpu_models.h"
>  #include "hw/nmi.h"
> @@ -263,6 +264,9 @@ static void ccw_init(MachineState *machine)
>      /* init the SIGP facility */
>      s390_init_sigp();
>  
> +    /* create AP bridge and bus(es) */
> +    s390_init_ap();
> +
>      /* get a BUS */
>      css_bus = virtual_css_bus_init();
>      s390_init_ipl_dev(machine->kernel_filename, machine->kernel_cmdline,
> diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
> new file mode 100644
> index 000000000000..470e439a98ed
> --- /dev/null
> +++ b/include/hw/s390x/ap-bridge.h
> @@ -0,0 +1,19 @@
> +/*
> + * ap bridge
> + *
> + * Copyright 2018 IBM Corp.
> + *

This one does not have 'Author(s):' and Connie already mentioned
that some others use vnet address.

I would prefer resolving this by not adding any 'Author(s):' for
any the files introduce by this series.

My r-b stands regardless of the resolution.

> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#ifndef HW_S390X_AP_BRIDGE_H
> +#define HW_S390X_AP_BRIDGE_H
> +
> +#define TYPE_AP_BRIDGE "ap-bridge"
> +#define TYPE_AP_BUS "ap-bus"
> +
> +void s390_init_ap(void);
> +
> +#endif
> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
> new file mode 100644
> index 000000000000..4fb3c9ab82f2
> --- /dev/null
> +++ b/include/hw/s390x/ap-device.h
> @@ -0,0 +1,23 @@
> +/*
> + * Adjunct Processor (AP) matrix device interfaces
> + *
> + * Copyright 2018 IBM Corp.
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +#ifndef HW_S390X_AP_DEVICE_H
> +#define HW_S390X_AP_DEVICE_H
> +
> +#define AP_DEVICE_TYPE       "ap-device"
> +
> +typedef struct APDevice {
> +    DeviceState parent_obj;
> +} APDevice;
> +
> +#define AP_DEVICE(obj) \
> +    OBJECT_CHECK(APDevice, (obj), AP_DEVICE_TYPE)
> +
> +#endif /* HW_S390X_AP_DEVICE_H */
> 
