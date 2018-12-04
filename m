Received: from eggs.gnu.org ([2001:4830:134:3::10]:50479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUBf2-0002Gq-33
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUBex-0002PD-9p
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:26:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gUBex-0002Om-3B
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:26:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so16149713wrt.7
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 06:26:47 -0800 (PST)
References: <20181204132952.2601-1-peter.maydell@linaro.org>
	<20181204132952.2601-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2ca111ab-6374-2a53-5290-e48d535939ae@redhat.com>
Date: Tue, 4 Dec 2018 15:26:42 +0100
MIME-Version: 1.0
In-Reply-To: <20181204132952.2601-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/5] hw/arm/mps2-tz.c: Free mscname string
 in make_dma()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 4/12/18 14:29, Peter Maydell wrote:
> The clang leak sanitizer spots a (one-off, trivial) memory
> leak in make_dma() due to a missing free.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/mps2-tz.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
> index 6dd02ae47e8..82b1d020a58 100644
> --- a/hw/arm/mps2-tz.c
> +++ b/hw/arm/mps2-tz.c
> @@ -322,6 +322,7 @@ static MemoryRegion *make_dma(MPS2TZMachineState *mms, void *opaque,
>      sysbus_connect_irq(s, 2, qdev_get_gpio_in_named(iotkitdev,
>                                                      "EXP_IRQ", 57 + i * 3));
>  
> +    g_free(mscname);
>      return sysbus_mmio_get_region(s, 0);
>  }
>  
> 
