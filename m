Received: from eggs.gnu.org ([209.51.188.92]:40948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk59M-0007d8-F8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk52w-00056m-60
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:37:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gk52v-00056R-TU
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:37:14 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-35-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d1c5781a-3bcf-6731-a301-4f7e5a42ca87@redhat.com>
Date: Thu, 17 Jan 2019 11:37:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-35-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 34/37] virtio: make virtio
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com

On 2019-01-15 15:11, Yang Zhong wrote:
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/i386-softmmu.mak  |  1 -
>  default-configs/s390x-softmmu.mak |  1 -
>  default-configs/virtio.mak        | 14 --------------
>  hw/9pfs/Kconfig                   |  2 ++
>  hw/block/Kconfig                  |  2 ++
>  hw/char/Kconfig                   |  2 ++
>  hw/display/Kconfig                |  5 +++++
>  hw/input/Kconfig                  |  2 ++
>  hw/net/Kconfig                    |  2 ++
>  hw/pci-host/Kconfig               |  2 ++
>  hw/scsi/Kconfig                   |  1 +
>  hw/virtio/Kconfig                 |  9 ++++++++-
>  12 files changed, 26 insertions(+), 17 deletions(-)
>  delete mode 100644 default-configs/virtio.mak

Reviewed-by: Thomas Huth <thuth@redhat.com>
