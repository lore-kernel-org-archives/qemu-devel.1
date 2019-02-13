Received: from eggs.gnu.org ([209.51.188.92]:41427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtxND-00023X-67
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:26:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtxN7-00045j-DF
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:26:55 -0500
Date: Wed, 13 Feb 2019 17:26:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190213172627.3b0a1ef0.cohuck@redhat.com>
In-Reply-To: <e36f47f0-04af-2677-184f-1bd8d8056076@linux.ibm.com>
References: <20190212112323.15904-1-david@redhat.com>
	<e36f47f0-04af-2677-184f-1bd8d8056076@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x: add zPCI feature to "qemu" CPU
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On Wed, 13 Feb 2019 10:54:23 -0500
Farhan Ali <alifm@linux.ibm.com> wrote:

> I noticed the qemu-iotests 200 was failing due to the commit
> "703fef6fcf3 : s390x/pci: Warn when adding PCI devices without the 
> 'zpci' feature".
> 
> This patch fixes the failure :).

Huh. So it was testing without pci before and now with and it's also
working? Awesome :)

> 
> Thanks
> Farhan
> 
> On 02/12/2019 06:23 AM, David Hildenbrand wrote:
> > As we now always have PCI support, let's add it to the "qemu" CPU model,
> > taking care of backwards compatibility.
> > 
> > Signed-off-by: David Hildenbrand<david@redhat.com>
> > ---
> > 
> > v1 -> v2:
> > - Use correct model identifiction of the z12 we emulate
> > 
> >   hw/s390x/s390-virtio-ccw.c  | 3 +++
> >   target/s390x/gen-features.c | 8 ++++++--
> >   2 files changed, 9 insertions(+), 2 deletions(-)  
> 
