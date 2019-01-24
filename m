Received: from eggs.gnu.org ([209.51.188.92]:35382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmc8L-00035S-L5
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmbuG-0006IH-AG
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:06:44 -0500
Date: Thu, 24 Jan 2019 11:06:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190124110637.2e2e3c4c.cohuck@redhat.com>
In-Reply-To: <20190123165148.55aba88b@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-6-cohuck@redhat.com>
	<20190123165148.55aba88b@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] vfio-ccw: add handling for async
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

On Wed, 23 Jan 2019 16:51:48 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 21 Jan 2019 12:03:54 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > Add a region to the vfio-ccw device that can be used to submit
> > asynchronous I/O instructions. ssch continues to be handled by the
> > existing I/O region; the new region handles hsch and csch.
> > 
> > Interrupt status continues to be reported through the same channels
> > as for ssch.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> I had a look, and I don't have any new concerns.(New like not raised
> before.)

So, what was raised before that I did not address?
