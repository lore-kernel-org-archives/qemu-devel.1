Received: from eggs.gnu.org ([2001:4830:134:3::10]:52440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1deiSo-0007XB-JE
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1deiSj-0007UL-Sk
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:52:58 -0400
Date: Mon, 7 Aug 2017 15:52:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170807135238.GD6578@localhost.localdomain>
References: <20170807123658.28772-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170807123658.28772-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10] quorum: Set
 sectors-count to 0 when reporting a flush error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org

Am 07.08.2017 um 14:36 hat Alberto Garcia geschrieben:
> The QUORUM_REPORT_BAD event has fields to report the sector in which
> the error was detected and the number of affected sectors starting
> from that one. This is important for read and write errors, but not
> for flush errors.
> 
> For flush errors the current code reports the total size of the disk
> image. That is however not useful information in this case. Moreover,
> the bdrv_getlength() call can fail, and there's no good way of
> handling that failure.
> 
> Since we're reporting useless information and we cannot even guarantee
> to do it in a consistent way, this patch changes the code to report 0
> instead in all cases.
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin
