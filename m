Received: from eggs.gnu.org ([2001:4830:134:3::10]:38451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMDGO-00066B-68
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMDGI-0007VW-K2
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:00:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60996 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMDGI-0007VL-Ep
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:00:06 -0400
Date: Fri, 25 May 2018 17:00:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180525165802-mutt-send-email-mst@kernel.org>
References: <20180525132755.21839-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525132755.21839-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/6] Update Linux headers to 4.17-rc6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, May 25, 2018 at 02:27:49PM +0100, Peter Maydell wrote:
> This series updates our copy of the Linux kernel headers to 4.17-rc6.
> To do that we have to fix up some issues:
>  * we had a hand-hacked definition of VIRTIO_GPU_CAPSET_VIRGL2
>    in our old header copy that needs to be moved to a header
>    that isn't auto-updated
>  * we need to turn __aligned_u64 into a portable type
>  * KVM_HINTS_DEDICATED was renamed to KVM_HINTS_REALTIME
>  * the kernel's licensing info is no longer solely in the COPYING file
> 
> thanks
> -- PMM

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> Alex Williamson (1):
>   virtio-gpu-3d: Define VIRTIO_GPU_CAPSET_VIRGL2 elsewhere
> 
> Peter Maydell (5):
>   scripts/update-linux-headers: Handle __aligned_u64
>   scripts/update-linux-headers: Handle kernel license no longer being
>     one file
>   target/i386/kvm.c: Handle renaming of KVM_HINTS_DEDICATED
>   Update Linux headers to 4.17-rc6
>   target/i386/kvm.c: Remove compatibility shim for KVM_HINTS_REALTIME
> 
>  include/hw/virtio/virtio-gpu.h                |   6 +
>  include/standard-headers/asm-x86/hyperv.h     |   1 -
>  include/standard-headers/asm-x86/kvm_para.h   |   2 +-
>  include/standard-headers/linux/ethtool.h      |  36 +-
>  include/standard-headers/linux/input.h        |   4 +-
>  include/standard-headers/linux/pci_regs.h     |   7 +-
>  .../standard-headers/linux/virtio_balloon.h   |  15 +
>  include/standard-headers/linux/virtio_gpu.h   |   1 -
>  .../standard-headers/rdma/vmw_pvrdma-abi.h    |  49 +--
>  linux-headers/asm-arm/kvm.h                   |  15 +
>  linux-headers/asm-arm64/kvm.h                 |   6 +
>  linux-headers/asm-x86/hyperv.h                |   1 -
>  linux-headers/asm-x86/kvm.h                   |  19 +-
>  linux-headers/linux/kvm.h                     |  30 +-
>  linux-headers/linux/vfio.h                    |  27 ++
>  target/i386/kvm.c                             |   2 +-
>  linux-headers/COPYING                         | 358 +-----------------
>  .../LICENSES/exceptions/Linux-syscall-note    |  25 ++
>  linux-headers/LICENSES/preferred/BSD-2-Clause |  32 ++
>  linux-headers/LICENSES/preferred/BSD-3-Clause |  36 ++
>  .../{COPYING => LICENSES/preferred/GPL-2.0}   |  27 +-
>  scripts/update-linux-headers.sh               |  17 +-
>  22 files changed, 310 insertions(+), 406 deletions(-)
>  delete mode 100644 include/standard-headers/asm-x86/hyperv.h
>  delete mode 100644 linux-headers/asm-x86/hyperv.h
>  create mode 100644 linux-headers/LICENSES/exceptions/Linux-syscall-note
>  create mode 100644 linux-headers/LICENSES/preferred/BSD-2-Clause
>  create mode 100644 linux-headers/LICENSES/preferred/BSD-3-Clause
>  copy linux-headers/{COPYING => LICENSES/preferred/GPL-2.0} (96%)
> 
> -- 
> 2.17.0
