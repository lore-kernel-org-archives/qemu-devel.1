Received: from eggs.gnu.org ([2001:4830:134:3::10]:44823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6518dd5c5=roger.pau@citrix.com>)
	id 1fDBE7-0000Zn-1E
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6518dd5c5=roger.pau@citrix.com>)
	id 1fDBE1-0002rk-RV
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:00:30 -0400
Date: Mon, 30 Apr 2018 16:12:04 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Message-ID: <20180430151145.iyou5pisaclvvn3v@MacBook-Pro-de-Roger.local>
References: <1525089699-13411-1-git-send-email-paul.durrant@citrix.com>
	<1525089699-13411-3-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1525089699-13411-3-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 2/4] block/xen_disk: remove use
 of grant map/unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Max Reitz <mreitz@redhat.com>

On Mon, Apr 30, 2018 at 01:01:37PM +0100, Paul Durrant wrote:
> The grant copy operation was added to libxengnttab in Xen 4.8.0. If grant
> copy is available then data from the guest will be copied rather than
> mapped.
> The xen_disk source can be significantly simplified by removing this now
> redundant code.

Hm, I know this is a PITA, but FreeBSD gntdev hasn't implemented the
grant-copy operation yet.

I could try to implement it, but I can't make any promises on the time
ATM, since I'm quite busy.

Thanks, Roger.
