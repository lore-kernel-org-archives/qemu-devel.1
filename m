Received: from eggs.gnu.org ([2001:4830:134:3::10]:53307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cwEkt-0007lF-MZ
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 17:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cwEkr-0004dR-Mo
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 17:15:47 -0400
Date: Thu, 6 Apr 2017 22:15:38 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170406211537.GR30620@redhat.com>
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
	<1488314205-16264-44-git-send-email-kwolf@redhat.com>
	<20170406205939.GA28584@redhat.com>
	<a010df05-e986-2142-3196-31f549558511@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a010df05-e986-2142-3196-31f549558511@redhat.com>
Subject: Re: [Qemu-devel] [PULL 43/46] block: Assertions for write
 permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, Apr 06, 2017 at 04:03:28PM -0500, Eric Blake wrote:
> On 04/06/2017 03:59 PM, Richard W.M. Jones wrote:
> > On Tue, Feb 28, 2017 at 09:36:42PM +0100, Kevin Wolf wrote:
> >> This adds assertions that ensure that the necessary write permissions
> >> have been granted before someone attempts to write to a node.
> >>
> >> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >> Acked-by: Fam Zheng <famz@redhat.com>
> >> Reviewed-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  block/io.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/block/io.c b/block/io.c
> >> index 2592ca1..4c79745 100644
> >> --- a/block/io.c
> >> +++ b/block/io.c
> >> @@ -945,6 +945,8 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
> >>      size_t skip_bytes;
> >>      int ret;
> >>  
> >> +    assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE));
> > 
> > 
> > This assertion is thrown in the libguestfs test suite.  I filed a bug
> > about it against the Fedora package:
> > 
> > https://lists.gnu.org/archive/html/qemu-block/2017-02/msg01305.html
> 
> Wrong URL?

Ooops, the right link is:

https://bugzilla.redhat.com/show_bug.cgi?id=1439922

There is also a minimal reproducer in comment 2.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
