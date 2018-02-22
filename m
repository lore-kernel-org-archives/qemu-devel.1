Received: from eggs.gnu.org ([2001:4830:134:3::10]:50669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eopy9-0000bL-MX
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:27:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eopy8-00064O-Qu
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:27:25 -0500
Date: Thu, 22 Feb 2018 13:27:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180222122700.GE4147@localhost.localdomain>
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205151835.20812-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 01/26] block/mirror: Small
 absolute-paths simplification
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
> When invoking drive-mirror in absolute-paths mode, the target's backing
> BDS is assigned to it in mirror_exit(). The current logic only does so
> if the target does not have that backing BDS already; but it actually
> cannot have a backing BDS at all (the BDS is opened with O_NO_BACKING in
> qmp_drive_mirror()), so just assert that and assign the new backing BDS
> unconditionally.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>

Introducing new assumptions that the graph stays unmodified between the
start of a block job and its completion feels a bit adventurous when all
of the blockdev work is moving towards making things more flexible.

If we really do want to enforce this, I guess you finally found a use
case for BLK_PERM_GRAPH_MOD.

Kevin
