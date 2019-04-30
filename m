Received: from eggs.gnu.org ([209.51.188.92]:44043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQa6-0004Fz-Lu
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQNp-00081c-Th
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:53:10 -0400
Date: Tue, 30 Apr 2019 12:52:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190430105256.GE5607@linux.fritz.box>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422145838.70903-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 0/9] block: buffer-based io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org

Am 22.04.2019 um 16:58 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Hi all!
> 
> We often need to do read/write with buffer, not qiov. Instead of
> creating qiov in such cases, let's introduce corresponding helpers.

Thanks, applied to the block branch.

As I wrote in patch 4, a follow-up that adds coroutine_fn markers where
we rely on being in coroutine context now would be nice.

Kevin
