Received: from eggs.gnu.org ([2001:4830:134:3::10]:51433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEeuR-000883-0t
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEeuQ-0001XL-9Z
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:17:30 -0500
Date: Wed, 7 Dec 2016 17:17:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161207161722.GH4773@noname.str.redhat.com>
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161202192223.15153-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/5] blkdebug: Sanity check block layer
 guarantees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org

Am 02.12.2016 um 20:22 hat Eric Blake geschrieben:
> Commits 04ed95f4 and 1a62d0ac updated the block layer to auto-fragment
> any I/O to fit within device boundaries. Additionally, when using a
> minimum alignment of 4k, we want to ensure the block layer does proper
> read-modify-write rather than requesting I/O on a slice of a sector.
> Let's enforce that the contract is obeyed when using blkdebug.  For
> now, blkdebug only allows alignment overrides, and just inherits other
> limits from whatever device it is wrapping, but a future patch will
> further enhance things.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
