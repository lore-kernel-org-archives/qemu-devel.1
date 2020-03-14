Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E596C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 21:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2109D2082E
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 21:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2109D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDEXr-0003MV-AP
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 17:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1jDEX3-0002dE-Ld
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1jDEX2-0001Ml-NQ
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:41:21 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:35334)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1jDEX2-0001MJ-He
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:41:20 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id BAA71DB2D;
 Sat, 14 Mar 2020 22:41:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PTEdQdeqXkru; Sat, 14 Mar 2020 22:41:17 +0100 (CET)
Received: from function (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 7966DDB2B;
 Sat, 14 Mar 2020 22:41:17 +0100 (CET)
Received: from samy by function with local (Exim 4.93)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1jDEWy-00474L-PY; Sat, 14 Mar 2020 22:41:16 +0100
Date: Sat, 14 Mar 2020 22:41:16 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [PATCH 4/4] usb-serial: Fix timeout closing the device
Message-ID: <20200314214116.khrfla75xa224zjw@function>
References: <20200312125524.7812-1-jandryuk@gmail.com>
 <20200312125524.7812-5-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312125524.7812-5-jandryuk@gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a0c:e300::1
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason Andryuk, le jeu. 12 mars 2020 08:55:23 -0400, a ecrit:
> Linux guests wait ~30 seconds when closing the emulated /dev/ttyUSB0.
> During that time, the kernel driver is sending many control URBs
> requesting GetModemStat (5).  Real hardware returns a status with
> FTDI_THRE (Transmitter Holding Register) and FTDI_TEMT (Transmitter
> Empty) set.  QEMU leaves them clear, and it seems Linux is waiting for
> FTDI_TEMT to be set to indicate the tx queue is empty before closing.
> 
> Set the bits when responding to a GetModemStat query and avoid the
> shutdown delay.
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
> Looking at a USB dump for a real FTDI USB adapter, I see these bits set
> in all the bulk URBs where QEMU currently has them clear.
> ---
>  hw/usb/dev-serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index ef33bcd127..5389235f17 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -332,7 +332,7 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>          break;
>      case DeviceInVendor | FTDI_GET_MDM_ST:
>          data[0] = usb_get_modem_lines(s) | 1;
> -        data[1] = 0;
> +        data[1] = FTDI_THRE | FTDI_TEMT;
>          p->actual_length = 2;
>          break;
>      case DeviceOutVendor | FTDI_SET_EVENT_CHR:
> -- 
> 2.24.1
> 

-- 
Samuel
c> ah (on trouve fluide glacial sur le net, ou il faut aller dans le monde reel ?)
s> dans le monde reel
c> zut

