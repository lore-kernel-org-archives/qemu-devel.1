Received: from eggs.gnu.org ([2001:4830:134:3::10]:51201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoq10-0001fu-A7
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoq0z-0000CD-7y
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:30:22 -0500
Date: Thu, 22 Feb 2018 13:30:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180222123014.GF4147@localhost.localdomain>
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205151835.20812-3-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 02/26] block: Use children list in
 bdrv_refresh_filename
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
> bdrv_refresh_filename() should invoke itself recursively on all
> children, not just on file.
> 
> With that change, we can remove the manual invocations in blkverify,
> quorum, commit, and mirror.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
