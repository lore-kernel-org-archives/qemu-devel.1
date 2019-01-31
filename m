Received: from eggs.gnu.org ([209.51.188.92]:33280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpAuy-0003c8-Iw
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpAux-0001NH-Sp
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:54:04 -0500
Date: Thu, 31 Jan 2019 12:53:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190131125356.3c227899.cohuck@redhat.com>
In-Reply-To: <20190130180931.4fd4b6a9@oc2783563651>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-7-cohuck@redhat.com>
	<20190130180931.4fd4b6a9@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/6] vfio-ccw: add handling for async
 channel instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Wed, 30 Jan 2019 18:09:31 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 30 Jan 2019 14:22:12 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > +static void fsm_async_retry(struct vfio_ccw_private *private,
> > +			    enum vfio_ccw_event event)
> > +{
> > +	private->cmd_region->ret_code = -EAGAIN;
> > +}
> > +  
> 
> This is essentially dead code at the moment, isn't it? I mean we hold the
> io_mutex whenever we are in state VFIO_CCW_STATE_CP_PROCESSING, and we
> call vfio_ccw_fsm_event() with the very same mutex held.

Well, I did have to put something in the state machine...
