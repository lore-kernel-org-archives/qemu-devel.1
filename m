Received: from eggs.gnu.org ([2001:4830:134:3::10]:38816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK5nh-0007zJ-HZ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK5c9-00029w-CL
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:58:13 -0500
Date: Tue, 6 Nov 2018 18:57:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181106175720.GI4758@linux.fritz.box>
References: <20181015160633.63130-1-vsementsov@virtuozzo.com>
	<20181015160633.63130-4-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015160633.63130-4-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v4 03/11] block: allow serialized reads to
 intersect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, stefanha@redhat.com, jcody@redhat.com, mreitz@redhat.com, den@openvz.org, eblake@redhat.com

Am 15.10.2018 um 18:06 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Otherwise, if we have serialized read-part in copy_range from backing
> file to its parent if CoW take place, this CoW's sub-reads will
> intersect with firstly created serialized read request.
> 
> Anyway, reads should not influence on disk view, let's allow them to
> intersect.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

What about reads that internally trigger writes, such as copy-on-read?

Kevin
