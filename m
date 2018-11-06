Received: from eggs.gnu.org ([2001:4830:134:3::10]:47139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gK29I-00028l-PR
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gK1xD-00034H-Sl
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:03:42 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181101182738.70462-8-vsementsov@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
	<20181101182738.70462-8-vsementsov@virtuozzo.com>
Date: Tue, 06 Nov 2018 15:03:15 +0100
Message-ID: <w517ehqe21o.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 7/7] qcow2: do decompression
 in threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

On Thu 01 Nov 2018 07:27:38 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> Do decompression in threads, like it is already done for compression.
> This improves asynchronous compressed reads performance.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
