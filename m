Received: from eggs.gnu.org ([209.51.188.92]:36821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk4rp-0005PR-6N
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk4rn-00046e-Tv
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:25:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gk4rn-00044o-GP
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:25:43 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-29-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <90e7b6ea-079b-929d-2839-9ef900467229@redhat.com>
Date: Thu, 17 Jan 2019 11:25:39 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-29-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 28/37] isa: express dependencies
 with kconfig
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

On 2019-01-15 15:10, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/i386-softmmu.mak | 10 ----------
>  hw/audio/Kconfig                 |  2 ++
>  hw/block/Kconfig                 |  2 ++
>  hw/char/Kconfig                  |  6 ++++++
>  hw/display/Kconfig               |  6 ++++++
>  hw/i386/Kconfig                  |  1 +
>  hw/ide/Kconfig                   |  1 +
>  hw/input/Kconfig                 |  2 ++
>  hw/isa/Kconfig                   |  5 +++++
>  hw/misc/Kconfig                  |  4 ++++
>  hw/net/Kconfig                   |  3 +++
>  hw/watchdog/Kconfig              |  2 ++
>  12 files changed, 34 insertions(+), 10 deletions(-)
[...]
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 5e73277cc2..a53ca4601a 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -9,6 +9,9 @@ config ADS7846
>  
>  config VGA_CIRRUS
>      bool
> +    default y
> +    depends on PCI
> +    select VGA

This hunk should likely rather be part of the pci.mak patch?

Apart from that, the patch here looks fine to me.

 Thomas
