Received: from eggs.gnu.org ([2001:4830:134:3::10]:52041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gNJXb-0002S3-PI
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gNJXZ-0007ri-Iu
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:26:47 -0500
Date: Thu, 15 Nov 2018 16:26:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181115152618.GB12677@localhost.localdomain>
References: <20181031215622.27690-1-kwolf@redhat.com>
	<20181112165026.GF11580@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112165026.GF11580@linux.fritz.box>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 00/12] file-posix: Simplify
 delegation to worker thread
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

Am 12.11.2018 um 17:50 hat Kevin Wolf geschrieben:
> Am 31.10.2018 um 22:56 hat Kevin Wolf geschrieben:
> > This series cleans up and simplifies the code that calls worker thread
> > functions for the various operations in the file-posix driver. This
> > results in less indirection and better readability as well as reduced
> > heap allocations because we can store ACBs on the coroutine stack now.
> 
> ping?

Seems nobody has objections, so applied to block-next.

Kevin
