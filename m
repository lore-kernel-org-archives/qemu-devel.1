Received: from eggs.gnu.org ([2001:4830:134:3::10]:53026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dACza-0008Sh-8I
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dACzZ-0002Fa-BB
	for qemu-devel@nongnu.org; Mon, 15 May 2017 06:12:42 -0400
Date: Mon, 15 May 2017 12:12:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170515101232.GA5784@noname.redhat.com>
References: <20170515093424.28954-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170515093424.28954-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] stream: fix crash in stream_start() when
 block_job_create() fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, "qemu-stable@nongnu.org Max Reitz" <mreitz@redhat.com>

Am 15.05.2017 um 11:34 hat Alberto Garcia geschrieben:
> The code that tries to reopen a BlockDriverState in stream_start()
> when the creation of a new block job fails crashes because it attempts
> to dereference a pointer that is known to be NULL.
> 
> This is a regression introduced in a170a91fd3eab6155da39e740381867e,
> likely because the code was copied from stream_complete().
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Cc: qemu-stable@nongnu.org

Thanks, applied to the block branch.

Kevin
