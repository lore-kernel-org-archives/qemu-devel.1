Received: from eggs.gnu.org ([2001:4830:134:3::10]:51519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d2gUg-0006fL-LR
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d2gUb-0002Iv-3N
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:05:42 -0400
Date: Mon, 24 Apr 2017 18:05:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170424160503.GI4739@noname.redhat.com>
References: <1492765915-32253-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492765915-32253-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH V2] qemu-img: simplify img_convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com

Am 21.04.2017 um 11:11 hat Peter Lieven geschrieben:
> img_convert has been around before there was an ImgConvertState or
> a block backend, but it has never been modified to directly use
> these structs. Change this by parsing parameters directly into
> the ImgConvertState and directly use BlockBackend where possible.
> Furthermore variable initialization has been reworked and sorted.
> 
> Signed-off-by: Peter Lieven <pl@kamp.de>

Thanks, updated in the block-next branch.

Kevin
