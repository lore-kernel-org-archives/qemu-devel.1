Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F7DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 20:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067D62086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 20:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="riIeVtwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067D62086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMemS-0004jY-7g
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 16:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1iMelg-0004Hx-HF
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 16:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1iMelf-0006O7-99
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 16:59:08 -0400
Received: from smtp.duncanthrax.net ([89.31.1.170]:38465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1iMele-0006K9-NW
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 16:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References
 :Message-ID:Subject:Cc:To:From:Date;
 bh=p7oRawM6YBdZk9l6LpW8iJfrVMOvcWy9PPJ5azRCP7w=; b=riIeVtwIM4vMf2NgHQyt88ok72
 H5oaKu/8Qxfr78o+5E2qV4mL2JNTDMOwl3TCP/vIw7Rkq2GrzSKDeZPnim50FpD7TgJ7VgGFrFcMz
 loAL6DVrltzYZpxIpwlXHcisVdYzvWBc0aXnhO8+D6PIpDeKzW0gJPWdp+qLVeev2dDg=;
Received: from hsi-kbw-046-005-233-221.hsi8.kabel-badenwuerttemberg.de
 ([46.5.233.221] helo=t470p.stackframe.org)
 by smtp.eurescom.eu with esmtpa (Exim 4.86_2)
 (envelope-from <svens@stackframe.org>)
 id 1iMelV-00035D-VB; Mon, 21 Oct 2019 22:58:58 +0200
Date: Mon, 21 Oct 2019 22:58:57 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 3/7] hppa: remove ISA region
Message-ID: <20191021205857.GB1439@t470p.stackframe.org>
References: <20191020204724.31537-1-svens@stackframe.org>
 <20191020204724.31537-4-svens@stackframe.org>
 <284a4bcc-a076-2b94-86e0-0bffbe3e61a0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <284a4bcc-a076-2b94-86e0-0bffbe3e61a0@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 89.31.1.170
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

Hi Richard,

On Mon, Oct 21, 2019 at 11:17:24AM -0700, Richard Henderson wrote:
> On 10/20/19 1:47 PM, Sven Schnelle wrote:
> > B160L doesn't have an ISA bus, and we no longer need it to
> > workaround missing hardware, so remove it.
> > 
> > Signed-off-by: Sven Schnelle <svens@stackframe.org>
> > ---
> >  hw/hppa/hppa_hardware.h |  1 -
> >  hw/hppa/machine.c       | 32 --------------------------------
> >  2 files changed, 33 deletions(-)
> 
> This should remove ISA_BUS from hw/hppa/Kconfig as well.

Right. I thought to do so is easy, but that turned out to reveal a lot
of other issues:

- hppa is using the I8259 code, which relies on ISA
- hw/hppa/pci.c seems to only contain unused stuff
- LASI use hw/char/parallel.c, which relies on ISA. parallel.c could
  propably be split up into a ISA dependent part and a generic part

So it is more work to remove ISA completely, therefore i'll drop that
patch for now and submit it later again.

Thanks
Sven

