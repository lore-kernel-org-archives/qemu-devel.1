Received: from eggs.gnu.org ([2001:4830:134:3::10]:46729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cJa8C-0005Ef-BE
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cJa89-0000Xn-3p
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:12:04 -0500
Received: from [59.151.112.132] (port=12225 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cJa88-0000TL-N2
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:12:01 -0500
References: <1479108340-3453-1-git-send-email-caoj.fnst@cn.fujitsu.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <585A1E33.1090002@cn.fujitsu.com>
Date: Wed, 21 Dec 2016 14:16:19 +0800
MIME-Version: 1.0
In-Reply-To: <1479108340-3453-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 00/10] Convert msix_init() to error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

ping

On 11/14/2016 03:25 PM, Cao jin wrote:
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
> 
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

-- 
Sincerely,
Cao jin
