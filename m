Received: from eggs.gnu.org ([2001:4830:134:3::10]:47569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHWLB-0002a8-Iy
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:49:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHWL7-0006r5-MM
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:49:29 -0500
Date: Wed, 22 Nov 2017 15:49:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171122154919.35f5e413.cohuck@redhat.com>
In-Reply-To: <0154a676-649c-ac64-a139-41aa26aa6097@redhat.com>
References: <20171122142627.73170-1-borntraeger@de.ibm.com>
	<20171122142627.73170-2-borntraeger@de.ibm.com>
	<0154a676-649c-ac64-a139-41aa26aa6097@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/migration: use zero flag
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On Wed, 22 Nov 2017 15:37:55 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 22.11.2017 15:26, Christian Borntraeger wrote:
> > valgrind pointed out that we call KVM_S390_GET_IRQ_STATE with an
> > undefined value for flags. Right now this is unused, but we
> > better play safe.
> > The same is true for SET_IRQ_STATE. While QEMU is now fixed in
> > that regard, we should make sure to not use the flag and pad
> > fields in the kernel. A corresponding kernel documentation patch
> > will be submitted later.
> > 
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> >  target/s390x/kvm.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)

(...)

> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> IMHO that would still be fine for 2.11, too.

I can queue this if another fix comes along, but I'd not push it on its
own.
