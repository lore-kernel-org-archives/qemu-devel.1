Received: from eggs.gnu.org ([209.51.188.92]:42720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghF2w-0006XW-1G
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghF2v-0000Xv-C9
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:41:30 -0500
Date: Wed, 9 Jan 2019 15:41:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190109144123.GD4867@localhost.localdomain>
References: <20181221184226.28881-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221184226.28881-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Make 234 stable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 21.12.2018 um 19:42 hat Max Reitz geschrieben:
> This test waits for a MIGRATION event with status=completed on the
> source VM before querying the migration status on both source and
> destination.  However, just because the source says migration has
> completed does not mean the destination thinks the same.  Therefore, in
> some cases, the destination VM may still report "active" instead of
> "completed" when asked for its migration status.
> 
> Fix this by enabling migration events on both VMs and waiting until both
> source and destination emit a status=completed MIGRATION event.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Thanks, applied to the block branch.

Kevin
