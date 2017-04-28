Received: from eggs.gnu.org ([2001:4830:134:3::10]:37754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d41Lb-0002gi-Dl
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d41La-0003Wh-8M
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:33:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170427215821.19397-1-eblake@redhat.com>
	<20170427215821.19397-7-eblake@redhat.com>
Date: Fri, 28 Apr 2017 10:33:36 +0200
In-Reply-To: <20170427215821.19397-7-eblake@redhat.com> (Eric Blake's message
	of "Thu, 27 Apr 2017 16:58:17 -0500")
Message-ID: <87a871nd7j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 06/10] qobject: Use simpler QDict/QList
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alexander Graf <agraf@suse.de>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, Stefan Weil <sw@weilnetz.de>, Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <f4bug@amsat.org>

Eric Blake <eblake@redhat.com> writes:

> We now have macros in place to make it less verbose to add a scalar
> to QDict and QList, so use them.  To make this patch smaller to
> review, a couple of subdirectories were done in earlier patches.

Scratch the last sentence.  Can do on commit.

> Patch created mechanically via:
>   spatch --sp-file scripts/coccinelle/qobject.cocci \
>     --macro-file scripts/cocci-macro-file.h --dir . --in-place
> then touched up manually to fix a couple of '?:' back to original
> spacing, as well as avoiding a long line in monitor.c.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> ---
> v5: rebase to master (Coccinelle found a couple new spots), squash 3
> patches into 1, adjust R-b to only list Markus (while there were other
> reviews on the pre-squashed patches, Markus was the only one on all 3)

The block: part had

    Acked-by: Richard W.M. Jones <rjones@redhat.com>
    Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
    Reviewed-by: Alberto Garcia <berto@igalia.com>

The tests and qobject parts had

    Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Richard, Stefan, Alberto, Philippe, let me know if you'd like me to
convert your R-by of parts to an Acked-by of the combined patch.  Feel
free to review the combined patch, of course.

> v4: no change
> v3: new patch
