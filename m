Received: from eggs.gnu.org ([209.51.188.92]:47874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gp7n0-0003V9-Vx
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gp7n0-0000p3-8k
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:33:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gp7n0-0000on-15
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:33:38 -0500
References: <20190131073234.18037-1-yang.zhong@intel.com>
	<20190131073234.18037-5-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3ef979e7-9bc4-8c5a-9592-7be17e30e187@redhat.com>
Date: Thu, 31 Jan 2019 09:33:33 +0100
MIME-Version: 1.0
In-Reply-To: <20190131073234.18037-5-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 04/27] hw/pci-host/Makefile.objs: make
 CONFIGS clear for PCI EXPRESS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>

On 2019-01-31 08:32, Yang Zhong wrote:
> Change the CONFIGs for PCI EXPRESS and make module name more
> clear for code files.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/arm-softmmu.mak      | 4 ++--
>  default-configs/i386-softmmu.mak     | 2 +-
>  default-configs/mips64el-softmmu.mak | 2 +-
>  default-configs/pci.mak              | 2 +-
>  default-configs/riscv32-softmmu.mak  | 2 +-
>  default-configs/riscv64-softmmu.mak  | 2 +-
>  hw/net/Makefile.objs                 | 4 ++--
>  hw/pci-host/Makefile.objs            | 8 ++++----
>  8 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
