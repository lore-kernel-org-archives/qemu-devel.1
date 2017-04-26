Received: from eggs.gnu.org ([2001:4830:134:3::10]:45729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3OnJ-0003lx-54
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3OnI-0000ik-Bk
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:23:53 -0400
Date: Wed, 26 Apr 2017 17:23:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170426152345.GO4538@noname.str.redhat.com>
References: <20170426141407.10161-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426141407.10161-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Launch qemu-nbd with -e 42
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

Am 26.04.2017 um 16:14 hat Max Reitz geschrieben:
> There is no reason for the qemu-nbd server used for tests not to accept
> an arbitrary number of clients. In fact, test 181 will require it to
> accept two clients at the same time (and thus it fails before this
> patch).
> 
> This patch updates common.rc to launch qemu-nbd with -e 42 which should
> be enough for all of our current and future tests.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Thanks, applied to block-next.

Kevin
