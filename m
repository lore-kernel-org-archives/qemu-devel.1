Received: from eggs.gnu.org ([2001:4830:134:3::10]:55669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMECy-0008B9-BS
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:33:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMECu-0002V3-HR
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:33:00 -0500
Date: Mon, 12 Nov 2018 16:32:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181112153210.GD11580@linux.fritz.box>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101182738.70462-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] qcow2 decompress in threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, den@openvz.org

Am 01.11.2018 um 19:27 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Hi all!
> 
> The series brings threads to qcow2 decompression path, like it is
> already done for compression.

Thanks! Nice series, I like it a lot.

I fixed some non-function stuff like the coroutine_fn tags and comment
formatting and applied it to block-next (for 3.2).

Kevin
