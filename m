Received: from eggs.gnu.org ([2001:4830:134:3::10]:44031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSKe9-0008Ng-Hc
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 06:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSKdz-0003J7-KX
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 06:01:29 -0400
Date: Tue, 4 Jul 2017 12:01:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170704100101.GD4253@noname.str.redhat.com>
References: <20170704084059.6278-1-el13635@mail.ntua.gr>
	<20170704084059.6278-5-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170704084059.6278-5-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v3 4/4] block: Add default implementations
 for bdrv_co_get_block_status()
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
> bdrv_co_get_block_status_from_file() and
> bdrv_co_get_block_status_from_backing() set *file to bs->file and
> bs->backing respectively, so that bdrv_co_get_block_status() can recurse
> to them. Future block drivers won't have to duplicate code to implement
> this.
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
