Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11579C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92491223EA
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92491223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWz2K-0006dH-HI
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kWyzM-0002fA-54
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:40:28 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:39218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kWyzK-0005Dx-J0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:40:27 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 06902615;
 Mon, 26 Oct 2020 10:40:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c2kkTuvtXZUm; Mon, 26 Oct 2020 10:40:24 +0100 (CET)
Received: from function (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr
 [90.50.148.204])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 5E2FA4CC;
 Mon, 26 Oct 2020 10:40:24 +0100 (CET)
Received: from samy by function with local (Exim 4.94)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1kWyzH-006i2P-Hx; Mon, 26 Oct 2020 10:40:23 +0100
Date: Mon, 26 Oct 2020 10:40:23 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 4/9] dev-serial: add trace-events for baud rate and data
 parameters
Message-ID: <20201026094023.7xmowepzmdhsu5ba@function>
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
 <20201026083401.13231-5-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201026083401.13231-5-mark.cave-ayland@ilande.co.uk>
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

Mark Cave-Ayland, le lun. 26 oct. 2020 08:33:56 +0000, a ecrit:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  hw/usb/dev-serial.c | 3 +++
>  hw/usb/trace-events | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index abc316c7bf..badf8785db 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -307,6 +307,7 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>          }
>  
>          s->params.speed = (48000000 / 2) / (8 * divisor + subdivisor8);
> +        trace_usb_serial_set_baud(bus->busnr, dev->addr, s->params.speed);
>          qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_PARAMS, &s->params);
>          break;
>      }
> @@ -340,6 +341,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>              goto fail;
>          }
>  
> +        trace_usb_serial_set_data(bus->busnr, dev->addr, s->params.parity,
> +                                  s->params.data_bits, s->params.stop_bits);
>          qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_PARAMS, &s->params);
>          /* TODO: TX ON/OFF */
>          break;
> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index e5871cbbbc..9e984b2e0c 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -328,3 +328,5 @@ usb_serial_unsupported_parity(int bus, int addr, int value) "dev %d:%d unsupport
>  usb_serial_unsupported_stopbits(int bus, int addr, int value) "dev %d:%d unsupported stop bits %d"
>  usb_serial_unsupported_control(int bus, int addr, int request, int value) "dev %d:%d got unsupported/bogus control 0x%x, value 0x%x"
>  usb_serial_bad_token(int bus, int addr) "dev %d:%d bad token"
> +usb_serial_set_baud(int bus, int addr, int baud) "dev %d:%d baud rate %d"
> +usb_serial_set_data(int bus, int addr, int parity, int data, int stop) "dev %d:%d parity %c, data bits %d, stop bits %d"
> -- 
> 2.20.1
> 

-- 
Samuel
 J'ai un gros problème: j'ai cet exercice à rendre demain lundi, mais ma
 TI 89 ne sait pas le faire...
 Est-ce que quelqu'un pourrait m'aider??
 -+- OD In Guide du Neuneu Usenet : Comment ça ! Il faut réfléchir ?-+-

