Received: from eggs.gnu.org ([2001:4830:134:3::10]:48119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYnsw-0008Pu-7V
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYnsv-0002sc-FO
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:32:02 -0400
Date: Fri, 29 Jun 2018 09:31:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180629073154.GC4555@localhost.localdomain>
References: <20180621171925.28925-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621171925.28925-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: Implement co versions of
 discard/flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

Am 21.06.2018 um 19:19 hat Kevin Wolf geschrieben:
> This simplifies file-posix by implementing the coroutine variants of
> the discard and flush BlockDriver callbacks. These were the last
> remaining users of paio_submit(), which can be removed now.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Applied to the block branch.

Kevin
