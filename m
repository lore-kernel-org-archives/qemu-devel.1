Received: from eggs.gnu.org ([2001:4830:134:3::10]:59328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce1yQ-0005dt-JM
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:58:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce1yQ-0003Qf-0c
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:58:30 -0500
Date: Wed, 15 Feb 2017 16:58:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170215155822.GE4935@noname.redhat.com>
References: <20170214192525.18624-1-eblake@redhat.com>
	<20170214192525.18624-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170214192525.18624-6-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 5/7] blkdebug: Simplify override logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 14.02.2017 um 20:25 hat Eric Blake geschrieben:
> Rather than store into a local variable, then copy to the struct
> if the value is valid, then reporting errors otherwise, it is
> simpler to just store into the struct and report errors if the
> value is invalid.  This however requires that the struct store
> a 64-bit number, rather than a narrower type.  Move the errno
> assignment into a label that will be reused from more places in
> the next patch.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
