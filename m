Received: from eggs.gnu.org ([209.51.188.92]:57318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gn2Ms-0002Cb-P2
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:22:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gn2Ms-0004LX-3L
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:22:02 -0500
Date: Fri, 25 Jan 2019 15:21:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190125152154.05120461.cohuck@redhat.com>
In-Reply-To: <20190125150101.3b61f0a1@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
	<20190125135835.2d59b511.cohuck@redhat.com>
	<20190125150101.3b61f0a1@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
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

On Fri, 25 Jan 2019 15:01:01 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 25 Jan 2019 13:58:35 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:

> > - We currently do not want the user space to submit another channel
> >   program while the first one is still in flight. As submitting another
> >   one is a valid request, however, we should allow this in the future
> >   (once we have the code to handle that in place).  
> 
> I don't agree. There is at most one channel program processed by a
> subchannel at any time. I would prefer an early error code if channel
> programs are issued on top of each other (our virtual subchannel
> is channel pending or FC start function bit set or similar).

You can submit a new request if the subchannel is pending with primary,
but not with secondary state.

Regardless of that, I think it is much easier to push as much as
possible of sorting out of requests to the hardware.
