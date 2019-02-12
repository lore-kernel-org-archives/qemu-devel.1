Received: from eggs.gnu.org ([209.51.188.92]:51112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtYhF-0001Z9-Ij
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtYhC-00069a-6O
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:06:00 -0500
Date: Tue, 12 Feb 2019 09:05:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212090538-mutt-send-email-mst@kernel.org>
References: <20190212134758.10514-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212134758.10514-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] a few trivials
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com, qemu-trivial@nongnu.org

On Tue, Feb 12, 2019 at 01:47:54PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Just cleaning out my trivial pile; a few more traces and
> a couple of error reporting tweaks.
> 
> Dave

Looks sane

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> 
> Dr. David Alan Gilbert (4):
>   pckbd: Convert DPRINTF->trace
>   HMP: Prepend errors with 'Error:'
>   kvm: Add kvm_set_ioeventfd* traces
>   wavcapture: Convert to error_report
> 
>  accel/kvm/kvm-all.c    |  3 +++
>  accel/kvm/trace-events |  2 ++
>  audio/wavcapture.c     | 39 +++++++++++++++++----------------------
>  hmp.c                  |  2 +-
>  hw/input/pckbd.c       | 19 ++++++-------------
>  hw/input/trace-events  |  7 +++++++
>  6 files changed, 36 insertions(+), 36 deletions(-)
> 
> -- 
> 2.20.1
