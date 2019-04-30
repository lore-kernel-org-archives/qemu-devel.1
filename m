Received: from eggs.gnu.org ([209.51.188.92]:44714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLOE0-0002Rx-IU
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLODz-0007xq-FY
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:34:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLODz-0007xO-9A
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:34:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id o4so8022697wra.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 01:34:51 -0700 (PDT)
References: <20190430071405.16714-1-thuth@redhat.com>
	<20190430071405.16714-31-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <53e321c9-5ce9-14ef-9f55-b5ee1fa3f0e9@redhat.com>
Date: Tue, 30 Apr 2019 10:34:47 +0200
MIME-Version: 1.0
In-Reply-To: <20190430071405.16714-31-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 30/30] hw/arm: Remove hard-enablement of
 the remaining PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Paul Burton <pburton@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Rob Herring <robh@kernel.org>, qemu-block@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, Antony Pavlov <antonynpavlov@gmail.com>, Joel Stanley <joel@jms.id.au>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Philippe Mathieu-Daude <f4bug@amsat.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>

On 4/30/19 9:14 AM, Thomas Huth wrote:
> The PCI devices should be pulled in by default if PCI_DEVICES
> is set, so there is no need anymore to enforce them in the configs
> file.
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 233937f394..f23ecfd5c5 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -36,14 +36,6 @@ CONFIG_DIGIC=y
>  CONFIG_SABRELITE=y
>  CONFIG_EMCRAFT_SF2=y
>  CONFIG_MICROBIT=y
> -
> -CONFIG_VGA=y

OK for this one.

> -
>  CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
>  CONFIG_FSL_IMX6UL=y
> -
> -CONFIG_PCIE_PORT=y
> -CONFIG_XIO3130=y
> -CONFIG_IOH3420=y
> -CONFIG_I82801B11=y

Since I don't understand the extent of commit 4681867544f0, I'll let
David/Edgar/Alistair review it.

Regards,

Phil.
