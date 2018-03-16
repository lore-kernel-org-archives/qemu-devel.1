Received: from eggs.gnu.org ([2001:4830:134:3::10]:43101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ewmZy-00015H-Ll
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ewmZu-0004Gz-NG
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:27:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57746
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1ewmZu-0004GX-HS
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 06:27:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GAOTis099472
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 06:27:13 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2grc2jr8cs-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 06:27:13 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 10:27:11 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id w2GAR9WK48365664
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 10:27:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6E0042042
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 10:19:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF91242047
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 10:19:21 +0000 (GMT)
Received: from [9.152.224.146] (unknown [9.152.224.146])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 10:19:21 +0000 (GMT)
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-3-git-send-email-akrowiak@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 11:27:09 +0100
MIME-Version: 1.0
In-Reply-To: <1521156300-19296-3-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <ac62a601-9d6e-2aac-2a7c-286ce53465ad@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/7] s390x/ap: base Adjunct Processor
 (AP) object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 16/03/2018 00:24, Tony Krowiak wrote:
> This patch introduces the base object for an AP device.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>   hw/s390x/Makefile.objs       |    1 +
>   hw/s390x/ap-device.c         |   38 +++++++++++++++++++++++++++++++++=
+++++
>   include/hw/s390x/ap-device.h |   38 +++++++++++++++++++++++++++++++++=
+++++
>   3 files changed, 77 insertions(+), 0 deletions(-)
>   create mode 100644 hw/s390x/ap-device.c
>   create mode 100644 include/hw/s390x/ap-device.h
>
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index dc704b5..3247a07 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -17,3 +17,4 @@ obj-y +=3D s390-stattrib.o
>   obj-$(CONFIG_KVM) +=3D s390-skeys-kvm.o
>   obj-$(CONFIG_KVM) +=3D s390-stattrib-kvm.o
>   obj-y +=3D s390-ccw.o
> +obj-y +=3D ap-device.o
> diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
> new file mode 100644
> index 0000000..448f6db
> --- /dev/null
> +++ b/hw/s390x/ap-device.c
> @@ -0,0 +1,38 @@
> +/*
> + * Adjunct Processor (AP) matrix device
> + *
> + * Copyright 2018 IBM Corp.
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
> + * your option) any later version. See the COPYING file in the top-lev=
el
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
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->desc =3D "AP device class";

Shouldn't we make the AP devices unpluggable ?

> +}
> +
> +static const TypeInfo ap_device_info =3D {
> +    .name =3D AP_DEVICE_TYPE,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(APDevice),
> +    .class_size =3D sizeof(APDeviceClass),
> +    .class_init =3D ap_class_init,
> +    .abstract =3D true,
> +};
> +
> +static void ap_device_register(void)
> +{
> +    type_register_static(&ap_device_info);
> +}
> +
> +type_init(ap_device_register)
> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.=
h
> new file mode 100644
> index 0000000..693df90
> --- /dev/null
> +++ b/include/hw/s390x/ap-device.h
> @@ -0,0 +1,38 @@
> +/*
> + * Adjunct Processor (AP) matrix device interfaces
> + *
> + * Copyright 2018 IBM Corp.
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
(at
> + * your option) any later version. See the COPYING file in the top-lev=
el
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
> +typedef struct APDeviceClass {
> +    DeviceClass parent_class;
> +} APDeviceClass;
> +
> +static inline APDevice *to_ap_dev(DeviceState *dev)
> +{
> +    return container_of(dev, APDevice, parent_obj);
> +}
> +
> +#define AP_DEVICE(obj) \
> +    OBJECT_CHECK(APDevice, (obj), AP_DEVICE_TYPE)
> +
> +#define AP_DEVICE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(APDeviceClass, (obj), AP_DEVICE_TYPE)
> +
> +#define AP_DEVICE_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(APDeviceClass, (klass), AP_DEVICE_TYPE)
> +
> +#endif /* HW_S390X_AP_DEVICE_H */


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
