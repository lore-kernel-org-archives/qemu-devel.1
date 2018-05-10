Received: from eggs.gnu.org ([2001:4830:134:3::10]:37017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGb00-0001cf-K7
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGazz-0006Sy-Rl
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:08:04 -0400
Date: Thu, 10 May 2018 10:07:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180510020755.GB4492@lemon.usersys.redhat.com>
References: <20180509215336.31304-1-mreitz@redhat.com>
	<20180509215336.31304-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509215336.31304-3-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block/file-posix: File locking
 during creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed, 05/09 23:53, Max Reitz wrote:
> When creating a file, we should take the WRITE and RESIZE permissions.
> We do not need either for the creation itself, but we do need them for
> clearing and resizing it.  So we can take the proper permissions by
> replacing O_TRUNC with an explicit truncation to 0, and by taking the
> appropriate file locks between those two steps.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
