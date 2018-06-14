Received: from eggs.gnu.org ([2001:4830:134:3::10]:42413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTS7k-0006ES-5q
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTS7f-0002PY-28
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:17:11 -0400
Date: Thu, 14 Jun 2018 15:16:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180614131652.GF8564@localhost.localdomain>
References: <20180608192027.284601-1-vsementsov@virtuozzo.com>
	<20180608192027.284601-4-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608192027.284601-4-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qcow2: add compress threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@gmail.com, pl@kamp.de, den@openvz.org

Am 08.06.2018 um 21:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Do data compression in separate threads. This significantly improve
> performance for qemu-img convert with -W (allow async writes) and -c
> (compressed) options.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Looks correct to me, but why do we introduce a separate
MAX_COMPRESS_THREADS? Can't we simply leave the maximum number of
threads to the thread poll?

I see that you chose a much smaller number here (4 vs. 64), but is there
actually a good reason for this?

Kevin
