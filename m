Received: from eggs.gnu.org ([2001:4830:134:3::10]:51829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSheO-0006Of-O4
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSheN-0000hN-R8
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:12:04 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSheN-0000hB-Kr
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:12:03 -0500
Received: by mail-oi1-x244.google.com with SMTP id a77so4522691oii.5
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 04:12:03 -0800 (PST)
MIME-Version: 1.0
References: <1542880825-2604-1-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1542880825-2604-1-git-send-email-liq3ea@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 12:11:51 +0000
Message-ID: <CAFEAcA96KgoQJHcqToKO43yEpiH50CW-_6zRU+BYDRpB82cJNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw: arm: musicpal: drop TYPE_WM8750 in
 object_property_set_link()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Jan Kiszka <jan.kiszka@web.de>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Thu, 22 Nov 2018 at 10:00, Li Qiang <liq3ea@gmail.com> wrote:
>
> The third argument of object_property_set_link() is the name of
> property, not related with the QOM type name, using the constant
> string instead.
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/arm/musicpal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index 9648b3af44..726ae29394 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1696,7 +1696,7 @@ static void musicpal_init(MachineState *machine)
>      dev = qdev_create(NULL, TYPE_MV88W8618_AUDIO);
>      s = SYS_BUS_DEVICE(dev);
>      object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
> -                             TYPE_WM8750, NULL);
> +                             "wm8750", NULL);
>      qdev_init_nofail(dev);
>      sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
>      sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
> --



Applied to target-arm.next for 4.0, thanks.

-- PMM
