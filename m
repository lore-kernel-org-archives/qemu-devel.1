Received: from eggs.gnu.org ([2001:4830:134:3::10]:44791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAYOX-0004VY-JC
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAYOS-0005Oc-GY
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:40:41 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:52577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAYOS-0005OK-7G
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:40:36 -0400
Received: by mail-wm1-f49.google.com with SMTP id 189-v6so8473478wmw.2
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 03:40:36 -0700 (PDT)
References: <20181011090007.1103-1-maozhongyi@cmss.chinamobile.com>
	<20181011090007.1103-3-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bb273664-7ca5-08a5-fe53-980c5b6944bb@redhat.com>
Date: Thu, 11 Oct 2018 12:40:33 +0200
MIME-Version: 1.0
In-Reply-To: <20181011090007.1103-3-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] audio: use TYPE_WM8750 instead of a
 hardcoded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@web.de>, Gerd Hoffmann <kraxel@redhat.com>

On 11/10/2018 11:00, Mao Zhongyi wrote:
> Cc: Jan Kiszka <jan.kiszka@web.de>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> To: qemu-arm@nongnu.org
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/musicpal.c          | 2 +-
>  hw/audio/marvell_88w8618.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index c807010e83..3dafb41b0b 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1695,7 +1695,7 @@ static void musicpal_init(MachineState *machine)
>      wm8750_dev = i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
>      dev = qdev_create(NULL, "mv88w8618_audio");
>      s = SYS_BUS_DEVICE(dev);
> -    qdev_prop_set_ptr(dev, "wm8750", wm8750_dev);
> +    qdev_prop_set_ptr(dev, TYPE_WM8750, wm8750_dev);
>      qdev_init_nofail(dev);
>      sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
>      sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
> diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
> index e546892d3c..cf6ce6979b 100644
> --- a/hw/audio/marvell_88w8618.c
> +++ b/hw/audio/marvell_88w8618.c
> @@ -280,7 +280,7 @@ static const VMStateDescription mv88w8618_audio_vmsd = {
>  };
>  
>  static Property mv88w8618_audio_properties[] = {
> -    DEFINE_PROP_PTR("wm8750", mv88w8618_audio_state, wm),
> +    DEFINE_PROP_PTR(TYPE_WM8750, mv88w8618_audio_state, wm),
>      {/* end of list */},
>  };
>  
> 
