Received: from eggs.gnu.org ([2001:4830:134:3::10]:34709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5auq-0002o2-Op
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5auq-0000kh-0T
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:44:44 -0400
Date: Wed, 3 May 2017 00:44:35 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170502164435.GA8307@lemon.lan>
References: <20170502163558.7611-1-famz@redhat.com>
	<20170502163558.7611-19-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502163558.7611-19-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v17 18/23] block: Reuse bs as backing hd
 for drive-backup sync=none
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, eblake@redhat.com, qemu-stable@nongnu.org

On Wed, 05/03 00:35, Fam Zheng wrote:
> Opening the backing image for the second time is bad, especially here
> when it is also in use as the active image as the source. The
> drive-backup job itself doesn't read from target->backing for COW,
> instead it gets data from the write notifier, so it's not a big problem.
> However, exporting the target to NBD etc. won't work, because of the
> likely stale metadata cache.
> 
> Use BDRV_O_NO_BACKING in this case and manually set up the backing
> BdrvChild.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fam Zheng <famz@redhat.com>

Actually Cc qemu-stable. (git-publish does unified Cc for each patch in a whole
series, hence the noise. Sorry.)

Fam
