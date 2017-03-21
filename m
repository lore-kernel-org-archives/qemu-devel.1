Received: from eggs.gnu.org ([2001:4830:134:3::10]:52504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cqOp5-0003V7-0k
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cqOp2-0001Co-FI
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:47:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cqOp2-0001CU-8j
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:47:56 -0400
Date: Tue, 21 Mar 2017 12:47:54 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170321124754.3f278901@t450s.home>
In-Reply-To: <20170317031743.40128-4-bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
	<20170317031743.40128-4-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 03/16] vfio: ccw: define device_api
 strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Fri, 17 Mar 2017 04:17:30 +0100
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Define vfio-ccw device API strings. CCW vendor driver using mediated
> device framework should use this string for device_api attribute.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  include/uapi/linux/vfio.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 519eff3..6183789 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -212,6 +212,7 @@ struct vfio_device_info {
>  #define VFIO_DEVICE_API_PCI_STRING		"vfio-pci"
>  #define VFIO_DEVICE_API_PLATFORM_STRING		"vfio-platform"
>  #define VFIO_DEVICE_API_AMBA_STRING		"vfio-amba"
> +#define VFIO_DEVICE_API_CCW_STRING		"vfio-ccw"
>  
>  /**
>   * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,


Acked-by: Alex Williamson <alex.williamson@redhat.com>
