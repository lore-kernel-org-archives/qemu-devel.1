Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4C8C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 01:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81BD62145D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 01:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mo1uo1Av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BD62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNRKx-0007Sn-3I
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 21:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1kNRJx-0006uR-4P
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 21:54:17 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1kNRJv-0007OI-Cd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 21:54:16 -0400
Received: by mail-oi1-x244.google.com with SMTP id x14so7774707oic.9
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 18:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OxAQKYEAUM738jQfw1ak2Mxg3V7s5CMgGPbbA66J0EY=;
 b=mo1uo1Av1S3S8oWf17HRl4bARubIysCR4bN8B9802gTmXqBL6oWH8K6eyCYVioGyVW
 0C+8lTVgLSWovkcGsnuQ+f0gkVQ7v5hFogJpq7a+J2qbDcJlXiKwAzZG9S9mg3twVPw7
 BH5VN9p5cvvxuAUUl4ZshmBizFePVG+pTO1Bj+oux3BtzRFh2dA9GXmz9pfqwMwrxTJX
 4pYxXPP2dZ8XJBX52XjNAjvo6imcjMCTFN0SHXEVI+IAFBLDjhTTqt4ciOZRl9HNTIPZ
 hFxeHNVh76aitsJ652yuRxdfnmAWT8UH4FXMYHxMW3OPlxVB1asEdzkZPd9FH7R7LKOc
 eFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition:in-reply-to
 :user-agent;
 bh=OxAQKYEAUM738jQfw1ak2Mxg3V7s5CMgGPbbA66J0EY=;
 b=WUUiVT4mMlNM25SQQ641fw6II72bOp4hBK5beA/e3ow4hEBbwtw7/FPDKFYbIPwukB
 IvfmuR+ghPRQE1xBdB+Rpqxfb1DKLCChVaxlMjJ9T8Ndd3Lk2wtzqMCsBd9eQzySrbXS
 2fFuv7hroZWyk9DCUzAwMWIqbkfinjJFV2QSjRfokiSO7IYBOq42fh26yXezY8fBjUcY
 SbMEf1mVEYo/dOrhJAUQ0XlkrQox4Uagn48ahPnSX2R+bj/U8o3tY/h/Am8Wt2w83A94
 ZWMtvXR/udOth0Xg2JuVj2xFufeWSGQgk4qYeyrnKtzGbcC+szLnGuAb+artvGj8O/vX
 cvUQ==
X-Gm-Message-State: AOAM5318rEp8k13Tml/IrNG6NkNHUCcDz1Yp9+1chRrUQ5m6jQR/wnvu
 PSUpcqKmIL4c//UMSfM1yg==
X-Google-Smtp-Source: ABdhPJyfLoRZpDoieYjPgTUuD5cpjsXQs37xxN4rBtmheOuYHhyvtQKOVhULXMHq/GBmkkDDtZctwA==
X-Received: by 2002:a05:6808:8f3:: with SMTP id
 d19mr219865oic.34.1601430853785; 
 Tue, 29 Sep 2020 18:54:13 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id l3sm62296oth.36.2020.09.29.18.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 18:54:12 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:39:f0c4:8e9f:b46b])
 by serve.minyard.net (Postfix) with ESMTPSA id 6981418003E;
 Wed, 30 Sep 2020 01:54:11 +0000 (UTC)
Date: Tue, 29 Sep 2020 20:54:10 -0500
From: Corey Minyard <minyard@acm.org>
To: Havard Skinnemoen <hskinnemoen@google.com>
Subject: Re: [RFC 0/3] QEMU as IPMI BMC emulator
Message-ID: <20200930015410.GX3674@minyard.net>
References: <20200929003916.4183696-1-hskinnemoen@google.com>
 <20200929174644.GW3674@minyard.net>
 <CAFQmdRaJOqDxOWgoJ6c4TFuJGw5zvb6KyUXoYT0SFJe1xJZhNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQmdRaJOqDxOWgoJ6c4TFuJGw5zvb6KyUXoYT0SFJe1xJZhNQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=tcminyard@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: minyard@acm.org
