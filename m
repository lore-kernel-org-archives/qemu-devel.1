Received: from eggs.gnu.org ([2001:4830:134:3::10]:36090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fFxDF-0006TZ-O4
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fFxDA-00027N-Sg
	for qemu-devel@nongnu.org; Tue, 08 May 2018 03:39:05 -0400
Date: Tue, 8 May 2018 09:38:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180508093844.02ee43f5.cohuck@redhat.com>
In-Reply-To: <2eead61e-420f-643c-363c-151f5a066268@de.ibm.com>
References: <20180507155130.21085-1-cohuck@redhat.com>
	<20180507155130.21085-3-cohuck@redhat.com>
	<2eead61e-420f-643c-363c-151f5a066268@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 2/2] s390x/ccw: make sure all
 ccw devices are properly reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On Tue, 8 May 2018 09:17:08 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> ACK.
> 
> cc stable?

Probably. We'd also need patch 1 for that.

> 
> 
> 
> On 05/07/2018 05:51 PM, Cornelia Huck wrote:
> > Thomas reported that the subchannel for a  3270 device that ended up
> > in a broken state (status pending even though not enabled) did not
> > get out of that state even after a reboot (which involves a subsytem
> > reset). The reason for this is that the 3270 device did not define
> > a reset handler.
> > 
> > Let's fix this by introducing a base reset handler (set up for all
> > ccw devices) that resets the subchannel and have virtio-ccw call
> > its virtio-specific reset procedure in addition to that.
> > 
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  hw/s390x/ccw-device.c | 8 ++++++++
> >  hw/s390x/virtio-ccw.c | 9 ++++++---
> >  hw/s390x/virtio-ccw.h | 1 +
> >  3 files changed, 15 insertions(+), 3 deletions(-)
