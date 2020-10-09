Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC95C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 09:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D7E22258
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 09:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qiz5q2f0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D7E22258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQooo-0000KW-BV
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 05:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kQooC-00088D-K6
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 05:35:28 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kQooB-0004bG-0O
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 05:35:28 -0400
Received: by mail-pf1-x442.google.com with SMTP id e10so6390562pfj.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 02:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Px80NKFRN/Qhwq8fc/3pbACbxDFmAXwGiIdglnUmglk=;
 b=qiz5q2f0D0j7UYcxqnlgnsFgrYxlGWfYJLzrDF06q/7Z2nYQyJuMno/lBZK54srW2e
 HZrM6j7t4sLLYumRB3jxYH4N+/6M/qOssCAxWsp0t5vpuUdp/+dXS64AzAKeozG3EoAw
 huGtF8AGUoPb2H+9s2XTHtbIGc/VZLPNF8UATDv5wt1HJ04saXtjiOVaFv+4CSP6ieVx
 IT8iX0CfUFhn2NT8ay6bIyORVFoJkp0q8/97Adu7+vj6hOM/Ij54M7nYHIB5WFq+dsCr
 pn8Bn9tiCYd7GtNWAe43i1WjzpUtoTZHQAs1FfEU/Xj0hEJUwmlBWJNOzJrl12Kr3CE3
 PrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Px80NKFRN/Qhwq8fc/3pbACbxDFmAXwGiIdglnUmglk=;
 b=b5flOUODgEIoaAjok9mjyU5vhUA/Khi6AHBN4hdlkrME9e+8Ao9U1HToiNaa7KYzCv
 gGenPscUkzWmytBaOtbvaWvAw9QyrgHEs0vJhCY+sl1x3hKvc66xp7NjY55aEZ5m1aIe
 TmNZaAp1DCSqMYBVeCyiHmFa7NCBcuaOhj93ScHFCxMr/tfk3WHkVVnsPG/aQVsiFRHa
 5aDTrheg/NMDfvsYHL84359JH12UEDcJUv/Nkgcmf8V+TGgsumxRGesgVxF1PgBBDTZf
 rhqFWYMBBi3qkfKQMq/NKQCpN5j5nO8L8JTV4+FyXKCEfhBPCNalsc+Uy3TDVGizBdlW
 xfMQ==
X-Gm-Message-State: AOAM531gCt9CUBpFP42lGZYvhgatEOX8cshTG4pY2CLbHCRrRbxtKemL
 nMKRb3PBYmOzmp4sCi2odXLuFRf514yKPBDRFbQlew==
X-Google-Smtp-Source: ABdhPJxxZ2bS8LdHJBLY5aleqRK8p8RkOQ+aDN+7guKGyqEAZVuFsuOs6M4fFjnEjFFKGEQ+mT5U4e94IFvB68nMyG8=
X-Received: by 2002:a65:64c1:: with SMTP id t1mr2660395pgv.55.1602236125529;
 Fri, 09 Oct 2020 02:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201008024203.112303-1-shashi.mallela@linaro.org>
 <20201008024203.112303-2-shashi.mallela@linaro.org>
 <CAD8XO3ZRGqNbr1GM6jMAdhm=pPXXr6K7m_F0MKRDQMnrDw=yDA@mail.gmail.com>
 <CAFEAcA9QRJhorL1XtWBCQk9uo21OtMHUrH7ipG3tiFbOBGizPQ@mail.gmail.com>
 <CAD8XO3YaavVfz6yaAx2N95B8a87tkp=-GKt814Zou4e7B+cVvg@mail.gmail.com>
 <CAFEAcA__EG5Ou9W0H24oEKFA9Ft11n6pjcSwD-ZG4Bir8=3Xhw@mail.gmail.com>
In-Reply-To: <CAFEAcA__EG5Ou9W0H24oEKFA9Ft11n6pjcSwD-ZG4Bir8=3Xhw@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Fri, 9 Oct 2020 12:35:14 +0300
Message-ID: <CAD8XO3bNhRpsHF40KLWJNayL-FoX3vSyubAyUUPC++Btpdt6QQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] hw/watchdog: Implement SBSA watchdog device
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=maxim.uvarov@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Shashi Mallela <shashi.mallela@linaro.org>,
 Leif Lindholm <leif@nuviainc.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 8 Oct 2020 at 17:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 8 Oct 2020 at 11:43, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> >
> > On Thu, 8 Oct 2020 at 13:27, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Thu, 8 Oct 2020 at 11:21, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> > > > Interesting why gcc does not warn on  64bit signed to 32bit unsigned
> > > > truncation here. Looks like it's too smart to understand
> > > > that value fits in 32 bits.
> > >
> > > What truncation? 1000000000 in decimal is 0x3B9ACA00 in hex:
> > > the number fits in an 32 bit integer without truncation.
>
> > I meant that LL is an long long int which is 64 bit size type. And
> > then you pass it to uint32_t.
>
> Yes, that's fine, because it fits. The LL ensures that if
> you do a calculation like:
>  uint64_t max_timeout = 16 * NANOSECONDS_PER_SECOND;
> it isn't incorrectly done as 32-bit arithmetic.
>
> thanks
> -- PMM

Ok. Thanks.

