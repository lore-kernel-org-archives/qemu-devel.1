Received: from eggs.gnu.org ([2001:4830:134:3::10]:60832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1fT5ur-0005et-Bh
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1fT5un-00029d-BB
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:34:25 -0400
References: <20180613123458.24685-1-kwolf@redhat.com>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <c92cb437-f584-0557-eb99-0316523670e4@redhat.com>
Date: Wed, 13 Jun 2018 09:34:12 -0400
MIME-Version: 1.0
In-Reply-To: <20180613123458.24685-1-kwolf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] block: Remove deprecated -drive options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, libvirt mailing list <Libvir-list@redhat.com>

On 06/13/2018 08:34 AM, Kevin Wolf wrote:
> We deprecated a bunch of -drive options in 2.10, so let's remove them
> for 3.0.
> 
> Kevin Wolf (3):
>   block: Remove deprecated -drive geometry options
>   block: Remove deprecated -drive option addr
>   block: Remove deprecated -drive option serial
> 
>  include/hw/block/block.h  |   1 -
>  include/sysemu/blockdev.h |   3 --
>  block/block-backend.c     |   1 -
>  blockdev.c                | 110 ----------------------------------------------
>  device-hotplug.c          |   4 --
>  hw/block/block.c          |  27 ------------
>  hw/block/nvme.c           |   1 -
>  hw/block/virtio-blk.c     |   1 -
>  hw/ide/qdev.c             |   1 -
>  hw/scsi/scsi-disk.c       |   1 -
>  hw/usb/dev-storage.c      |   1 -
>  tests/ahci-test.c         |   6 +--
>  tests/hd-geo-test.c       |  18 --------
>  tests/ide-test.c          |   8 ++--
>  hmp-commands.hx           |   1 -
>  qemu-doc.texi             |  15 -------
>  qemu-options.hx           |  14 +-----
>  17 files changed, 8 insertions(+), 205 deletions(-)
> 

I think libvirt needs to be adjusted to handle new style options for
patch #1 and patch #3, ccing

- Cole
