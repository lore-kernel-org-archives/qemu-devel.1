Received: from eggs.gnu.org ([2001:4830:134:3::10]:45936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dufHw-00004s-MY
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dufHv-0005Lf-U2
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:43:40 -0400
Date: Wed, 20 Sep 2017 14:24:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170920122421.GD4730@localhost.localdomain>
References: <20170920114310.13080-1-el13635@mail.ntua.gr>
	<20170920114310.13080-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170920114310.13080-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 1/2] block/block-backend.c: add
 blk_check_byte_request call to blk_pread/blk_pwrite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Am 20.09.2017 um 13:43 hat Manos Pitsidianakis geschrieben:
> blk_check_byte_request() is called from the blk_co_pwritev/blk_co_preadv to
> check if the request offset and request bytes parameters are valid for the
> given Blockbackend. Let's do that in blk_pread/blk_pwrite too.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

I don't think this is necessary, blk_pread/pwrite() are only wrappers
around blk_co_preadv/pwritev(), so we're already checking the
parameters.

Kevin
