Received: from eggs.gnu.org ([2001:4830:134:3::10]:36935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eWhKr-0006RK-P4
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 06:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eWhKn-0002eI-Lx
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 06:35:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1eWhKn-0002dU-EN
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 06:35:49 -0500
Date: Wed, 3 Jan 2018 11:35:45 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180103113544.GI2450@redhat.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514940265-18093-1-git-send-email-mjc@sifive.com>
Subject: Re: [Qemu-devel] [PATCH v1 00/21] RISC-V QEMU Port Submission v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

Just a few small points:

(1) I've built Fedora RPMs from this patch set [approximately - I'm
using a very slightly different / slightly older version, but it's not
substantively different]:

  http://copr-fe.cloud.fedoraproject.org/coprs/rjones/riscv/

It works well for me building plenty of Fedora packages over the past
few weeks, except for a possible Linux kernel bug which interacts with
the patch set not handling EBREAK correctly, which I had to patch
around (in the kernel):

  https://groups.google.com/a/groups.riscv.org/forum/#!msg/sw-dev/v05FjcGC1EI/atXXUAcsCgAJ

(2) I'm worried that this patch starts off using virtio-mmio instead
of virtio-pci.  virtio-pci is better in every respect than
virtio-mmio, and while it may be a good interim solution I think we
need to have a plan to get rid of it eventually, and should make it
clear that virtio-mmio is not a permanent ABI so we don't get into the
same situation that we did with -M virt on ARM.

(3) poweroff doesn't work if you use -M virt (and hence don't use
HTIF).  I wrote a dummy poweroff device to get around this, but I
think it could raise a bigger point: Why bother to support HTIF
machine types at all?  The reason given in the patch set is because
spike (the cycle-accurate RISC-V emulator) only supports HTIF but
is that a good reason?

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
