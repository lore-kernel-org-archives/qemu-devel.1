Received: from eggs.gnu.org ([2001:4830:134:3::10]:52525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gRvn9-0005S2-5u
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gRvn5-0003v4-1K
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 04:05:55 -0500
Date: Wed, 28 Nov 2018 10:05:34 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181128100534.7350639c.cohuck@redhat.com>
In-Reply-To: <a3a73709-e354-758a-a7f0-219eafd593ab@linux.ibm.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-2-cohuck@redhat.com>
	<a3a73709-e354-758a-a7f0-219eafd593ab@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] vfio-ccw: add capabilities chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Tue, 27 Nov 2018 14:04:49 -0500
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 11/22/2018 11:54 AM, Cornelia Huck wrote:
> > diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> > index 078e46f9623d..a6f9f84526e2 100644
> > --- a/drivers/s390/cio/vfio_ccw_private.h
> > +++ b/drivers/s390/cio/vfio_ccw_private.h
> > @@ -3,9 +3,11 @@
> >    * Private stuff for vfio_ccw driver
> >    *
> >    * Copyright IBM Corp. 2017
> > + * Copyright Red Hat, Inc. 2018
> >    *
> >    * Author(s): Dong Jia Shi<bjsdjshi@linux.vnet.ibm.com>
> >    *            Xiao Feng Ren<renxiaof@linux.vnet.ibm.com>
> > + *            Cornelia Huck<cohuck@redhat.com>
> >    */
> >   
> >   #ifndef_VFIO_CCW_PRIVATE_H_
> > @@ -19,6 +21,38 @@
> >   #include "css.h"
> >   #include "vfio_ccw_cp.h"
> >   
> > +#define VFIO_CCW_OFFSET_SHIFT   40
> > +#define VFIO_CCW_OFFSET_TO_INDEX(off)	(off >> VFIO_CCW_OFFSET_SHIFT)
> > +#define VFIO_CCW_INDEX_TO_OFFSET(index)	((u64)(index) << VFIO_CCW_OFFSET_SHIFT)
> > +#define VFIO_CCW_OFFSET_MASK	(((u64)(1) << VFIO_CCW_OFFSET_SHIFT) - 1)
> > +  
> 
> Why is the offset shift 40? I know vfio-pci is also using the same 
> offset shift, but I am curious about the reasoning behind why we are 
> using this? :)
> 

My entire reasoning was "hey, vfio-pci is using this, so it should not
be bad" 8)
