Received: from eggs.gnu.org ([209.51.188.92]:41073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gpFwI-0006eP-T8
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gpFwH-0001V0-0x
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:15:46 -0500
Date: Thu, 31 Jan 2019 12:15:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190131121412-mutt-send-email-mst@kernel.org>
References: <20190131151914.164903-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131151914.164903-1-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] virtio-blk: add DISCARD and WRITE
 ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org

On Thu, Jan 31, 2019 at 04:19:09PM +0100, Stefano Garzarella wrote:
> This series adds the support of DISCARD and WRITE ZEROES commands
> and extends the virtio-blk-test to test WRITE_ZEROES command when
> the feature is enabled.
> 
> v2:
> - added patch 1 to use virtio_blk_handle_rw_error() with discard operation
> - added patch 2 to make those new features machine-type dependent (thanks David)
> - fixed patch 3 (previously patch 1/2) adding more checks, block_acct_start()
>                 for WRITE_ZEROES requests, and configurable parameters to
>                 initialize the limits (max_sectors, wzeroes_may_unmap).
>                 (thanks Stefan)
>                 I moved in a new function the code to handle a single segment,
>                 in order to simplify the support of multiple segments in the
>                 future.
> - added patch 4 to change the assert on data_size following the discussion with
>                 Thomas, Changpeng, Michael, and Stefan (thanks all)
> - fixed patch 5 (previously patch 2/2) using local dwz_hdr variable instead of
>                 dynamic allocation (thanks Thomas)
> 
> This series requires the new virtio headers from linux v5.0-rc1
> already imported by Paolo:
> 
> Based-on: <20190104082731.24967-1-pbonzini@redhat.com>
> 
> Thanks,
> Stefano

series:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


merge through block tree I guess?


> Stefano Garzarella (5):
>   virtio-blk: add acct_failed param to virtio_blk_handle_rw_error()
>   virtio-blk: add "discard-wzeroes" boolean property
>   virtio-blk: add DISCARD and WRITE ZEROES features
>   tests/virtio-blk: change assert on data_size in virtio_blk_request()
>   tests/virtio-blk: add test for WRITE_ZEROES command
> 
>  hw/block/virtio-blk.c          | 185 ++++++++++++++++++++++++++++++++-
>  hw/core/machine.c              |   1 +
>  include/hw/virtio/virtio-blk.h |   3 +
>  tests/virtio-blk-test.c        |  75 ++++++++++++-
>  4 files changed, 259 insertions(+), 5 deletions(-)
> 
> -- 
> 2.20.1
