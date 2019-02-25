Received: from eggs.gnu.org ([209.51.188.92]:46064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyESB-0001sb-PG
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 06:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyES9-0003ci-0D
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 06:29:45 -0500
Date: Mon, 25 Feb 2019 12:29:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190225112937.GB6320@linux.fritz.box>
References: <20190223192041.289782-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223192041.289782-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] block: fix graph modification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, den@virtuozzo.com

Am 23.02.2019 um 20:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Hi all.
> 
> I've found two problems during my developing of backup-top filter.
> The first one was already discussed in context of backup-top series,
> so, here is patch 01 taken from it, previously it was
> 03 of [PATCH v5 00/11] backup-top filter driver for backup
> (https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg06218.html)
> so, here it is marked v6, and it was changed a lot:
>  v6: rewrite using GHashTable and GQueue for efficient BFS.
> 
> 02 is a new fix of bug I've found today, and 03 is a test for both
> fixed bugs.

Thanks, applied to the block branch.

Kevin
