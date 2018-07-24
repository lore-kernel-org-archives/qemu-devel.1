Received: from eggs.gnu.org ([2001:4830:134:3::10]:40087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fhvQ3-0002zV-79
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fhvPy-0002X3-62
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:23:55 -0400
Date: Tue, 24 Jul 2018 13:23:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180724132345.039c339e.cohuck@redhat.com>
In-Reply-To: <20180724111550.GF20399@angien.pipo.sk>
References: <20180724092413.5770-1-cohuck@redhat.com>
	<20180724111550.GF20399@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [PATCH for-3.1] s390x: remove
 's390-squash-mcss' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-s390x@nongnu.org, Xiao Feng Ren <renxiaof@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On Tue, 24 Jul 2018 13:15:50 +0200
Peter Krempa <pkrempa@redhat.com> wrote:

> On Tue, Jul 24, 2018 at 11:24:13 +0200, Cornelia Huck wrote:
> > This option has been deprecated for two releases; remove it.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  hw/s390x/3270-ccw.c                |  2 +-
> >  hw/s390x/css-bridge.c              |  1 -
> >  hw/s390x/css.c                     |  6 ++----
> >  hw/s390x/s390-ccw.c                |  2 +-
> >  hw/s390x/s390-virtio-ccw.c         | 37 ++-----------------------------------
> >  hw/s390x/virtio-ccw.c              |  2 +-
> >  include/hw/s390x/css-bridge.h      |  1 -
> >  include/hw/s390x/css.h             |  9 +++------
> >  include/hw/s390x/s390-virtio-ccw.h |  1 -
> >  qemu-deprecated.texi               |  8 --------
> >  qemu-options.hx                    | 10 ----------
> >  target/s390x/cpu.c                 | 10 ----------
> >  target/s390x/cpu.h                 |  1 -
> >  13 files changed, 10 insertions(+), 80 deletions(-)  
> 
> Looks like libvirt did not use this option at all according to my brief
> grepping, so it should be okay to remove it.

Yes, the option has never been used to my knowledge.

Thanks for checking; it seems adding libvir-list as reviewer for
qemu-deprecated.texi is working as designed :)
