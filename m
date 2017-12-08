Received: from eggs.gnu.org ([2001:4830:134:3::10]:50043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eNLZ4-0007v1-N6
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eNLZ3-00081q-VD
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:31:54 -0500
Date: Fri, 8 Dec 2017 17:31:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171208163142.GG4217@localhost.localdomain>
References: <20171206105309.3468-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171206105309.3468-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] block: Fix BlockDriver callbacks in
 bdrv_drain_all_begin()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

Am 06.12.2017 um 11:53 hat Kevin Wolf geschrieben:
> I was looking into the drain functions in order to develop them a bit in
> the direction that Fam suggested, to unify the code between bdrv_drain()
> and bdrv_drain_all() a bit more, and maybe to find a place to take
> coroutine locks for graph changes.
> 
> The first thing I found is a bug in bdrv_drain_all(), so I'm already
> sending this part before I have made much progress with my actual plan.
> 
> v2:
> - Added patches 5 and 6 [Paolo]
> - Fixed commit message of patch 1 [Eric]

Applied to block-next.

Kevin
