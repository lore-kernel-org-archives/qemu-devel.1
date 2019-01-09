Received: from eggs.gnu.org ([209.51.188.92]:37246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghB9w-0004RY-3T
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghB9t-0003HS-VK
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:32:27 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190108170655.29766-2-vsementsov@virtuozzo.com>
References: <20190108170655.29766-1-vsementsov@virtuozzo.com>
	<20190108170655.29766-2-vsementsov@virtuozzo.com>
Date: Wed, 09 Jan 2019 11:32:17 +0100
Message-ID: <w51va2y6s0e.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/9] qcow2.h: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, den@openvz.org, pbonzini@redhat.com

On Tue 08 Jan 2019 06:06:47 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> qcow2.h depends on block_int.h. Compilation isn't broken currently only
> due to block_int.h always included before qcow2.h. Though, it seems
> better to directly include block_int.h in qcow2.h.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
