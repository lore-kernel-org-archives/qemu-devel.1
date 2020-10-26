Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E87C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D53223EA
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D53223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyz6-0002AK-Og
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kWywY-0000hX-Ay
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:37:34 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:39154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kWywW-0004CK-OK
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:37:34 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 12135611;
 Mon, 26 Oct 2020 10:37:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HZKJ8pFHP8il; Mon, 26 Oct 2020 10:37:30 +0100 (CET)
Received: from function (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr
 [90.50.148.204])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 251D760E;
 Mon, 26 Oct 2020 10:37:30 +0100 (CET)
Received: from samy by function with local (Exim 4.94)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1kWywT-006hxe-7P; Mon, 26 Oct 2020 10:37:29 +0100
Date: Mon, 26 Oct 2020 10:37:29 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/9] dev-serial: use USB_SERIAL QOM macro for
 USBSerialState assignments
Message-ID: <20201026093729.7jvakhktbrzp66h4@function>
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
 <20201026083401.13231-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026083401.13231-3-mark.cave-ayland@ilande.co.uk>
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

Mark Cave-Ayland, le lun. 26 oct. 2020 08:33:54 +0000, a ecrit:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  hw/usb/dev-serial.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index 7a5fa3770e..77ce89d38b 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -204,7 +204,7 @@ static void usb_serial_reset(USBSerialState *s)
>  
>  static void usb_serial_handle_reset(USBDevice *dev)
>  {
> -    USBSerialState *s = (USBSerialState *)dev;
> +    USBSerialState *s = USB_SERIAL(dev);
>  
>      DPRINTF("Reset\n");
>  
> @@ -243,7 +243,7 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>                                        int request, int value, int index,
>                                        int length, uint8_t *data)
>  {
> -    USBSerialState *s = (USBSerialState *)dev;
> +    USBSerialState *s = USB_SERIAL(dev);
>      int ret;
>  
>      DPRINTF("got control %x, value %x\n", request, value);
> @@ -430,7 +430,7 @@ static void usb_serial_token_in(USBSerialState *s, USBPacket *p)
>  
>  static void usb_serial_handle_data(USBDevice *dev, USBPacket *p)
>  {
> -    USBSerialState *s = (USBSerialState *)dev;
> +    USBSerialState *s = USB_SERIAL(dev);
>      uint8_t devep = p->ep->nr;
>      struct iovec *iov;
>      int i;
> -- 
> 2.20.1
> 

-- 
Samuel
<h> t: bah c'est tendre le pattern pour se faire matcher, hein

