Received: from eggs.gnu.org ([2001:4830:134:3::10]:59281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1flUfd-0004O0-PT
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 03:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1flUfd-0004Lq-0T
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 03:38:45 -0400
Date: Fri, 3 Aug 2018 09:38:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180803073836.GC4380@localhost.localdomain>
References: <20180729212744.23709-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729212744.23709-1-lbloch@janustech.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] qcow2: Make the L2 cache cover the
 whole image by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Am 29.07.2018 um 23:27 hat Leonid Bloch geschrieben:
> This series makes the qcow2 L2 cache cover the entire image by default.
> The importance of this change is in noticeable performance improvement,
> especially with heavy random I/O. The memory overhead is very small:
> only 1 MB of cache for every 8 GB of image size. On systems with very
> limited RAM the maximal cache size can be limited by the existing
> cache-size and l2-cache-size options.
> 
> The L2 cache is also resized accordingly, by default, if the image is
> resized.

Are you going to send a new version that makes the changes we agreed on?

Kevin
