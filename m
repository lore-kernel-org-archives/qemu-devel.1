Received: from eggs.gnu.org ([2001:4830:134:3::10]:54287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f9V0j-0008JM-Lf
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f9V0f-0002qH-Sc
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:19:29 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180416165849.28864-7-mreitz@redhat.com>
References: <20180416165849.28864-1-mreitz@redhat.com>
	<20180416165849.28864-7-mreitz@redhat.com>
Date: Fri, 20 Apr 2018 14:19:17 +0200
Message-ID: <w51o9ievzne.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 6/9] block: Support
 BDRV_REQ_WRITE_UNCHANGED in filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Mon 16 Apr 2018 06:58:46 PM CEST, Max Reitz wrote:
> Update the rest of the filter drivers to support
> BDRV_REQ_WRITE_UNCHANGED.  They already forward write request flags to
> their children, so we just have to announce support for it.
>
> This patch does not cover the replication driver because that currently
> does not support flags at all, and because it just grabs the WRITE
> permission for its children when it can, so we should be fine just
> submitting the incoming WRITE_UNCHANGED requests as normal writes.
>
> It also does not cover format drivers for similar reasons.  They all use
> bdrv_format_default_perms() as their .bdrv_child_perm() implementation
> so they just always grab the WRITE permission for their file children
> whenever possible.  In addition, it often would be difficult to
> ascertain whether incoming unchanging writes end up as unchanging writes
> in their files.  So we just leave them as normal potentially changing
> writes.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
