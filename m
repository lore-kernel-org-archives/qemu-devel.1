Received: from eggs.gnu.org ([2001:4830:134:3::10]:45858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAYTj-0005nj-5d
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAYTe-0002Er-AU
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:46:03 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:38306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAYTe-0002ET-33
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:45:58 -0400
Received: by mail-wm1-f47.google.com with SMTP id 193-v6so8842762wme.3
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 03:45:58 -0700 (PDT)
References: <20181011090007.1103-1-maozhongyi@cmss.chinamobile.com>
	<20181011090007.1103-5-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <997db16e-3da8-b66a-b29b-517674ae860f@redhat.com>
Date: Thu, 11 Oct 2018 12:45:54 +0200
MIME-Version: 1.0
In-Reply-To: <20181011090007.1103-5-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] audio: use existing macros istead of
 hardcoded strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@web.de>, Gerd Hoffmann <kraxel@redhat.com>

On 11/10/2018 11:00, Mao Zhongyi wrote:
> Cc: Jan Kiszka <jan.kiszka@web.de>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> To: qemu-arm@nongnu.org
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>  hw/arm/musicpal.c          | 16 ++++++++--------
>  hw/audio/marvell_88w8618.c |  3 +--
>  include/hw/audio/wm8750.h  |  1 +
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index ac266f9253..6425f1d50f 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -406,7 +406,7 @@ static void mv88w8618_eth_realize(DeviceState *dev, Error **errp)
>  }
>  
>  static const VMStateDescription mv88w8618_eth_vmsd = {
> -    .name = "mv88w8618_eth",
> +    .name = TYPE_MV88W8618_ETH,

I understand TYPE_device name might changed, but once used,
VMStateDescription shouldn't, else this would break migration.
Thus I wouldn't recommend using TYPE_name in VMStateDescription.name.

Since I'm not sure I cc'ed the migration maintainers.

>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
> @@ -645,7 +645,7 @@ static void musicpal_lcd_init(Object *obj)
>  }
>  
>  static const VMStateDescription musicpal_lcd_vmsd = {
> -    .name = "musicpal_lcd",
> +    .name = TYPE_MUSICPAL_LCD,
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
> @@ -771,7 +771,7 @@ static void mv88w8618_pic_init(Object *obj)
>  }
>  
>  static const VMStateDescription mv88w8618_pic_vmsd = {
> -    .name = "mv88w8618_pic",
> +    .name = TYPE_MV88W8618_PIC,
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
> @@ -951,7 +951,7 @@ static const VMStateDescription mv88w8618_timer_vmsd = {
>  };
>  
>  static const VMStateDescription mv88w8618_pit_vmsd = {
> -    .name = "mv88w8618_pit",
> +    .name = TYPE_MV88W8618_PIT,
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
> @@ -1038,7 +1038,7 @@ static void mv88w8618_flashcfg_init(Object *obj)
>  }
>  
>  static const VMStateDescription mv88w8618_flashcfg_vmsd = {
> -    .name = "mv88w8618_flashcfg",
> +    .name = TYPE_MV88W8618_FLASHCFG,
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
> @@ -1375,7 +1375,7 @@ static void musicpal_gpio_init(Object *obj)
>  }
>  
>  static const VMStateDescription musicpal_gpio_vmsd = {
> -    .name = "musicpal_gpio",
> +    .name = TYPE_MUSICPAL_GPIO,
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
> @@ -1539,7 +1539,7 @@ static void musicpal_key_init(Object *obj)
>  }
>  
>  static const VMStateDescription musicpal_key_vmsd = {
> -    .name = "musicpal_key",
> +    .name = TYPE_MUSICPAL_KEY,
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
> @@ -1693,7 +1693,7 @@ static void musicpal_init(MachineState *machine)
>      }
>  
>      wm8750_dev = i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
> -    dev = qdev_create(NULL, "mv88w8618_audio");
> +    dev = qdev_create(NULL, TYPE_MV88W8618_AUDIO);

This change is correct.

>      s = SYS_BUS_DEVICE(dev);
>      object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
>                               TYPE_WM8750, NULL);
> diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
> index baab4a3d53..dbdddf8ef4 100644
> --- a/hw/audio/marvell_88w8618.c
> +++ b/hw/audio/marvell_88w8618.c
> @@ -39,7 +39,6 @@
>  #define MP_AUDIO_CLOCK_24MHZ    (1 << 9)
>  #define MP_AUDIO_MONO           (1 << 14)
>  
> -#define TYPE_MV88W8618_AUDIO "mv88w8618_audio"
>  #define MV88W8618_AUDIO(obj) \
>      OBJECT_CHECK(mv88w8618_audio_state, (obj), TYPE_MV88W8618_AUDIO)
>  
> @@ -268,7 +267,7 @@ static void mv88w8618_audio_realize(DeviceState *dev, Error **errp)
>  }
>  
>  static const VMStateDescription mv88w8618_audio_vmsd = {
> -    .name = "mv88w8618_audio",
> +    .name = TYPE_MV88W8618_AUDIO,
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
> diff --git a/include/hw/audio/wm8750.h b/include/hw/audio/wm8750.h
> index 84e7a119bb..e12cb886d1 100644
> --- a/include/hw/audio/wm8750.h
> +++ b/include/hw/audio/wm8750.h
> @@ -17,6 +17,7 @@
>  #include "hw/hw.h"
>  
>  #define TYPE_WM8750 "wm8750"
> +#define TYPE_MV88W8618_AUDIO "mv88w8618_audio"
>  
>  typedef void data_req_cb(void *opaque, int free_out, int free_in);
>  
> 

Regards,

Phil.