Cc: IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 Patrick Venture <venture@google.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Hao Wu <wuhaotsh@google.com>, CS20 KFTing <kfting@nuvoton.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 06:05:16PM -0700, Havard Skinnemoen wrote:
> On Tue, Sep 29, 2020 at 10:46 AM Corey Minyard <minyard@acm.org> wrote:
> >
> > On Mon, Sep 28, 2020 at 05:39:13PM -0700, Havard Skinnemoen via wrote:
> > > This series briefly documents the existing IPMI device support for main
> > > processor emulation, and goes on to propose a similar device structure to
> > > emulate IPMI responder devices in BMC machines. This would allow a qemu
> > > instance running BMC firmware to serve as an external BMC for a qemu instance
> > > running server software.
> > >
> > > RFC only at this point because the series does not include actual code to
> > > implement this. I'd appreciate some initial feedback on
> > >
> > > 1. Whether anyone else is interested in something like this.
> >
> > Though I've had this idea once or twice, I'm not working on real BMCs,
> > so I didn't really pursue anything.  It's a good idea, I think, for the
> > BMC developers, and possibly for system developers trying to do
> > integration testing between BMCs and system software.
> >
> > You will need to tie in to more emulation than just the BMC side of the
> > system interface registers.  You will also need to tie into GPIOs or
> > whatnot for things like host reset.
> 
> That is true. The OpenIPMI protocol seems to handle at least some of
> that, so it should be just a matter of adding a few GPIO inputs
> (power, reset, ATTN, ...) to the ipmi-host-extern device.
> 
> I should add some more details about this to the doc.
> 
> > Power handling is going to be a bit weird.  The OpenIPMI emulator
> > starts/stops qemu based upon power control.  It might be possible to do
> > the same thing in this sort of emulator.
> 
> Hmm, yeah, I guess we can't kill/restart qemu from within qemu itself.
> But perhaps stopping all CPUs and doing a full system reset might be a
> good enough approximation for power-off?

This might be argument for keeping them in separate qemu processes.  But
it would be really cool if you could start up a single qemu and have a
BMC built-in running it's own code.  I'm sure something could be done to
simulate a power off.  If you can stop the CPUs, that's probably good
enough.

-corey

> 
> > You may need extensions to the protocol, and that's fine.  I can't think
> > of any at the moment, but you never know.
> 
> True.
> 
> > > 2. Completeness (i.e. anything that could be explained in more detail in the
> > >    docs).
> >
> > It's certainly a good start.  The second patch would be useful right
> > now.  There are more details, of course, but I think that's covered in
> > the man page under the various devices.
> 
> Thanks, I might send the second patch separately in the next round.
> 
> Havard
> 
> > Thanks,
> >
> > -corey
> >
> > > 3. Naming, and whether 'specs' is the right place to put this.
> > > 4. Whether it's OK to enable the blockdiag sphinx extension (if not, I'll just
> > >    toss the block diagrams and turn the docs into walls of text).
> > >
> > > If this seems reasonable, I'll start working with one of my team mates on
> > > implementing the common part, as well as the Nuvoton-specific responder device.
> > > Possibly also an Aspeed device.
> > >
> > > Havard Skinnemoen (3):
> > >   docs: enable sphinx blockdiag extension
> > >   docs/specs: IPMI device emulation: main processor
> > >   docs/specs: IPMI device emulation: BMC
> > >
> > >  docs/conf.py         |   5 +-
> > >  docs/specs/index.rst |   1 +
> > >  docs/specs/ipmi.rst  | 183 +++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 188 insertions(+), 1 deletion(-)
> > >  create mode 100644 docs/specs/ipmi.rst
> > >
> > > --
> > > 2.28.0.709.gb0816b6eb0-goog
> > >
> > >

