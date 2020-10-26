Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77041C55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 235E52224A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235E52224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX46f-0000Pp-8p
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kX436-0006Bh-R4
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:04:42 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:41694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kX435-0004Yq-0D
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:04:40 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 5B38265C;
 Mon, 26 Oct 2020 16:04:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 43JuhXPVY4MP; Mon, 26 Oct 2020 16:04:33 +0100 (CET)
Received: from function.home (unknown
 [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 6CE7A363;
 Mon, 26 Oct 2020 16:04:33 +0100 (CET)
Received: from samy by function.home with local (Exim 4.94)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1kX42y-007qIv-Ag; Mon, 26 Oct 2020 16:04:32 +0100
Date: Mon, 26 Oct 2020 16:04:32 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 8/9] dev-serial: fix FTDI_GET_MDM_ST response
Message-ID: <20201026150432.yqkyceke5uppqom5@function>
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
 <20201026083401.13231-9-mark.cave-ayland@ilande.co.uk>
 <20201026095450.ko6snc4dusk3pvnw@function>
 <547c0ea5-dad4-d246-1de8-844a2e9a9507@ilande.co.uk>
 <20201026111406.jvpexlkh53g4fxff@function>
 <CAKf6xpvcnmEs+v3+Tm1srQfo=m37EAGRPynJDJy4HkMuCmD6NQ@mail.gmail.com>
 <38110b4a-34b1-3e97-5a7f-4fad1bfff080@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38110b4a-34b1-3e97-5a7f-4fad1bfff080@ilande.co.uk>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Received-SPF: softfail client-ip=185.233.100.1;
 envelope-from=samuel.thibault@gnu.org; helo=hera.aquilenet.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 11:04:34
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark Cave-Ayland, le lun. 26 oct. 2020 13:40:05 +0000, a ecrit:
> On 26/10/2020 13:00, Jason Andryuk wrote:
> > On Mon, Oct 26, 2020 at 7:21 AM Samuel Thibault <samuel.thibault@gnu.org> wrote:
> > > Aurelien, you introduced the "| 1" in
> > > 
> > > commit abb8a13918ecc1e8160aa78582de9d5224ea70df
> > > Author: Aurelien Jarno <aurelien@aurel32.net>
> > > Date:   Wed Aug 13 04:23:17 2008 +0000
> > > 
> > >      usb-serial: add support for modem lines
> > > 
> > > [...]
> > > @@ -357,9 +393,9 @@ static int usb_serial_handle_control(USBDevice *dev, int request, int value,
> > >           /* TODO: TX ON/OFF */
> > >           break;
> > >       case DeviceInVendor | FTDI_GET_MDM_ST:
> > > -        /* TODO: return modem status */
> > > -        data[0] = 0;
> > > -        ret = 1;
> > > +        data[0] = usb_get_modem_lines(s) | 1;
> > > +        data[1] = 0;
> > > +        ret = 2;
> > >           break;
> > 
> > I'm not particularly familiar with the FTDI USB serial devices.  I
> > found setting FTDI_THRE | FTDI_TEMT by comparing with real hardware.
> > 
> > A little searching found this:
> > https://elixir.bootlin.com/linux/latest/source/drivers/usb/serial/ftdi_sio.h#L541
> > 
> > That shows "B0   Reserved - must be 1", so maybe that is why "| 1" was added?
> 
> Right - that's for the modem status returned as part of the first 2 status
> bytes for incoming data which is slightly different from modem status
> returned directly from FTDI_SIO_GET_MODEM_STATUS: https://elixir.bootlin.com/linux/latest/source/drivers/usb/serial/ftdi_sio.h#L423.
> 
> It is the latter which this patch changes and appears to match what I see on
> my Chipi-X hardware here.

Aurelien, do you remember the reason for the addition of 1 here? It does
look like the confusion between the incoming data bytes and the modem
status bytes.

Samuel

