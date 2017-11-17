Received: from eggs.gnu.org ([2001:4830:134:3::10]:60761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFfno-0003XN-HR
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFfnn-0001U9-No
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:31:24 -0500
Date: Fri, 17 Nov 2017 13:30:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171117123059.GB4795@localhost.localdomain>
References: <20171023092945.54532-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023092945.54532-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] block/snapshot: dirty all dirty bitmaps on
 snapshot-switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com

Am 23.10.2017 um 11:29 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Snapshot-switch actually changes active state of disk so it should
> reflect on dirty bitmaps. Otherwise next incremental backup using
> these bitmaps will be invalid.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We discussed this quite a while ago, and I'm still not convinced that
this approach makes sense.

Can you give just one example of a use case where dirtying the whole
bitmap while loading a snapshot is the desired behaviour?

I think the most useful behaviour would be something where the bitmaps
themselves are snapshotted, too. But for the time being, the easiest and
safest solution might just be to error out in any snapshot operations
if any bitmaps are in use.

Kevin
