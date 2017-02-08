Received: from eggs.gnu.org ([2001:4830:134:3::10]:40125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephane.chazelas@gmail.com>) id 1cbVrE-0006Gt-Tq
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 12:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephane.chazelas@gmail.com>) id 1cbVrA-0000Xd-PJ
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 12:16:40 -0500
Date: Wed, 8 Feb 2017 17:16:33 +0000
From: Stephane Chazelas <stephane.chazelas@gmail.com>
Message-ID: <20170208171633.GC19518@chaz.gmail.com>
References: <20170202123045.GA24714@chaz.gmail.com>
	<f8a93c01-682e-fbcb-7b81-012f6df97465@redhat.com>
	<20170208140646.GA19518@chaz.gmail.com>
	<11bfda2a-7799-a5d5-4ba0-37b2b9dd92f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11bfda2a-7799-a5d5-4ba0-37b2b9dd92f6@redhat.com>
Subject: Re: [Qemu-devel] [qcow2] how to avoid qemu doing
 lseek(SEEK_DATA/SEEK_HOLE)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>

2017-02-08 15:27:11 +0100, Max Reitz:
[...]
> A bit of a stupid question, but: How is your performance when using
> detect-zeroes=off?
[...]

I did try that. See:

} Note that passing detect-zeroes=off or detect-zeroes=unmap (with
} discard) doesn't help (even though FALLOC_FL_PUNCH_HOLE is
} supported on ZFS on Linux).

In my original message. It makes no difference, I still see
those lseek()s being done.

-- 
Stephane
