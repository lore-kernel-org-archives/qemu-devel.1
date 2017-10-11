Received: from eggs.gnu.org ([2001:4830:134:3::10]:35101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e2FnA-00015q-MB
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e2Fn9-0002uM-Sa
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:07:16 -0400
Date: Wed, 11 Oct 2017 14:07:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171011120706.GF4593@dhcp-200-186.str.redhat.com>
References: <CY4PR0101MB291815E29308B3C75D26876FE9740@CY4PR0101MB2918.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR0101MB291815E29308B3C75D26876FE9740@CY4PR0101MB2918.prod.exchangelabs.com>
Subject: Re: [Qemu-devel] Co-routine re-entered recursively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gugnani, Shashank" <gugnani.2@buckeyemail.osu.edu>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org

[ Cc: qemu-block ]

Am 09.10.2017 um 21:11 hat Gugnani, Shashank geschrieben:
> Hi,
> 
> I'm trying to modify the NVMe emulator in QEMU to use multiple threads.
> 
> After making necessary changes, I see this error: 'Co-routine re-entered recursively'
> 
> Can anybody tell me the reason for this error? Is there anything I can do to fix this issue?

I suspect that you need to fix your locking. Are you sure you're holding
the AioContext locks while you're making requests to the block layer?

Kevin
