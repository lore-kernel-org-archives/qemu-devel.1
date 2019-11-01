Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E09ECA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 22:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48488217D9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 22:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="Wlq6q4Ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48488217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQf3U-00030y-2z
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 18:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1iQexh-0001SB-Hw
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 18:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1iQexe-0006Ia-9z
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 18:00:04 -0400
Received: from shroom.duncanthrax.net ([2a01:4f8:121:41fa::169]:33219
 helo=smtp.duncanthrax.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1iQexZ-0005hQ-CG
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 18:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References
 :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gxVD6etMuleHcna34Hgdm6ehb9ZJJSp8yUcBXwXKR3E=; b=Wlq6q4OtNH3bwLXTGIjiovCDgo
 ZESsJMIXHTYW/IYu3ax32IB5QAr2SNQa2qa8s2VLRXZNRaMOohfH4qzXK/IpTrYB7MNI+ZQfavO4m
 Nljq2m0a6BCzTrf31HK2q61F3J6LuUtO7GHXBJkqJtutgYzjMJ/Y6rWoIvZPaoD5TLyo=;
Received: from hsi-kbw-046-005-233-221.hsi8.kabel-badenwuerttemberg.de
 ([46.5.233.221] helo=t470p.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1iQexM-0004em-PA; Fri, 01 Nov 2019 22:59:44 +0100
Date: Fri, 1 Nov 2019 22:59:44 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v3 5/6] hppa: Add emulation of Artist graphics
Message-ID: <20191101215943.GB9053@t470p.stackframe.org>
References: <20191022205941.23152-1-svens@stackframe.org>
 <20191022205941.23152-6-svens@stackframe.org>
 <b91ee508-2ae4-0307-561a-f930a7709404@ilande.co.uk>
 <20191025093159.GA4261@stackframe.org>
 <1a414492-1623-5620-9e5b-097b45fc746a@ilande.co.uk>
 <20191026175439.GA10792@stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026175439.GA10792@stackframe.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Hi Mark,

On Sat, Oct 26, 2019 at 07:54:40PM +0200, Sven Schnelle wrote:
> Hi Mark,
> 
> On Sat, Oct 26, 2019 at 10:35:20AM +0100, Mark Cave-Ayland wrote:
> 
> > > However, the VRAM in Artist is not really exposed to the Host. Instead,
> > > there's the Chipset inbetween that can do byte swapping (Colormap is LE,
> > > VRAM is BE) and Bit-to-Byte/Word/Dword conversion. For example you could
> > > write 0x55 into that VRAM region, and the chipset would expand that to
> > > VRAM Bytes: 00 01 00 01 00 01 00 01. And to make it even worse emulation
> > > wise it can also do different encodings for Read or Write accesses, and
> > > mask out certain bits of the data. So after trying to convert it to the
> > > "dirty bitmap" API i decided to just leave it as it is. The CPU load
> > > used by the display update code is usually < 1%, so it's ok for me.
> > 
> > Wow that sounds that some interesting hardware(!). Does it make sense to model the
> > behaviour of the chipset separately using a proxy MemoryRegion similar to virtio i.e.
> > introduce an intermediate IO MemoryRegion that does the swapping and then forward it
> > onto the VRAM MemoryRegion?
> 
> Thanks for the pointer, i'll check whether that would work. For now i
> think i'll remove the Artist patch from the series, so we can apply the
> other patches, and i'll re-submit Artist when it's done. I guess the
> rewrite to use a MemRegion is a bit bigger. But i would to get the other
> patches in especially the LASI Stuff as both Helge and i have a lot of
> stuff depending on that.

I've looked into it again and changed my mind. There are at least the following
functions that the Artist chip does before a Read/Write is passed to/from VRAM:

- endianess conversion (actually configurable via some register, but i don't
  know how and hardwired it depending on CMAP / FB access)

- The Address passed on the System bus are the X/Y coordinates added to the FB
  base address in the selected buffer instead of the VRAM offset for pixel data.
  I think that's configurable via the some registers, but i don't know how.
  Unfortunately there's absolutely no documentation about Artist available and
  everything was developed by reverse engineering.

- bitmap to Byte/Word conversion (not implemented yet for the VRAM window, only
  for the I/O register window)

So in my opinion it's way to much effort to squeeze all of that into the memory
space, and it is not really a Memory range that's just behind a bus bridge.

Regards
Sven

