Received: from eggs.gnu.org ([2001:4830:134:3::10]:49785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYbip-0003zf-LK
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYbio-0003HS-Bu
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:00:31 -0500
Date: Mon, 8 Jan 2018 19:00:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180108180015.GJ8052@localhost.localdomain>
References: <20171221142251.18366-1-kwolf@redhat.com>
	<20171221142251.18366-10-kwolf@redhat.com>
	<w51lgh88ik0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51lgh88ik0.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 09/19] block: Nested
 drain_end must still call callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Am 08.01.2018 um 16:41 hat Alberto Garcia geschrieben:
> On Thu 21 Dec 2017 03:22:41 PM CET, Kevin Wolf wrote:
> > bdrv_do_drained_begin() restricts the call of parent callbacks and
> > aio_disable_external() to the outermost drain section, but the block
> > driver callbacks are always called. bdrv_do_drained_end() must match
> > this behaviour, otherwise nodes stay drained even if begin/end calls
> > were balanced.
> 
> Is this patch in the correct place in the series? I was confused becaue
> you mention bdrv_do_drained_begin() and bdrv_do_drained_end() that don't
> seem to exist yet, I see you add them in a later patch.

I think I only forgot to update the commit message when I had to move
some patches around so I could attack one bug after another and keep the
series reviewable.

The series has landed in master today, so for this kind of thing it's
too late anyway, but additional review never hurts. If you find
something, we'll have to do a follow-up patch.

Kevin
