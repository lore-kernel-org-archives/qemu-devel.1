Received: from eggs.gnu.org ([2001:4830:134:3::10]:49683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceN1n-00075y-Ju
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceN1m-00052j-Mh
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:27:23 -0500
Date: Thu, 16 Feb 2017 15:27:13 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170216142713.GH4869@noname.redhat.com>
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-22-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487153430-17260-22-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v15 21/25] qcow2-bitmap: refcounts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

Am 15.02.2017 um 11:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Calculate refcounts for qcow2 bitmaps. It is needed for qcow2's qemu-img
> check implementation.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

Maybe this should come earlier in the series so that qemu-img check
doesn't corrupt them. Basically it's needed as soon as we add the
autoclear flag as supported.

Anyway, the actual point I was going to make is that it would be good to
have a qemu-iotests case which actually invokes qemu-img check on an
image with dirty bitmaps. In general, the test case side of the series
seems to be rather weak so far. Just keep in mind that I won't feel bad
for breaking anything that isn't tested by a test case. So if you like
to keep persistent bitmaps working in the long run, you'd better write
tests and give me no chance to break anything without them failing.

Kevin
