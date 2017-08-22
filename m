Received: from eggs.gnu.org ([2001:4830:134:3::10]:52433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dkDY8-0006HG-G4
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dkDY0-0007IB-TR
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dkDY0-0007Gr-NE
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:05:04 -0400
Date: Tue, 22 Aug 2017 11:05:01 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <e56c3b75-332d-4876-2d45-fd2f4edc4d69@citrix.com>
Message-ID: <alpine.DEB.2.10.1708221104440.12143@sstabellini-ThinkPad-X260>
References: <20170821140138.27421-1-ross.lagerwall@citrix.com>
	<alpine.DEB.2.10.1708211528350.12143@sstabellini-ThinkPad-X260>
	<e56c3b75-332d-4876-2d45-fd2f4edc4d69@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] xen: Emit RTC_CHANGE upon TIMEOFFSET ioreq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>

On Tue, 22 Aug 2017, Ross Lagerwall wrote:
> On 08/21/2017 11:30 PM, Stefano Stabellini wrote:
> > On Mon, 21 Aug 2017, Ross Lagerwall wrote:
> > > When the guest writes to the RTC, Xen emulates it and broadcasts a
> > > TIMEOFFSET ioreq. Emit an RTC_CHANGE QMP message when this happens
> > > rather than ignoring it so that something useful can be done with the
> > > information.
> > 
> > Are there any handlers of the RTC_CHANGE QMP message today? What happens
> > if there are no handlers?
> 
> The libxl toolstack doesn't handle it nor does the XAPI project currently,
> although we plan on modifying XAPI to handle it.
> 
> It is simply an event that is broadcast to any QMP monitors. If nothing
> handles the event, then it is the same behavior as before. If something is
> interested in the event, then it can make use of the time offset however it
> wants.

OK, please expland the patch description and repost.
