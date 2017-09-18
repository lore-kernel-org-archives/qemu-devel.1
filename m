Received: from eggs.gnu.org ([2001:4830:134:3::10]:38417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dtsw0-00082u-8F
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dtsvw-00076U-IJ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:05:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dtsvw-00075m-2h
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:05:44 -0400
Date: Mon, 18 Sep 2017 12:05:36 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170918120536.6186c7fe.cohuck@redhat.com>
In-Reply-To: <6c53f939cf2d64b66d2a6878b29c9bf3820f3d5b.1505485574.git.alifm@linux.vnet.ibm.com>
References: <cover.1505485574.git.alifm@linux.vnet.ibm.com>
	<6c53f939cf2d64b66d2a6878b29c9bf3820f3d5b.1505485574.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] virtio-gpu-ccw: Create a virtio gpu
 device for the ccw bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com

On Fri, 15 Sep 2017 10:40:32 -0400
Farhan Ali <alifm@linux.vnet.ibm.com> wrote:

> Wire up the virtio-gpu device for the CCW bus. The virtio-gpu
> is a virtio-1 device, so disable revision 0.
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/virtio-ccw.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/virtio-ccw.h | 10 ++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index b1976fd..12cacf6 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c

> @@ -1815,6 +1863,7 @@ static void virtio_ccw_register(void)
>      type_register_static(&vhost_vsock_ccw_info);
>  #endif
>      type_register_static(&virtio_ccw_crypto);
> +    type_register_static(&virtio_ccw_gpu);

Not a critique of this patch, just an observation: For virtio-ccw, we
tend to collect the various virtio devices all in the same file. For
virtio-pci, they sometimes get separate files. Not sure which is
better, but it means that sometimes only the virtio-pci version is
added...

>  }
>  
>  type_init(virtio_ccw_register)

The patch looks good to me.

Gerd, if the first patch looks good to you, I can take both patches
through the s390 tree. If you prefer to merge the patches yourself,
that's fine with me as well.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
