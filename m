Received: from eggs.gnu.org ([209.51.188.92]:60122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghyR9-0006L4-20
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:09:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghyR7-00068H-U0
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:09:31 -0500
Date: Fri, 11 Jan 2019 16:09:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190111150917.GL5010@dhcp-200-186.str.redhat.com>
References: <cover.1547132561.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547132561.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] Acquire the AioContext during
 _realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Am 10.01.2019 um 16:03 hat Alberto Garcia geschrieben:
> As discussed yesterday, this series acquires the AioContext in the
> _realize() functions of several devices before making use of their
> block backends. This fixes at least a couple of crashes (in virtio-blk
> and scsi).

Apart from the incomplete scsi-block fix, this looks good. Of course,
I think patches 3-6 are completely optional because none of these
devices actually support iothreads, so we can't hit a bug. But it might
be nicer to add it there as well anyway.

For patches 1 and 2, which actually fix bugs, it would be nice to have
an accompanying test case.

Kevin
