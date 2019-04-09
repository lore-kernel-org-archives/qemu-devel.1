Received: from eggs.gnu.org ([209.51.188.92]:59048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDqcD-0006LM-O4
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDqcC-00076s-NA
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:16:41 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1554747741-918964-4-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554747741-918964-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554747741-918964-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Date: Tue, 09 Apr 2019 15:16:34 +0200
Message-ID: <w51bm1f48ul.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 3/3] block/stream: introduce a bottom
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: stefanha@redhat.com, fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

On Mon 08 Apr 2019 08:22:21 PM CEST, Andrey Shinkevich wrote:
> The bottom node is the intermediate block device that has the base as its
> backing image. It is used instead of the base node while a block stream
> job is running to avoid dependency on the base that may change due to the
> parallel jobs. The change may take place due to a filter node as well that
> is inserted between the base and the intermediate bottom node. It occurs
> when the base node is the top one for another commit or stream job.
> After the introduction of the bottom node, don't freeze its backing child,
> that's the base, anymore.
>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
