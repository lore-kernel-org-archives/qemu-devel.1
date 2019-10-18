Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAC6CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6290D2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="bop1k2OR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6290D2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTR2-0001DH-DY
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1iLTQF-0000Tl-JP
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1iLTQE-0005gi-Dl
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:40:07 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:58007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1iLTQD-0005gE-Py
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=VUWcLIA4+OFg7yhtjNY2Mp/f9AESE3jnRQA9Vf+MHnA=; b=bop1k2OR3dyqmHqyUps2NX7Lr5
 zSL10yaZWik7ZxAtzotyI4r4/AXWLqxINsa2rt8jxpXGA7JBDCH7/YByapcWVa4H1JMVbrRMwcf3X
 ArGqqA63ZBxbJ/RSyu+TixeLcaTjqi4WJTz0+OVkXiU1qmd42GEPj+t9VbOtiPQ/Y+AY=;
Received: from hsi-kbw-046-005-233-221.hsi8.kabel-badenwuerttemberg.de
 ([46.5.233.221] helo=yeti.stackframe.org)
 by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.86_2) (envelope-from <svens@stackframe.org>)
 id 1iLTQA-0003Qh-HP; Fri, 18 Oct 2019 16:40:02 +0200
Date: Fri, 18 Oct 2019 16:40:00 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 0/2] tests/acceptance: Add tests for the PA-RISC machine
Message-ID: <20191018144000.GA10996@yeti.stackframe.org>
References: <20191010122128.29000-1-f4bug@amsat.org>
 <CAAdtpL4Y24_12FBDP_Ohh-hpOS3vG+XS7K-LCFCWkPwkWGQ5wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAdtpL4Y24_12FBDP_Ohh-hpOS3vG+XS7K-LCFCWkPwkWGQ5wg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:470:70c5:1111::170
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,
On Fri, Oct 18, 2019 at 04:23:10PM +0200, Philippe Mathieu-Daudé wrote:

> Sven since you tested this series, can I add your Tested-by tag?

Sure, please do.

> On Thu, Oct 10, 2019 at 2:21 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> >
> > This tests boot a HP-UX firmware CD-ROM which allow serial
> > console interaction. This exercise the PCI LSI53C895A SCSI
> > controller.
> >
> > I'm not adding it to the Travis-CI list because I'm not sure
> > how to split/rename the current job, see:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg644753.html
> >
> > Philippe Mathieu-Daudé (2):
> >   tests/boot_console: Send <carriage return> on serial lines
> >   tests/boot_console: Test booting HP-UX firmware upgrade
> >
> >  tests/acceptance/boot_linux_console.py | 27 +++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)

Best Regards
Sven

