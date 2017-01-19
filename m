Received: from eggs.gnu.org ([2001:4830:134:3::10]:39611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cU8yd-0006J3-FX
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cU8yZ-0008LB-MS
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:25:51 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-3-eblake@redhat.com>
Date: Thu, 19 Jan 2017 10:25:39 +0100
In-Reply-To: <20170118161653.19296-3-eblake@redhat.com> (Eric Blake's message
	of "Wed, 18 Jan 2017 10:16:49 -0600")
Message-ID: <87lgu7flkc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qdict: Add convenience helpers for
 wrapped puts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>, Anthony Perard <anthony.perard@citrix.com>, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Chrysostomos Nanakos <chris@include.gr>, Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:X86" <xen-devel@lists.xensource.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> Quite a few users of qdict_put() were manually wrapping a
> non-QObject. We can make such call-sites shorter, by providing
> common macros to do the tedious work.  Also shorten nearby
> qdict_put_obj(,,QOBJECT()) sequences.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
>
> ---
>
> v2: rebase to current master
>
> I'm okay if you want me to break this patch into smaller pieces.

I guess I'm okay with a single piece, but I'd like to know how you did
the conversion.  Coccinelle?  Manually?
