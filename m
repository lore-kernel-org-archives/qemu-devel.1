Received: from eggs.gnu.org ([2001:4830:134:3::10]:42740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT4F1-0007xI-SZ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT4F1-00087R-1Y
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:42:35 -0400
Date: Thu, 6 Jul 2017 12:42:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170706104224.GC5975@noname.redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-9-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705210842.960-9-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 08/21] mirror: Switch MirrorBlockJob to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 05.07.2017 um 23:08 hat Eric Blake geschrieben:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Continue by converting an
> internal structure (no semantic change), and all references to the
> buffer size.
> 
> Add an assertion that our use of s->granularity >> BDRV_SECTOR_BITS
> (necessary for interaction with sector-based dirty bitmaps, until
> a later patch converts those to be byte-based) does not suffer from
> truncation problems.
> 
> [checkpatch has a false positive on use of MIN() in this patch]
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
