Received: from eggs.gnu.org ([2001:4830:134:3::10]:34092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1em0ah-0001fx-Ll
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 12:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1em0ag-0003Vz-Mr
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 12:11:31 -0500
Date: Wed, 14 Feb 2018 18:11:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180214171105.GG4766@localhost.localdomain>
References: <20180213202701.15858-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213202701.15858-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 00/21] add byte-based block_status
 driver callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

Am 13.02.2018 um 21:26 hat Eric Blake geschrieben:
> There are patches floating around to add NBD_CMD_BLOCK_STATUS,
> but NBD wants to report status on byte granularity (even if the
> reporting will probably be naturally aligned to sectors or even
> much higher levels).  I've therefore started the task of
> converting our block status code to report at a byte granularity
> rather than sectors.
> 
> These patches have been around for a while, but it's time to
> finish it now that 2.12 is open for patches.

Thanks, touched up patch 8 and applied to the block branch.

Kevin
