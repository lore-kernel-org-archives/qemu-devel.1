Received: from eggs.gnu.org ([2001:4830:134:3::10]:43552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAu5m-0004CW-Hu
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAu5h-00005u-JQ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:50:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAu5h-00005M-BP
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:50:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id g15-v6so12726957wru.9
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 02:50:41 -0700 (PDT)
References: <20181012083008.29027-1-maozhongyi@cmss.chinamobile.com>
	<20181012083008.29027-2-maozhongyi@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c2cbdec4-02db-a171-13c2-d8083a0ef355@redhat.com>
Date: Fri, 12 Oct 2018 11:50:38 +0200
MIME-Version: 1.0
In-Reply-To: <20181012083008.29027-2-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] audio: use TYPE_WM8750 instead of a
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

On 12/10/2018 10:30, Mao Zhongyi wrote:
> Cc: Jan Kiszka <jan.kiszka@web.de>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> To: qemu-arm@nongnu.org

"To: qemu-arm@nongnu.org" is probably not relevant in the commit message.

The Linux kernel describes the 'Cc:' line in the "Submitting patches:
the essential guide to getting your code into the kernel" document as:

  If a person has had the opportunity to comment on a patch, but has not
  provided such comments, you may optionally add a Cc: tag to the patch.
  This is the only tag which might be added without an explicit action
  by the person it names - but it should indicate that this person was
  copied on the patch. This tag documents that potentially interested
  parties have been included in the discussion.

> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
