Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E660C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 01:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BBEC20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 01:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tB71iyDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBEC20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNQZw-0000CE-5H
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 21:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kNQYm-0008Cn-Sd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 21:05:32 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44]:37048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kNQYj-00034F-Na
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 21:05:31 -0400
Received: by mail-vk1-xa44.google.com with SMTP id h23so34513vkn.4
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 18:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FoyFyzp6E3LDn7z9CHnhiE2TsJI3nV8V4sbVPljM0F0=;
 b=tB71iyDMfj9rWzxD2mrOYzYVBKfF6sG2h3KFrLr7csiB7TVDh40bdMUvGafCf6h1AY
 q12B6975GZm+W1Up3KdgQT6EqUSDO4dUe63n7PiMFnm5tJNRaP5n/NVUf48WZUr25IoD
 lSoc0PdmYsUENgK/VLry2e9QalJR1GYSK5xjnPhMnIiJ8S4YoIKzmbMKJhd2A134B62O
 AJhgFDympazXtwAITTo9AQvoThTatHvnn5yPnOujV5LTh8OFP+8VcBShFT8V7XXxr2Q7
 ISfTJt5BP2w0A2KWtp7WK8w5l/VlCdfij1p9fR4c85dQuMMd944QHeWJ/UhNwPvXQU1F
 5OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FoyFyzp6E3LDn7z9CHnhiE2TsJI3nV8V4sbVPljM0F0=;
 b=Joea8IiOzfn/xUeFGpmRL1jOHCsZh9Q6IPf0KNDmPqU2ILjfv6Pk2krHJEfoQaXGUj
 71V/8KoGP0x0EwlkpSt8FgQOYZHKr11rfV+9Ea5r+7WE6sYhf0m7du9fr/AgeZNzjYxU
 aH15V0vKIm+RyendDykz0kdxJZ3VlLVJozMPQ8ml+kTGG3STJCXNWN/CCorXGNNoeqIs
 EezQbZdUjOS/GQEeYm9DAVh5qQ1cx6bSWgzO4dM3+L4JOc17bVs2U6JP3k1G0WwzzdJE
 r1VP2cjWncKEULPmOSA5NeBEWYUB1wtNtt32RWaHjvuVwItwZjCy6P/mv0NPMPRYugIt
 nhXA==
X-Gm-Message-State: AOAM533/Axtj5tP7AdEOPnG3yFxDnUyR1fafHirt4Ap+eRozWM4sSav5
 JfbjQkim0KVw1akpw3zy9vrGn2AzWv3kilVvWLOxew==
X-Google-Smtp-Source: ABdhPJxvYnt8wVVT+NdJF0s8SjpY+ZuC5DIYp6tMJMWIcPn7NQklBW+C+/AuZ7vBiL95SjtBuVI6LsbimmGgqTU2caw=
X-Received: by 2002:a1f:b64a:: with SMTP id g71mr111994vkf.11.1601427927991;
 Tue, 29 Sep 2020 18:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200929003916.4183696-1-hskinnemoen@google.com>
 <20200929174644.GW3674@minyard.net>
In-Reply-To: <20200929174644.GW3674@minyard.net>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Tue, 29 Sep 2020 18:05:16 -0700
Message-ID: <CAFQmdRaJOqDxOWgoJ6c4TFuJGw5zvb6KyUXoYT0SFJe1xJZhNQ@mail.gmail.com>
Subject: Re: [RFC 0/3] QEMU as IPMI BMC emulator
To: minyard@acm.org
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Patrick Venture <venture@google.com>, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a44;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.468,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 10:46 AM Corey Minyard <minyard@acm.org> wrote:
>
> On Mon, Sep 28, 2020 at 05:39:13PM -0700, Havard Skinnemoen via wrote:
> > This series briefly documents the existing IPMI device support for main
> > processor emulation, and goes on to propose a similar device structure to
> > emulate IPMI responder devices in BMC machines. This would allow a qemu
> > instance running BMC firmware to serve as an external BMC for a qemu instance
> > running server software.
> >
> > RFC only at this point because the series does not include actual code to
> > implement this. I'd appreciate some initial feedback on
> >
> > 1. Whether anyone else is interested in something like this.
>
> Though I've had this idea once or twice, I'm not working on real BMCs,
> so I didn't really pursue anything.  It's a good idea, I think, for the
> BMC developers, and possibly for system developers trying to do
> integration testing between BMCs and system software.
>
> You will need to tie in to more emulation than just the BMC side of the
> system interface registers.  You will also need to tie into GPIOs or
> whatnot for things like host reset.

That is true. The OpenIPMI protocol seems to handle at least some of
that, so it should be just a matter of adding a few GPIO inputs
(power, reset, ATTN, ...) to the ipmi-host-extern device.

I should add some more details about this to the doc.

> Power handling is going to be a bit weird.  The OpenIPMI emulator
> starts/stops qemu based upon power control.  It might be possible to do
> the same thing in this sort of emulator.

Hmm, yeah, I guess we can't kill/restart qemu from within qemu itself.
But perhaps stopping all CPUs and doing a full system reset might be a
good enough approximation for power-off?

> You may need extensions to the protocol, and that's fine.  I can't think
> of any at the moment, but you never know.

True.

> > 2. Completeness (i.e. anything that could be explained in more detail in the
> >    docs).
>
> It's certainly a good start.  The second patch would be useful right
> now.  There are more details, of course, but I think that's covered in
> the man page under the various devices.

Thanks, I might send the second patch separately in the next round.

Havard

> Thanks,
>
> -corey
>
> > 3. Naming, and whether 'specs' is the right place to put this.
> > 4. Whether it's OK to enable the blockdiag sphinx extension (if not, I'll just
> >    toss the block diagrams and turn the docs into walls of text).
> >
> > If this seems reasonable, I'll start working with one of my team mates on
> > implementing the common part, as well as the Nuvoton-specific responder device.
> > Possibly also an Aspeed device.
> >
> > Havard Skinnemoen (3):
> >   docs: enable sphinx blockdiag extension
> >   docs/specs: IPMI device emulation: main processor
> >   docs/specs: IPMI device emulation: BMC
> >
> >  docs/conf.py         |   5 +-
> >  docs/specs/index.rst |   1 +
> >  docs/specs/ipmi.rst  | 183 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 188 insertions(+), 1 deletion(-)
> >  create mode 100644 docs/specs/ipmi.rst
> >
> > --
> > 2.28.0.709.gb0816b6eb0-goog
> >
> >

