Received: from eggs.gnu.org ([2001:4830:134:3::10]:47141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYnnI-00066G-Tx
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYnnI-0003Jd-45
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 03:26:12 -0400
Date: Fri, 29 Jun 2018 09:26:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180629072604.GB4555@localhost.localdomain>
References: <20180628153937.26097-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628153937.26097-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] qcow2: Fix cluster leaks on write error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

Am 28.06.2018 um 17:39 hat Kevin Wolf geschrieben:
> Kevin Wolf (3):
>   qemu-iotests: Update 026.out.nocache reference output
>   qcow2: Free allocated clusters on write error
>   qemu-iotests: Test qcow2 not leaking clusters on write error

Thanks for the review, applied to the block branch.

Kevin
