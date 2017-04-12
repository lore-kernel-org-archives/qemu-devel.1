Received: from eggs.gnu.org ([2001:4830:134:3::10]:46915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyHyh-0008SH-Um
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyHyd-0005Jj-0x
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:06:31 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170411185034.13460-6-eblake@redhat.com>
References: <20170411185034.13460-1-eblake@redhat.com>
	<20170411185034.13460-6-eblake@redhat.com>
Date: Wed, 12 Apr 2017 15:06:23 +0200
Message-ID: <w51a87lkc6o.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 05/13] qobject: Drop useless QObject
 casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Weil <sw@weilnetz.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, "open list:Block layer core" <qemu-block@nongnu.org>

On Tue 11 Apr 2017 08:50:26 PM CEST, Eric Blake wrote:
> We have macros in place to make it less verbose to add a subtype
> of QObject to both QDict and QList. While we have made cleanups
> like this in the past (see commit fcfcd8ffc, for example), having
> it be automated by Coccinelle makes it easier to maintain.
>
> Patch created mechanically via:
>   spatch --sp-file scripts/coccinelle/qobject.cocci \
>     --macro-file scripts/cocci-macro-file.h --dir . --in-place
> then I verified that no manual touchups were required.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
