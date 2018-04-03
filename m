Received: from eggs.gnu.org ([2001:4830:134:3::10]:51565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3LyI-0001j5-6e
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3LyA-0003IV-K6
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:27:34 -0400
Date: Tue, 3 Apr 2018 15:27:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180403132710.GB11070@localhost.localdomain>
References: <f7011b6ebc323b45b46a8f01310249e2e6d77617.1522730165.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7011b6ebc323b45b46a8f01310249e2e6d77617.1522730165.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] block: handle invalid lseek
 returns gracefully
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 03.04.2018 um 06:37 hat Jeff Cody geschrieben:
> In commit 223a23c198787328ae75bc65d84edf5fde33c0b6, we implemented a
> workaround in the gluster driver to handle invalid values returned for
> SEEK_DATA or SEEK_HOLE.
> 
> In some instances, these same invalid values can be seen in the posix
> file handler as well - for example, it has been reported on FUSE gluster
> mounts.
> 
> Calling assert() for these invalid values is overly harsh; we can safely
> return -EIO and allow this case to be treated as a "learned nothing"
> case (e.g., D4 / H4, as commented in the code).
> 
> This patch does the same thing that 223a23c198787 did for gluster.c,
> except in file-posix.c
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>

Thanks, applied to the block branch.

Kevin
