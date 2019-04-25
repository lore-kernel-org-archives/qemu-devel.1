Received: from eggs.gnu.org ([209.51.188.92]:60964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJmHj-0006Jp-Cb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJmHi-0004j3-Ba
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:52:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJmHi-0004hm-4c
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:52:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id b1so1469789wru.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 14:52:01 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-29-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c7f48b17-1a52-5c0e-bfd8-04eec2893fbc@redhat.com>
Date: Thu, 25 Apr 2019 23:51:57 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-29-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 28/29] hw/arm: Express
 dependencies of the musca machines with Kconfig
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
> looking at the musca.c source file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/Kconfig | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 22be1e1231..eca8387050 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -75,6 +75,12 @@ config MAINSTONE
>      select PFLASH_CFI01
>      select SMC91C111
>  
> +config MUSCA
> +    bool
> +    select ARMSSE
> +    select PL011
> +    select PL031
> +
>  config MUSICPAL
>      bool
>      select BITBANG_I2C
> @@ -423,6 +429,3 @@ config ARMSSE_CPUID
>  
>  config ARMSSE_MHU
>      bool
> -
> -config MUSCA
> -    bool
> 
