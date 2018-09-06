Received: from eggs.gnu.org ([2001:4830:134:3::10]:46987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fxvte-0005rX-NK
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fxvtd-0003nA-QJ
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:08:38 -0400
Date: Thu, 6 Sep 2018 11:08:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180906110349-mutt-send-email-mst@kernel.org>
References: <CANzW0mueyweHLy5k_UPvYLSwyB3_4o9+SBMWvnPFBsC+PdRF_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANzW0mueyweHLy5k_UPvYLSwyB3_4o9+SBMWvnPFBsC+PdRF_A@mail.gmail.com>
Subject: Re: [Qemu-devel] backend for blk or fs with guaranteed
 blocking/synchronous I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Greg Kurz <groug@kaod.org>

On Thu, Sep 06, 2018 at 04:24:12PM +0600, Artem Pisarenko wrote:
> Hi all,
> 
> I'm developing paravirtualized target linux system which runs multiple linux
> containers (LXC) inside itself. (For those, who unfamiliar with LXC, simply
> put, it's an isolated group of userspace processes with their own rootfs.) Each
> container should be provided access to its rootfs located at host and execution
> of container should be deterministic. Particularly, it means that container I/O
> operations must be synchronized within some predefined quantum of guest
> _virtual_ time, i.e. its I/O activity shouldn't be delayed by host performance
> or activities on host and other containers. In other words, guest should see
> it's like either infinite throughput and zero latency, or some predefined
> throughput/latency characteristics guaranteed per each rootfs.
> 
> While other sources of non-determinism are seem to be eliminated (using TCG,
> -icount, etc.), asynchronous I/O still introduces it.

...

Just that you should realize that the issues are not limited to QEMU: to
get real time behaviour out of a Linux host you need a real-time kernel
and real-time capable hardware/firmware. I'm not an expert on this at
all, but see e.g. these old presentations:
https://lwn.net/Articles/656807/

-- 
MST
