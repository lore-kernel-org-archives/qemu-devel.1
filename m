Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E50C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF2E206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF2E206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyCPi-0005G8-Tt
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 05:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1hyCP3-0004pC-LX
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hyCP1-00008h-Vj
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:50:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50968)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hyCP1-00007w-QQ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:50:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 804973082E42;
 Thu, 15 Aug 2019 09:50:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com
 [10.36.116.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1615927C34;
 Thu, 15 Aug 2019 09:50:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E434916E32; Thu, 15 Aug 2019 11:50:36 +0200 (CEST)
Date: Thu, 15 Aug 2019 11:50:36 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20190815095036.lon6sw6cft2agdzw@sirius.home.kraxel.org>
References: <20190815002652.79FDE7456E2@zero.eik.bme.hu>
 <20190815062313.ve26cevmbyuewlo5@sirius.home.kraxel.org>
 <alpine.BSF.2.21.9999.1908151051570.23526@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1908151051570.23526@zero.eik.bme.hu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 15 Aug 2019 09:50:38 +0000 (UTC)
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

  Hi,

> > > +static void ati_vga_update_irq(ATIVGAState *s)
> > > +{
> > > +    pci_set_irq(&s->dev, s->regs.gen_int_status & 1);
> > 
> > This should be "s->regs.gen_int_status & s->regs.gen_int_cntl" I guess?
> 
> Probably, but we only try to emulate VBlank yet so to avoid any problems due
> to raising irq for unknown bits I restricted it for that now.

Well, qemu doesn't set unknown status bits, only vblank.  The guest
can't set them either due to status register having write-one-to-clear
semantics.  So, that should not happen.  If you want an extra check to
catch programming errors I'd suggest to add an assert() for that.

> > > +        s->regs.gen_int_status &= ~data;
> > 
> > ati_vga_update_irq() needed here too.
> 
> Thanks. Indeed I forgot this. With that it works a bit better, mouse now can
> be moved but only vertically... No idea why, I'll have to check,

Still progress.  One step at a time ;)

cheers,
  Gerd


