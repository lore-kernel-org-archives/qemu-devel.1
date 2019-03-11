Received: from eggs.gnu.org ([209.51.188.92]:47491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38mt-0006Va-PQ
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38mr-00012p-VJ
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:27:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h38mr-000123-OJ
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:27:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id j125so2622027wmj.1
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 17:27:25 -0700 (PDT)
References: <20190310235351.1863-1-philmd@redhat.com>
	<20190310235351.1863-2-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a85ce985-d763-4b2b-09eb-a4bc93d9f5f9@redhat.com>
Date: Mon, 11 Mar 2019 01:27:22 +0100
MIME-Version: 1.0
In-Reply-To: <20190310235351.1863-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/8] hw/i2c: The ACPI_SMBUS Kconfig depends
 on ACPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 3/11/19 12:53 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/i2c/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
> index ef1caa6d89..ec62909fa1 100644
> --- a/hw/i2c/Kconfig
> +++ b/hw/i2c/Kconfig
> @@ -17,6 +17,7 @@ config VERSATILE_I2C
>  config ACPI_SMBUS
>      bool
>      select I2C
> +    depends on ACPI

Please ignore this patch in this series, I incorrectly reordered it here
while rebasing, but it doesn't work without the next series "Kconfig:
Cleanup the ICH9 device". As it there is a circular dependency with
PC_ACPI.

>  
>  config BITBANG_I2C
>      bool
> 
