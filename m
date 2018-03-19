Received: from eggs.gnu.org ([2001:4830:134:3::10]:32910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1exwmq-0008Hl-Pt
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1exwmq-0002GA-1Y
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:33:24 -0400
Date: Mon, 19 Mar 2018 16:33:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180319153309.GE30864@localhost.localdomain>
References: <20180310214554.157155-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310214554.157155-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: 163 is not quick
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 10.03.2018 um 22:45 hat Eric Blake geschrieben:
> Testing on ext4, most 'quick' qcow2 tests took less than 5 seconds,
> but 163 took more than 20.  Let's remove it from the quick set.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Takes only 11 seconds for me, but that's still longer than most other
tests.

Thanks, applied to the block branch.

Kevin
