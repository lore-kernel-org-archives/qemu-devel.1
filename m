Received: from eggs.gnu.org ([209.51.188.92]:36628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtDxM-0000JY-IK
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtDxL-0007op-TE
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 10:57:16 -0500
Date: Mon, 11 Feb 2019 16:57:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190211165704.42090ae6.cohuck@redhat.com>
In-Reply-To: <9ae9987a-f48d-9f35-9320-b9cfde6b2bad@linux.ibm.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-4-cohuck@redhat.com>
	<9ae9987a-f48d-9f35-9320-b9cfde6b2bad@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/6] vfio-ccw: protect the I/O region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Fri, 8 Feb 2019 16:26:06 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 01/30/2019 08:22 AM, Cornelia Huck wrote:
> > Introduce a mutex to disallow concurrent reads or writes to the
> > I/O region. This makes sure that the data the kernel or user
> > space see is always consistent.
> > 
> > The same mutex will be used to protect the async region as well.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> I keep wondering how the FSM could provide this, but I end up getting 
> into chicken/egg rabbit holes.

Yes, if the fsm is able to provide this, it is probably not in an
easy-to-understand way...

> So, until my brain becomes wiser...
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>

Thanks!

> 
> > ---
> >   drivers/s390/cio/vfio_ccw_drv.c     |  3 +++
> >   drivers/s390/cio/vfio_ccw_ops.c     | 28 +++++++++++++++++++---------
> >   drivers/s390/cio/vfio_ccw_private.h |  2 ++
> >   3 files changed, 24 insertions(+), 9 deletions(-)
