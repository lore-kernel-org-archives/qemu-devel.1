Received: from eggs.gnu.org ([2001:4830:134:3::10]:53061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSILG-0001vd-3M
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSILF-0005FO-GM
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:33:50 -0400
Date: Tue, 4 Jul 2017 15:33:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170704073330.GC10298@lemon.lan>
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170703221456.30817-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/15] block: add default
 implementations for bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

On Mon, 07/03 17:14, Eric Blake wrote:
> From: Manos Pitsidianakis <el13635@mail.ntua.gr>
> 
> bdrv_co_get_block_status_from_file() and
> bdrv_co_get_block_status_from_backing() set *file to bs->file and
> bs->backing respectively, so that bdrv_co_get_block_status() can recurse
> to them. Future block drivers won't have to duplicate code to implement
> this.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> Message-Id: <20170629184320.7151-4-el13635@mail.ntua.gr>

Reviewed-by: Fam Zheng <famz@redhat.com>
