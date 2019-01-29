Received: from eggs.gnu.org ([209.51.188.92]:51856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goV1m-0004xM-2J
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goV1a-0006Rc-Tl
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:10:12 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goV1Z-0006O1-5M
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:10:06 -0500
Received: by mail-ot1-x341.google.com with SMTP id n8so18130536otl.6
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 07:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20190125155630.17430-1-sourav.jb1988@gmail.com>
In-Reply-To: <20190125155630.17430-1-sourav.jb1988@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 15:09:34 +0000
Message-ID: <CAFEAcA-E=-6H340nhA258GkCbM2YC4=CxCRsBicanKJtEc7SXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/nrf51_soc: set object owner in
 memory_region_init_ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kumar sourav <sourav.jb1988@gmail.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Fri, 25 Jan 2019 at 15:56, kumar sourav <sourav.jb1988@gmail.com> wrote:
>
> set object owner in memory_region_init_ram() instead
> of NULL.
>
> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
> ---
>  hw/arm/nrf51_soc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index 1630c27594..3a1c7e200c 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -89,7 +89,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
>      }
>      memory_region_add_subregion(&s->container, NRF51_FLASH_BASE, &s->flash);
>
> -    memory_region_init_ram(&s->sram, NULL, "nrf51.sram", s->sram_size, &err);
> +    memory_region_init_ram(&s->sram, OBJECT(s), "nrf51.sram", s->sram_size,
> +                           &err);
>      if (err) {
>          error_propagate(errp, err);
>          return;


Applied to target-arm.next, thanks.

-- PMM
