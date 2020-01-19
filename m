Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21ECC33CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 17:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B728120684
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 17:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="kSMacf/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B728120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itEKX-0008Fx-JS
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 12:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1itEHK-0007ki-Io
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 12:22:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1itEHI-0005TZ-4s
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 12:22:26 -0500
Received: from propper.duncanthrax.net ([91.207.61.48]:55204
 helo=smtp.duncanthrax.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1itEHH-0005Rq-HS
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 12:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IaPB6sEvBXtD9yZAJOTgkcbRrghXoh4lmTZRESqr1JE=; b=kSMacf/tO49RXylgim/8B2h5Nk
 kjjlPKcf1MzWvBqF/nVCCRrWyuoFMz8Ju7FUHUJv3OALPTxeSWwx3eJa/+KLGrxEAbzINti4I8xsd
 H83whtyQXu48v/SDXFjLkc2zIEpGUUIs3XEQqk30Vw6ZKS9jemfX2exPvBUKTb0eFr+E=;
Received: from hsi-kbw-046-005-233-221.hsi8.kabel-badenwuerttemberg.de
 ([46.5.233.221] helo=t470p.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1itEH6-0007jL-H3; Sun, 19 Jan 2020 18:22:12 +0100
Date: Sun, 19 Jan 2020 18:22:04 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 4/6] hppa: add emulation of LASI PS2 controllers
Message-ID: <20200119172204.GA4835@t470p.stackframe.org>
References: <20191220211512.3289-1-svens@stackframe.org>
 <20191220211512.3289-5-svens@stackframe.org>
 <8eff8c1b-1d56-19a1-a8dd-743517716007@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8eff8c1b-1d56-19a1-a8dd-743517716007@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.207.61.48
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

On Fri, Jan 03, 2020 at 07:15:49AM +0100, Philippe Mathieu-Daudé wrote:
> On 12/20/19 10:15 PM, Sven Schnelle wrote:
> > Signed-off-by: Sven Schnelle <svens@stackframe.org>
> > ---
> >   hw/hppa/Kconfig            |   1 +
> >   hw/hppa/lasi.c             |  10 +-
> >   hw/input/Kconfig           |   3 +
> >   hw/input/Makefile.objs     |   1 +
> >   hw/input/lasips2.c         | 289 +++++++++++++++++++++++++++++++++++++
> >   hw/input/ps2.c             |   5 +
> >   hw/input/trace-events      |   5 +
> >   include/hw/input/lasips2.h |  16 ++
> >   include/hw/input/ps2.h     |   1 +
> >   9 files changed, 330 insertions(+), 1 deletion(-)
> >   create mode 100644 hw/input/lasips2.c
> >   create mode 100644 include/hw/input/lasips2.h
> > 
> > diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
> > index 2a7b38d6d6..7f9be7f25c 100644
> > --- a/hw/hppa/Kconfig
> > +++ b/hw/hppa/Kconfig
> > @@ -11,3 +11,4 @@ config DINO
> >       select MC146818RTC
> >       select LSI_SCSI_PCI
> >       select LASI_82596
> > +    select LASIPS2
> 
> If these components are part of the LASI chipset, you don't need an specific
> Kconfig entry for each, you can simply use the LASI one.
> 
> Add a LASI entry in hw/hppa/Kconfig such:
> 
> config LASI
>     bool
>     select I82596_COMMON
>     select PS2
> 

I'll send a patch as soon as this series is merged - that's easier than
resending the whole series.

Regards
Sven

