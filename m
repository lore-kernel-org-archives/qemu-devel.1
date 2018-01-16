Received: from eggs.gnu.org ([2001:4830:134:3::10]:60774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1ebTq2-0003xD-1N
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:11:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1ebTpv-0005oh-7C
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:11:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54674
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1ebTpv-0005oL-1R
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:11:43 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0GG9wTv035369
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 11:11:42 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fhkkcv9vy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 11:11:42 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Tue, 16 Jan 2018 11:11:41 -0500
References: <20180116131555.14242-1-f4bug@amsat.org>
	<20180116131555.14242-6-f4bug@amsat.org>
	<21f570e0-eae6-e93d-c011-4742d777d843@linux.vnet.ibm.com>
	<18def10c-ca89-6628-34db-c62b071b3277@amsat.org>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Tue, 16 Jan 2018 11:11:35 -0500
MIME-Version: 1.0
In-Reply-To: <18def10c-ca89-6628-34db-c62b071b3277@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <f7b3af0e-832c-5f9f-b6c1-8f9d24780d3c@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/11] virtio-ccw: convert
 VirtIOCCWDeviceClass::init -> realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>



On 01/16/2018 09:07 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 01/16/2018 10:41 AM, Farhan Ali wrote:
>> shouldn't the commit message say exit -> unrealize?
>=20
> Oops, indeed :|
>=20
> Thanks :)
>=20
> Phil.

Sure, you are welcome :)

With the change in commit message, the patch looks good to me:

Reviewed-by: Farhan Ali <alifm@linux.vnet.ibm.com>



>=20
>>
>>
>> Thanks
>> Farhan
>>
>> On 01/16/2018 08:15 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  =C2=A0 hw/s390x/virtio-ccw.h |=C2=A0 2 +-
>>>  =C2=A0 hw/s390x/virtio-ccw.c | 35 +++++++++++++++++-----------------=
-
>>>  =C2=A0 2 files changed, 18 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
>>> index 3905f3a3d6..2fc513001e 100644
>>> --- a/hw/s390x/virtio-ccw.h
>>> +++ b/hw/s390x/virtio-ccw.h
>>> @@ -76,7 +76,7 @@ typedef struct VirtioCcwDevice VirtioCcwDevice;
>>>  =C2=A0 typedef struct VirtIOCCWDeviceClass {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CCWDeviceClass parent_class;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*realize)(VirtioCcwDevice *dev,=
 Error **errp);
