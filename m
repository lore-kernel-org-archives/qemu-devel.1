Received: from eggs.gnu.org ([2001:4830:134:3::10]:48080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dulKW-0004nv-MY
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dulKV-0005MS-MP
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:10:44 -0400
References: <20170920114310.13080-1-el13635@mail.ntua.gr>
	<20170920114310.13080-3-el13635@mail.ntua.gr>
From: John Snow <jsnow@redhat.com>
Message-ID: <e96c930f-4693-f76d-b5b5-8fe6e3f59455@redhat.com>
Date: Wed, 20 Sep 2017 16:10:36 -0400
MIME-Version: 1.0
In-Reply-To: <20170920114310.13080-3-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] block/block-backend.c: remove
 blk_pread_unthrottled()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>



On 09/20/2017 07:43 AM, Manos Pitsidianakis wrote:
> blk_pread_unthrottled was used to bypass I/O throttling on the BlockBackend in
> the case of async I/O. This is not needed anymore and we can just call
> blk_pread() directly.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  include/sysemu/block-backend.h |  2 --
>  block/block-backend.c          | 16 ----------------
>  hw/block/hd-geometry.c         |  7 +------
>  3 files changed, 1 insertion(+), 24 deletions(-)
> 


Acked-by: John Snow <jsnow@redhat.com>
