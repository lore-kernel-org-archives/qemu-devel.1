Received: from eggs.gnu.org ([2001:4830:134:3::10]:50308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxzLh-0002b3-M3
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxzLg-0002VN-LN
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:13:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-10-eblake@redhat.com>
Date: Tue, 11 Apr 2017 19:12:50 +0200
In-Reply-To: <20170405194741.18956-10-eblake@redhat.com> (Eric Blake's message
	of "Wed, 5 Apr 2017 14:47:37 -0500")
Message-ID: <87k26q50ml.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 09/13] qobject: Use simpler QDict/QList
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alexander Graf <agraf@suse.de>, Stefano Stabellini <sstabellini@kernel.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>

Eric Blake <eblake@redhat.com> writes:

> We now have macros in place to make it less verbose to add a scalar
> to QDict and QList, so use them.  To make this patch smaller to
> review, a couple of subdirectories were done in earlier patches.
>
> Patch created mechanically via:
>   spatch --sp-file scripts/coccinelle/qobject.cocci \
>     --macro-file scripts/cocci-macro-file.h --dir . --in-place
> and needed only one touch-up in monitor.c to avoid a long line.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block.c                   | 45 +++++++++++++++++++--------------------------
>  blockdev.c                | 30 +++++++++++++-----------------
>  hw/block/xen_disk.c       |  2 +-
>  hw/usb/xen-usb.c          | 12 ++++++------
>  monitor.c                 | 23 +++++++++++------------
>  qapi/qmp-event.c          |  2 +-
>  qemu-img.c                |  6 +++---
>  qemu-io.c                 |  2 +-
>  qemu-nbd.c                |  2 +-
>  qobject/qdict.c           |  2 +-
>  target/s390x/cpu_models.c |  4 ++--
>  util/qemu-option.c        |  2 +-
>  12 files changed, 60 insertions(+), 72 deletions(-)

Looks like you intent is to split the application of qobject.cocci into
block [PATCH 07], tests [PATCH 08] and rest [PATCH 09, i.e. this one].
Okay, although everything on one patch would also be okay for me.
However, this patch also contains block stuff: block.c blockdev.c
qemu-{img,io,nbd}.c.  Move to PATCH 07?
