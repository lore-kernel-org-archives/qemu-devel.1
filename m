Received: from eggs.gnu.org ([2001:4830:134:3::10]:40193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPOrV-0001hk-Sc
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPOrV-0007mG-92
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:31:57 -0500
Date: Wed, 21 Nov 2018 10:31:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181121093146.GA4030@linux.fritz.box>
References: <20181120225241.2371769-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120225241.2371769-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Skip 233 if certtool not installed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 20.11.2018 um 23:52 hat Eric Blake geschrieben:
> The use of TLS while building qemu is optional. While the
> 'certtool' binary should be available on every platform that
> supports building against TLS, that does not imply that the
> developer has installed it.  Make the test gracefully skip
> in that case.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Thanks, applied to the block branch.

Kevin
