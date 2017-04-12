Received: from eggs.gnu.org ([2001:4830:134:3::10]:48323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyI1h-00023k-N0
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyI1c-0006LE-PK
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:09:37 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170411185034.13460-8-eblake@redhat.com>
References: <20170411185034.13460-1-eblake@redhat.com>
	<20170411185034.13460-8-eblake@redhat.com>
Date: Wed, 12 Apr 2017 15:09:30 +0200
Message-ID: <w517f2pkc1h.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 07/13] block: Use simpler QDict/QList
 scalar insertion macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Josh Durgin <jdurgin@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, "open list:blkdebug" <qemu-block@nongnu.org>

On Tue 11 Apr 2017 08:50:28 PM CEST, Eric Blake wrote:
> We now have macros in place to make it less verbose to add a scalar
> to QDict and QList, so use them.
>
> Patch created mechanically via:
>   spatch --sp-file scripts/coccinelle/qobject.cocci \
>     --macro-file scripts/cocci-macro-file.h --dir block --in-place
> then touched up manually to fix a couple of '?:' back to original spacing.
>
> For ease of review, the mechanical work was split by tree location:
> this only touches files under block/; there are other block-related
> files (like top-level block.c) that will be fixed in a later global
> cleanup.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Acked-by: Richard W.M. Jones <rjones@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
