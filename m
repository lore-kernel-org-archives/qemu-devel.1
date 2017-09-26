Received: from eggs.gnu.org ([2001:4830:134:3::10]:34038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwkm8-0000SV-BU
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 03:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwkm7-0000jP-Hq
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 03:59:28 -0400
Date: Tue, 26 Sep 2017 09:59:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170926075916.GA3399@localhost.localdomain>
References: <20170925122808.14561-1-kwolf@redhat.com>
	<b384fd86-52e4-8468-f0d7-f9ab8c4a9e01@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b384fd86-52e4-8468-f0d7-f9ab8c4a9e01@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/5] commit: Support multiple
 roots above top node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

Am 25.09.2017 um 22:02 hat John Snow geschrieben:
> On 09/25/2017 08:28 AM, Kevin Wolf wrote:
> > This is a step towards making the commit job flexible enough that it can
> > work with any kind of block graph. Currently, it requires that not only
> > the top and base node of the commit operation are specified, but also
> > the active layer of the backing file chain. Of course, the assumption
> > that a single active layer exists is invalid.
> > 
> > This series makes the commit job consider other roots as well so that
> > all parent nodes of the top node get their backing file updated and stay
> > valid after the commit job completes.
> > 
> > With this, we should have all of the prerequisites for a follow-up
> > series that adds a new and clean blockdev-commit QMP command which
> > doesn't require an option for the active layer and which accepts node
> > names instead of file names for base and top.
> > 
> > Kevin Wolf (5):
> >   block: Introduce BdrvChildRole.update_filename
> >   commit: Support multiple roots above top node
> >   qemu-iotests: Allow QMP pretty printing in common.qemu
> >   qemu-iotests: Test commit block job where top has two parents
> >   commit: Remove overlay_bs
> 
> Does this depend on another series?

It is based on my block branch. I think specifically the series "block:
Fix permissions after ro/rw reopen" might be needed for the patches to
work correctly.

Kevin
