Received: from eggs.gnu.org ([2001:4830:134:3::10]:47348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fBwoD-0008Hj-5q
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fBwoC-0002bV-BQ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:24:41 -0400
Date: Fri, 27 Apr 2018 14:24:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180427062425.GE4217@lemon.usersys.redhat.com>
References: <20180420220913.27000-1-mreitz@redhat.com>
	<20180420220913.27000-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420220913.27000-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] block/file-posix: Pass FD to locking
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Sat, 04/21 00:09, Max Reitz wrote:
> raw_apply_lock_bytes() and raw_check_lock_bytes() currently take a
> BDRVRawState *, but they only use the lock_fd field.  During image
> creation, we do not have a BDRVRawState, but we do have an FD; so if we
> want to reuse the functions there, we should modify them to receive only
> the FD.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
