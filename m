Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FD2C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43CD2242B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43CD2242B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWz6M-0000JX-W5
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kWz5E-0007yc-VF
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:46:32 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:39286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kWz5D-0007eM-5m
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:46:32 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 069B7615;
 Mon, 26 Oct 2020 10:46:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oqZnyKKB98GY; Mon, 26 Oct 2020 10:46:28 +0100 (CET)
Received: from function (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr
 [90.50.148.204])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 876DCB8;
 Mon, 26 Oct 2020 10:46:28 +0100 (CET)
Received: from samy by function with local (Exim 4.94)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1kWz59-006i4O-Mq; Mon, 26 Oct 2020 10:46:27 +0100
Date: Mon, 26 Oct 2020 10:46:27 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 7/9] dev-serial: add support for setting data_bits in
 QEMUSerialSetParams
Message-ID: <20201026094627.a2fk3vkvaiaid5k3@function>
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
 <20201026083401.13231-8-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201026083401.13231-8-mark.cave-ayland@ilande.co.uk>
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

Mark Cave-Ayland, le lun. 26 oct. 2020 08:33:59 +0000, a ecrit:
> Also implement the behaviour reported in Linux's ftdi_sio.c whereby if an invalid
> data_bits value is provided then the hardware defaults to using 8.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  hw/usb/dev-serial.c | 17 +++++++++++++++++
>  hw/usb/trace-events |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index 919e25e1d9..4c374d0790 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -308,6 +308,23 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>          break;
>      }
>      case VendorDeviceOutRequest | FTDI_SET_DATA:
> +        switch (value & 0xff) {
> +        case 7:
> +            s->params.data_bits = 7;
> +            break;
> +        case 8:
> +            s->params.data_bits = 8;
> +            break;
> +        default:
> +            /*
> +             * According to a comment in Linux's ftdi_sio.c original FTDI
> +             * chips fall back to 8 data bits for unsupported data_bits
> +             */
> +            trace_usb_serial_unsupported_data_bits(bus->busnr, dev->addr,
> +                                                   value & 0xff);
> +            s->params.data_bits = 8;
> +        }
> +
>          switch (value & FTDI_PARITY) {
>          case 0:
>              s->params.parity = 'N';
> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index 9e984b2e0c..0d0a3e5f2a 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -327,6 +327,7 @@ usb_serial_handle_control(int bus, int addr, int request, int value) "dev %d:%d
>  usb_serial_unsupported_parity(int bus, int addr, int value) "dev %d:%d unsupported parity %d"
>  usb_serial_unsupported_stopbits(int bus, int addr, int value) "dev %d:%d unsupported stop bits %d"
>  usb_serial_unsupported_control(int bus, int addr, int request, int value) "dev %d:%d got unsupported/bogus control 0x%x, value 0x%x"
> +usb_serial_unsupported_data_bits(int bus, int addr, int value) "dev %d:%d unsupported data bits %d, falling back to 8"
>  usb_serial_bad_token(int bus, int addr) "dev %d:%d bad token"
>  usb_serial_set_baud(int bus, int addr, int baud) "dev %d:%d baud rate %d"
>  usb_serial_set_data(int bus, int addr, int parity, int data, int stop) "dev %d:%d parity %c, data bits %d, stop bits %d"
> -- 
> 2.20.1
> 

-- 
Samuel
 > Il [e2fsck] a bien démarré, mais il m'a rendu la main aussitot en me
 > disant "houlala, c'est pas beau à voir votre truc, je préfèrerai que
 > vous teniez vous même la tronçonneuse" (traduction libre)
 NC in Guide du linuxien pervers : "Bien configurer sa tronçonneuse."

