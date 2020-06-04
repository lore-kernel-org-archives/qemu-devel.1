Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455B5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7482065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="iPF4qL9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7482065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglq1-0000HG-59
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jgloQ-0006id-1A
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:05:22 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18]:59410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jgloO-0004v0-KX
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A0O2uP3zgUg8a+8P9/sPRNcmH8TQxrWXHBNcZvSCdqw=; b=iPF4qL9ceDMUchAgys+Dg7RHDJ
 qKvhgngHvflLRinsMpC5xcK0d6GzrNC3JjuztYK+VgSLP94U7E9ie7rsxHfy0wU2nVP7GQMLANGTi
 X18o4aCVVhfEzYb1dSkZDBfjqL8EZpiLlKyd7USS61GCFBFVG2T+79kuSIUX9V2bKQtU=;
Date: Thu, 4 Jun 2020 11:05:15 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: How do I add my tcg tests to check-tcg?
Message-ID: <20200604090515.7pojpek2fh734nb2@schnipp-desktop>
References: <20200603095137.lt6dafpqpa4jzx2n@schnipp-desktop>
 <87v9k85tun.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v9k85tun.fsf@linaro.org>
X-IMT-Spam-Score: 0.0 ()
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=6898900, da=78870581,
 mc=187, sc=3, hc=184, sp=1, fso=6898900, re=0, sd=0, hd=0
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.6.4.90318, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.6.4.5740000
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::18;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=nylar.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On Wed, Jun 03, 2020 at 11:25:36AM +0100, Alex Bennée wrote:
> 
> Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:
> 
> > Hi Alex,
> >
> > I have some time again to integrate my tcg tests patch for TriCore [1]. However,
> > I'm struggeling a bit to get through the details of the Makefiles. I'm assuming
> > the right rule to run is 'make check-tcg'. I tried running that for
> > xtensa-softmmu, arm-softmmu, and aarch64-softmmu, but they are always skipped.
> > Digging into the Makefiles I found that there is some way to use the dockerfiles
> > to run the test. Can someone elighten me on how to properly use this?
> 
> The configure script in tests/tcg/configure.sh will probe for available
> cross compilers (or take a passed in one). Failing that you can fall
> back to a docker image which has the compilers included.
> 
> The result should end up in:
>   $(BUILD_DIR)/tests/tcg/config-$(PROBE_TARGET).mak

that file did not get generated, as I didn't add TriCore to
tests/tcg/configure.sh

Thanks for the quick help. I have sent the TriCore tcg-tests series to the list.

Cheers,
Bastian

