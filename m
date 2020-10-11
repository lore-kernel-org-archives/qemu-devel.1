Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAF3C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 08:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6E320776
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 08:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6E320776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRWio-0005kO-Ht
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 04:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kRWho-0005F3-3A
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 04:27:48 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:48182
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kRWhm-0000AO-Iu
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 04:27:47 -0400
Received: from host86-158-109-18.range86-158.btcentralplus.com
 ([86.158.109.18] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kRWhh-0004KO-SH; Sun, 11 Oct 2020 09:27:46 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20201011082022.3016-1-mark.cave-ayland@ilande.co.uk>
Message-ID: <ac6228b3-9ebf-fc9c-e3cc-5d26a33166c1@ilande.co.uk>
Date: Sun, 11 Oct 2020 09:27:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201011082022.3016-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.18
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] pci: assert that irqnum is between 0 and bus->nirqs in
 pci_change_irq_level()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.207,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/10/2020 09:20, Mark Cave-Ayland wrote:

> These assertions similar to those in the adjacent pci_bus_get_irq_level() function
> ensure that irqnum lies within the valid PCI bus IRQ range.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
> 
> This would have immediately picked up on the sabre PCI bus IRQ overflow fixed by
> the patch I just posted.
> 
> ---
>  hw/pci/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 3c8f10b461..b1484b3747 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -258,6 +258,8 @@ static void pci_change_irq_level(PCIDevice *pci_dev, int irq_num, int change)
>              break;
>          pci_dev = bus->parent_dev;
>      }
> +    assert(irq_num >= 0);
> +    assert(irq_num < bus->nirq);
>      bus->irq_count[irq_num] += change;
>      bus->set_irq(bus->irq_opaque, irq_num, bus->irq_count[irq_num] != 0);
>  }

Actually something else is odd here: I've just done a quick check on the callers to
pci_change_irq_level() and it appears that both pci_update_irq_disabled() and
pci_irq_handler() assume that irqnum is a PCI device IRQ i.e between 0 and 3, whereas
pci_change_irq_level() assumes it is working with a PCI bus IRQ between 0 and bus->nirqs.

It feels like pci_change_irq_level() should be renamed to pci_bus_change_irq_level()
similar to pci_bus_get_irq_level() but in that case are pci_update_irq_disabled() and
pci_irq_handler() both incorrect?


ATB,

Mark.

