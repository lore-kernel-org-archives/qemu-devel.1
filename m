Received: from eggs.gnu.org ([2001:4830:134:3::10]:57558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dDZ18-0002fd-9l
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dDZ15-0006is-29
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:20:10 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <0e3fc298-d47b-4066-c8c8-02f620c50b89@virtuozzo.com>
References: <cover.1495536228.git.berto@igalia.com>
	<142326a3-eaa4-8333-9580-ae0063f8a876@redhat.com>
	<w51shjutjz7.fsf@maestria.local.igalia.com>
	<0e3fc298-d47b-4066-c8c8-02f620c50b89@virtuozzo.com>
Date: Wed, 24 May 2017 18:20:00 +0200
Message-ID: <w51poeytefj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/7] qcow2: Reduce the number of I/O ops
 when doing COW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>

On Wed 24 May 2017 06:09:42 PM CEST, Anton Nefedov wrote:

> I agree; as mentioned we have similar patches and they don't conflict
> much.  We noticed a performance regression on HDD though, for the
> presumably optimized case (random 4k write over a large backed image);
> so the patches were put on hold.

Interesting, I think that scenario was noticeably faster in my
tests. What cluster size(s) and image size(s) were you using?

Berto
