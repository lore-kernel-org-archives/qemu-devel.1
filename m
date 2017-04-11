Received: from eggs.gnu.org ([2001:4830:134:3::10]:57462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxxG9-00046Q-Vs
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxxG9-0002bX-9P
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:59:10 -0400
Date: Tue, 11 Apr 2017 16:58:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170411145849.GO4516@noname.str.redhat.com>
References: <20170411145050.31290-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411145050.31290-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9?] block/io: Comment out permission
 assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Am 11.04.2017 um 16:50 hat Max Reitz geschrieben:
> In case of block migration, there may be writes to BlockBackends that do
> not have the write permission taken. Before this issue is fixed (which
> is not going to happen in 2.9), we therefore cannot assert that this is
> the case.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

I tested block migration (migrate -b). Leaving postcopy migration, which
is apparently also broken, to Laurent.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Kevin Wolf <kwolf@redhat.com>
