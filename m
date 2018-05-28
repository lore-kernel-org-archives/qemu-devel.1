Received: from eggs.gnu.org ([2001:4830:134:3::10]:49739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNG1W-0006yU-8Q
	for qemu-devel@nongnu.org; Mon, 28 May 2018 07:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNG1V-00051v-EP
	for qemu-devel@nongnu.org; Mon, 28 May 2018 07:09:10 -0400
Date: Mon, 28 May 2018 13:09:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180528110902.GF4580@localhost.localdomain>
References: <20180425183223.580566-1-eblake@redhat.com>
	<20180425183223.580566-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425183223.580566-5-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/8] qcow: Switch qcow_co_writev to
 byte-based calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:qcow" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Am 25.04.2018 um 20:32 hat Eric Blake geschrieben:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Make the change for the internals of the qcow
> driver write function, by iterating over offset/bytes instead of
> sector_num/nb_sectors, and repurposing index_in_cluster and n
> to be bytes instead of sectors.
> 
> A later patch will then switch the qcow driver as a whole over
> to byte-based operation.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

The same comments from patch 3 apply here.

Kevin
