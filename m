Received: from eggs.gnu.org ([2001:4830:134:3::10]:45033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAuDV-0008IO-C3
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAuDQ-0005Ah-HR
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:58:45 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:55545)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAuDP-00057k-Tn
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:58:40 -0400
References: <20181012083008.29027-1-maozhongyi@cmss.chinamobile.com>
	<20181012083008.29027-4-maozhongyi@cmss.chinamobile.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <209c0825-0218-d783-0d28-9a4d88873b0e@cmss.chinamobile.com>
Date: Fri, 12 Oct 2018 17:58:29 +0800
MIME-Version: 1.0
In-Reply-To: <20181012083008.29027-4-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] audio: use TYPE_MV88W8618_AUDIO
 instead of hardcoded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@web.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Sorry for the noise, there is something wrong with this patch,
I will fix it and resend this patchset.

Thanks,
Mao

On 10/12/18 4:30 PM, Mao Zhongyi wrote:
> Cc: Jan Kiszka <jan.kiszka@web.de>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> To: qemu-arm@nongnu.org
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>   hw/arm/musicpal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index ac266f9253..9648b3af44 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1693,7 +1693,7 @@ static void musicpal_init(MachineState *machine)
>       }
>   
>       wm8750_dev = i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
> -    dev = qdev_create(NULL, "mv88w8618_audio");
> +    dev = qdev_create(NULL, TYPE_MV88W8618_AUDIO);
>       s = SYS_BUS_DEVICE(dev);
>       object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
>                                TYPE_WM8750, NULL);
> 
