Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E55C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08458223EA
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08458223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWz5F-0007py-4L
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kWz3s-0007Fs-8O
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:45:08 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:39258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kWz3q-00072u-JK
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:45:07 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id EF33E4D8;
 Mon, 26 Oct 2020 10:45:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id queAIUnTYpox; Mon, 26 Oct 2020 10:45:04 +0100 (CET)
Received: from function (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr
 [90.50.148.204])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 0FE7CB8;
 Mon, 26 Oct 2020 10:45:04 +0100 (CET)
Received: from samy by function with local (Exim 4.94)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1kWz3m-006i3v-Fq; Mon, 26 Oct 2020 10:45:02 +0100
Date: Mon, 26 Oct 2020 10:45:02 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 6/9] dev-serial: add always-plugged property to ensure
 USB device is always attached
Message-ID: <20201026094502.b75mb5h2isa4lysx@function>
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
 <20201026083401.13231-7-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026083401.13231-7-mark.cave-ayland@ilande.co.uk>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Received-SPF: softfail client-ip=185.233.100.1;
 envelope-from=samuel.thibault@gnu.org; helo=hera.aquilenet.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 05:37:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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

Mark Cave-Ayland, le lun. 26 oct. 2020 08:33:58 +0000, a ecrit:
> Some operating systems will generate a new device ID when a USB device is unplugged
> and then replugged into the USB. If this is done whilst switching between multiple
> applications over a virtual serial port, the change of device ID requires going
> back into the OS/application to locate the new device accordingly.
> 
> Add a new always-plugged property that if specified will ensure that the device
> always remains attached to the USB regardless of the state of the backend
> chardev.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  hw/usb/dev-serial.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index 92c35615eb..919e25e1d9 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -97,6 +97,7 @@ struct USBSerialState {
>      uint8_t event_chr;
>      uint8_t error_chr;
>      uint8_t event_trigger;
> +    bool always_plugged;
>      QEMUSerialSetParams params;
>      int latency;        /* ms */
>      CharBackend cs;
> @@ -516,12 +517,12 @@ static void usb_serial_event(void *opaque, QEMUChrEvent event)
>          s->event_trigger |= FTDI_BI;
>          break;
>      case CHR_EVENT_OPENED:
> -        if (!s->dev.attached) {
> +        if (!s->always_plugged && !s->dev.attached) {
>              usb_device_attach(&s->dev, &error_abort);
>          }
>          break;
>      case CHR_EVENT_CLOSED:
> -        if (s->dev.attached) {
> +        if (!s->always_plugged && s->dev.attached) {
>              usb_device_detach(&s->dev);
>          }
>          break;
> @@ -556,7 +557,8 @@ static void usb_serial_realize(USBDevice *dev, Error **errp)
>                               usb_serial_event, NULL, s, NULL, true);
>      usb_serial_handle_reset(dev);
>  
> -    if (qemu_chr_fe_backend_open(&s->cs) && !dev->attached) {
> +    if (s->always_plugged || (qemu_chr_fe_backend_open(&s->cs) &&
> +                              !dev->attached)) {
>          usb_device_attach(dev, &error_abort);
>      }
>      s->intr = usb_ep_get(dev, USB_TOKEN_IN, 1);
> @@ -584,6 +586,7 @@ static const VMStateDescription vmstate_usb_serial = {
>  
>  static Property serial_properties[] = {
>      DEFINE_PROP_CHR("chardev", USBSerialState, cs),
> +    DEFINE_PROP_BOOL("always-plugged", USBSerialState, always_plugged, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -- 
> 2.20.1
> 

-- 
Samuel
"...[Linux's] capacity to talk via any medium except smoke signals."
(By Dr. Greg Wettstein, Roger Maris Cancer Center)

