Received: from eggs.gnu.org ([2001:4830:134:3::10]:53074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVs96-0008If-PJ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVs95-0002cR-PQ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:24:04 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-19-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d525140c-f99d-f7c3-916a-8b6c9f1453df@amsat.org>
Date: Fri, 14 Jul 2017 01:23:55 -0300
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-19-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 18/29] piix: use
 DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>

On 07/13/2017 01:32 PM, Marc-André Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/pci-host/piix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index a2c1033dbe..3745b56c8e 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -140,7 +140,7 @@ static void i440fx_update_memory_mappings(PCII440FXState *d)
>       memory_region_transaction_begin();
>       for (i = 0; i < 13; i++) {
>           pam_update(&d->pam_regions[i], i,
> -                   pd->config[I440FX_PAM + ((i + 1) / 2)]);
> +                   pd->config[I440FX_PAM + (DIV_ROUND_UP(i, 2))]);
>       }
>       memory_region_set_enabled(&d->smram_region,
>                                 !(pd->config[I440FX_SMRAM] & SMRAM_D_OPEN));
> 
