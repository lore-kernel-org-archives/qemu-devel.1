Received: from eggs.gnu.org ([2001:4830:134:3::10]:51817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d86XF-0002nf-Vr
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d86XF-0002G8-Af
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:54:46 -0400
Date: Tue, 9 May 2017 16:54:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170509145436.GE5243@noname.str.redhat.com>
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] block: Fix op blockers for inactive
 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: famz@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Am 04.05.2017 um 18:52 hat Kevin Wolf geschrieben:
> Fam's image locking series introduced some special-casing in the file-posix
> driver that avoids taking locks when the image is inactive. While this works,
> it really isn't the job of the file-posix driver, but the core block layer
> should consider that inactive nodes require a lot less permissions.
> 
> This series integrates op blockers with bdrv_inactivate/invalidate_cache() to
> solve this problem gennerically, and removes the workaround in file-posix.

Applied to the block branch.

Kevin
