Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E815FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 21:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FEA2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 21:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="sOeFtFOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FEA2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj85l-000382-Nj
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 17:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1jj82B-0002UF-TQ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 17:13:19 -0400
Received: from smtp.duncanthrax.net ([178.63.180.169]:35924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1jj829-0005ys-64
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 17:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5HXmsJemK3Z/HjZjfG+HfBxGSEyLXogQWpQqZYl9IEM=; b=sOeFtFObMdfBeizf3h88ocxmp9
 8nEAMCNWqk9vErSofmLDlRXC/ME3fzLLKkf1URLA//wQzjX5zGwDpQV1pbismDLIS70fGEtaO2rrc
 nuKJZc8DUbaJUtnPKAnHQxnhAWK/hrXAstmH2V3LhtF1gCNQkewtSpYnxZVW80T+dADI=;
Received: from hsi-kbw-091-089-248-125.hsi2.kabel-badenwuerttemberg.de
 ([91.89.248.125] helo=t470p.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1jj822-0000RQ-V2; Wed, 10 Jun 2020 23:13:11 +0200
Date: Wed, 10 Jun 2020 23:13:10 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH] net: tulip: Set PCI revision to match dec21143
Message-ID: <20200610211310.GA26448@t470p.stackframe.org>
References: <20200418002552.343480-1-marek.vasut+renesas@gmail.com>
 <203b5328-b473-119c-4122-8f775f390ad0@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <203b5328-b473-119c-4122-8f775f390ad0@amsat.org>
Received-SPF: none client-ip=178.63.180.169; envelope-from=svens@stackframe.org;
 helo=smtp.duncanthrax.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 17:13:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-devel@nongnu.org,
 Marek Vasut <marek.vasut@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 08, 2020 at 12:17:11AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Sven, could you review thiw one-line patch?
> 
> On 4/18/20 2:25 AM, Marek Vasut wrote:
> > The tulip driver claims to emulate dec21143 and it does not emulate dec21142.
> > The dec21142 and dec21143 can be discerned by the PCI revision register,
> > where dec21142 reports value < 0x20 and dec21143 value >= 0x20. E.g. the
> > U-Boot 'tulip' driver also only supports dec21143 and verifies that the
> > PCI revision ID is >= 0x20, otherwise refuses to operate such a card.
> > 
> > This patch sets the PCI revision ID to 0x20 to match the dec21143 and
> > thus also permits e.g. U-Boot to work with the tulip emulation.
> > 
> > Fixes: 34ea023d4b95 ("net: add tulip (dec21143) driver")
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Prasad J Pandit <pjp@fedoraproject.org>
> > Cc: Sven Schnelle <svens@stackframe.org>
> > ---
> >  hw/net/tulip.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> > index 1295f51d07..ffb6c2479a 100644
> > --- a/hw/net/tulip.c
> > +++ b/hw/net/tulip.c
> > @@ -962,6 +962,8 @@ static void pci_tulip_realize(PCIDevice *pci_dev, Error **errp)
> >  
> >      pci_conf = s->dev.config;
> >      pci_conf[PCI_INTERRUPT_PIN] = 1; /* interrupt pin A */
> > +    /* Anything with revision < 0x20 is DC21142, anything >= 0x20 is DC21143 */
> > +    pci_conf[PCI_REVISION_ID] = 0x20;
> >  
> >      s->eeprom = eeprom93xx_new(&pci_dev->qdev, 64);
> >      tulip_fill_eeprom(s);
> > 
> 

The intel datasheet for the DEC21143 lists only Rev IDs > 30 for this particular family:

21143-PB,TB,PC,TC - 0x30
21143-PD,TD - x041

but maybe older DEC chips used 0x20 - don't know. The most interesting question is
whether ancient OS' like HP-UX or Windows XP would still work with this patch, but
i don't have test images at hand right now.

Regards
Sven

