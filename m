Received: from eggs.gnu.org ([2001:4830:134:3::10]:38077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dv1ux-0001FK-8s
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dv1uw-0000kF-Kn
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:53:27 -0400
Date: Thu, 21 Sep 2017 15:53:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170921135314.GD4677@localhost.localdomain>
References: <20170915101008.16646-1-kwolf@redhat.com>
	<20170915101008.16646-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170915101008.16646-2-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-io: Reset qemuio_blk permissions
 before each command
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
> qemu-io provides a 'reopen' command that allows switching from writable
> to read-only access. We need to make sure that we don't try to keep
> write permissions to a BlockBackend that becomes read-only, otherwise
> things are going to fail.
> 
> command() already makes sure to request any additional permissions that
> a qemu-io command requires, so just resetting the permissions to values
> that are safe for read-only images is enough to fix this.
> 
> As a side effect, this makes the output of qemu-iotests case 187 more
> consistent.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

This seems to break qemu-iotests 077 and 081 for raw. I'll look into
it tomorrow.

Kevin
