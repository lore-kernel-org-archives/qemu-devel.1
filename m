Received: from eggs.gnu.org ([2001:4830:134:3::10]:53217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gXO5i-0004cS-SS
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 05:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gXO5f-0007G5-Lj
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 05:19:38 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181211164317.32893-2-vsementsov@virtuozzo.com>
References: <20181211164317.32893-1-vsementsov@virtuozzo.com>
	<20181211164317.32893-2-vsementsov@virtuozzo.com>
Date: Thu, 13 Dec 2018 11:18:55 +0100
Message-ID: <w51zht9pw4w.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/8] qcow2.h: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berrange@redhat.com, den@openvz.org

On Tue 11 Dec 2018 05:43:10 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> qcow2.h depends on block_int.h. Compilation isn't broken currently only
> due to block_int.h always included before qcow2.h. Though, it seems
> better to directly include block_int.h in qcow2.h.

If you include block_int.h in qcow2.h then I guess there's no need to do
it again in qcow2.c

Berto
