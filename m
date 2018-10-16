Received: from eggs.gnu.org ([2001:4830:134:3::10]:33972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gCQmM-0005De-VF
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gCQmJ-0005tZ-N4
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:57:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gCQmI-0005o6-QW
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:56:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9GEpoGc004402
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:56:56 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n5h5yug6r-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:56:55 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Tue, 16 Oct 2018 08:56:54 -0600
References: <20181016115817.14605-1-cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Tue, 16 Oct 2018 10:56:50 -0400
MIME-Version: 1.0
In-Reply-To: <20181016115817.14605-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b61ffb66-027e-ee78-6b89-f7bc7c7da7b9@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/vfio-ap: report correct error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 10/16/2018 07:58 AM, Cornelia Huck wrote:
> If ioctl(..., VFIO_DEVICE_RESET) fails, we want to report errno
> instead of ret (which is always -1 on error).
> 
> Fixes Coverity issue CID 1396176.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/vfio/ap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 3962bb74e5..65de952f44 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -142,7 +142,7 @@ static void vfio_ap_reset(DeviceState *dev)
>       ret = ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
>       if (ret) {
>           error_report("%s: failed to reset %s device: %s", __func__,
> -                     vapdev->vdev.name, strerror(ret));
> +                     vapdev->vdev.name, strerror(errno));
>       }
>   }

Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>

>   
> 
