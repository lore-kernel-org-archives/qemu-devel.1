Received: from eggs.gnu.org ([2001:4830:134:3::10]:49754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eP5GA-0007e5-Ba
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eP5G9-0004yf-LV
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:31:34 -0500
Date: Wed, 13 Dec 2017 12:31:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171213113120.GC3950@localhost.localdomain>
References: <20171207170834.15843-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207170834.15843-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Tweak 030 in order to trigger a
 race condition with parallel jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 07.12.2017 um 18:08 hat Alberto Garcia geschrieben:
> This patch tweaks TestParallelOps in iotest 030 so it allocates data
> in smaller regions (256KB/512KB instead of 512KB/1MB) and the
> block-stream job in test_stream_commit() only needs to copy data that
> is at the very end of the image.
> 
> This way when the block-stream job is waken up it will finish right
> away without any chance of being stopped by block_job_sleep_ns(). This
> triggers the bug that was fixed by 3d5d319e1221082974711af1d09d82f07
> and is therefore a more useful test case for parallel block jobs.

But if all jobs complete right away, doesn't this kill the parallelism
that the test case intended to test?

Maybe we need both cases?

Kevin
