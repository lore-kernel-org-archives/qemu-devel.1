Received: from eggs.gnu.org ([2001:4830:134:3::10]:37042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIeCK-0004bZ-Kh
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIeCJ-0005I9-SK
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:52:44 -0400
Date: Wed, 7 Jun 2017 18:52:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170607165236.GF8144@noname.redhat.com>
References: <d5b487b58c2c6b3e68de0e858b84877434f05c76.1496843678.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5b487b58c2c6b3e68de0e858b84877434f05c76.1496843678.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: fix external snapshot abort
 permission error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 07.06.2017 um 15:55 hat Jeff Cody geschrieben:
> In external_snapshot_abort(), we try to undo what was done in
> external_snapshot_prepare() calling bdrv_replace_node() to swap the
> nodes back.  However, we receive a permissions error as writers are
> blocked on the old node, which is now the new node backing file.
> 
> An easy fix (initially suggested by Kevin Wolf) is to call
> bdrv_set_backing_hd() on the new node, to set the backing node to NULL.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>

Thanks, applied to the block branch.

Kevin
