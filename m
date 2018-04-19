Received: from eggs.gnu.org ([2001:4830:134:3::10]:54719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f99f4-0006bc-RR
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f99ez-0001vB-AQ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:31:42 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180411185425.2461-2-mreitz@redhat.com>
References: <20180411185425.2461-1-mreitz@redhat.com>
	<20180411185425.2461-2-mreitz@redhat.com>
Date: Thu, 19 Apr 2018 15:31:18 +0200
Message-ID: <w51r2nbcogp.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 01/13] block/mirror: Pull
 out mirror_perform()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Wed 11 Apr 2018 08:54:13 PM CEST, Max Reitz wrote:
> When converting mirror's I/O to coroutines, we are going to need a point
> where these coroutines are created.  mirror_perform() is going to be
> that point.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Jeff Cody <jcody@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
