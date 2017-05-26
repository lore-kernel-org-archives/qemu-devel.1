Received: from eggs.gnu.org ([2001:4830:134:3::10]:57711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dECJQ-0000lO-Of
	for qemu-devel@nongnu.org; Fri, 26 May 2017 06:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dECJP-0006oX-Ur
	for qemu-devel@nongnu.org; Fri, 26 May 2017 06:17:40 -0400
Date: Fri, 26 May 2017 12:17:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170526101727.GF7211@noname.str.redhat.com>
References: <cover.1495536228.git.berto@igalia.com>
	<142326a3-eaa4-8333-9580-ae0063f8a876@redhat.com>
	<w51shjutjz7.fsf@maestria.local.igalia.com>
	<0e3fc298-d47b-4066-c8c8-02f620c50b89@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e3fc298-d47b-4066-c8c8-02f620c50b89@virtuozzo.com>
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
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>

Am 24.05.2017 um 18:09 hat Anton Nefedov geschrieben:
> I agree; as mentioned we have similar patches and they don't conflict much.
> We noticed a performance regression on HDD though, for the
> presumably optimized case (random 4k write over a large backed
> image); so the patches were put on hold.

You're talking about your own patches that should do the same thing,
right? Can you re-do the same test with Berto's patches? Maybe there was
just an implementation glitch in yours.

This approach should very obviously result in a performance improvement,
and the patches are relatively simple, so I'm very much inclined to
merge this as soon as possible.

Kevin
