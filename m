Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D64CC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14BE20663
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="pvnp7F/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14BE20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijRtr-0007hK-Pg
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 12:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1ijRqR-0005tl-9r
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 12:50:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1ijRqQ-0005U1-8W
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 12:50:15 -0500
Received: from shroom.duncanthrax.net ([2a01:4f8:121:41fa::169]:57633
 helo=smtp.duncanthrax.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1ijRqP-0005Pj-Mh
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 12:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r2K6B4O0r91thNnDh+saPyZAP9VdHJfai9zKiH07b+k=; b=pvnp7F/cUqkYuS2ZVGh+REpGAB
 z0Dv04MTjV5YO+p6cg+2cbkiXT2Mi5QJorUfSTJaV9tGneG523AdGcfxhqxDMEeymvRl+vsddLNhU
 Wm5ujoZwKzEtPuMYC7gudjpjf+6kqD2axiHr3NvbYzBZ81hx6v/xbgyW29a5hQ0qGu/Q=;
Received: from hsi-kbw-046-005-233-221.hsi8.kabel-badenwuerttemberg.de
 ([46.5.233.221] helo=t470p.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1ijRqI-0006T4-Tl; Mon, 23 Dec 2019 18:50:07 +0100
Date: Mon, 23 Dec 2019 18:50:06 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v5 5/6] hppa: Add emulation of Artist graphics
Message-ID: <20191223175006.GA17323@t470p.stackframe.org>
References: <20191220211512.3289-1-svens@stackframe.org>
 <20191220211512.3289-6-svens@stackframe.org>
 <8e0f79d6-46ba-a121-b6cc-8c0a5cc4ea14@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e0f79d6-46ba-a121-b6cc-8c0a5cc4ea14@amsat.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:121:41fa::169
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Sun, Dec 22, 2019 at 01:37:48PM +0100, Philippe Mathieu-Daudé wrote:
> >  
> > +    if (vga_interface_type != VGA_NONE) {
> > +        dev = qdev_create(NULL, "artist");
> > +        qdev_init_nofail(dev);
> > +        s = SYS_BUS_DEVICE(dev);
> > +        sysbus_mmio_map(s, 0, LASI_GFX_HPA);
> > +        sysbus_mmio_map(s, 1, ARTIST_FB_ADDR);
> 
> How is this chipset connected on the board?
> If it is a card you can plug on a bus, you can use a condition.
> If it is soldered or part of another chipset, then it has to be mapped
> unconditionally.

Depends on the Model. Hp 9000 712 and 715 had it onboard, for the B160L
we're emulating and others it was a GSC add-on card.

Regards
Sven

