Received: from eggs.gnu.org ([2001:4830:134:3::10]:40966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1et80L-0003j5-VL
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1et80H-0001AS-1j
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:31:25 -0500
Date: Tue, 6 Mar 2018 09:30:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180306093059.110b568f.cohuck@redhat.com>
In-Reply-To: <14338610-c556-9e3d-ab4e-fc7658217c76@de.ibm.com>
References: <20180305174914.25931-1-nia.alarie@gmail.com>
	<14338610-c556-9e3d-ab4e-fc7658217c76@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/sclpconsole: Remove dead code -
 delete error handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Nia Alarie <nia.alarie@gmail.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au

On Tue, 6 Mar 2018 09:13:33 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 03/05/2018 06:49 PM, Nia Alarie wrote:
> > The other event handlers (quiesce and cpu) do not define these
> > handlers, and this one does nothing, so it can be removed.
> > 
> > virtio_ccw_exit always returns 0, so change its return type to
> > void.
> > 
> > Signed-off-by: Nia Alarie <nia.alarie@gmail.com>  
> 
> 
> I would like to have 2 patches to make the subject non-misleading.
> 
> patch1: sclp/event
> patch2: virtio-ccw

Yes, please. sclp/event and virtio-ccw are two different code paths.

Also, looking at the virtio-ccw part: Rather than modifying exit
handlers, the code should be converted to unrealize instead.

> 
> With that
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> > ---
> >  hw/char/sclpconsole-lm.c          |  6 ------
> >  hw/char/sclpconsole.c             |  6 ------
> >  hw/s390x/event-facility.c         | 14 --------------
> >  hw/s390x/virtio-ccw.c             |  6 +++---
> >  hw/s390x/virtio-ccw.h             |  2 +-
> >  include/hw/s390x/event-facility.h |  1 -
> >  6 files changed, 4 insertions(+), 31 deletions(-)

I'd be happy to merge the sclp part for 2.12 if I get the patch
Thursday morning CET latest.

I'd be happy to merge an unrealize conversion for virtio-ccw as well,
but I'm not sure how much work that is (although it looks manageable).
