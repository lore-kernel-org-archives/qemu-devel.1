Received: from eggs.gnu.org ([2001:4830:134:3::10]:59873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBQfI-0008A6-56
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBQfE-0003UQ-62
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:37:36 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:33103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBQfD-0003Tu-Ac
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 16:37:32 -0400
Received: by mail-wr1-x430.google.com with SMTP id e4-v6so16934276wrs.0
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 13:37:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181013060809.52496-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3356400f-c16e-5174-dcfd-c0bd2f203638@amsat.org>
Date: Sat, 13 Oct 2018 22:37:27 +0200
MIME-Version: 1.0
In-Reply-To: <20181013060809.52496-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw: AC97: make it more QOMconventional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, kraxel@redhat.com
Cc: qemu-devel@nongnu.org

On 10/13/18 8:08 AM, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/audio/ac97.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> index 337402e9c6..d799533aa9 100644
> --- a/hw/audio/ac97.c
> +++ b/hw/audio/ac97.c
> @@ -123,6 +123,10 @@ enum {
>  
>  #define MUTE_SHIFT 15
>  
> +#define TYPE_AC97 "AC97"
> +#define AC97(obj) \
> +    OBJECT_CHECK(AC97LinkState, (obj), TYPE_AC97)
> +
>  #define REC_MASK 7
>  enum {
>      REC_MIC = 0,
> @@ -1340,7 +1344,7 @@ static void ac97_on_reset (DeviceState *dev)
>  
>  static void ac97_realize(PCIDevice *dev, Error **errp)
>  {
> -    AC97LinkState *s = DO_UPCAST (AC97LinkState, dev, dev);
> +    AC97LinkState *s = AC97(dev);
>      uint8_t *c = s->dev.config;
>  
>      /* TODO: no need to override */
> @@ -1389,7 +1393,7 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
>  
>  static void ac97_exit(PCIDevice *dev)
>  {
> -    AC97LinkState *s = DO_UPCAST(AC97LinkState, dev, dev);
> +    AC97LinkState *s = AC97(dev);
>  
>      AUD_close_in(&s->card, s->voice_pi);
>      AUD_close_out(&s->card, s->voice_po);
> @@ -1399,7 +1403,7 @@ static void ac97_exit(PCIDevice *dev)
>  
>  static int ac97_init (PCIBus *bus)
>  {
> -    pci_create_simple (bus, -1, "AC97");
> +    pci_create_simple(bus, -1, TYPE_AC97);
>      return 0;
>  }
>  
> @@ -1427,7 +1431,7 @@ static void ac97_class_init (ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo ac97_info = {
> -    .name          = "AC97",
> +    .name          = TYPE_AC97,
>      .parent        = TYPE_PCI_DEVICE,
>      .instance_size = sizeof (AC97LinkState),
>      .class_init    = ac97_class_init,
> 
