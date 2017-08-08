Received: from eggs.gnu.org ([2001:4830:134:3::10]:34944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dezwU-0004f4-LW
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dezwT-00027F-Jt
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:32:46 -0400
Date: Tue, 8 Aug 2017 10:32:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170808083238.GD4850@dhcp-200-186.str.redhat.com>
References: <20170807203007.19033-1-eblake@redhat.com>
	<20170807203007.19033-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170807203007.19033-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] qcow2: Drop debugging dump_refcounts()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 07.08.2017 um 22:30 hat Eric Blake geschrieben:
> It's been #if 0'd since its introduction in 2006, commit 585f8587.
> We can revive dead code if we need it, but in the meantime, it has
> bit-rotted (for example, not checking for failure in bdrv_getlength()).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
