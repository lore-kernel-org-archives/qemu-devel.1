Received: from eggs.gnu.org ([2001:4830:134:3::10]:57844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dtvAm-0006QX-EN
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dtvAj-0006cb-8M
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:29:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dtvAj-0006cK-2C
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:29:09 -0400
Date: Mon, 18 Sep 2017 14:29:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170918142902.1aa7fa4d.cohuck@redhat.com>
In-Reply-To: <cover.1505485574.git.alifm@linux.vnet.ibm.com>
References: <cover.1505485574.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Virtio GPU for S390
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, borntraeger@de.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com

On Fri, 15 Sep 2017 10:40:30 -0400
Farhan Ali <alifm@linux.vnet.ibm.com> wrote:

> These patches wire up the virtio-gpu device for CCW bus for
> S390.
> 
> For the S390 architecture which does not natively support any graphics
> device, virtio gpu in 2D mode could be used to emulate a simple graphics
> card and use VNC as the display.
> 
> eg: qemu-system-s390x ... -device virtio-gpu-ccw,devno=fe.0.0101
>     -vnc host_ip_addr:5900
> 
> Note, to actually see any display content the
> guest kernel needs to support DRM layer, Virtio GPU driver,
> the Virtual Terminal layer etc.
> 
> I would appreciate any feedback on these patches, specially the
> first patch.
> 
> ChangeLog
> --------
> v1 -> v2
>     - remove error_propagate (patch 2)
>     - Add byteswap functions (patch 1)
>     - Handle endian conversion for virtio_gpu_ctrl_response (patch 1)
> 
> v2 -> v3
>     - updated patch 1 based on Gerd's feedback
>     - rename bswap functions (patch 1)
>     - use in-place swapping functions (patch 1)
>     - Handle endian conversion for cursor update (patch 1)
> 
> Thank you
> Farhan
> 
> 
> Farhan Ali (2):
>   virtio-gpu: Handle endian conversion
>   virtio-gpu-ccw: Create a virtio gpu device for the ccw bus
> 
>  hw/display/virtio-gpu.c | 70 +++++++++++++++++++++++++++++++++++++++++++------
>  hw/s390x/virtio-ccw.c   | 49 ++++++++++++++++++++++++++++++++++
>  hw/s390x/virtio-ccw.h   | 10 +++++++
>  3 files changed, 121 insertions(+), 8 deletions(-)
> 

Thanks, applied.
