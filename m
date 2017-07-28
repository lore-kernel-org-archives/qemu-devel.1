Received: from eggs.gnu.org ([2001:4830:134:3::10]:35845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db7qm-0001Xe-GR
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1db7ql-0005KA-Nv
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:10:52 -0400
Date: Fri, 28 Jul 2017 18:10:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170728161038.GG3983@localhost.localdomain>
References: <20170714143548.32559-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170714143548.32559-1-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] fix leaks in bdrv_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 14.07.2017 um 16:35 hat Manos Pitsidianakis geschrieben:
> v3:
>  new commit: block: fix dangling bs->explicit_options in block.c
>  rework error paths in bdrv_open_driver()
> v2:
>  move bdrv_unref_child(bs, bs->file) to bdrv_open_driver
>  do not set bs->drv to NULL if open succeeds

Thanks, applied to the block branch.

Kevin
