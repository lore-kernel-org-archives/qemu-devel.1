Received: from eggs.gnu.org ([2001:4830:134:3::10]:39474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etTZn-0005pU-Ry
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etTZk-0006q2-Ii
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:33:27 -0500
Date: Wed, 7 Mar 2018 08:33:11 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180307083311.14b08fec.cohuck@redhat.com>
In-Reply-To: <CA+k8WDoM246LNv70Gu+Fjtit=OOdLqiSi83xO_DeRssFKJZxOg@mail.gmail.com>
References: <20180306100721.19419-1-nia.alarie@gmail.com>
	<20180306100721.19419-2-nia.alarie@gmail.com>
	<20180306154013.251f13e9.cohuck@redhat.com>
	<CA+k8WDoM246LNv70Gu+Fjtit=OOdLqiSi83xO_DeRssFKJZxOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] s390x: Change return type of
 virtio_ccw_exit to void.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: nee <nia.alarie@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>

On Tue, 6 Mar 2018 23:40:18 +0000
nee <nia.alarie@gmail.com> wrote:

> On Tue, Mar 6, 2018 at 2:40 PM, Cornelia Huck <cohuck@redhat.com> wrote:
> > On Tue,  6 Mar 2018 10:07:21 +0000
> > Nia Alarie <nia.alarie@gmail.com> wrote:
> >  
> >> Allows a branch to be removed - this function always returns 0.
> >>
> >> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
> >> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  hw/s390x/virtio-ccw.c | 6 +++---
> >>  hw/s390x/virtio-ccw.h | 2 +-
> >>  2 files changed, 4 insertions(+), 4 deletions(-)  
> >
> > While your patch is not wrong, I'd prefer to skip changing the exit
> > functions and convert virtio-ccw to unrealize instead.
> >
> > Should not be too hard; do you want to take a stab at it?  
> 
> Is there any difference in semantics between exit and unrealize aside
> from the arguments and return type?

In our case, it should be a simple transformation to the new functions.
