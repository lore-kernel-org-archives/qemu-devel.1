Received: from eggs.gnu.org ([2001:4830:134:3::10]:42351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSKaY-0004b1-Hh
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSKaX-0001ld-Pa
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:57:46 -0400
Date: Tue, 4 Jul 2017 11:57:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170704095735.GC4253@noname.str.redhat.com>
References: <20170704084059.6278-1-el13635@mail.ntua.gr>
	<20170704084059.6278-4-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170704084059.6278-4-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v3 3/4] block: Remove bdrv_truncate
 callback in blkdebug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-block <qemu-block@nongnu.org>

Am 04.07.2017 um 10:40 hat Manos Pitsidianakis geschrieben:
> Now that bdrv_truncate is passed to bs->file by default, remove the
> callback from block/blkdebug.c
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

We'll need to set .is_filter = true for blkdebug now. I haven't yet
looked into the existing implications that this has, but intuitively
this should be okay.

When you do so, please explain in the commit message the implications
that this has.

Kevin
