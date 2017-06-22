Received: from eggs.gnu.org ([2001:4830:134:3::10]:56082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dO5Rk-0003jg-2s
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dO5Rj-0007nz-AB
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:59:08 -0400
Date: Thu, 22 Jun 2017 18:58:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170622165854.GC4353@noname.redhat.com>
References: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497634636-20230-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/31] qed: Convert to coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

Am 16.06.2017 um 19:36 hat Kevin Wolf geschrieben:
> The qed block driver is one of the last remaining block drivers that use the
> AIO callback style interfaces. This series converts it to the coroutine model
> that other drivers are using and removes some AIO functions from the block
> layer API afterwards.
> 
> If this isn't compelling enough, the diffstat should speak for itself.
> 
> This series is relatively long, but it consists mostly of mechanical
> conversions of one function per patch, so it should be easy to review.
> 
> v2:
> - Add coroutine_fn markers [Stefan, Paolo]
> - Use bdrv_co_*() instead of bdrv_*() in coroutine_fns
> - Use ACB on stack in qed_co_request [Paolo]
> - Updated some comments [Paolo]
> - Unplug earlier in qed_clear_need_check() [Stefan]
> - Removed now unused trace events [Stefan]
> - Improved commit message of patch creating qed_aio_write_cow() [Eric]

Applied to the block branch.

Kevin
