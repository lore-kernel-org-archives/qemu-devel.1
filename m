Received: from eggs.gnu.org ([2001:4830:134:3::10]:35972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dJIMX-0004mf-57
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dJIMW-0008Hl-BJ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:45:57 -0400
Date: Fri, 9 Jun 2017 13:45:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170609114547.GB4462@noname.redhat.com>
References: <1496437930-12654-1-git-send-email-kwolf@redhat.com>
	<1496437930-12654-2-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496437930-12654-2-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] commit: Fix use after free in
 completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

Am 02.06.2017 um 23:12 hat Kevin Wolf geschrieben:
> The final bdrv_set_backing_hd() could be working on already freed nodes
> because the commit job drops its references (through BlockBackends) to
> both overlay_bs and top already a bit earlier.
> 
> One way to trigger the bug is hot unplugging a disk for which
> blockdev_mark_auto_del() cancels the block job.
> 
> Fix this by taking BDS-level references while we're still using the
> nodes.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Cc: qemu-stable@nongnu.org
