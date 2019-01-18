Received: from eggs.gnu.org ([209.51.188.92]:53242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gkRV8-0000wj-Cc
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gkRV7-0004lf-KO
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:35:50 -0500
Date: Fri, 18 Jan 2019 11:35:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190118103535.GD4530@dhcp-200-176.str.redhat.com>
References: <cover.1547475602.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547475602.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Acquire the AioContext during
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Am 14.01.2019 um 15:23 hat Alberto Garcia geschrieben:
> This series acquires the AioContext in the _realize() functions of
> several devices before making use of their block backends. This fixes
> at least a couple of crashes (in virtio-blk and scsi). The other
> devices don't currently support iothreads so there's no crashes.

>  tests/qemu-iotests/236     | 121 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/236.out |  46 +++++++++++++++++

236 is already taken by two other series. :-)

I'll use 239 and 239.out for the conflict resolution, so I think the
next free one for you is 240.

Kevin
