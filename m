Received: from eggs.gnu.org ([2001:4830:134:3::10]:40300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ekATO-0006WS-6l
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:20:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ekATL-0005Jz-0W
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:20:22 -0500
Date: Fri, 9 Feb 2018 16:19:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180209151955.GJ3998@localhost.localdomain>
References: <20180209113744.11842-1-berto@igalia.com>
	<66ffb17c-6238-db0e-5a50-16d83ee12482@redhat.com>
	<20180209150331.GG3998@localhost.localdomain>
	<w516076dwpr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w516076dwpr.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Check the L1 table parameters from
 all internal snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 09.02.2018 um 16:11 hat Alberto Garcia geschrieben:
> On Fri 09 Feb 2018 04:03:31 PM CET, Kevin Wolf wrote:
> > How about we move the check to bdrv_open() as proposed, but make it
> > conditional so that it's skipped with BDRV_O_CHECK and then add a way
> > to fix the situation with qemu-img check -r?
> 
> That was one of the alternatives that I was considering, but you can't
> really fix a broken L1 table pointer, can you?
> 
> What you can probably do is allow deleting the snapshot, but 'qemu-img
> snapshot' doesn't use BDRV_O_CHECK. We'd have to change that, look for a
> new flag or think of some other alternative.
> 
> Or, perhaps more easily, make 'qemu-img check' delete all corrupted
> snapshots.

Yes, the latter is what I was thinking of. Of course, that would require
a new -r option because it would be a destructive operation.

Maybe it would even be worth making such destructive operations
interactive so that the user has to explicitly confirm each snapshot
that we delete. Not sure though.

Kevin
