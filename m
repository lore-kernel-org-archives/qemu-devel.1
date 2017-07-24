Received: from eggs.gnu.org ([2001:4830:134:3::10]:36949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZZfG-0007mp-QL
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZZfG-0005y0-04
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 05:28:34 -0400
Date: Mon, 24 Jul 2017 11:28:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170724092822.GC4630@noname.str.redhat.com>
References: <20170721183243.22706-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170721183243.22706-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] Bug fixes from byte-based
 block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-block@nongnu.org

Am 21.07.2017 um 20:32 hat Eric Blake geschrieben:
> Series 2-4 of my byte-based conversion missed soft freeze, so they
> are now 2.11 material.  However, there are some bug fixes in those
> series that we should fix now in 2.10 (patch 1 from series two
> on dirty bitmaps, patch 2 extracted from "qcow2: Switch qcow2_measure()
> to byte-based iteration" from series three on block status).

Thanks, applied to the block branch.

> I don't know if it is worth enhancing iotest 178 to probe the size
> of a 2T image.  The test is simple, and fast when patched:
> 
> $ qemu-img create -f qcow2 -o cluster_size=2M huge 2T
> $ time ./qemu-img measure -O qcow2 -f qcow2 huge
> required size: 335806464
> fully allocated size: 2199359062016
> 
> real	0m0.021s
> user	0m0.017s
> sys	0m0.004s
> 
> but the inf-loop when unpatched is annoying; meanwhile, 'huge' only
> occupies 6 megabytes on disk, so it's not that invasive.

Yes, please follow up with qemu-iotests cases for both bugs. We're only
adding the test after fixing the bug, so a hang in the buggy old code
isn't a problem.

Kevin
