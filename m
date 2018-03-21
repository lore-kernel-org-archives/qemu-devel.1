Received: from eggs.gnu.org ([2001:4830:134:3::10]:43025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1eydXi-0001DG-Py
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1eydXc-0006dF-UN
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:12:38 -0400
References: <1518461904-5305-1-git-send-email-eric.auger@redhat.com>
	<1518461904-5305-16-git-send-email-eric.auger@redhat.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <895f039a-ade7-cf1a-6c47-81fd093f75e9@arm.com>
Date: Wed, 21 Mar 2018 13:15:43 +0000
MIME-Version: 1.0
In-Reply-To: <1518461904-5305-16-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v6 15/22] virtio-iommu: Implement fault
 reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Will Deacon <Will.Deacon@arm.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "drjones@redhat.com" <drjones@redhat.com>, "wei@redhat.com" <wei@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "peterx@redhat.com" <peterx@redhat.com>, "linuc.decode@gmail.com" <linuc.decode@gmail.com>

Hi Eric,

On 12/02/18 18:58, Eric Auger wrote:
[...]
> +    for (;;) {
> +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +
> +        if (!elem) {
> +            virtio_error(vdev,
> +                         "no buffer available in event queue to report event");
> +            return;
> +        }

When $user attempts something silly like trying VFIO without the VFIO
patches, this outputs thousands of messages per second... I guess it would
also happen if the driver isn't consuming error reports fast enough. Is
there a simple way of ratelimiting printfs so the context of the error
doesn't get washed away?

Thanks,
Jean
