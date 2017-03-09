Received: from eggs.gnu.org ([2001:4830:134:3::10]:43091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cm0AA-0003bC-Uq
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:39:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cm0AA-000661-1E
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:39:35 -0500
Date: Thu, 9 Mar 2017 16:39:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170309153923.GB4910@noname.redhat.com>
References: <20170308213429.29244-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308213429.29244-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/3] Fix bdrv_is_allocated usage
 bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 08.03.2017 um 22:34 hat Eric Blake geschrieben:
> bdrv_is_allocated() returns tri-state, not just bool, although
> there were several callers using it as a bool.  Fix them to
> either propagate the error or to document why treatment of
> failure like allocation is okay.
> 
> [Found during a larger effort to convert bdrv_get_block_status
> to be byte-based for 2.10]

Thanks, applied to the block branch.

Kevin
