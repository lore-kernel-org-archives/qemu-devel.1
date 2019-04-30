Received: from eggs.gnu.org ([209.51.188.92]:40102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLSCH-0000jO-8K
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLSCG-0003aa-Cz
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 08:49:21 -0400
Date: Tue, 30 Apr 2019 14:49:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190430124912.GI5607@linux.fritz.box>
References: <20190430123611.31203-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430123611.31203-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] block/qed: add missed coroutine_fn markers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

Am 30.04.2019 um 14:36 hat Vladimir Sementsov-Ogievskiy geschrieben:
> qed_read_table and qed_write_table use coroutine-only interfaces but
> are not marked coroutine_fn. Happily, they are called only from
> coroutine context, so we only need to add missed markers.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks for the quick follow-up! Applied to the block branch.

Kevin
