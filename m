Received: from eggs.gnu.org ([2001:4830:134:3::10]:38021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=400b57bf0=ross.lagerwall@citrix.com>)
	id 1dk4RM-0001jg-Fv
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=400b57bf0=ross.lagerwall@citrix.com>)
	id 1dk4RG-0006pI-Nd
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:21:36 -0400
Received: from smtp.citrix.com ([66.165.176.89]:21457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=400b57bf0=ross.lagerwall@citrix.com>)
	id 1dk4RG-0006on-Hv
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:21:30 -0400
References: <20170821140138.27421-1-ross.lagerwall@citrix.com>
	<alpine.DEB.2.10.1708211528350.12143@sstabellini-ThinkPad-X260>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <e56c3b75-332d-4876-2d45-fd2f4edc4d69@citrix.com>
Date: Tue, 22 Aug 2017 09:21:26 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1708211528350.12143@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] xen: Emit RTC_CHANGE upon TIMEOFFSET ioreq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>

On 08/21/2017 11:30 PM, Stefano Stabellini wrote:
> On Mon, 21 Aug 2017, Ross Lagerwall wrote:
>> When the guest writes to the RTC, Xen emulates it and broadcasts a
>> TIMEOFFSET ioreq. Emit an RTC_CHANGE QMP message when this happens
>> rather than ignoring it so that something useful can be done with the
>> information.
> 
> Are there any handlers of the RTC_CHANGE QMP message today? What happens
> if there are no handlers?

The libxl toolstack doesn't handle it nor does the XAPI project 
currently, although we plan on modifying XAPI to handle it.

It is simply an event that is broadcast to any QMP monitors. If nothing 
handles the event, then it is the same behavior as before. If something 
is interested in the event, then it can make use of the time offset 
however it wants.

-- 
Ross Lagerwall
