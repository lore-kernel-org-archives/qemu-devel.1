Received: from eggs.gnu.org ([2001:4830:134:3::10]:54624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYoTI-0003aZ-Pg
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYoTI-00052M-0i
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:09:36 -0400
Date: Fri, 29 Jun 2018 10:09:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180629080925.GB15588@localhost.localdomain>
References: <20180628201525.281787-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628201525.281787-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/8] block: more byte-based cleanups:
 vectored I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Am 28.06.2018 um 22:15 hat Eric Blake geschrieben:
> My quest continues.  I spent some time pruning sector-based usage
> out of qcow as far as possible (and was dismayed at how long it
> took to prove no iotests regressions); so for the other drivers, I
> did the bare minimum to get rid of an interface, but will leave it
> to those file owners if they want to get rid of further pointless
> sector manipulations in their files.

Thanks, applied to the block branch.

Kevin
