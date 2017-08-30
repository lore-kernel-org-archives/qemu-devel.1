Received: from eggs.gnu.org ([2001:4830:134:3::10]:57408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn3Fg-0006oI-Ps
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn3Fd-0007Bj-I6
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:41:52 -0400
Date: Wed, 30 Aug 2017 14:41:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830134144.GS24565@stefanha-x1.localdomain>
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822131832.20191-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/10] scsi: move block/scsi.h to
 include/scsi/constants.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

On Tue, Aug 22, 2017 at 03:18:27PM +0200, Paolo Bonzini wrote:
> Complete the transition by renaming this header, which was
> shared by block/iscsi.c and the SCSI emulation code.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/iscsi.c                              | 2 +-
>  hw/block/virtio-blk.c                      | 2 +-
>  hw/scsi/megasas.c                          | 2 +-
>  hw/scsi/mptendian.c                        | 2 +-
>  hw/scsi/mptsas.c                           | 2 +-
>  hw/scsi/scsi-bus.c                         | 2 +-
>  hw/scsi/scsi-disk.c                        | 2 +-
>  hw/scsi/scsi-generic.c                     | 2 +-
>  hw/scsi/spapr_vscsi.c                      | 2 +-
>  hw/scsi/virtio-scsi-dataplane.c            | 2 +-
>  hw/scsi/virtio-scsi.c                      | 2 +-
>  hw/scsi/vmw_pvscsi.c                       | 2 +-
>  hw/usb/dev-uas.c                           | 2 +-
>  include/hw/ide/internal.h                  | 2 +-
>  include/{block/scsi.h => scsi/constants.h} | 0
>  scsi/utils.c                               | 2 +-
>  tests/virtio-scsi-test.c                   | 2 +-
>  17 files changed, 16 insertions(+), 16 deletions(-)
>  rename include/{block/scsi.h => scsi/constants.h} (100%)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
