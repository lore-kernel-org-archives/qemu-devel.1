Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303F4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 09:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D77B2080D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 09:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D77B2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRu4c-0008SK-Eu
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 05:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kRu3M-0007aE-Gu; Mon, 12 Oct 2020 05:23:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:49278
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kRu3K-0006Nh-JM; Mon, 12 Oct 2020 05:23:36 -0400
Received: from host86-158-109-18.range86-158.btcentralplus.com
 ([86.158.109.18] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kRu3E-00043v-Rq; Mon, 12 Oct 2020 10:23:33 +0100
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201011190332.3189611-1-f4bug@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <85549ebe-6644-3c45-0e56-e4d5c509ea80@ilande.co.uk>
Date: Mon, 12 Oct 2020 10:23:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201011190332.3189611-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.18
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/pci-host/grackle: Verify PIC link is properly set
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/10/2020 20:03, Philippe Mathieu-Daudé wrote:

> The Grackle PCI host model expects the interrupt controller
> being set, but does not verify it is present. Add a check to
> help developers using this model.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/pci-host/grackle.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
> index 57c29b20afb..20361d215ca 100644
> --- a/hw/pci-host/grackle.c
> +++ b/hw/pci-host/grackle.c
> @@ -76,6 +76,10 @@ static void grackle_realize(DeviceState *dev, Error **errp)
>      GrackleState *s = GRACKLE_PCI_HOST_BRIDGE(dev);
>      PCIHostState *phb = PCI_HOST_BRIDGE(dev);
>  
> +    if (!s->pic) {
> +        error_setg(errp, TYPE_GRACKLE_PCI_HOST_BRIDGE ": 'pic' link not set");
> +        return;
> +    }
>      phb->bus = pci_register_root_bus(dev, NULL,
>                                       pci_grackle_set_irq,
>                                       pci_grackle_map_irq,

Reviewing this now, my feeling is that both grackle and uninorth are doing the wrong
thing here by passing in a link to the PIC - certainly if I had written this more
recently than I originally did, I would simply use qdev_init_gpio_out() for the IRQ
lines and do the wiring during machine init.

I've got a few other things to look at first, but I'll post a patchset later which I
think will improve this for both Mac machines.


ATB,

Mark.

