Received: from eggs.gnu.org ([209.51.188.92]:45695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3L4a-0006Gp-Tc
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3L4Z-00034c-Tn
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:34:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h3L4Z-00034D-Fh
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:34:31 -0400
References: <20190309165740.0755B7480BD@zero.eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <00541f7e-db59-8409-c728-db72181e1872@redhat.com>
Date: Mon, 11 Mar 2019 14:34:27 +0100
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
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org

On 09/03/19 17:48, BALATON Zoltan wrote:
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
> +    select ACPI_X86
>  
>  config SMC37C669
>      bool
> 

Queued, thanks.

Paolo
