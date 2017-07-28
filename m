Received: from eggs.gnu.org ([2001:4830:134:3::10]:56348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db6ot-0001DT-5P
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db6os-0007xI-FC
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 11:04:51 -0400
Date: Fri, 28 Jul 2017 17:04:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170728150427.GF3983@localhost.localdomain>
References: <20170713153028.31065-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170713153028.31065-1-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v6 0/4] block: Block driver callbacks fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 13.07.2017 um 17:30 hat Manos Pitsidianakis geschrieben:
> This series makes implementing some of the bdrv_* callbacks easier for block
> filters by passing requests to bs->file if bs->drv doesn't implement it instead
> of failing, and adding default bdrv_co_get_block_status() implementations.
> 
> This is based against commit ced1484322 of 
> https://github.com/XanClic/qemu.git block branch

Thanks, applied to the block-next branch for 2.11.

Kevin
