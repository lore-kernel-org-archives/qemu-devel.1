Received: from eggs.gnu.org ([2001:4830:134:3::10]:46547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDtoa-0006PT-SR
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDtoU-00084h-5y
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:32:36 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:34136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dDtoT-00084C-F0
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:32:30 -0400
Received: by mail-lf0-x243.google.com with SMTP id q24so13536515lfb.1
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 07:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <1495198042-124203-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495198042-124203-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495198042-124203-3-git-send-email-anton.nefedov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 25 May 2017 14:32:17 +0000
Message-ID: <CAJ+F1C+WpTWc4EFQJ4U8VBn2AL4Pc3Rj9j=U65Cxzkr6EdZxSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/9] char: add backend hotswap handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com

On Fri, May 19, 2017 at 4:51 PM Anton Nefedov <anton.nefedov@virtuozzo.com>
wrote:

> Frontends should have an interface to setup the handler of a backend
> change.
> The interface will be used in the next commits
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  backends/rng-egd.c          |  2 +-
>  chardev/char-mux.c          |  1 +
>  chardev/char.c              |  4 +++-
>  gdbstub.c                   |  2 +-
>  hw/arm/pxa2xx.c             |  3 ++-
>  hw/arm/strongarm.c          |  2 +-
>  hw/char/bcm2835_aux.c       |  2 +-
>  hw/char/cadence_uart.c      |  2 +-
>  hw/char/debugcon.c          |  2 +-
>  hw/char/digic-uart.c        |  2 +-
>  hw/char/escc.c              |  2 +-
>  hw/char/etraxfs_ser.c       |  2 +-
>  hw/char/exynos4210_uart.c   |  2 +-
>  hw/char/grlib_apbuart.c     |  2 +-
>  hw/char/imx_serial.c        |  2 +-
>  hw/char/ipoctal232.c        |  2 +-
>  hw/char/lm32_juart.c        |  2 +-
>  hw/char/lm32_uart.c         |  2 +-
>  hw/char/mcf_uart.c          |  2 +-
>  hw/char/milkymist-uart.c    |  2 +-
>  hw/char/pl011.c             |  2 +-
>  hw/char/sclpconsole-lm.c    |  2 +-
>  hw/char/sclpconsole.c       |  2 +-
>  hw/char/serial.c            |  2 +-
>  hw/char/sh_serial.c         |  2 +-
>  hw/char/spapr_vty.c         |  2 +-
>  hw/char/stm32f2xx_usart.c   |  3 ++-
>  hw/char/terminal3270.c      |  2 +-
>  hw/char/virtio-console.c    |  4 ++--
>  hw/char/xen_console.c       |  2 +-
>  hw/char/xilinx_uartlite.c   |  2 +-
>  hw/ipmi/ipmi_bmc_extern.c   |  2 +-
>  hw/mips/boston.c            |  2 +-
>  hw/mips/mips_malta.c        |  2 +-
>  hw/misc/ivshmem.c           |  2 +-
>  hw/usb/ccid-card-passthru.c |  2 +-
>  hw/usb/dev-serial.c         |  2 +-
>  hw/usb/redirect.c           |  2 +-
>  include/sysemu/char.h       |  5 +++++
>  monitor.c                   |  4 ++--
>  net/colo-compare.c          | 14 ++++++++------
>  net/filter-mirror.c         |  6 +++---
>  net/slirp.c                 |  2 +-
>  net/vhost-user.c            |  7 ++++---
>  qtest.c                     |  2 +-
>  tests/test-char.c           | 14 ++++++++++----
>  tests/vhost-user-test.c     |  2 +-
>  47 files changed, 78 insertions(+), 59 deletions(-)
>
> diff --git a/backends/rng-egd.c b/backends/rng-egd.c
> index 380b19a..0b0e945 100644
> --- a/backends/rng-egd.c
> +++ b/backends/rng-egd.c
> @@ -106,7 +106,7 @@ static void rng_egd_opened(RngBackend *b, Error **err=
p)
>
>      /* FIXME we should resubmit pending requests when the CDS reconnects=
.
> */
>      qemu_chr_fe_set_handlers(&s->chr, rng_egd_chr_can_read,
> -                             rng_egd_chr_read, NULL, s, NULL, true);
> +                             rng_egd_chr_read, NULL, NULL, s, NULL, true=
);
>  }
>
>  static void rng_egd_set_chardev(Object *obj, const char *value, Error
> **errp)
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index 37d42c6..5849ea5 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -278,6 +278,7 @@ void mux_chr_set_handlers(Chardev *chr, GMainContext
> *context)
>                               mux_chr_can_read,
>                               mux_chr_read,
>                               mux_chr_event,
> +                             NULL,
>                               chr,
>                               context, true);
>  }
> diff --git a/chardev/char.c b/chardev/char.c
> index 684cccd..ae60950 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -522,7 +522,7 @@ void qemu_chr_fe_deinit(CharBackend *b)
>      assert(b);
>
>      if (b->chr) {
> -        qemu_chr_fe_set_handlers(b, NULL, NULL, NULL, NULL, NULL, true);
> +        qemu_chr_fe_set_handlers(b, NULL, NULL, NULL, NULL, NULL, NULL,
> true);
>          if (b->chr->be =3D=3D b) {
>              b->chr->be =3D NULL;
>          }
> @@ -538,6 +538,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>                                IOCanReadHandler *fd_can_read,
>                                IOReadHandler *fd_read,
>                                IOEventHandler *fd_event,
> +                              BackendChangeHandler *be_change,
>                                void *opaque,
>                                GMainContext *context,
>                                bool set_open)
> @@ -561,6 +562,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>      b->chr_can_read =3D fd_can_read;
>      b->chr_read =3D fd_read;
>      b->chr_event =3D fd_event;
> +    b->chr_be_change =3D be_change;
>      b->opaque =3D opaque;
>      if (cc->chr_update_read_handler) {
>          cc->chr_update_read_handler(s, context);
> diff --git a/gdbstub.c b/gdbstub.c
> index 86eed4f..1ac0489 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2013,7 +2013,7 @@ int gdbserver_start(const char *device)
>      if (chr) {
>          qemu_chr_fe_init(&s->chr, chr, &error_abort);
>          qemu_chr_fe_set_handlers(&s->chr, gdb_chr_can_receive,
> gdb_chr_receive,
> -                                 gdb_chr_event, NULL, NULL, true);
> +                                 gdb_chr_event, NULL, NULL, NULL, true);
>      }
>      s->state =3D chr ? RS_IDLE : RS_INACTIVE;
>      s->mon_chr =3D mon_chr;
> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> index eea551d..3e51882 100644
> --- a/hw/arm/pxa2xx.c
> +++ b/hw/arm/pxa2xx.c
> @@ -1970,7 +1970,8 @@ static void pxa2xx_fir_realize(DeviceState *dev,
> Error **errp)
>      PXA2xxFIrState *s =3D PXA2XX_FIR(dev);
>
>      qemu_chr_fe_set_handlers(&s->chr, pxa2xx_fir_is_empty,
> -                             pxa2xx_fir_rx, pxa2xx_fir_event, s, NULL,
> true);
> +                             pxa2xx_fir_rx, pxa2xx_fir_event, NULL, s,
> NULL,
> +                             true);
>  }
>
>  static bool pxa2xx_fir_vmstate_validate(void *opaque, int version_id)
> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index 3311cc3..bec093d 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -1246,7 +1246,7 @@ static void strongarm_uart_realize(DeviceState *dev=
,
> Error **errp)
>                               strongarm_uart_can_receive,
>                               strongarm_uart_receive,
>                               strongarm_uart_event,
> -                             s, NULL, true);
> +                             NULL, s, NULL, true);
>  }
>
>  static void strongarm_uart_reset(DeviceState *dev)
> diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
> index 4d46ad6..370dc7e 100644
> --- a/hw/char/bcm2835_aux.c
> +++ b/hw/char/bcm2835_aux.c
> @@ -279,7 +279,7 @@ static void bcm2835_aux_realize(DeviceState *dev,
> Error **errp)
>      BCM2835AuxState *s =3D BCM2835_AUX(dev);
>
>      qemu_chr_fe_set_handlers(&s->chr, bcm2835_aux_can_receive,
> -                             bcm2835_aux_receive, NULL, s, NULL, true);
> +                             bcm2835_aux_receive, NULL, NULL, s, NULL,
> true);
>  }
>
>  static Property bcm2835_aux_props[] =3D {
> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> index 4dcee57..71867b3 100644
> --- a/hw/char/cadence_uart.c
> +++ b/hw/char/cadence_uart.c
> @@ -484,7 +484,7 @@ static void cadence_uart_realize(DeviceState *dev,
> Error **errp)
>                                            fifo_trigger_update, s);
>
>      qemu_chr_fe_set_handlers(&s->chr, uart_can_receive, uart_receive,
> -                             uart_event, s, NULL, true);
> +                             uart_event, NULL, s, NULL, true);
>  }
>
>  static void cadence_uart_init(Object *obj)
> diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
> index 80dce07..6d95297 100644
> --- a/hw/char/debugcon.c
> +++ b/hw/char/debugcon.c
> @@ -92,7 +92,7 @@ static void debugcon_realize_core(DebugconState *s,
> Error **errp)
>          return;
>      }
>
> -    qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, s, NULL, true);
> +    qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL, s, NULL,
> true);
>  }
>
>  static void debugcon_isa_realizefn(DeviceState *dev, Error **errp)
> diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
> index 029f5bb..2d373dc 100644
> --- a/hw/char/digic-uart.c
> +++ b/hw/char/digic-uart.c
> @@ -146,7 +146,7 @@ static void digic_uart_realize(DeviceState *dev, Erro=
r
> **errp)
>      DigicUartState *s =3D DIGIC_UART(dev);
>
>      qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx,
> -                             uart_event, s, NULL, true);
> +                             uart_event, NULL, s, NULL, true);
>  }
>
>  static void digic_uart_init(Object *obj)
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index 9228091..aa882b6 100644
> --- a/hw/char/escc.c
> +++ b/hw/char/escc.c
> @@ -1015,7 +1015,7 @@ static void escc_realize(DeviceState *dev, Error
> **errp)
>          if (qemu_chr_fe_get_driver(&s->chn[i].chr)) {
>              s->chn[i].clock =3D s->frequency / 2;
>              qemu_chr_fe_set_handlers(&s->chn[i].chr, serial_can_receive,
> -                                     serial_receive1, serial_event,
> +                                     serial_receive1, serial_event, NULL=
,
>                                       &s->chn[i], NULL, true);
>          }
>      }
> diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
> index 5438387..4abd382 100644
> --- a/hw/char/etraxfs_ser.c
> +++ b/hw/char/etraxfs_ser.c
> @@ -233,7 +233,7 @@ static void etraxfs_ser_realize(DeviceState *dev,
> Error **errp)
>
>      qemu_chr_fe_set_handlers(&s->chr,
>                               serial_can_receive, serial_receive,
> -                             serial_event, s, NULL, true);
> +                             serial_event, NULL, s, NULL, true);
>  }
>
>  static void etraxfs_ser_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
> index bff706a..7ef4ea5 100644
> --- a/hw/char/exynos4210_uart.c
> +++ b/hw/char/exynos4210_uart.c
> @@ -644,7 +644,7 @@ static void exynos4210_uart_realize(DeviceState *dev,
> Error **errp)
>
>      qemu_chr_fe_set_handlers(&s->chr, exynos4210_uart_can_receive,
>                               exynos4210_uart_receive,
> exynos4210_uart_event,
> -                             s, NULL, true);
> +                             NULL, s, NULL, true);
>  }
>
>  static Property exynos4210_uart_properties[] =3D {
> diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
> index db686e6..610a317 100644
> --- a/hw/char/grlib_apbuart.c
> +++ b/hw/char/grlib_apbuart.c
> @@ -247,7 +247,7 @@ static int grlib_apbuart_init(SysBusDevice *dev)
>                               grlib_apbuart_can_receive,
>                               grlib_apbuart_receive,
>                               grlib_apbuart_event,
> -                             uart, NULL, true);
> +                             NULL, uart, NULL, true);
>
>      sysbus_init_irq(dev, &uart->irq);
>
> diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
> index 52e67f8..b66396f 100644
> --- a/hw/char/imx_serial.c
> +++ b/hw/char/imx_serial.c
> @@ -316,7 +316,7 @@ static void imx_serial_realize(DeviceState *dev, Erro=
r
> **errp)
>      DPRINTF("char dev for uart: %p\n", qemu_chr_fe_get_driver(&s->chr));
>
>      qemu_chr_fe_set_handlers(&s->chr, imx_can_receive, imx_receive,
> -                             imx_event, s, NULL, true);
> +                             imx_event, NULL, s, NULL, true);
>  }
>
>  static void imx_serial_init(Object *obj)
> diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
> index 93929c2..734e42c 100644
> --- a/hw/char/ipoctal232.c
> +++ b/hw/char/ipoctal232.c
> @@ -545,7 +545,7 @@ static void ipoctal_realize(DeviceState *dev, Error
> **errp)
>          if (qemu_chr_fe_get_driver(&ch->dev)) {
>              qemu_chr_fe_set_handlers(&ch->dev, hostdev_can_receive,
>                                       hostdev_receive, hostdev_event,
> -                                     ch, NULL, true);
> +                                     NULL, ch, NULL, true);
>              DPRINTF("Redirecting channel %u to %s\n", i, ch->dev->label)=
;
>          } else {
>              DPRINTF("Could not redirect channel %u, no chardev set\n", i=
);
> diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
> index f8c1e0d..b3a5351 100644
> --- a/hw/char/lm32_juart.c
> +++ b/hw/char/lm32_juart.c
> @@ -119,7 +119,7 @@ static void lm32_juart_realize(DeviceState *dev, Erro=
r
> **errp)
>      LM32JuartState *s =3D LM32_JUART(dev);
>
>      qemu_chr_fe_set_handlers(&s->chr, juart_can_rx, juart_rx,
> -                             juart_event, s, NULL, true);
> +                             juart_event, NULL, s, NULL, true);
>  }
>
>  static const VMStateDescription vmstate_lm32_juart =3D {
> diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
> index 7f3597c..3a6dbf8 100644
> --- a/hw/char/lm32_uart.c
> +++ b/hw/char/lm32_uart.c
> @@ -266,7 +266,7 @@ static void lm32_uart_realize(DeviceState *dev, Error
> **errp)
>      LM32UartState *s =3D LM32_UART(dev);
>
>      qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx,
> -                             uart_event, s, NULL, true);
> +                             uart_event, NULL, s, NULL, true);
>  }
>
>  static const VMStateDescription vmstate_lm32_uart =3D {
> diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
> index e69672f..7f3cd5a 100644
> --- a/hw/char/mcf_uart.c
> +++ b/hw/char/mcf_uart.c
> @@ -305,7 +305,7 @@ static void mcf_uart_realize(DeviceState *dev, Error
> **errp)
>      mcf_uart_state *s =3D MCF_UART(dev);
>
>      qemu_chr_fe_set_handlers(&s->chr, mcf_uart_can_receive,
> mcf_uart_receive,
> -                             mcf_uart_event, s, NULL, true);
> +                             mcf_uart_event, NULL, s, NULL, true);
>  }
>
>  static Property mcf_uart_properties[] =3D {
> diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
> index ae8e2f3..523959a 100644
> --- a/hw/char/milkymist-uart.c
> +++ b/hw/char/milkymist-uart.c
> @@ -199,7 +199,7 @@ static void milkymist_uart_realize(DeviceState *dev,
> Error **errp)
>      MilkymistUartState *s =3D MILKYMIST_UART(dev);
>
>      qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx,
> -                             uart_event, s, NULL, true);
> +                             uart_event, NULL, s, NULL, true);
>  }
>
>  static void milkymist_uart_init(Object *obj)
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 24ea973..c38f60a 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -329,7 +329,7 @@ static void pl011_realize(DeviceState *dev, Error
> **errp)
>      PL011State *s =3D PL011(dev);
>
>      qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive,
> -                             pl011_event, s, NULL, true);
> +                             pl011_event, NULL, s, NULL, true);
>  }
>
>  static void pl011_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
> index 07d6ebd..ed1e2c5 100644
> --- a/hw/char/sclpconsole-lm.c
> +++ b/hw/char/sclpconsole-lm.c
> @@ -313,7 +313,7 @@ static int console_init(SCLPEvent *event)
>      console_available =3D true;
>
>      qemu_chr_fe_set_handlers(&scon->chr, chr_can_read,
> -                             chr_read, NULL, scon, NULL, true);
> +                             chr_read, NULL, NULL, scon, NULL, true);
>
>      return 0;
>  }
> diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
> index b78f240..9a65010 100644
> --- a/hw/char/sclpconsole.c
> +++ b/hw/char/sclpconsole.c
> @@ -228,7 +228,7 @@ static int console_init(SCLPEvent *event)
>      }
>      console_available =3D true;
>      qemu_chr_fe_set_handlers(&scon->chr, chr_can_read,
> -                             chr_read, NULL, scon, NULL, true);
> +                             chr_read, NULL, NULL, scon, NULL, true);
>
>      return 0;
>  }
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 03d890c..d8d34d0 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -897,7 +897,7 @@ void serial_realize_core(SerialState *s, Error **errp=
)
>      qemu_register_reset(serial_reset, s);
>
>      qemu_chr_fe_set_handlers(&s->chr, serial_can_receive1,
> serial_receive1,
> -                             serial_event, s, NULL, true);
> +                             serial_event, NULL, s, NULL, true);
>      fifo8_create(&s->recv_fifo, UART_FIFO_LENGTH);
>      fifo8_create(&s->xmit_fifo, UART_FIFO_LENGTH);
>      serial_reset(s);
> diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
> index 303eb0a..c352337 100644
> --- a/hw/char/sh_serial.c
> +++ b/hw/char/sh_serial.c
> @@ -400,7 +400,7 @@ void sh_serial_init(MemoryRegion *sysmem,
>          qemu_chr_fe_init(&s->chr, chr, &error_abort);
>          qemu_chr_fe_set_handlers(&s->chr, sh_serial_can_receive1,
>                                   sh_serial_receive1,
> -                                 sh_serial_event, s, NULL, true);
> +                                 sh_serial_event, NULL, s, NULL, true);
>      }
>
>      s->eri =3D eri_source;
> diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
> index e30c8da..9cdc0e0 100644
> --- a/hw/char/spapr_vty.c
> +++ b/hw/char/spapr_vty.c
> @@ -84,7 +84,7 @@ static void spapr_vty_realize(VIOsPAPRDevice *sdev,
> Error **errp)
>      }
>
>      qemu_chr_fe_set_handlers(&dev->chardev, vty_can_receive,
> -                             vty_receive, NULL, dev, NULL, true);
> +                             vty_receive, NULL, NULL, dev, NULL, true);
>  }
>
>  /* Forward declaration */
> diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
> index 59872e6..268e435 100644
> --- a/hw/char/stm32f2xx_usart.c
> +++ b/hw/char/stm32f2xx_usart.c
> @@ -207,7 +207,8 @@ static void stm32f2xx_usart_realize(DeviceState *dev,
> Error **errp)
>      STM32F2XXUsartState *s =3D STM32F2XX_USART(dev);
>
>      qemu_chr_fe_set_handlers(&s->chr, stm32f2xx_usart_can_receive,
> -                             stm32f2xx_usart_receive, NULL, s, NULL,
> true);
> +                             stm32f2xx_usart_receive, NULL, NULL,
> +                             s, NULL, true);
>  }
>
>  static void stm32f2xx_usart_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
> index b2dda01..943a0f3 100644
> --- a/hw/char/terminal3270.c
> +++ b/hw/char/terminal3270.c
> @@ -179,7 +179,7 @@ static void terminal_init(EmulatedCcw3270Device *dev,
> Error **errp)
>      }
>      terminal_available =3D true;
>      qemu_chr_fe_set_handlers(&t->chr, terminal_can_read,
> -                             terminal_read, chr_event, t, NULL, true);
> +                             terminal_read, chr_event, NULL, t, NULL,
> true);
>  }
>
>  static int read_payload_3270(EmulatedCcw3270Device *dev, uint32_t cda,
> diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
> index 798d9b6..cf7331d 100644
> --- a/hw/char/virtio-console.c
> +++ b/hw/char/virtio-console.c
> @@ -188,11 +188,11 @@ static void virtconsole_realize(DeviceState *dev,
> Error **errp)
>           */
>          if (k->is_console) {
>              qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
> -                                     NULL, vcon, NULL, true);
> +                                     NULL, NULL, vcon, NULL, true);
>              virtio_serial_open(port);
>          } else {
>              qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
> -                                     chr_event, vcon, NULL, false);
> +                                     chr_event, NULL, vcon, NULL, false)=
;
>          }
>      }
>  }
> diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
> index c01f410..cb7975f 100644
> --- a/hw/char/xen_console.c
> +++ b/hw/char/xen_console.c
> @@ -246,7 +246,7 @@ static int con_initialise(struct XenDevice *xendev)
>
>      xen_be_bind_evtchn(&con->xendev);
>      qemu_chr_fe_set_handlers(&con->chr, xencons_can_receive,
> -                             xencons_receive, NULL, con, NULL, true);
> +                             xencons_receive, NULL, NULL, con, NULL,
> true);
>
>      xen_pv_printf(xendev, 1,
>                    "ring mfn %d, remote port %d, local port %d, limit
> %zd\n",
> diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
> index 37d313b..2568302 100644
> --- a/hw/char/xilinx_uartlite.c
> +++ b/hw/char/xilinx_uartlite.c
> @@ -212,7 +212,7 @@ static void xilinx_uartlite_realize(DeviceState *dev,
> Error **errp)
>      XilinxUARTLite *s =3D XILINX_UARTLITE(dev);
>
>      qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx,
> -                             uart_event, s, NULL, true);
> +                             uart_event, NULL, s, NULL, true);
>  }
>
>  static void xilinx_uartlite_init(Object *obj)
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index e8e3d25..6f2339d 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -453,7 +453,7 @@ static void ipmi_bmc_extern_realize(DeviceState *dev,
> Error **errp)
>      }
>
>      qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
> -                             chr_event, ibe, NULL, true);
> +                             chr_event, NULL, ibe, NULL, true);
>  }
>
>  static int ipmi_bmc_extern_post_migrate(void *opaque, int version_id)
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index 83f7b82..a57c860 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -533,7 +533,7 @@ static void boston_mach_init(MachineState *machine)
>      chr =3D qemu_chr_new("lcd", "vc:320x240");
>      qemu_chr_fe_init(&s->lcd_display, chr, NULL);
>      qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
> -                             boston_lcd_event, s, NULL, true);
> +                             boston_lcd_event, NULL, s, NULL, true);
>
>      ahci =3D
> pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
>                                             PCI_DEVFN(0, 0),
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 5dd177e..96dce76 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -571,7 +571,7 @@ static MaltaFPGAState *malta_fpga_init(MemoryRegion
> *address_space,
>      chr =3D qemu_chr_new("fpga", "vc:320x200");
>      qemu_chr_fe_init(&s->display, chr, NULL);
>      qemu_chr_fe_set_handlers(&s->display, NULL, NULL,
> -                             malta_fgpa_display_event, s, NULL, true);
> +                             malta_fgpa_display_event, NULL, s, NULL,
> true);
>
>      s->uart =3D serial_mm_init(address_space, base + 0x900, 3, uart_irq,
>                               230400, uart_chr, DEVICE_NATIVE_ENDIAN);
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 475e36a..e2dece8 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -896,7 +896,7 @@ static void ivshmem_common_realize(PCIDevice *dev,
> Error **errp)
>          }
>
>          qemu_chr_fe_set_handlers(&s->server_chr, ivshmem_can_receive,
> -                                 ivshmem_read, NULL, s, NULL, true);
> +                                 ivshmem_read, NULL, NULL, s, NULL, true=
);
>
>          if (ivshmem_setup_interrupts(s, errp) < 0) {
>              error_prepend(errp, "Failed to initialize interrupts: ");
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index a41b0d6..9ace5ac 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -351,7 +351,7 @@ static int passthru_initfn(CCIDCardState *base)
>          qemu_chr_fe_set_handlers(&card->cs,
>              ccid_card_vscard_can_read,
>              ccid_card_vscard_read,
> -            ccid_card_vscard_event, card, NULL, true);
> +            ccid_card_vscard_event, NULL, card, NULL, true);
>          ccid_card_vscard_send_init(card);
>      } else {
>          error_report("missing chardev");
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index 83a4f0e..e6b2c7c 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -501,7 +501,7 @@ static void usb_serial_realize(USBDevice *dev, Error
> **errp)
>      }
>
>      qemu_chr_fe_set_handlers(&s->cs, usb_serial_can_read, usb_serial_rea=
d,
> -                             usb_serial_event, s, NULL, true);
> +                             usb_serial_event, NULL, s, NULL, true);
>      usb_serial_handle_reset(dev);
>
>      if (chr->be_open && !dev->attached) {
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index ad5ef78..1e9bf69 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -1399,7 +1399,7 @@ static void usbredir_realize(USBDevice *udev, Error
> **errp)
>      /* Let the backend know we are ready */
>      qemu_chr_fe_set_handlers(&dev->cs, usbredir_chardev_can_read,
>                               usbredir_chardev_read,
> usbredir_chardev_event,
> -                             dev, NULL, true);
> +                             NULL, dev, NULL, true);
>
>      dev->vmstate =3D
>          qemu_add_vm_change_state_handler(usbredir_vm_state_change, dev);
> diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> index fffc0f4..9f8df07 100644
> --- a/include/sysemu/char.h
> +++ b/include/sysemu/char.h
> @@ -64,6 +64,7 @@ struct ParallelIOArg {
>  #define CHR_TIOCM_RTS  0x004
>
>  typedef void IOEventHandler(void *opaque, int event);
> +typedef int BackendChangeHandler(void *opaque);
>
>  typedef enum {
>      /* Whether the chardev peer is able to close and
> @@ -87,6 +88,7 @@ typedef struct CharBackend {
>      IOEventHandler *chr_event;
>      IOCanReadHandler *chr_can_read;
>      IOReadHandler *chr_read;
> +    BackendChangeHandler *chr_be_change;
>      void *opaque;
>      int tag;
>      int fe_open;
> @@ -399,6 +401,8 @@ void qemu_chr_fe_deinit(CharBackend *b);
>   *               receive
>   * @fd_read: callback to receive data from char
>   * @fd_event: event callback
> + * @be_change: backend change callback; passing NULL means hot backend
> change
> + *             is not supported and will not be attempted
>   * @opaque: an opaque pointer for the callbacks
>   * @context: a main loop context or NULL for the default
>   * @set_open: whether to call qemu_chr_fe_set_open() implicitely when
> @@ -413,6 +417,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>                                IOCanReadHandler *fd_can_read,
>                                IOReadHandler *fd_read,
>                                IOEventHandler *fd_event,
> +                              BackendChangeHandler *be_change,
>                                void *opaque,
>                                GMainContext *context,
>                                bool set_open);
> diff --git a/monitor.c b/monitor.c
> index afbacfe..9057ad3 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4088,12 +4088,12 @@ void monitor_init(Chardev *chr, int flags)
>
>      if (monitor_is_qmp(mon)) {
>          qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
> monitor_qmp_read,
> -                                 monitor_qmp_event, mon, NULL, true);
> +                                 monitor_qmp_event, NULL, mon, NULL,
> true);
>          qemu_chr_fe_set_echo(&mon->chr, true);
>          json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
>      } else {
>          qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read,
> monitor_read,
> -                                 monitor_event, mon, NULL, true);
> +                                 monitor_event, NULL, mon, NULL, true);
>      }
>
>      qemu_mutex_lock(&monitor_lock);
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 4ab80b1..f672f4f 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -532,7 +532,7 @@ static void compare_pri_chr_in(void *opaque, const
> uint8_t *buf, int size)
>
>      ret =3D net_fill_rstate(&s->pri_rs, buf, size);
>      if (ret =3D=3D -1) {
> -        qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL,
> +        qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL, NULL,
>                                   NULL, NULL, true);
>          error_report("colo-compare primary_in error");
>      }
> @@ -549,7 +549,7 @@ static void compare_sec_chr_in(void *opaque, const
> uint8_t *buf, int size)
>
>      ret =3D net_fill_rstate(&s->sec_rs, buf, size);
>      if (ret =3D=3D -1) {
> -        qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL,
> +        qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL, NULL,
>                                   NULL, NULL, true);
>          error_report("colo-compare secondary_in error");
>      }
> @@ -577,9 +577,11 @@ static void *colo_compare_thread(void *opaque)
>      s->worker_context =3D g_main_context_new();
>
>      qemu_chr_fe_set_handlers(&s->chr_pri_in, compare_chr_can_read,
> -                          compare_pri_chr_in, NULL, s, s->worker_context=
,
> true);
> +                             compare_pri_chr_in, NULL, NULL,
> +                             s, s->worker_context, true);
>      qemu_chr_fe_set_handlers(&s->chr_sec_in, compare_chr_can_read,
> -                          compare_sec_chr_in, NULL, s, s->worker_context=
,
> true);
> +                             compare_sec_chr_in, NULL, NULL,
> +                             s, s->worker_context, true);
>
>      s->compare_loop =3D g_main_loop_new(s->worker_context, FALSE);
>
> @@ -790,9 +792,9 @@ static void colo_compare_finalize(Object *obj)
>  {
>      CompareState *s =3D COLO_COMPARE(obj);
>
> -    qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL, NULL,
> +    qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL, NULL, NUL=
L,
>                               s->worker_context, true);
> -    qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL, NULL,
> +    qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL, NULL, NUL=
L,
>                               s->worker_context, true);
>      qemu_chr_fe_deinit(&s->chr_out);
>
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index 72fa7c2..06321d7 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -112,7 +112,7 @@ static void redirector_chr_read(void *opaque, const
> uint8_t *buf, int size)
>
>      if (ret =3D=3D -1) {
>          qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
> -                                 NULL, NULL, true);
> +                                 NULL, NULL, NULL, true);
>      }
>  }
>
> @@ -124,7 +124,7 @@ static void redirector_chr_event(void *opaque, int
> event)
>      switch (event) {
>      case CHR_EVENT_CLOSED:
>          qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
> -                                 NULL, NULL, true);
> +                                 NULL, NULL, NULL, true);
>          break;
>      default:
>          break;
> @@ -251,7 +251,7 @@ static void filter_redirector_setup(NetFilterState
> *nf, Error **errp)
>
>          qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_read,
>                                   redirector_chr_read,
> redirector_chr_event,
> -                                 nf, NULL, true);
> +                                 NULL, nf, NULL, true);
>      }
>
>      if (s->outdev) {
> diff --git a/net/slirp.c b/net/slirp.c
> index c705a60..6cbae5a 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -778,7 +778,7 @@ static int slirp_guestfwd(SlirpState *s, const char
> *config_str,
>          fwd->slirp =3D s->slirp;
>
>          qemu_chr_fe_set_handlers(&fwd->hd, guestfwd_can_read,
> guestfwd_read,
> -                                 NULL, fwd, NULL, true);
> +                                 NULL, NULL, fwd, NULL, true);
>      }
>      return 0;
>
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 00a0c1c..d090311 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -214,7 +214,7 @@ static void chr_closed_bh(void *opaque)
>      vhost_user_stop(queues, ncs);
>
>      qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
> -                             opaque, NULL, true);
> +                             NULL, opaque, NULL, true);
>
>      if (err) {
>          error_report_err(err);
> @@ -260,7 +260,7 @@ static void net_vhost_user_event(void *opaque, int
> event)
>
>              g_source_remove(s->watch);
>              s->watch =3D 0;
> -            qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL,
> +            qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL,
>                                       NULL, NULL, false);
>
>              aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
> @@ -308,7 +308,8 @@ static int net_vhost_user_init(NetClientState *peer,
> const char *device,
>              return -1;
>          }
>          qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
> -                                 net_vhost_user_event, nc0->name, NULL,
> true);
> +                                 net_vhost_user_event, NULL, nc0->name,
> NULL,
> +                                 true);
>      } while (!s->started);
>
>      assert(s->vhost_net);
> diff --git a/qtest.c b/qtest.c
> index 5aa6636..b6e9780 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -691,7 +691,7 @@ void qtest_init(const char *qtest_chrdev, const char
> *qtest_log, Error **errp)
>
>      qemu_chr_fe_init(&qtest_chr, chr, errp);
>      qemu_chr_fe_set_handlers(&qtest_chr, qtest_can_read, qtest_read,
> -                             qtest_event, &qtest_chr, NULL, true);
> +                             qtest_event, NULL, &qtest_chr, NULL, true);
>      qemu_chr_fe_set_echo(&qtest_chr, true);
>
>      inbuf =3D g_string_new("");
> diff --git a/tests/test-char.c b/tests/test-char.c
> index 124d0c5..f3b377f 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -182,6 +182,7 @@ static void char_mux_test(void)
>                               fe_can_read,
>                               fe_read,
>                               fe_event,
> +                             NULL,
>                               &h1,
>                               NULL, true);
>
> @@ -190,6 +191,7 @@ static void char_mux_test(void)
>                               fe_can_read,
>                               fe_read,
>                               fe_event,
> +                             NULL,
>                               &h2,
>                               NULL, true);
>      qemu_chr_fe_take_focus(&chr_be2);
> @@ -213,7 +215,8 @@ static void char_mux_test(void)
>      h1.read_count =3D 0;
>
>      /* remove first handler */
> -    qemu_chr_fe_set_handlers(&chr_be1, NULL, NULL, NULL, NULL, NULL,
> true);
> +    qemu_chr_fe_set_handlers(&chr_be1, NULL, NULL, NULL, NULL,
> +                             NULL, NULL, true);
>      qemu_chr_be_write(base, (void *)"hello", 6);
>      g_assert_cmpint(h1.read_count, =3D=3D, 0);
>      g_assert_cmpint(h2.read_count, =3D=3D, 0);
> @@ -312,13 +315,13 @@ static void char_socket_test(void)
>
>      qemu_chr_fe_init(&be, chr, &error_abort);
>      qemu_chr_fe_set_handlers(&be, socket_can_read, socket_read,
> -                             NULL, &d, NULL, true);
> +                             NULL, NULL, &d, NULL, true);
>
>      chr_client =3D qemu_chr_new("client", tmp);
>      qemu_chr_fe_init(&client_be, chr_client, &error_abort);
>      qemu_chr_fe_set_handlers(&client_be, socket_can_read_hello,
>                               socket_read_hello,
> -                             NULL, &d, NULL, true);
> +                             NULL, NULL, &d, NULL, true);
>      g_free(tmp);
>
>      d.conn_expected =3D true;
> @@ -388,6 +391,7 @@ static void char_pipe_test(void)
>                               fe_can_read,
>                               fe_read,
>                               fe_event,
> +                             NULL,
>                               &fe,
>                               NULL, true);
>
> @@ -437,7 +441,7 @@ static void char_udp_test(void)
>      d.chr =3D chr;
>      qemu_chr_fe_init(&be, chr, &error_abort);
>      qemu_chr_fe_set_handlers(&be, socket_can_read_hello,
> socket_read_hello,
> -                             NULL, &d, NULL, true);
> +                             NULL, NULL, &d, NULL, true);
>      ret =3D qemu_chr_write_all(chr, (uint8_t *)"hello", 5);
>      g_assert_cmpint(ret, =3D=3D, 5);
>
> @@ -503,6 +507,7 @@ static void char_file_test(void)
>                                   fe_can_read,
>                                   fe_read,
>                                   fe_event,
> +                                 NULL,
>                                   &fe, NULL, true);
>
>          main_loop();
> @@ -558,6 +563,7 @@ static void char_null_test(void)
>                               fe_can_read,
>                               fe_read,
>                               fe_event,
> +                             NULL,
>                               NULL, NULL, true);
>
>      ret =3D qemu_chr_fe_write(&be, (void *)"buf", 4);
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 9095af2..718c08a 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -464,7 +464,7 @@ static void test_server_create_chr(TestServer *server=
,
> const gchar *opt)
>
>      qemu_chr_fe_init(&server->chr, chr, &error_abort);
>      qemu_chr_fe_set_handlers(&server->chr, chr_can_read, chr_read,
> -                             chr_event, server, NULL, true);
> +                             chr_event, NULL, server, NULL, true);
>  }
>
>  static void test_server_listen(TestServer *server)
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
