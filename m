Received: from eggs.gnu.org ([2001:4830:134:3::10]:58724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwBbW-0000Pf-Fx
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwBbV-0006uT-K5
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:53:54 -0400
Date: Thu, 6 Apr 2017 19:53:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170406175345.GM4341@noname.redhat.com>
References: <20170403175150.15253-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170403175150.15253-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/2] block/mirror: Fix
 use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 03.04.2017 um 19:51 hat Max Reitz geschrieben:
> And the exciting 2.9 ride continues!
> 
> When mirroring from a BDS with no parents at all (such as those added
> with -blockdev or blockdev-add), we have a use-after-free in mirror's
> error path. The first patch of this series fixes that, the other adds a
> patch so we don't regress.
> 
> What issue will we find next? Stay tuned!

Thanks, applied to the block branch.

Kevin
