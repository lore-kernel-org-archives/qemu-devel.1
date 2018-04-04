Received: from eggs.gnu.org ([2001:4830:134:3::10]:52091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3krq-0008Tx-H7
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3krm-000143-IP
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:02:34 -0400
Date: Wed, 4 Apr 2018 18:02:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180404160214.GH4482@localhost.localdomain>
References: <78bd072951c71d940c8efaa5c0486342239ea996.1522857106.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78bd072951c71d940c8efaa5c0486342239ea996.1522857106.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] block/rbd: remove processed
 options from qdict
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

Am 04.04.2018 um 17:53 hat Jeff Cody geschrieben:
> Commit 4bfb274 added some QAPIfication of option parsing in
> qemu_rbd_open().  We need to remove all the options we processed,
> otherwise in bdrv_open_inherit() we will think the remaining options are
> invalid.
> 
> (This needs to go in 2.12 to avoid a regression that prevents rbd
> from being opened.)
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
