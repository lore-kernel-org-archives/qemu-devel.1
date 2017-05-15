Received: from eggs.gnu.org ([2001:4830:134:3::10]:34479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dAMdI-0000pM-RX
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dAMdH-000307-OH
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:30:20 -0400
Date: Mon, 15 May 2017 21:30:05 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170515203004.GD16511@redhat.com>
References: <20170510143205.32013-1-pbonzini@redhat.com>
	<20170510155700.GY16511@redhat.com>
	<0c3040de-aabb-ae8c-7689-a6012f8c72e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c3040de-aabb-ae8c-7689-a6012f8c72e5@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/7] curl: locking
 cleanups/fixes, coroutine conversion, remove aio_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org

On Mon, May 15, 2017 at 09:12:54PM +0200, Max Reitz wrote:
> On 2017-05-10 17:57, Richard W.M. Jones wrote:
> > On Wed, May 10, 2017 at 04:31:58PM +0200, Paolo Bonzini wrote:
> >> Since the last patch in v1 didn't work, I bit the bullet and converted
> >> the whole thing to coroutines (patches 4-6).  This in turns allows a more
> >> elegant solution to wait for CURLStates to get free (patch 7).
> >>
> >> I tested this by lowering CURL_NUM_STATES to 2.  With this change, the
> >> buggy case triggers a couple times while booting a Fedora netinst image.
> > 
> > This series fixes the original bug, so:
> > 
> >   Tested-by: Richard W.M. Jones <rjones@redhat.com>
> > 
> > I think the Reported-by in patch 3 should credit Kun Wei for finding
> > the bug, and we should probably mention the BZ too:
> > 
> >   Reported-by: Kun Wei <kuwei@redhat.com>
> >   Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1447590
> 
> This one is older, though:
> https://bugzilla.redhat.com/show_bug.cgi?id=1437393

Fair enough, it does seem to be the same issue.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
