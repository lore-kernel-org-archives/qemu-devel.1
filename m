Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E2AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E73B2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIH0mT9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E73B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCug-0006ir-EF
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixCtr-00057m-6M
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:42:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixCtq-00084t-BQ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:42:39 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ixCtq-00083p-6s; Thu, 30 Jan 2020 11:42:38 -0500
Received: by mail-oi1-x242.google.com with SMTP id p125so4097400oif.10;
 Thu, 30 Jan 2020 08:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xan89D3pvQMbkkmOMtQj9Exv7itvnLmUUN+3NmzwLV8=;
 b=JIH0mT9uGT+EpWLosZrTIP3vYzC+l8qrhI3Gk7xQ4Gg7tvcRUUg7n/eWhyPEKdZvMq
 1glOqIIjzyKSq6vL2bosTa/6MBmvtI86TfLz+7q4SHDpdAVqsZVjTU9s4C6DcnQKKj1x
 r7ka7h6bt0B81FSd4pa/n2B2AvQ35cxQ7o0xuswTABoqOc70QenUPQzSpohHzcrDZrtN
 XYV01eThcPT3qpdcRcghug/lmRKnLqr2UuksoDbmyIPP7zBBBkIN6em5rLfUka5O2HR8
 //LvfUlqZ4slVoSA68E/k2Mqx25oPGaX8Sr5brivrMux1XvQuNV4i0BWZXzC4a3rInP/
 sLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xan89D3pvQMbkkmOMtQj9Exv7itvnLmUUN+3NmzwLV8=;
 b=HXP3YsDOGpKLfNzDIhjps/MU2sZSJlej7050Z8s20r8P6v4LcomX+HnQHRpQSdaszJ
 V6cU9L+wUpqBeCgtBEIAWRxs7RjBlcctOKvytrj2ozC5GPzmXxb06sq2Vtqsox/Gr03H
 bNMLVMFtK3R/BwtmXSA3c2YnyYr8hGhGrm6QtddsCwXfJPIlpp4msWj+Bgd3jz8f+vrT
 cOhEOSIql+8cwbsxnSLB6iT9KMDkwuBREVc416jOWnCrLgk/5IPNRx8OUuvIY2EEMnBG
 Elv6TsNBtt+DnPFmLUKhKZJfVIAGJgA9rky7+bo6awViJE7zhFqEAlsXsJMKFKurbR09
 Gtwg==
X-Gm-Message-State: APjAAAXM2GYL1ffzzlS8G6AhtbKYwh7g8SZYcdfuYYniUxOvhPeKiGz1
 csyn42JLP5tPeaHQco1jSrFu/7oGq5nukjPKfg4=
X-Google-Smtp-Source: APXvYqxpxzfL2sL62EDNy1L2FWwqhmhmF/3fFGG+l4k2IXiNDQccGUmia6k+wulqt3BJHuGByRQ60DhLyzvVJpnZL8g=
X-Received: by 2002:a05:6808:6c5:: with SMTP id
 m5mr3347382oih.106.1580402557474; 
 Thu, 30 Jan 2020 08:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20200129235040.24022-1-richard.henderson@linaro.org>
 <CAL1e-=jbTY6a-B4RkoR9hL_h5LiOwio=A6pp3=KqqjUu7bEWUQ@mail.gmail.com>
 <170b1d50-72b5-72c1-7bc5-9c41d84425cf@linaro.org>
In-Reply-To: <170b1d50-72b5-72c1-7bc5-9c41d84425cf@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 30 Jan 2020 17:42:26 +0100
Message-ID: <CAL1e-=ho7N=VTLrc8peROEq=7Yo_kuXPasCYqwNRbQdekqouVg@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/ppc: Use probe_access
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 "open list:ppc4xx" <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 30, 2020 at 5:09 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/29/20 5:35 PM, Aleksandar Markovic wrote:

> > My additional concern, of course, is: Are other targets exposed to performance
> > degradation, and why?
>
> Potentially, yes.  However:
>
> It requires lots of loads in a loop, on a hot path.  I would not have guessed
> that the ppc32 Load Multiple Word (et al) was on a hot path at all, since the
> instructions are deprecated.  But that's what an ancient os gets you, I suppose.
>

OK.

>
> r~

