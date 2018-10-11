Received: from eggs.gnu.org ([2001:4830:134:3::10]:42591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAYF8-000223-Uy
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAYF5-0007dy-QD
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:30:58 -0400
Date: Thu, 11 Oct 2018 12:30:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181011123035.5d97de0d.cohuck@redhat.com>
In-Reply-To: <20181010170309.12045-6-akrowiak@linux.ibm.com>
References: <20181010170309.12045-1-akrowiak@linux.ibm.com>
	<20181010170309.12045-6-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 5/6] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, akrowiak@linux.vnet.ibm.com, fiuczy@linux.ibm.com, mimu@linux.ibm.com

On Wed, 10 Oct 2018 13:03:07 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> +static void vfio_ap_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->props = vfio_ap_properties;
> +    dc->vmsd = &vfio_ap_vmstate;
> +    dc->desc = "VFIO-based AP device assignment";
> +    dc->realize = vfio_ap_realize;
> +    dc->unrealize = vfio_ap_unrealize;
> +    dc->hotpluggable = false;
> +    dc->reset = vfio_ap_reset;
> +    dc->bus_type = TYPE_AP_BUS;
> +}
> +
> +static const TypeInfo vfio_ap_info = {
> +    .name = VFIO_AP_DEVICE_TYPE,
> +    .parent = AP_DEVICE_TYPE,
> +    .instance_size = sizeof(VFIOAPDevice),
> +    .class_init = vfio_ap_class_init,
> +};
> +
> +static void vfio_ap_type_init(void)
> +{
> +    type_register_static(&vfio_ap_info);
> +}
> +
> +type_init(vfio_ap_type_init)

This device is missing the categorization, which was already requested
in a previous version. I added it to the misc category myself.
