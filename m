Received: from eggs.gnu.org ([2001:4830:134:3::10]:58043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cfqqi-0004Ik-Ry
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:30:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cfqqh-0004QU-SQ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:30:04 -0500
Date: Mon, 20 Feb 2017 17:29:19 +0100
From: Alberto Garcia <berto@igalia.com>
Message-ID: <20170220162919.GA21263@igalia.com>
References: <20170220153012.GK21255@stefanha-x1.localdomain>
	<20170220154554.GF4814@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170220154554.GF4814@noname.redhat.com>
Subject: Re: [Qemu-devel] blockdev-add I/O throttling parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Mon, Feb 20, 2017 at 04:45:54PM +0100, Kevin Wolf wrote:
> > I can imagine two solutions that do not need these parameters in
> > blockdev-add:
> > 
> > 1. I/O throttling is implemented by a BlockDriver.  Users are expected
> >    to create the BDS themselves.  This is a little awkward since
> >    query-block *does* include the throttling parameters in its output
> >    and we must preserve this behavior for existing users.
> > 
> > 2. block_set_io_throttle must be used after blockdev-add.  Suboptimal
> >    because issuing two commands is not atomic (use transaction?).
> 
> The existing I/O throttling code is working on BlockBackends, but
> blockdev-add creates BlockDriverStates. So it can't possibly add
> throttling parameters.
> 
> The currently recommended solution block_set_io_throttle. The
> other option to control BB level thorttling would be to add qdev
> properties to the block devices.
> 
> In the long term, I think going with 1. and moving throttling to the
> block node level is the much nicer (and more flexible) option.

Yeah I agree with Kevin.

Berto
