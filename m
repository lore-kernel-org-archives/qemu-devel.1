Received: from eggs.gnu.org ([2001:4830:134:3::10]:58728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTNse-0002iO-CA
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 02:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTNsd-0006NW-IK
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 02:08:32 -0500
Date: Tue, 17 Jan 2017 15:08:18 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170117070818.GE21563@lemon.Home>
References: <20170116211201.46601-1-farman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170116211201.46601-1-farman@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] scsi-generic and BLKSECTGET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, linux-scsi@vger.kernel.org, mreitz@redhat.com

On Mon, 01/16 22:11, Eric Farman wrote:
> (cc'ing linux-scsi for the cover-letter; patches only to QEMU lists.)
> 
> In the Linux kernel, I see two (three) places where the BLKSECTGET ioctl is
> handled:
> 
> (1) block/(compat_)ioctl.c -- (compat_)blkdev_ioctl
> (2) drivers/scsi/sg.c -- sg_ioctl
> 
> The former has been around forever[1], and returns a short value measured in
> sectors.  A sector is generally assumed to be 512 bytes.
> 
> The latter has been around for slightly less than forever[2], and returns an
> int that measures the value in bytes.  A change to return the block count
> was brought up a few years ago[3] and nacked.
> 
> As a convenient example, if I use the blockdev tool to drive the ioctl to a
> SCSI disk and its scsi-generic equivalent, I get different results:

Fun! :-/

The patch looks correct but I don't like how it is written a lot, but still
thanks for bringing it up so we won't be bitten in the future, and your detailed
explanation is much appreciated!

Fam
