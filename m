Received: from eggs.gnu.org ([2001:4830:134:3::10]:52060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNGBh-0001Po-4T
	for qemu-devel@nongnu.org; Mon, 28 May 2018 07:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNGBf-0003KW-G5
	for qemu-devel@nongnu.org; Mon, 28 May 2018 07:19:41 -0400
Date: Mon, 28 May 2018 13:19:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180528111930.GG4580@localhost.localdomain>
References: <20180425183223.580566-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425183223.580566-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/8] block: more byte-based cleanups:
 vectored I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 25.04.2018 um 20:32 hat Eric Blake geschrieben:
> Based-on: <20180424192506.149089-1-eblake@redhat.com>
> ([PATCH v2 0/6] block: byte-based AIO read/write)
> Based-on: <20180424220157.177385-1-eblake@redhat.com>
> ([PATCH] block: Merge .bdrv_co_writev{, _flags} in drivers)
> 
> My quest continues.  I spent some time pruning qcow down as far
> as possible (and was dismayed at how long it took to prove no
> iotests regressions); so for the other drivers, I did the bare
> minimum to get rid of an interface, but will leave it to those
> file owners if they want to get rid of further pointless sector
> manipulations in their files.
> 
> Next on the chopping block: bdrv_read/bdrv_write.

Nice series, looks good apart from a few minor comments on the qcow1
conversion.

For v2, can you please make sure to have proper CCs also on the cover
letter?

Kevin
