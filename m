Received: from eggs.gnu.org ([2001:4830:134:3::10]:42366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f9ArG-0007rH-97
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f9ArF-0003r7-MQ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:48:22 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180411185425.2461-6-mreitz@redhat.com>
References: <20180411185425.2461-1-mreitz@redhat.com>
	<20180411185425.2461-6-mreitz@redhat.com>
Date: Thu, 19 Apr 2018 16:48:14 +0200
Message-ID: <w51o9ifckwh.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 05/13] block/mirror: Use
 source as a BdrvChild
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

On Wed 11 Apr 2018 08:54:17 PM CEST, Max Reitz wrote:
> With this, the mirror_top_bs is no longer just a technically required
> node in the BDS graph but actually represents the block job operation.
>
> Also, drop MirrorBlockJob.source, as we can reach it through
> mirror_top_bs->backing.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
