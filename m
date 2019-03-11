Received: from eggs.gnu.org ([209.51.188.92]:34621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3MMX-0004j8-M5
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3MJc-0000k1-2b
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:54:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h3MJb-0000jd-Ph
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:54:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id i16so5421740wrs.13
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 07:54:07 -0700 (PDT)
References: <20190309165740.0755B7480BD@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e514ff3c-4769-83bb-3640-a2320f9d5e3b@redhat.com>
Date: Mon, 11 Mar 2019 15:54:04 +0100
MIME-Version: 1.0
In-Reply-To: <20190309165740.0755B7480BD@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] isa: Add APM and ACPI dependencies for
 VT82C686
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 3/9/19 5:48 PM, BALATON Zoltan wrote:
> Compiling vt82c686.c fails without APM and ACPI_PM funtions. Add
> dependency on these in Kconfig to fix this.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/isa/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
> index 57e09a0cb8..e092da3fc3 100644
> --- a/hw/isa/Kconfig
> +++ b/hw/isa/Kconfig
> @@ -36,6 +36,8 @@ config VT82C686
>      select ACPI_SMBUS
>      select SERIAL_ISA
>      select FDC
> +    select APM

Correct, I missed this one.

> +    select ACPI_X86

NACK it does require ACPI but not X86.

ACPI_X86 is messy. I tried to fix VT82C686 in my "Kconfig MIPS" series,
but I might have to include this in my 'Kconfig PIIX' series.

>  
>  config SMC37C669
>      bool
> 
