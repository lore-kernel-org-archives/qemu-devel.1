Received: from eggs.gnu.org ([2001:4830:134:3::10]:44065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAu8m-0005D3-R8
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAu8h-0001qo-PF
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:53:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAu8h-0001qS-I2
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:53:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id y140-v6so17665951wmd.0
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 02:53:47 -0700 (PDT)
References: <20181012083008.29027-1-maozhongyi@cmss.chinamobile.com>
	<20181012083008.29027-4-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <477885af-51fc-56a0-0ff0-0ce67d3fa123@redhat.com>
Date: Fri, 12 Oct 2018 11:53:45 +0200
MIME-Version: 1.0
In-Reply-To: <20181012083008.29027-4-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
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
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>

On 12/10/2018 10:30, Mao Zhongyi wrote:
> Cc: Jan Kiszka <jan.kiszka@web.de>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> To: qemu-arm@nongnu.org
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/musicpal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index ac266f9253..9648b3af44 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1693,7 +1693,7 @@ static void musicpal_init(MachineState *machine)
>      }
>  
>      wm8750_dev = i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
> -    dev = qdev_create(NULL, "mv88w8618_audio");
> +    dev = qdev_create(NULL, TYPE_MV88W8618_AUDIO);
>      s = SYS_BUS_DEVICE(dev);
>      object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
>                               TYPE_WM8750, NULL);
> 
