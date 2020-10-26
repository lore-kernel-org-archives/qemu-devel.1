Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C1AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB78223EA
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB78223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyzO-0002Oz-NN
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kWyxv-0001RK-Cv
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:38:59 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:55922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kWyxt-0004cc-JU
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:38:59 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 5DA2B4B4;
 Mon, 26 Oct 2020 10:38:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IUAok5_inwW3; Mon, 26 Oct 2020 10:38:54 +0100 (CET)
Received: from function (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr
 [90.50.148.204])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 6496846A;
 Mon, 26 Oct 2020 10:38:54 +0100 (CET)
Received: from samy by function with local (Exim 4.94)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1kWyxp-006hyZ-Ju; Mon, 26 Oct 2020 10:38:53 +0100
Date: Mon, 26 Oct 2020 10:38:53 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 3/9] dev-serial: convert from DPRINTF to trace-events
Message-ID: <20201026093853.ve52vgolorftf3tf@function>
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
 <20201026083401.13231-4-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026083401.13231-4-mark.cave-ayland@ilande.co.uk>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Received-SPF: softfail client-ip=2a0c:e300::1;
 envelope-from=samuel.thibault@gnu.org; helo=hera.aquilenet.fr
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark Cave-Ayland, le lun. 26 oct. 2020 08:33:55 +0000, a ecrit:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  hw/usb/dev-serial.c | 28 ++++++++++++++--------------
>  hw/usb/trace-events |  8 ++++++++
>  2 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index 77ce89d38b..abc316c7bf 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -20,15 +20,8 @@
>  #include "chardev/char-serial.h"
>  #include "chardev/char-fe.h"
>  #include "qom/object.h"
> +#include "trace.h"
>  
> -//#define DEBUG_Serial
> -
> -#ifdef DEBUG_Serial
> -#define DPRINTF(fmt, ...) \
> -do { printf("usb-serial: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while(0)
> -#endif
>  
>  #define RECV_BUF (512 - (2 * 8))
>  
> @@ -205,8 +198,9 @@ static void usb_serial_reset(USBSerialState *s)
>  static void usb_serial_handle_reset(USBDevice *dev)
>  {
>      USBSerialState *s = USB_SERIAL(dev);
> +    USBBus *bus = usb_bus_from_device(dev);
>  
> -    DPRINTF("Reset\n");
> +    trace_usb_serial_reset(bus->busnr, dev->addr);
>  
>      usb_serial_reset(s);
>      /* TODO: Reset char device, send BREAK? */
> @@ -244,9 +238,11 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>                                        int length, uint8_t *data)
>  {
>      USBSerialState *s = USB_SERIAL(dev);
> +    USBBus *bus = usb_bus_from_device(dev);
>      int ret;
>  
> -    DPRINTF("got control %x, value %x\n", request, value);
> +    trace_usb_serial_handle_control(bus->busnr, dev->addr, request, value);
> +
>      ret = usb_desc_handle_control(dev, p, request, value, index, length, data);
>      if (ret >= 0) {
>          return;
> @@ -326,7 +322,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>              s->params.parity = 'E';
>              break;
>          default:
> -            DPRINTF("unsupported parity %d\n", value & FTDI_PARITY);
> +            trace_usb_serial_unsupported_parity(bus->busnr, dev->addr,
> +                                                value & FTDI_PARITY);
>              goto fail;
>          }
>  
> @@ -338,7 +335,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>              s->params.stop_bits = 2;
>              break;
>          default:
> -            DPRINTF("unsupported stop bits %d\n", value & FTDI_STOP);
> +            trace_usb_serial_unsupported_stopbits(bus->busnr, dev->addr,
> +                                                  value & FTDI_STOP);
>              goto fail;
>          }
>  
> @@ -367,7 +365,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>          break;
>      default:
>      fail:
> -        DPRINTF("got unsupported/bogus control %x, value %x\n", request, value);
> +        trace_usb_serial_unsupported_control(bus->busnr, dev->addr, request,
> +                                             value);
>          p->status = USB_RET_STALL;
>          break;
>      }
> @@ -431,6 +430,7 @@ static void usb_serial_token_in(USBSerialState *s, USBPacket *p)
>  static void usb_serial_handle_data(USBDevice *dev, USBPacket *p)
>  {
>      USBSerialState *s = USB_SERIAL(dev);
> +    USBBus *bus = usb_bus_from_device(dev);
>      uint8_t devep = p->ep->nr;
>      struct iovec *iov;
>      int i;
> @@ -459,7 +459,7 @@ static void usb_serial_handle_data(USBDevice *dev, USBPacket *p)
>          break;
>  
>      default:
> -        DPRINTF("Bad token\n");
> +        trace_usb_serial_bad_token(bus->busnr, dev->addr);
>      fail:
>          p->status = USB_RET_STALL;
>          break;
> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index 72e4298780..e5871cbbbc 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -320,3 +320,11 @@ usb_host_parse_interface(int bus, int addr, int num, int alt, int active) "dev %
>  usb_host_parse_endpoint(int bus, int addr, int ep, const char *dir, const char *type, int active) "dev %d:%d, ep %d, %s, %s, active %d"
>  usb_host_parse_error(int bus, int addr, const char *errmsg) "dev %d:%d, msg %s"
>  usb_host_remote_wakeup_removed(int bus, int addr) "dev %d:%d"
> +
> +# dev-serial.c
> +usb_serial_reset(int bus, int addr) "dev %d:%d reset"
> +usb_serial_handle_control(int bus, int addr, int request, int value) "dev %d:%d got control 0x%x, value 0x%x"
> +usb_serial_unsupported_parity(int bus, int addr, int value) "dev %d:%d unsupported parity %d"
> +usb_serial_unsupported_stopbits(int bus, int addr, int value) "dev %d:%d unsupported stop bits %d"
> +usb_serial_unsupported_control(int bus, int addr, int request, int value) "dev %d:%d got unsupported/bogus control 0x%x, value 0x%x"
> +usb_serial_bad_token(int bus, int addr) "dev %d:%d bad token"
> -- 
> 2.20.1
> 

-- 
Samuel
The nice thing about Windows is - It does not just crash, it displays a
dialog box and lets you press 'OK' first.
(Arno Schaefer's .sig)

