Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9CDC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B4B9204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aj7fq97Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4B9204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwSkt-0002MW-JD
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 11:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwSkF-0001wp-NX
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:57:55 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwSkD-0004WC-NN
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:57:55 -0400
Received: by mail-ot1-x342.google.com with SMTP id c25so7206976otf.7
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qAmMcZoRpH/gqtIcUNy0dfrHx1psdWOmorKqixKI1Mw=;
 b=aj7fq97QNen8WoOeBFy7a1EQQyUGNpPH4KyBT6wWKNbFF7sup1ykXYC6BZk8AF9dJy
 DguZr2u3NuAOVQP4ppysT3Wzpsk2HDBGtOU82N9R/lhC3j1QsRWHHDKxsNRtKBBbvyQs
 IiPqL1JlOw1dWos+PpkhtcAXTs1LW/9WiWGj82JMaoB496KY+AXEuUXidHKWFSCmE+J8
 SuZyF5qcVZlPqibv8l0Wha5WCRI3seEHsx/H+MkLpuVlZyffLqHT2Kb8Rr/fAdA3CYzu
 8tA8P/nO6AauxyVpj8A9F+rkX7p7HMX48MxK0BjZZn43gTr+W6HozcYKN8lbieU5qwAT
 9FuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qAmMcZoRpH/gqtIcUNy0dfrHx1psdWOmorKqixKI1Mw=;
 b=VJRgMPQBdvjCmDZbwOWPhNz0kXQmoTzcGhP9uLJ9I3El9FPhtVD40+0HXb5ZhgpDWv
 sWyfPHawbWn2NflfWXKUoUJVk2yTKikX+BbcsiIfadgPkj6Gk3U5sdj0oBmduLlpV0wo
 9DACOEiHe6Mhh6axjy4KnpXN6VGfvhEHH4MPth6BjPk58r4CBIZkWppSBvxKxhM8NLVH
 bTZWhQKT70uj/so0wHQ6LF84lW/R99oY06vyE/r1M5WMzvQG05MZswnzfqGHA3ilryk0
 7wwqIGIsCaksbqhvrwBHWLPOycX+rBBTm+0nsnnD/r10Q7r53bqtAgCZnXnDKa0+xZSJ
 17Zg==
X-Gm-Message-State: AOAM531oIXAqykacXVeCQOrh4aBLBQiLUS477YQEjKkajFRzrBZ+XHax
 igY4K9arpjopgj/XIY5aavvIoXHlHIkmlXb02alsXg==
X-Google-Smtp-Source: ABdhPJxn9e1Z0ArQpav9lTUp8T33qY1x2IMb34ijjJod8RUgbKPjWLIyndozQ9buurR/79uk+I0oZqtwD83r77rOvqo=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr9027178otk.221.1595001472065; 
 Fri, 17 Jul 2020 08:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <20200630122710.1119158-4-ppandit@redhat.com>
 <CAFEAcA-1EhD=0vU1r=48HhFPpovns2M5DBgTu7g2074kueaEuw@mail.gmail.com>
 <20200717095352.45845d8a@x1.home>
In-Reply-To: <20200717095352.45845d8a@x1.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2020 16:57:40 +0100
Message-ID: <CAFEAcA-_8=edW0_uu5UcRnG-pNjkE7GvHyti=og0+vpYAHpwRA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] vfio: add quirk device write method
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 P J P <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jul 2020 at 16:54, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Thu, 16 Jul 2020 18:46:33 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > Alex (Williamson) -- as the vfio maintainer, do you have a view
> > on whether we should be logging write accesses to port 0x3c3
> > here as guest-errors or unimplemented-QEMU-functionality?
> >
> > Guest-error seems plausible to me, anyway.
>
> I believe the intention was that writes would be dropped, so if this
> generates logging that is going to cause users to file bugs, that would
> be undesirable.  Thanks,

It will only log if the user explicitly turns on "log things the
guest does which are bugs in it, like writing to read-only
registers" (with the '-d guest_errors' option).

thanks
-- PMM

