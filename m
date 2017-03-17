Received: from eggs.gnu.org ([2001:4830:134:3::10]:33549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1coqTU-00026S-Q9
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1coqTU-000581-0P
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:55:16 -0400
Date: Fri, 17 Mar 2017 12:55:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170317115502.GB5072@noname.redhat.com>
References: <1489680169-7638-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489680169-7638-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH for-2.9] thread-pool: add missing
 qemu_bh_cancel in completion function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@gmail.com, pbonzini@redhat.com, berrange@redhat.com, qemu-stable@nongnu.org

Am 16.03.2017 um 17:02 hat Peter Lieven geschrieben:
> commit 3c80ca15 fixed a deadlock scenarion with nested aio_poll invocations.
> 
> However, the rescheduling of the completion BH introcuded unnecessary spinning
> in the main-loop. On very fast file backends this can even lead to the
> "WARNING: I/O thread spun for 1000 iterations" message popping up.
> 
> Callgrind reports about 3-4% less instructions with this patch running
> qemu-img bench on a ramdisk based VMDK file.
> 
> Fixes: 3c80ca158c96ff902a30883a8933e755988948b1
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>

Thanks, applied to the block branch.

Kevin
