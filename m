Received: from eggs.gnu.org ([2001:4830:134:3::10]:40467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3f7d-00069N-LP
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3f7c-0005Zn-KT
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:54:29 -0400
Date: Wed, 4 Apr 2018 11:54:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180404095421.GD4482@localhost.localdomain>
References: <20180403163400.6307-1-kwolf@redhat.com>
	<20180403163400.6307-2-kwolf@redhat.com>
	<20180403210343.GD30186@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403210343.GD30186@localhost.localdomain>
Subject: Re: [Qemu-devel] [PULL 1/9] gluster: Fix blockdev-add with
 server.N.type=unix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org

Am 03.04.2018 um 23:03 hat Jeff Cody geschrieben:
> On Tue, Apr 03, 2018 at 06:33:52PM +0200, Kevin Wolf wrote:
> > The legacy command line interface gets the socket path from an option
> > called 'socket'. QAPI in contract uses SocketAddress, where the
> > corresponding option is called 'path'.
> > 
> > Fix the gluster block driver to accept both 'socket' and 'path', with
> > 'path' being the preferred syntax.
> > 
> > https://bugzilla.redhat.com/show_bug.cgi?id=1545155
> > 
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Oops, you and I had a pull request collision on this patch (it is in both of
> our PRs); Sorry, my fault, I didn't know you were pulling it in through your
> tree.

Or my fault for applying a patch to something that is maintained by you.
Anyway, I think git should sort it out without a problem.

Kevin
