Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7998DC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 03:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E4720818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 03:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F4Vz1gTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E4720818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnb2z-0004oF-Sx
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 23:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47063)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hnb2o-0004Og-TD
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 23:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hnb2n-0004F4-Fo
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 23:55:54 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hnb2n-0004Du-5z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 23:55:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id p13so23074528wru.10
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 20:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jnBei1yTTuleAylaqhr7+3dugwLg+SZA83nWp4EiY+A=;
 b=F4Vz1gTL9d24GYSRA3LpOgsPLKK/Wa7ZDwUzKLQ1MRij7zl2IT/a0qSiTOU4/4boQr
 ZELmKdVVPUk4i+WPTF8TzUsFkDy/GzJP0ICFZZymPlpz39pdKdVUc0fbeuTvXJTFxsp8
 NCBaG3UQKm96kenTyJ3oDOpPX5aHsrI6StcB9keUmX9RXdUGhhsarYJT9FweEVdTtGhs
 dbYALUEP3s8rno7ga2xIq9Dwovsvc4vqXBugvYh1GdW/c+MbN5nIjFScybphkBC0gDez
 K0RQ95gVB3kyuB5KkHFiDb4hy+wN0xp8jAh/y3zKYwvRFyC8Y7gMyRmPCK70ZqA08NnT
 gJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jnBei1yTTuleAylaqhr7+3dugwLg+SZA83nWp4EiY+A=;
 b=KwN9KIO4B61ktSjVAz0Cr1IlC4kNPmM8LF5OXpubuMztHhrVpBCeVq++8aBGdM07J8
 c2oUMN6Byi1bj6CBtTW3XOHGk5moXbNwx68UuxdacgfpvEpvl5Eli8YfBH+eHx+Bk7mG
 UQ3kvT2PD0Wu4H13byF1NntcgU2ndsrrP4Tu568NOTbmXgf6jVaLHJae/NkS3BGUEjzp
 4V615DV/Hxx8hWR+5WiDRg6IzEUAcrjOGh9gNhU/Mmb/tBT2UQyczrYl2UThlMt+kRAW
 nnkIypuDYcgNbK9xg35m33akSoc7RQMzNKf63YQ48YB77Mo1CQhnjK4cMtjcwKoI0zuj
 tCVg==
X-Gm-Message-State: APjAAAWsJWn4DQVsdaZezysTdstDYXWN+y00nxv+IsRbSe4OhQvUIFAj
 thsh1HgQzom2H88xFnJ66/a+2hxFhKIRsxMWppR4gQ==
X-Google-Smtp-Source: APXvYqx0snTZ0UlF/nWwL7nSSv/h6FnsP12UjuFWL/qkLJMSmlKNOTPTjIKprSuj6K4iOtgoHSCEpTHc9qaidm6+5oQ=
X-Received: by 2002:adf:ecd0:: with SMTP id s16mr39066490wro.324.1563335751570; 
 Tue, 16 Jul 2019 20:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559944445.git.alistair.francis@wdc.com>
 <CAFEAcA95grVBoiCbMAeZYTXYxc6nhjx1EM6=05G_3Qqpp8obNQ@mail.gmail.com>
 <CAKmqyKPPtSHSBMvrVxwi1aX=oPSEfxxpD-QQ=ym2ymvcvk5z0w@mail.gmail.com>
In-Reply-To: <CAKmqyKPPtSHSBMvrVxwi1aX=oPSEfxxpD-QQ=ym2ymvcvk5z0w@mail.gmail.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Wed, 17 Jul 2019 11:55:39 +0800
Message-ID: <CAEiOBXWW5HAEvsF0+UYWXJTpnfnawLFbShXyjmyiLmZMcZnUqQ@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v1 00/27] Add RISC-V Hypervisor Extension
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 17, 2019 at 8:17 AM Alistair Francis <alistair23@gmail.com>
wrote:

> On Mon, Jul 15, 2019 at 5:00 AM Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >
> > On Fri, 7 Jun 2019 at 23:03, Alistair Francis <alistair.francis@wdc.com>
> wrote:
> > > At the moment this spec is in a draft state and is subject to change.
> As
> > > QEMU is extreamly useful in early bring up I think it makes sense for
> > > QEMU to support non-frozen extensions. I would like to decide with this
> > > series how QEMU will handle all future non-frozen extensions. That is a
> > > standard way that QEMU users can test future RISC-V extensions while
> > > still understanding things will change. One idea is just to disable it
> by
> > > default, another option is to maybe use the Kconfig to make it a
> compile
> > > time option which developers can use. Should we also display a warning
> > > when running non-frozen extensions?
> >
> > We had an instance of this for Arm (though in fact the
> > relevant patches to QEMU didn't end up getting into master
> > before the spec was finalized in the end). My suggestion
> > would be at minimum:
> >  * by default non-frozen extensions should not be provided
>
> Yep, these are off by default.
>
> >  * they should be enabled via a command line option (cpu
> >    property) whose name starts with "x-", which is our standard
> >    way of flagging properties that are experimental and subject
> >    to change or removal in future QEMU versions
>
> Sounds good, I'll rename the property in the next version.
>
> Alistair
>
> >
> > That way end-users know they're doing something non-standard
> > that won't necessarily be supported in future by newer versions
> > of QEMU, and if people copy recipes/commandlines/random guest
> > images off old blog posts there'll be a hint that there's a
> > reason why they don't work on newer QEMU that adheres to the
> > final spec.
> >
> > thanks
> > -- PMM
>


Hi Peter,

I agree that unfrozen extension should't be merged into master but I think
the patch set is more like RFC version.
Some part of the patches have been merged in into master and will be
available in 4.1.  So my intention is to be
familiar with present h-extension by reviewing the Alistair's great work
and help the work when new patch set are ready
for 4.2 cycle.

chihmin.chao
