Received: from eggs.gnu.org ([209.51.188.92]:44835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmeUF-0002xH-8Y
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmeUE-0002R0-H5
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:52:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmeUE-0002QU-8g
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:52:02 -0500
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-42-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fa45d1f5-4bc4-827a-321d-7df073c97861@redhat.com>
Date: Thu, 24 Jan 2019 13:51:58 +0100
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-42-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v4 41/44] virtio: make virtio
 dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com

On 2019-01-23 07:56, Yang Zhong wrote:
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/i386-softmmu.mak  |  1 -
>  default-configs/s390x-softmmu.mak |  1 -
>  default-configs/virtio.mak        | 15 ---------------
>  hw/9pfs/Kconfig                   |  2 ++
>  hw/block/Kconfig                  |  2 ++
>  hw/char/Kconfig                   |  2 ++
>  hw/display/Kconfig                |  5 +++++
>  hw/input/Kconfig                  |  2 ++
>  hw/net/Kconfig                    |  2 ++
>  hw/pci-host/Kconfig               |  2 ++
>  hw/scsi/Kconfig                   |  1 +
>  hw/virtio/Kconfig                 |  9 ++++++++-
>  12 files changed, 26 insertions(+), 18 deletions(-)
>  delete mode 100644 default-configs/virtio.mak

This breaks compilation of aarch64 / arm as long as these targets are
not fully converted yet:

Exception: contradiction between clauses when setting VIRTIO_MMIO
make: *** No rule to make target `aarch64-softmmu/config-devices.mak',
needed by `config-all-devices.mak'.  Stop.

I think you temporarily have not to set CONFIG_VIRTIO=3Dy in
default-configs/arm-softmmu.mak (and likely also in the riscv and s390x
configs), until they are finally converted completely?

 Thomas
