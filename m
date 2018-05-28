Received: from eggs.gnu.org ([2001:4830:134:3::10]:50477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNDjw-0007kp-De
	for qemu-devel@nongnu.org; Mon, 28 May 2018 04:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNDjv-0002my-NA
	for qemu-devel@nongnu.org; Mon, 28 May 2018 04:42:52 -0400
Date: Mon, 28 May 2018 10:42:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180528084240.GC4580@localhost.localdomain>
References: <20180525163327.23097-1-kwolf@redhat.com>
	<737e2294-6d40-04a0-3bb8-88ed85d6e224@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <737e2294-6d40-04a0-3bb8-88ed85d6e224@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/14] block: Make blockdev-create a job
 and stable API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

Am 25.05.2018 um 20:13 hat Eric Blake geschrieben:
> On 05/25/2018 11:33 AM, Kevin Wolf wrote:
> > This changes the x-blockdev-create QMP command so that it doesn't block
> > the monitor and the main loop any more, but starts a background job that
> > performs the image creation.
> > 
> > The basic job as implemented here is all that is necessary to make image
> > creation asynchronous and to provide a QMP interface that can be marked
> > stable, but it still lacks a few features that jobs usually provide: The
> > job will ignore pause commands and it doesn't publish progress yet (so
> > both current-progress and total-progress stay at 0). These features can
> > be added later without breaking compatibility.
> 
> Can we at least have total-progress start at 1, and current-progress move
> from 0 to 1 at completion?  Seeing a 0/1 => 1/1 transition is better than a
> divide-by-zero 0/0 ratio throughout the entire job; and libvirt doesn't want
> to add any more special-casing of 0/0 than it already has (where it wants to
> treat that as "job not yet started" rather than the more usual sense that if
> total==current the job is hopefully complete).

Sure, I can do that.

Kevin
