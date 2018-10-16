Received: from eggs.gnu.org ([2001:4830:134:3::10]:60897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCPPY-0005aM-5m
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCPPO-0005DA-DP
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:29:18 -0400
References: <20181016115817.14605-1-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <390decd2-bcaa-15fd-7600-f7621622247f@redhat.com>
Date: Tue, 16 Oct 2018 15:29:07 +0200
MIME-Version: 1.0
In-Reply-To: <20181016115817.14605-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x/vfio-ap: report correct
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 2018-10-16 13:58, Cornelia Huck wrote:
> If ioctl(..., VFIO_DEVICE_RESET) fails, we want to report errno
> instead of ret (which is always -1 on error).
> 
> Fixes Coverity issue CID 1396176.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
