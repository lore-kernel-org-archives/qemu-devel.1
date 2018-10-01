Received: from eggs.gnu.org ([2001:4830:134:3::10]:53231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71Y5-0005xv-Ce
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71Y4-00067B-OV
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:59:57 -0400
Date: Mon, 1 Oct 2018 18:59:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181001165945.GD4445@localhost.localdomain>
References: <20180929095454.32066-1-lbloch@janustech.com>
	<dd15dbb9-6aaa-ab5a-9105-8cf49e76cc27@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd15dbb9-6aaa-ab5a-9105-8cf49e76cc27@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix cache-clean-interval
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

Am 01.10.2018 um 16:35 hat Eric Blake geschrieben:
> On 9/29/18 4:54 AM, Leonid Bloch wrote:
> > Fixing cache-clean-interval documentation following the recent change to
> > a default of 600 seconds on supported plarforms (only Linux currently).
> > 
> > Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> > ---
> >   docs/qcow2-cache.txt | 19 +++++++++----------
> >   qapi/block-core.json |  3 ++-
> >   qemu-options.hx      |  3 ++-
> >   3 files changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
> > index 59358b816f..1778312e09 100644
> > --- a/docs/qcow2-cache.txt
> > +++ b/docs/qcow2-cache.txt
> > @@ -202,18 +202,17 @@ Reducing the memory usage
> >   It is possible to clean unused cache entries in order to reduce the
> >   memory usage during periods of low I/O activity.
> > -The parameter "cache-clean-interval" defines an interval (in seconds).
> > -All cache entries that haven't been accessed during that interval are
> > -removed from memory.
> > +The parameter "cache-clean-interval" defines an interval (in seconds),
> > +affer which all the cache entries that haven't been accessed during it
> 
> s/affer/after/
> 
> Maybe s/during it/during the interval/

Thanks, made these fixes and applied it to the block branch.

Kevin
