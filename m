Received: from eggs.gnu.org ([2001:4830:134:3::10]:55867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSIRT-0006k3-Fq
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSIRS-0006CP-O7
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:40:15 -0400
Date: Tue, 4 Jul 2017 15:40:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170704074004.GH10298@lemon.lan>
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170703221456.30817-8-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 07/15] qemu-img: Switch
 get_block_status() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr

On Mon, 07/03 17:14, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Continue by converting
> an internal function (no semantic change), and simplifying its
> caller accordingly.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
