Received: from eggs.gnu.org ([2001:4830:134:3::10]:53458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eH9kr-0004Cm-K9
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eH9kq-0007hS-KC
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:42:29 -0500
Date: Tue, 21 Nov 2017 16:41:57 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171121164037-mutt-send-email-mst@kernel.org>
References: <1511289434-1551-1-git-send-email-gengdongjiu@huawei.com>
	<1511289434-1551-6-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1511289434-1551-6-git-send-email-gengdongjiu@huawei.com>
Subject: Re: [Qemu-devel] [PATCH RESEND v12 05/12] linux-headers: sync
 against Linux v4.14-rc8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: pbonzini@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, james.morse@arm.com, lersek@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, guohanjun@huawei.com, lijinyue@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhengqiang10@huawei.com, linuxarm@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, dingtianhong@huawei.com, wangxiongfeng2@huawei.com

On Wed, Nov 22, 2017 at 02:37:07AM +0800, Dongjiu Geng wrote:
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> 
> ---
> Address Peter's comments to sync mainline Linux header file in [1]
> 
> [1]: https://lkml.org/lkml/2017/9/5/575
> ---
>  include/standard-headers/asm-s390/kvm_virtio.h     | 1 +
>  include/standard-headers/asm-s390/virtio-ccw.h     | 1 +
>  include/standard-headers/asm-x86/hyperv.h          | 1 +
>  include/standard-headers/linux/input-event-codes.h | 1 +
>  include/standard-headers/linux/input.h             | 1 +
>  include/standard-headers/linux/pci_regs.h          | 1 +
>  linux-headers/asm-arm/kvm.h                        | 1 +
>  linux-headers/asm-arm/kvm_para.h                   | 1 +
>  linux-headers/asm-arm/unistd.h                     | 1 +
>  linux-headers/asm-arm64/kvm.h                      | 1 +
>  linux-headers/asm-arm64/unistd.h                   | 1 +
>  linux-headers/asm-powerpc/epapr_hcalls.h           | 1 +
>  linux-headers/asm-powerpc/kvm.h                    | 1 +
>  linux-headers/asm-powerpc/kvm_para.h               | 1 +
>  linux-headers/asm-powerpc/unistd.h                 | 1 +
>  linux-headers/asm-s390/kvm.h                       | 1 +
>  linux-headers/asm-s390/kvm_para.h                  | 1 +
>  linux-headers/asm-s390/unistd.h                    | 1 +
>  linux-headers/asm-x86/kvm.h                        | 1 +
>  linux-headers/asm-x86/kvm_para.h                   | 1 +
>  linux-headers/asm-x86/unistd.h                     | 1 +
>  linux-headers/linux/kvm.h                          | 4 ++++
>  linux-headers/linux/kvm_para.h                     | 1 +
>  linux-headers/linux/psci.h                         | 1 +
>  linux-headers/linux/userfaultfd.h                  | 1 +
>  linux-headers/linux/vfio.h                         | 1 +
>  linux-headers/linux/vfio_ccw.h                     | 1 +
>  linux-headers/linux/vhost.h                        | 1 +
>  28 files changed, 31 insertions(+)
> 
> diff --git a/include/standard-headers/asm-s390/kvm_virtio.h b/include/standard-headers/asm-s390/kvm_virtio.h
> index daad324..4af18ca 100644
> --- a/include/standard-headers/asm-s390/kvm_virtio.h
> +++ b/include/standard-headers/asm-s390/kvm_virtio.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>  /*
>   * definition for virtio for kvm on s390
>   *
> diff --git a/include/standard-headers/asm-s390/virtio-ccw.h b/include/standard-headers/asm-s390/virtio-ccw.h
> index a9a4ebf..967aad3 100644
> --- a/include/standard-headers/asm-s390/virtio-ccw.h
> +++ b/include/standard-headers/asm-s390/virtio-ccw.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>  /*
>   * Definitions for virtio-ccw devices.
>   *

We intend to fix these ones. How about we skip the SPDX updates for now?

-- 
MST
