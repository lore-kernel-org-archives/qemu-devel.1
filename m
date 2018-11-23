Received: from eggs.gnu.org ([2001:4830:134:3::10]:51293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gQD3U-0003dU-EF
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gQD3R-0001AW-Kv
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:07:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58358
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gQD3R-00019p-G9
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 10:07:37 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wANF3j4K071219
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 10:07:37 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nxj8smgtq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 10:07:36 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 23 Nov 2018 15:07:34 -0000
Reply-To: pmorel@linux.ibm.com
References: <20181120110427.7321-1-david@redhat.com>
	<20181120110427.7321-4-david@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 23 Nov 2018 16:07:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181120110427.7321-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <17287746-ee99-7022-e828-d79b932e2427@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/11] s390x/pci: rename hotplug handler
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Collin Walling <walling@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On 20/11/2018 12:04, David Hildenbrand wrote:
> The callbacks are also called for cold plugged devices. Drop the "hot"
> to better match the actual callback names.
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/s390x/s390-pci-bus.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 060ff062bc..9abd49a9dc 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -827,8 +827,8 @@ static bool s390_pci_alloc_idx(S390pciState *s, S39=
0PCIBusDevice *pbdev)
>       return true;
>   }
>=20
> -static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
> -                                  DeviceState *dev, Error **errp)
> +static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState=
 *dev,
> +                              Error **errp)
>   {
>       PCIDevice *pdev =3D NULL;
>       S390PCIBusDevice *pbdev =3D NULL;
> @@ -936,8 +936,8 @@ static void s390_pcihost_timer_cb(void *opaque)
>       qdev_unplug(DEVICE(pbdev), NULL);
>   }
>=20
> -static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
> -                                    DeviceState *dev, Error **errp)
> +static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceSta=
te *dev,
> +                                Error **errp)
>   {
>       PCIDevice *pci_dev =3D NULL;
>       PCIBus *bus;
> @@ -1045,8 +1045,8 @@ static void s390_pcihost_class_init(ObjectClass *=
klass, void *data)
>=20
>       dc->reset =3D s390_pcihost_reset;
>       dc->realize =3D s390_pcihost_realize;
> -    hc->plug =3D s390_pcihost_hot_plug;
> -    hc->unplug =3D s390_pcihost_hot_unplug;
> +    hc->plug =3D s390_pcihost_plug;
> +    hc->unplug =3D s390_pcihost_unplug;
>       msi_nonbroken =3D true;
>   }
>=20

LBTM (does that exist? Look Better To Me)

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
