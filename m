Received: from eggs.gnu.org ([2001:4830:134:3::10]:52936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eorxC-0004Le-Ff
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eorxB-0001vt-My
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:34:34 -0500
Date: Thu, 22 Feb 2018 15:34:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180222143411.GI4147@localhost.localdomain>
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-5-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205151835.20812-5-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 04/26] iotests: Drop explicit base
 blockdev in 191
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>

Am 05.02.2018 um 16:18 hat Max Reitz geschrieben:
> Overriding the backing image should result in a json:{} pseudo-filename.
> Then, you can no longer use the commit block job with filename
> parameters.  Therefore, do not explicitly add the base and override the
> middle image in iotest 191, since we do not need to anyway.  This will
> allow us to continue to use the middle image's filename to identify it.
> 
> In the long run, we want block-commit to accept node names for base and
> top (just like block-stream does).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Is this actually needed once the FIXME in patch 3 is addressed and only
significant fields are considered, or can we revert the patch at the end
of the series?

Once we implement a node-named based blockdev-commit, we'll want to test
both versions here, so it would be good to be able to set a node-name
and still be able to use the filename for the older interface.

Kevin
