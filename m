Received: from eggs.gnu.org ([2001:4830:134:3::10]:49606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gCOuE-0002P0-OT
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gCOuA-00022J-Nq
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:57:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gCOuA-000203-BT
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:56:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9GCnjm2026933
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 08:56:56 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n5g758qn3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 08:56:56 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 16 Oct 2018 13:56:53 +0100
References: <20181016115817.14605-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 16 Oct 2018 14:56:48 +0200
MIME-Version: 1.0
In-Reply-To: <20181016115817.14605-1-cohuck@redhat.com>
Content-Language: en-US
Message-Id: <c2f660ac-ecd6-76ed-8a6b-07f3478e22a0@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] s390x/vfio-ap: report correct error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 10/16/2018 01:58 PM, Cornelia Huck wrote:
> If ioctl(..., VFIO_DEVICE_RESET) fails, we want to report errno
> instead of ret (which is always -1 on error).
> 
> Fixes Coverity issue CID 1396176.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

makes sense

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  hw/vfio/ap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 3962bb74e5..65de952f44 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -142,7 +142,7 @@ static void vfio_ap_reset(DeviceState *dev)
>      ret = ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
>      if (ret) {
>          error_report("%s: failed to reset %s device: %s", __func__,
> -                     vapdev->vdev.name, strerror(ret));
> +                     vapdev->vdev.name, strerror(errno));
>      }
>  }
>  
> 
