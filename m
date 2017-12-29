Received: from eggs.gnu.org ([2001:4830:134:3::10]:56295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUkdF-00089d-ST
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 21:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUkdF-0003Ta-14
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 21:42:49 -0500
Date: Fri, 29 Dec 2017 10:42:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171229024243.GE13004@lemon>
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207203036.14993-5-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 04/20] gluster: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, 12/07 14:30, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Update the gluster driver accordingly.
> 
> In want_zero mode, we continue to report fine-grained hole
> information (the caller wants as much mapping detail as possible);
> but when not in that mode, the caller prefers larger *pnum and
> merely cares about what offsets are allocated at this layer, rather
> than where the holes live.  Since holes still read as zeroes at
> this layer (rather than deferring to a backing layer), we can take
> the shortcut of skipping find_allocation(), and merely state that
> all bytes are allocated.
> 
> We can also drop redundant bounds checks that are already
> guaranteed by the block layer.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
