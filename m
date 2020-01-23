Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E886FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:25:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A7722522
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNIIwcC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A7722522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iui6L-0006Ae-6b
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iufnP-0006XP-E9
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iufnO-0006gH-CE
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:57:31 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iufnJ-0006Za-7i; Thu, 23 Jan 2020 11:57:25 -0500
Received: by mail-pg1-x543.google.com with SMTP id u131so1652509pgc.10;
 Thu, 23 Jan 2020 08:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DX9XPLUMx26HScqd/BBt+1dKos1BhNzRsteN/4RmO2g=;
 b=FNIIwcC37Uv5CUhA8kKyYV+ee7VZXuIPixuIFl7WWel/TvADRoQtojyOccW1bllX3N
 c5NXOnlm4NOq+0+ytxL/oRtomMh3LTbFuwikiv9sDUUT2OaT4j8ALPQVV8jh/kj8YvDN
 m3QdetRNsz31lgCzLhZu71t06UTLww2msQ/N7nQYRmvcz15ewZF990Zc9NJf/quDwqjJ
 kYiLdAq60tqtus3h73VyOBhLAcGfCyT3tGI2ixIhBEqLEvr5ltlu3bB8bn8wxXCUCCcd
 BXmlBv0oyxt3j+JA6HJd/T/mIoiRBs89ekcP9CbsLbuRT2kboA+7WX9VIRq8xjHdiZhU
 qDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=DX9XPLUMx26HScqd/BBt+1dKos1BhNzRsteN/4RmO2g=;
 b=Pxo7uU4DaKBkavY6IxgN9mBPN5mIT6KZIgM2XORq85h2RRoIWWx+oCw9gY4wCt+4lG
 hGsEImn6YkarndmJ+HoCRcqpp7Qvep4+69tmXxwbSTKg632GroMOVQRbEbVLBsNflDAv
 CbDMaXQ/vxsNLVb1r7FcS2d3WJTJemEeFgTdXaCvzttd+EuR67vR22JdreEUuw2xCTVP
 OJAB7Aq9TAdk6g3saUxJwkh2U3oLLE1+Pp5Z5pQ4gWxU57oo0A1Vd1XKnvJez2NBbPtq
 cF7pvv+dz56RQ1vCe+SJ1EtA2ta9lsUmK6bPFFWnpBiQS7TDP9vVI9SsubY0qg2O801k
 Vxog==
X-Gm-Message-State: APjAAAUGtU8yrSqXPtshh5cULzqdXwE0D3HDpAC0ryNVuHZcYI5k5mTa
 OCiyPHoQw+X8wVPo/rXit3I=
X-Google-Smtp-Source: APXvYqxPL67w4/GCDC05r5iBuRpYTzMGui3BJeOn6/7yOLD5+/k5Ygxn/Jt3U1HLFAexiuk2QXO1AA==
X-Received: by 2002:a65:4047:: with SMTP id h7mr4970926pgp.60.1579798644055;
 Thu, 23 Jan 2020 08:57:24 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id p17sm3212163pfn.31.2020.01.23.08.57.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 23 Jan 2020 08:57:21 -0800 (PST)
Date: Thu, 23 Jan 2020 08:57:20 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 1/8] dma/pl330: Convert to support tracing
Message-ID: <20200123165720.GA4805@roeck-us.net>
References: <20200123052540.6132-1-linux@roeck-us.net>
 <20200123052540.6132-2-linux@roeck-us.net>
 <CAFEAcA-SPUPEcV4Uw9=8-5EJmLztVorV++ypFp=vYxasncBrZw@mail.gmail.com>
 <CAFEAcA9p7Foko17jTB_GSGLnaQwpJTcf0-qTrJkVWje1jOpq-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9p7Foko17jTB_GSGLnaQwpJTcf0-qTrJkVWje1jOpq-g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 04:23:59PM +0000, Peter Maydell wrote:
> On Thu, 23 Jan 2020 at 15:51, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Thu, 23 Jan 2020 at 05:25, Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > Replace debug logging code with tracing.
> > >
> > > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >
> > This turns out not to compile on OSX, which is a bit
> > stricter about format strings:
> >
> > These two:
> >
> > > +pl330_dmald(uint32_t chan, uint32_t addr, uint32_t size, uint32_t num, uint32_t ch) "channel:%"PRId8" address:0x%08"PRIx32" size:0x%"PRIx32" num:%"PRId32"%c"
> >
> > > +pl330_dmast(uint32_t chn, uint32_t addr, uint32_t sz, uint32_t num, uint32_t c) "channel:%"PRId8" address:0x%08"PRIx32" size:0x%"PRIx32" num:%"PRId32" %c"
> >
> > both provoke
> >  error: format specifies type 'char' but the argument has type
> > 'uint32_t' (aka 'unsigned int') [-Werror,-Wformat]
> >
> > because of the last argument.
> >
> > Easy fix would seem to be to change 'uint32_t ch' to 'char ch'
> > (the argument is always a literal constant 'Y' or 'N').
> 
> The 'chan'/'chn' argument is wrong too -- should be uint8_t
> to match the format string and the type of PL330Chan::tag.
> I'll just fix up the pullreq rather than forcing a respin.

Thanks, and sorry for the trouble.

Guenter

