Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC698C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3980E2464E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3980E2464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0dw-0003Wr-4n
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kX0S6-0005bH-Rz
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:14:14 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:56808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kX0S4-0006TR-SP
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:14:14 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 11E0D60E;
 Mon, 26 Oct 2020 12:14:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lcQsYJDaj56D; Mon, 26 Oct 2020 12:14:08 +0100 (CET)
Received: from function (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr
 [90.50.148.204])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 2616644E;
 Mon, 26 Oct 2020 12:14:08 +0100 (CET)
Received: from samy by function with local (Exim 4.94)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1kX0Ry-007FEC-9S; Mon, 26 Oct 2020 12:14:06 +0100
Date: Mon, 26 Oct 2020 12:14:06 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 8/9] dev-serial: fix FTDI_GET_MDM_ST response
Message-ID: <20201026111406.jvpexlkh53g4fxff@function>
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
 <20201026083401.13231-9-mark.cave-ayland@ilande.co.uk>
 <20201026095450.ko6snc4dusk3pvnw@function>
 <547c0ea5-dad4-d246-1de8-844a2e9a9507@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <547c0ea5-dad4-d246-1de8-844a2e9a9507@ilande.co.uk>
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
Cc: kraxel@redhat.com, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark Cave-Ayland, le lun. 26 oct. 2020 10:58:43 +0000, a ecrit:
> On 26/10/2020 09:54, Samuel Thibault wrote:
> > Mark Cave-Ayland, le lun. 26 oct. 2020 08:34:00 +0000, a ecrit:
> > > The FTDI_GET_MDM_ST response should only return a single byte indicating the
> > > modem status with bit 0 cleared (as documented in the Linux ftdi_sio.h header
> > > file).
> > > 
> > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > ---
> > >   hw/usb/dev-serial.c | 5 ++---
> > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> > > index 4c374d0790..fa734bcf54 100644
> > > --- a/hw/usb/dev-serial.c
> > > +++ b/hw/usb/dev-serial.c
> > > @@ -360,9 +360,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
> > >           /* TODO: TX ON/OFF */
> > >           break;
> > >       case VendorDeviceRequest | FTDI_GET_MDM_ST:
> > > -        data[0] = usb_get_modem_lines(s) | 1;
> > > -        data[1] = FTDI_THRE | FTDI_TEMT;
> > > -        p->actual_length = 2;
> > > +        data[0] = usb_get_modem_lines(s);
> > > +        p->actual_length = 1;
> > 
[...]
> A quick test shows my Chipi-X returns 0x1 0x60 with nothing attached in
> response to FTDI_SIO_GET_MODEM_STATUS_REQUEST: assuming the reply length
> should be 2 bytes, the comment about B0-B3 being zero and the response from
> my Chip-X above suggests that the "| 1" should still be dropped from the
> response.

Aurelien, you introduced the "| 1" in 

commit abb8a13918ecc1e8160aa78582de9d5224ea70df
Author: Aurelien Jarno <aurelien@aurel32.net>
Date:   Wed Aug 13 04:23:17 2008 +0000

    usb-serial: add support for modem lines

[...]
@@ -357,9 +393,9 @@ static int usb_serial_handle_control(USBDevice *dev, int request, int value,
         /* TODO: TX ON/OFF */
         break;
     case DeviceInVendor | FTDI_GET_MDM_ST:
-        /* TODO: return modem status */
-        data[0] = 0;
-        ret = 1;
+        data[0] = usb_get_modem_lines(s) | 1;
+        data[1] = 0;
+        ret = 2;
         break;

do you know exactly what it is for?

Samuel

