Received: from eggs.gnu.org ([2001:4830:134:3::10]:60290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dDPDp-0000lY-HC
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dDPDm-0007NZ-F8
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:52:37 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170523174420.8903-1-eblake@redhat.com>
Date: Wed, 24 May 2017 07:52:29 +0200
In-Reply-To: <20170523174420.8903-1-eblake@redhat.com> (Eric Blake's message
	of "Tue, 23 May 2017 12:44:20 -0500")
Message-ID: <87k256u7he.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] qapi: Fix some QMP documentation
 regressions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, marcandre.lureau@redhat.com

Eric Blake <eblake@redhat.com> writes:

> In the process of getting rid of docs/qmp-commands.txt, we managed
> to regress on some of the text that changed after the point where
> the move was first branched and when the move actually occurred.
> For example, commit 3282eca for blockdev-snapshot re-added the
> extra "options" layer which had been cleaned up in commit 0153d2f.
>
> This clears up all regressions identified over the range
> 02b351d..bd6092e:
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05127.html
> as well as a cleanup to x-blockdev-remove-medium to prefer
> 'id' over 'device' (matching the cleanup for 'eject').
>
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

> ---
> v2: add 'eject', 'x-blockdev-remove-medium' cleanups, thanks to
> Markus' audit.
>
> Can go in either via trivial or via qapi tree

I'll put it in my next pull unless -trivial picks it up first.