>>> -=C2=A0=C2=A0=C2=A0 int (*exit)(VirtioCcwDevice *dev);
>>> +=C2=A0=C2=A0=C2=A0 void (*unrealize)(VirtioCcwDevice *dev, Error **e=
rrp);
>>>  =C2=A0 } VirtIOCCWDeviceClass;
>>>
>>>  =C2=A0 /* Performance improves when virtqueue kick processing is dec=
oupled
>>> from the
>>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>>> index 38f6a8afc9..a71c3feeb5 100644
>>> --- a/hw/s390x/virtio-ccw.c
>>> +++ b/hw/s390x/virtio-ccw.c
>>> @@ -751,7 +751,7 @@ out_err:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(sch);
>>>  =C2=A0 }
>>>
>>> -static int virtio_ccw_exit(VirtioCcwDevice *dev)
>>> +static void virtio_ccw_unrealize(VirtioCcwDevice *dev, Error **errp)
>>>  =C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CcwDevice *ccw_dev =3D CCW_DEVICE(dev=
);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SubchDev *sch =3D ccw_dev->sch;
>>> @@ -764,7 +764,6 @@ static int virtio_ccw_exit(VirtioCcwDevice *dev)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 release_indic=
ator(&dev->routes.adapter, dev->indicators);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev->indicato=
rs =3D NULL;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 return 0;
>>>  =C2=A0 }
>>>
>>>  =C2=A0 static void virtio_ccw_net_realize(VirtioCcwDevice *ccw_dev, =
Error
>>> **errp)
>>> @@ -1343,7 +1342,7 @@ static void
>>> virtio_ccw_net_class_init(ObjectClass *klass, void *data)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtIOCCWDeviceClass *k =3D VIRTIO_CC=
W_DEVICE_CLASS(klass);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->realize =3D virtio_ccw_net_realize=
;
>>> -=C2=A0=C2=A0=C2=A0 k->exit =3D virtio_ccw_exit;
>>> +=C2=A0=C2=A0=C2=A0 k->unrealize =3D virtio_ccw_unrealize;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->reset =3D virtio_ccw_reset;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->props =3D virtio_ccw_net_properti=
es;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(DEVICE_CATEGORY_NETWORK, dc->=
categories);
>>> @@ -1371,7 +1370,7 @@ static void
>>> virtio_ccw_blk_class_init(ObjectClass *klass, void *data)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtIOCCWDeviceClass *k =3D VIRTIO_CC=
W_DEVICE_CLASS(klass);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->realize =3D virtio_ccw_blk_realize=
;
>>> -=C2=A0=C2=A0=C2=A0 k->exit =3D virtio_ccw_exit;
>>> +=C2=A0=C2=A0=C2=A0 k->unrealize =3D virtio_ccw_unrealize;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->reset =3D virtio_ccw_reset;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->props =3D virtio_ccw_blk_properti=
es;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(DEVICE_CATEGORY_STORAGE, dc->=
categories);
>>> @@ -1399,7 +1398,7 @@ static void
>>> virtio_ccw_serial_class_init(ObjectClass *klass, void *data)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtIOCCWDeviceClass *k =3D VIRTIO_CC=
W_DEVICE_CLASS(klass);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->realize =3D virtio_ccw_serial_real=
ize;
>>> -=C2=A0=C2=A0=C2=A0 k->exit =3D virtio_ccw_exit;
>>> +=C2=A0=C2=A0=C2=A0 k->unrealize =3D virtio_ccw_unrealize;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->reset =3D virtio_ccw_reset;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->props =3D virtio_ccw_serial_prope=
rties;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(DEVICE_CATEGORY_INPUT, dc->ca=
tegories);
>>> @@ -1427,7 +1426,7 @@ static void
>>> virtio_ccw_balloon_class_init(ObjectClass *klass, void *data)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtIOCCWDeviceClass *k =3D VIRTIO_CC=
W_DEVICE_CLASS(klass);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->realize =3D virtio_ccw_balloon_rea=
lize;
>>> -=C2=A0=C2=A0=C2=A0 k->exit =3D virtio_ccw_exit;
>>> +=C2=A0=C2=A0=C2=A0 k->unrealize =3D virtio_ccw_unrealize;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->reset =3D virtio_ccw_reset;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->props =3D virtio_ccw_balloon_prop=
erties;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(DEVICE_CATEGORY_MISC, dc->cat=
egories);
>>> @@ -1455,7 +1454,7 @@ static void
>>> virtio_ccw_scsi_class_init(ObjectClass *klass, void *data)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtIOCCWDeviceClass *k =3D VIRTIO_CC=
W_DEVICE_CLASS(klass);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->realize =3D virtio_ccw_scsi_realiz=
e;
>>> -=C2=A0=C2=A0=C2=A0 k->exit =3D virtio_ccw_exit;
>>> +=C2=A0=C2=A0=C2=A0 k->unrealize =3D virtio_ccw_unrealize;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->reset =3D virtio_ccw_reset;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->props =3D virtio_ccw_scsi_propert=
ies;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(DEVICE_CATEGORY_STORAGE, dc->=
categories);
>>> @@ -1482,7 +1481,7 @@ static void
>>> vhost_ccw_scsi_class_init(ObjectClass *klass, void *data)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtIOCCWDeviceClass *k =3D VIRTIO_CC=
W_DEVICE_CLASS(klass);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->realize =3D vhost_ccw_scsi_realize=
;
>>> -=C2=A0=C2=A0=C2=A0 k->exit =3D virtio_ccw_exit;
>>> +=C2=A0=C2=A0=C2=A0 k->unrealize =3D virtio_ccw_unrealize;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->reset =3D virtio_ccw_reset;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->props =3D vhost_ccw_scsi_properti=
es;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(DEVICE_CATEGORY_STORAGE, dc->=
categories);
>>> @@ -1519,7 +1518,7 @@ static void
>>> virtio_ccw_rng_class_init(ObjectClass *klass, void *data)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtIOCCWDeviceClass *k =3D VIRTIO_CC=
W_DEVICE_CLASS(klass);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->realize =3D virtio_ccw_rng_realize=
;
>>> -=C2=A0=C2=A0=C2=A0 k->exit =3D virtio_ccw_exit;
>>> +=C2=A0=C2=A0=C2=A0 k->unrealize =3D virtio_ccw_unrealize;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->reset =3D virtio_ccw_reset;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->props =3D virtio_ccw_rng_properti=
es;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(DEVICE_CATEGORY_MISC, dc->cat=
egories);
>>> @@ -1557,7 +1556,7 @@ static void
>>> virtio_ccw_crypto_class_init(ObjectClass *klass, void *data)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtIOCCWDeviceClass *k =3D VIRTIO_CC=
W_DEVICE_CLASS(klass);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->realize =3D virtio_ccw_crypto_real=
ize;
>>> -=C2=A0=C2=A0=C2=A0 k->exit =3D virtio_ccw_exit;
>>> +=C2=A0=C2=A0=C2=A0 k->unrealize =3D virtio_ccw_unrealize;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->reset =3D virtio_ccw_reset;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->props =3D virtio_ccw_crypto_prope=
rties;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(DEVICE_CATEGORY_MISC, dc->cat=
egories);
>>> @@ -1595,7 +1594,7 @@ static void
>>> virtio_ccw_gpu_class_init(ObjectClass *klass, void *data)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtIOCCWDeviceClass *k =3D VIRTIO_CC=
W_DEVICE_CLASS(klass);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->realize =3D virtio_ccw_gpu_realize=
;
>>> -=C2=A0=C2=A0=C2=A0 k->exit =3D virtio_ccw_exit;
>>> +=C2=A0=C2=A0=C2=A0 k->unrealize =3D virtio_ccw_unrealize;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->reset =3D virtio_ccw_reset;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->props =3D virtio_ccw_gpu_properti=
es;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->hotpluggable =3D false;
>>> @@ -1624,7 +1623,7 @@ static void
>>> virtio_ccw_input_class_init(ObjectClass *klass, void *data)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtIOCCWDeviceClass *k =3D VIRTIO_CC=
W_DEVICE_CLASS(klass);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->realize =3D virtio_ccw_input_reali=
ze;
>>> -=C2=A0=C2=A0=C2=A0 k->exit =3D virtio_ccw_exit;
>>> +=C2=A0=C2=A0=C2=A0 k->unrealize =3D virtio_ccw_unrealize;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->reset =3D virtio_ccw_reset;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->props =3D virtio_ccw_input_proper=
ties;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(DEVICE_CATEGORY_INPUT, dc->ca=
tegories);
>>> @@ -1704,12 +1703,12 @@ static void
>>> virtio_ccw_busdev_realize(DeviceState *dev, Error **errp)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 virtio_ccw_device_realize(_dev, errp)=
;
>>>  =C2=A0 }
>>>
>>> -static int virtio_ccw_busdev_exit(DeviceState *dev)
>>> +static void virtio_ccw_busdev_unrealize(DeviceState *dev, Error **er=
rp)
>>>  =C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtioCcwDevice *_dev =3D (VirtioCcwD=
evice *)dev;
>>> -=C2=A0=C2=A0=C2=A0 VirtIOCCWDeviceClass *_info =3D VIRTIO_CCW_DEVICE=
_GET_CLASS(dev);
>>> +=C2=A0=C2=A0=C2=A0 VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_GET=
_CLASS(dev);
>>>
>>> -=C2=A0=C2=A0=C2=A0 return _info->exit(_dev);
>>> +=C2=A0=C2=A0=C2=A0 k->unrealize(_dev, errp);
>>>  =C2=A0 }
>>>
>>>  =C2=A0 static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_=
dev,
>>> @@ -1727,7 +1726,7 @@ static void
>>> virtio_ccw_device_class_init(ObjectClass *klass, void *data)
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->unplug =3D virtio_ccw_busdev_unplu=
g;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->realize =3D virtio_ccw_busdev_rea=
lize;
>>> -=C2=A0=C2=A0=C2=A0 dc->exit =3D virtio_ccw_busdev_exit;
>>> +=C2=A0=C2=A0=C2=A0 dc->unrealize =3D virtio_ccw_busdev_unrealize;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->bus_type =3D TYPE_VIRTUAL_CSS_BUS=
;
>>>  =C2=A0 }
>>>
>>> @@ -1803,7 +1802,7 @@ static void virtio_ccw_9p_class_init(ObjectClas=
s
>>> *klass, void *data)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klas=
s);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtIOCCWDeviceClass *k =3D VIRTIO_CC=
W_DEVICE_CLASS(klass);
>>>
>>> -=C2=A0=C2=A0=C2=A0 k->exit =3D virtio_ccw_exit;
>>> +=C2=A0=C2=A0=C2=A0 k->unrealize =3D virtio_ccw_unrealize;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->realize =3D virtio_ccw_9p_realize;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->reset =3D virtio_ccw_reset;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->props =3D virtio_ccw_9p_propertie=
s;
>>> @@ -1852,7 +1851,7 @@ static void
>>> vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtIOCCWDeviceClass *k =3D VIRTIO_CC=
W_DEVICE_CLASS(klass);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->realize =3D vhost_vsock_ccw_realiz=
e;
>>> -=C2=A0=C2=A0=C2=A0 k->exit =3D virtio_ccw_exit;
>>> +=C2=A0=C2=A0=C2=A0 k->unrealize =3D virtio_ccw_unrealize;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(DEVICE_CATEGORY_MISC, dc->cat=
egories);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->props =3D vhost_vsock_ccw_propert=
ies;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->reset =3D virtio_ccw_reset;
>>>
>>
>=20
