Received: from eggs.gnu.org ([2001:4830:134:3::10]:60367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e2Ia9-0005yL-FX
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e2Ia5-0005lV-N2
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:06:01 -0400
Date: Wed, 11 Oct 2017 16:05:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171011150545.GC8121@stefanha-x1.localdomain>
References: <20171009215533.12530-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009215533.12530-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] qcow2: Fix preallocated truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Mon, Oct 09, 2017 at 11:55:30PM +0200, Max Reitz wrote:
> There are (at least...) two bugs in preallocated truncation, which this
> series fixes.
> 
> Both would have been apparent if the the related iotest had used the
> default cluster size in addition to 512 byte clusters, but alas, it did
> not.  This is remedied by patch 3 of this series.
> 
> 
> Max Reitz (3):
>   qcow2: Fix unaligned preallocated truncation
>   qcow2: Always execute preallocate() in a coroutine
>   iotests: Add cluster_size=64k to 125
> 
>  block/qcow2.c              |  42 +++-
>  tests/qemu-iotests/125     |   7 +-
>  tests/qemu-iotests/125.out | 480 ++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 472 insertions(+), 57 deletions(-)
> 
> -- 
> 2.13.6
> 

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
