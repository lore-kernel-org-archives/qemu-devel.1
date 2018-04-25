Received: from eggs.gnu.org ([2001:4830:134:3::10]:56499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fBI9H-0007H8-Au
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fBI9G-0000Md-OM
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:59:43 -0400
Date: Wed, 25 Apr 2018 12:59:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180425105935.GD4652@localhost.localdomain>
References: <20180424192506.149089-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424192506.149089-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] block: byte-based AIO read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org

Am 24.04.2018 um 21:25 hat Eric Blake geschrieben:
> While we would prefer that block drivers use coroutines instead
> of aio callbacks, it is a fairly easy exercise to prove that
> all existing drivers with aio callbacks are merely scaling
> from bytes into sectors and back to bytes.  So, even though I
> am not set up to completely run (or even compile-test) this
> full series, it seems pretty straightforward to change the
> signature to quit playing games with pointless scaling.
> 
> Incorporate Kevin's review on v1, which amounted to pretty much
> rewriting the series to be saner (the block layer now defaults
> to alignment of 1, so drivers that still need 512 for keeping the
> patch conservative have to override that; and improve the code
> in io.c to put byte-based access before sector-based fallbacks).

Thanks, applied to the block-next branch.

Kevin
