Received: from eggs.gnu.org ([2001:4830:134:3::10]:56918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fpD05-00044Q-KP
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 09:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fpD02-0001nA-H3
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 09:35:13 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180813132754.16744-1-kwolf@redhat.com>
References: <20180813132754.16744-1-kwolf@redhat.com>
Date: Mon, 13 Aug 2018 15:34:58 +0200
Message-ID: <w51sh3i75kt.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/qapi: Fix memory leak
 in qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Mon 13 Aug 2018 03:27:54 PM CEST, Kevin Wolf wrote:
> For BlockBackends that are skipped in query-blockstats, we would leak
> info since commit 567dcb31. Allocate info only later to avoid the memory
> leak.
>
> Fixes: CID 1394727
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
