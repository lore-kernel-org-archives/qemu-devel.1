Received: from eggs.gnu.org ([2001:4830:134:3::10]:36384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQhl0-0004DL-Fj
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQhkw-0003F3-A9
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:45:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cQhkw-0003Ew-2l
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:45:30 -0500
Date: Mon, 9 Jan 2017 23:45:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170109234446-mutt-send-email-mst@kernel.org>
References: <1479108340-3453-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479108340-3453-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v7 00/10] Convert msix_init() to error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Jiri Pirko <jiri@resnulli.us>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Hannes Reinecke <hare@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Mon, Nov 14, 2016 at 03:25:30PM +0800, Cao jin wrote:
> v7 changelog:
> 1. fix the segfaut bug in patch 2. So drop the all the R-b of it,
>    please take a look, there is detailed description in the patch.
> 2. add the R-b from Hannes Reinecke
> 
> Test:
> 1. make check: pass
> 2. After applied all the patch, command line test for all the
>    affected devices, just make sure device realize process is ok,
>    no crash, but no further use of device.

Consider the megasas device for example, don't you
need to test that the change actually does what
it's intended to do?


> CC: Jiri Pirko <jiri@resnulli.us>
> CC: Gerd Hoffmann <kraxel@redhat.com>
> CC: Dmitry Fleytman <dmitry@daynix.com>
> CC: Jason Wang <jasowang@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Hannes Reinecke <hare@suse.de>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Alex Williamson <alex.williamson@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> 
> Cao jin (10):
>   msix: Follow CODING_STYLE
>   hcd-xhci: check & correct param before using it
>   pci: Convert msix_init() to Error and fix callers to check it
>   megasas: change behaviour of msix switch
>   hcd-xhci: change behaviour of msix switch
>   megasas: remove unnecessary megasas_use_msix()
>   megasas: undo the overwrites of msi user configuration
>   vmxnet3: fix reference leak issue
>   vmxnet3: remove unnecessary internal msix flag
>   msi_init: convert assert to return -errno
> 
>  hw/block/nvme.c        |  5 +++-
>  hw/misc/ivshmem.c      |  8 +++---
>  hw/net/e1000e.c        |  6 ++++-
>  hw/net/rocker/rocker.c |  7 ++++-
>  hw/net/vmxnet3.c       | 46 +++++++++++++++------------------
>  hw/pci/msi.c           |  9 ++++---
>  hw/pci/msix.c          | 42 +++++++++++++++++++++++++-----
>  hw/scsi/megasas.c      | 49 ++++++++++++++++++++---------------
>  hw/usb/hcd-xhci.c      | 69 ++++++++++++++++++++++++++++++--------------------
>  hw/vfio/pci.c          |  8 ++++--
>  hw/virtio/virtio-pci.c | 11 ++++----
>  include/hw/pci/msix.h  |  5 ++--
>  12 files changed, 164 insertions(+), 101 deletions(-)
> 
> -- 
> 2.1.0
> 
> 
