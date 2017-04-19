Received: from eggs.gnu.org ([2001:4830:134:3::10]:35783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0rri-0006Lp-75
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 11:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0rrh-0003tm-9T
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 11:49:58 -0400
Date: Wed, 19 Apr 2017 17:49:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170419154949.GF5826@noname.redhat.com>
References: <20170413203401.3213-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413203401.3213-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] qemu-img/convert: Some small
 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Am 13.04.2017 um 22:33 hat Max Reitz geschrieben:
> This series fixes some small issues I found in qemu-img's convert
> subcommand while reviewing Dan's convert/dd series.
> 
> Nothing serious at all, so all for 2.10.

This series conflicts with Peter Lieven's "qemu-img: simplify
img_convert" in my block-next branch.

Patch 1 is unnecessary now (ret is still -EINVAL at this point), the
other two probably just need rebasing.

Kevin
