Received: from eggs.gnu.org ([2001:4830:134:3::10]:33872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds4Rb-00083M-41
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds4RX-0006PL-8T
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:58:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ds4RX-0006Oq-1u
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:58:51 -0400
Date: Wed, 13 Sep 2017 11:58:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913115847.57eab4d7.cohuck@redhat.com>
In-Reply-To: <cf982df3-546f-69a7-0beb-2f83e1daaee8@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-4-pasic@linux.vnet.ibm.com>
	<20170906144221.76132052.cohuck@redhat.com>
	<cf982df3-546f-69a7-0beb-2f83e1daaee8@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] virtio-ccw: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Mon, 11 Sep 2017 20:14:59 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/06/2017 02:42 PM, Cornelia Huck wrote:
> >> @@ -488,7 +446,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
> >>          } else {
> >>              virtio_bus_get_vdev_config(&dev->bus, vdev->config);
> >>              /* XXX config space endianness */  
> > Unrelated: That should be fine, I guess?
> >   
> 
> Would be pretty bad if it weren't. It's the responsibility of the
> virtio device to give us the right endianness. We don't know the layout
> so we could not fix it even if we had to. I guess this comment should be
> removed.

Yes, please do so.
