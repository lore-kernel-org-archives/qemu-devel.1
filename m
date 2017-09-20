Received: from eggs.gnu.org ([2001:4830:134:3::10]:55914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dufl4-00029p-QQ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dufky-0004et-So
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:13:46 -0400
Date: Wed, 20 Sep 2017 12:33:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170920103341.GC4730@localhost.localdomain>
References: <20170915101008.16646-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170915101008.16646-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] block: Fix permissions after ro/rw
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Am 15.09.2017 um 12:10 hat Kevin Wolf geschrieben:
> bdrv_reopen() can switch nodes between read-only and read-write modes.
> This has implications for the required permissions on their child nodes.
> For example, a qcow2 node requests write permissions on bs->file only if
> it is writable itself.
> 
> This means that during bdrv_reopen(), the permissions need to be
> recalculated in order to prevent failures where the bs->file
> permissions don't match its actual read-only state (e.g. bs->file is a
> read-write node, but the permission still enforces read-only access).

Applied to the block branch.

Kevin
