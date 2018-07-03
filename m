Received: from eggs.gnu.org ([2001:4830:134:3::10]:55012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faMv3-0007Kh-PS
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faMv2-0003AG-Kq
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:08:41 -0400
Date: Tue, 3 Jul 2018 17:08:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180703150829.GC28229@localhost.localdomain>
References: <1530629328-10193-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530629328-10193-1-git-send-email-ari@tuxera.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/2] New block driver: blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 03.07.2018 um 16:48 hat Ari Sundholm geschrieben:
> This patch series adds a new block driver, blklogwrites, to QEMU. The
> driver is given two block devices: a raw device backed by an image or a
> host block device, and a log device, typically backed by a file, on
> which writes to the raw device are logged.
> 
> The logging format used is the same as in the dm-log-writes target of
> the Linux kernel device mapper. The log reflects the writes that have
> been performed on the guest block device and flushed. To be strict, the
> log may contain writes that have not been flushed yet, but they are
> technically outside the bounds of the log until the next flush updates
> the metadata in the log superblock. We believe these semantics to be
> useful even though they may not be completely identical to those of
> dm-log-writes.
> 
> This functionality can be used for crash consistency and fs consistency
> testing in filesystem drivers, including on non-Linux guests and older
> guests running Linux versions without support for dm-log-writes. This
> is simple and useful. Admittedly this and more advanced things could
> perhaps be done by extending the quorum driver, but this approach would
> require re-engineering the functionality and involve a more complicated
> setup, so we offer this simple solution which we have found useful
> internally.
> 
> In the first patch of this series, two block permission constants are
> moved from block.c to include/block/block.h to make them available
> outside of block.c. The next patch uses these constants.
> 
> In the second patch, the blklogwrites driver is introduced. The driver
> accepts a target block device to be logged, a log device and an option
> to set the sector size used for logging. All requests are aligned to
> this sector size, and offsets and sizes in the log entries will be
> expressed as a multiple of this value.

Thanks, applied to the block branch.

Kevin
