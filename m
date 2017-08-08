Received: from eggs.gnu.org ([2001:4830:134:3::10]:46229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dez5a-0003PF-Uu
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dez5a-0008Qa-1v
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:38:07 -0400
Date: Tue, 8 Aug 2017 09:37:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170808073756.GA4850@dhcp-200-186.str.redhat.com>
References: <20170803150301.10177-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170803150301.10177-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/5] block: bdrv_reopen() fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

Am 03.08.2017 um 17:02 hat Kevin Wolf geschrieben:
> This is the first part of some fixes to bdrv_reopen(), which seems
> reasonable enough to merge for 2.10.
> 
> There is much more wrong with bdrv_reopen() currently, especially with
> respect to op blocker permissions (basically the required permissions
> can change based on the options used in bdrv_reopen(), and both things
> affect the whole tree and aren't integrated with each other at all), but
> I have little hope to get this fixed before 2.10, so let's start with
> what is ready now.

Applied to the block branch.

Kevin
