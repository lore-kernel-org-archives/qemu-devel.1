Received: from eggs.gnu.org ([2001:4830:134:3::10]:42442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyEoj-0003zY-1R
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyEoi-00052Q-AQ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:48:33 -0400
Date: Tue, 20 Mar 2018 11:48:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180320104820.GB4865@localhost.localdomain>
References: <20180312220753.20096-1-farosas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312220753.20096-1-farosas@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] block: Ensure non-protocol drivers
 can only be selected explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 12.03.2018 um 23:07 hat Fabiano Rosas geschrieben:
> Block drivers can be selected by either protocol syntax:
> 
>   <protocol>:<filename>[:options]
> 
> or explicitly:
> 
>   driver=<driver>[,option=<opt1>...]
> 
> For the protocol syntax to work, drivers should set the protocol_name
> field of the BlockDriver structure and provide bdrv_file_open and
> bdrv_parse_filename implementations.
> 
> Conversely, block drivers that do not support the protocol syntax
> should instead implement bdrv_open and not have a protocol_name field.
> 
> Some drivers do not currently adhere to this and errors arise when
> trying to select them using the protocol syntax. For instance:
> 
>   $ qemu-img info replication:foo
>   qemu-img: block.c:2401: bdrv_open_inherit: \
>   Assertion `!!(flags & BDRV_O_PROTOCOL) == !!drv->bdrv_file_open' failed.
>   Aborted (core dumped)
> 
> This patch-set ensures that the following drivers are meeting the
> above criteria:
> - blkreplay
> - quorum
> - replication
> - throttle
> 
> Aside from that, documentation was added to make the above more
> explicit.

Thanks, applied to the block branch.

Kevin
