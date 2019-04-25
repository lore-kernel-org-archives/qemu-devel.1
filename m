Received: from eggs.gnu.org ([209.51.188.92]:47818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJh22-0000Bp-Ik
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJh21-0008Je-Lt
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:15:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJh21-0008Iz-Fc
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:15:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so61283wmf.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:15:29 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-28-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ccb95efc-acda-6613-6056-08a08f107a9e@redhat.com>
Date: Thu, 25 Apr 2019 18:15:23 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-28-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 27/29] hw/arm: Express
 dependencies of the xlnx-versal-virt machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Rob Herring <robh@kernel.org>, qemu-block@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Dependencies have been determined with trial-and-error and by
> looking at the xlnx-versal.c source file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 32e4cc50e5..22be1e1231 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -291,6 +291,10 @@ config XLNX_ZYNQMP_ARM
>  
>  config XLNX_VERSAL
>      bool
> +    select ARM_GIC
> +    select PL011
> +    select CADENCE
> +    select VIRTIO_MMIO
>  
>  config FSL_IMX25
>      bool
> 
