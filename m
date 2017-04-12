Received: from eggs.gnu.org ([2001:4830:134:3::10]:36516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyC9H-0001sj-Bl
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 02:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyC9G-0006ut-JV
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 02:53:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170411185034.13460-1-eblake@redhat.com>
	<20170411185034.13460-8-eblake@redhat.com>
Date: Wed, 12 Apr 2017 08:52:48 +0200
In-Reply-To: <20170411185034.13460-8-eblake@redhat.com> (Eric Blake's message
	of "Tue, 11 Apr 2017 13:50:28 -0500")
Message-ID: <87inmaw20v.fsf@dusky.pond.sub.org>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:blkdebug" <qemu-block@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, Stefan Weil <sw@weilnetz.de>, Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Eric Blake <eblake@redhat.com> writes:

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

I don't like this split.  Splitting out *subsystems* may ease review,
but this splits out directory block/, which is only a part of the block
subsystem.  Explaining this takes you more than three dozen words.  I'd
prefer either the whole block subsystem (as defined in MAINTAINERS)
split out, or no split.

I'm willing to accept the split as is anyway if block maintainers are
okay with it.

I'm also willing to squash the three parts on commit.

> Signed-off-by: Eric Blake <eblake@redhat.com>
> Acked-by: Richard W.M. Jones <rjones@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
