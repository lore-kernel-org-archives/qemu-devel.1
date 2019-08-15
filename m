Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DFCC31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 06:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23F52086C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 06:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23F52086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy9Ax-0003Ab-7y
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 02:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1hy9AL-0002kV-QU
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 02:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hy9AK-0002cC-9r
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 02:23:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hy9AK-0002bk-4b
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 02:23:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C870315C00E;
 Thu, 15 Aug 2019 06:23:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com
 [10.36.116.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF37827C32;
 Thu, 15 Aug 2019 06:23:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C283616E32; Thu, 15 Aug 2019 08:23:13 +0200 (CEST)
Date: Thu, 15 Aug 2019 08:23:13 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20190815062313.ve26cevmbyuewlo5@sirius.home.kraxel.org>
References: <20190815002652.79FDE7456E2@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815002652.79FDE7456E2@zero.eik.bme.hu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 15 Aug 2019 06:23:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH] ati-vga: Implement dummy VBlank IRQ
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 15, 2019 at 02:25:07AM +0200, BALATON Zoltan wrote:
> The MacOS driver exits if the card does not have an interrupt. If we
> set PCI_INTERRUPT_PIN to 1 then it enables VBlank interrupts and it
> boots but the mouse poniter can not be moved. This patch implements a
> dummy VBlank interrupt by a timer triggered at 60 Hz to test if it
> helps. Unfortunately it doesn't: MacOS with this patch hangs during
> boot just polling interrupts and acknowledging them so maybe it needs
> something else or there may be some other problem with this
> implementation.
> 
> This is posted for comments and to let others experiment with it but
> probably should not be committed upstream yet.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/ati.c      | 41 +++++++++++++++++++++++++++++++++++++++++
>  hw/display/ati_dbg.c  |  1 +
>  hw/display/ati_int.h  |  4 ++++
>  hw/display/ati_regs.h |  1 +
>  4 files changed, 47 insertions(+)
> 
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index a365e2455d..e06cbf3e91 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -243,6 +243,21 @@ static uint64_t ati_i2c(bitbang_i2c_interface *i2c, uint64_t data, int base)
>      return data;
>  }
>  
> +static void ati_vga_update_irq(ATIVGAState *s)
> +{
> +    pci_set_irq(&s->dev, s->regs.gen_int_status & 1);

This should be "s->regs.gen_int_status & s->regs.gen_int_cntl" I guess?

> +static void ati_vga_vblank_irq(void *opaque)
> +{
> +    ATIVGAState *s = opaque;
> +
> +    timer_mod(&s->vblank_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +              NANOSECONDS_PER_SECOND / 60);
> +    s->regs.gen_int_status |= 1;

#defines for the irq status bits would be nice.

> +    case GEN_INT_CNTL:
> +        s->regs.gen_int_cntl = data;
> +        if (data & 1) {
> +            ati_vga_vblank_irq(s);
> +        } else {
> +            timer_del(&s->vblank_timer);
> +        }

ati_vga_update_irq() needed here.

> +        break;
> +    case GEN_INT_STATUS:
> +        data &= (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
> +                 0x000f040fUL : 0xfc080effUL);

Add IRQ_MASK #define ?

> +        s->regs.gen_int_status &= ~data;

ati_vga_update_irq() needed here too.

cheers,
  Gerd


