Received: from eggs.gnu.org ([2001:4830:134:3::10]:59194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAatO-00025y-3x
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAatN-0008SU-84
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:43:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170515195439.17677-1-eblake@redhat.com>
Date: Tue, 16 May 2017 13:43:43 +0200
In-Reply-To: <20170515195439.17677-1-eblake@redhat.com> (Eric Blake's message
	of "Mon, 15 May 2017 14:54:39 -0500")
Message-ID: <87d1b9kowg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] block: Use QDict helpers for --force-share
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, famz@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> Fam's addition of --force-share in commits 459571f7 and 335e9937
> were developed prior to the addition of QDict scalar insertion
> macros, but merged after the general cleanup in commit 46f5ac20.
> Patch created mechanically by rerunning:
>
>  spatch --sp-file scripts/coccinelle/qobject.cocci \
>         --macro-file scripts/cocci-macro-file.h --dir . --in-place
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
> This could go in through Markus' qapi tree (since he took the
> original cleanup), a block maintainer (since it only touches block
> files), or even the trivial patch queue (since it's so small and
> mechanical) - I don't care which, as long as we don't drop it!

Applied to qapi-next, thanks!
