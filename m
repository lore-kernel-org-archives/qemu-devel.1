Received: from eggs.gnu.org ([2001:4830:134:3::10]:46011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elcNB-0008OG-6L
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:19:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elcNA-0006dR-An
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:19:57 -0500
Date: Tue, 13 Feb 2018 16:19:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180213151947.GJ5083@localhost.localdomain>
References: <20180213130356.8885-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213130356.8885-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] block: Preallocated truncation for
 gluster and sheepdog
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, sheepdog@lists.wpkg.org, Jeff Cody <jcody@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>

Am 13.02.2018 um 14:03 hat Max Reitz geschrieben:
> As far as I can see, these are the only protocols beside file-posix that
> support preallocated creation.  In contrast to file-posix, however, they
> have not supported preallocated truncation so far.  This series brings
> their truncation code to feature parity with their creation code in this
> regard.
> 
> Note that I do not have a test setup for either of the two drivers, so I
> do not actually know whether this works.  Anyone with a setup is more
> than welcome to test this series.

Thanks, applied to the block branch.

We'll see if someone screams once this hits master.

Kevin
