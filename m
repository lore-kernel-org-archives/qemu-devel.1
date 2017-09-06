Received: from eggs.gnu.org ([2001:4830:134:3::10]:57170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpZqm-0005gI-B4
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpZqg-0006uA-Da
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:54:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpZqg-0006tr-7E
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:54:30 -0400
Date: Wed, 6 Sep 2017 14:54:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170906145426.4ad1f358.cohuck@redhat.com>
In-Reply-To: <b5948d5c-cc42-5a76-061d-d65eb7b6bc7c@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-4-pasic@linux.vnet.ibm.com>
	<20170906144221.76132052.cohuck@redhat.com>
	<b5948d5c-cc42-5a76-061d-d65eb7b6bc7c@linux.vnet.ibm.com>
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

On Wed, 6 Sep 2017 14:49:52 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/06/2017 02:42 PM, Cornelia Huck wrote:
> > On Tue,  5 Sep 2017 13:16:43 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> >> @@ -488,7 +446,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
> >>          } else {
> >>              virtio_bus_get_vdev_config(&dev->bus, vdev->config);
> >>              /* XXX config space endianness */  
> > 
> > Unrelated: That should be fine, I guess?
> >   
> >> -            cpu_physical_memory_write(ccw.cda, vdev->config, len);
> >> +            /* TODO we may have made -EINVAL out of -EFAULT */  
> > 
> > Eek.
> >   
> 
> Actually I wanted to send a patch which gets rid of the -EFAULT case
> in sch_handle_start_func_virtual.
> 
> IMHO a program check is more appropriate here. We did the EFAULT if
> cpu_physical_memory_map failed, but we don't have that any more.

OK, such a patch would make this easier to figure out.
