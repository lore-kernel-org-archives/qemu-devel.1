Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B898FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 03:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81CCC206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 03:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L82PuNDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CCC206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAm16-0006Hn-QL
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 23:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kAm0Y-0005t6-N4
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 23:21:54 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:41313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kAm0X-0003kL-5t
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 23:21:54 -0400
Received: by mail-yb1-xb43.google.com with SMTP id s195so160104ybc.8
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 20:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bAZ9m90F6Uij1i6GpKxO4ERbqgUw9KDOp0yI+WeIPz0=;
 b=L82PuNDmgIMIdw5cRzcoalnxtbpPbMaw+XOSDZqUM+hVGvPzd4qaBiMBr5/+185Z8Z
 qUpdY6RF4tA5mqH5Eq1mhPzZCA85EB932aPC58s6I7uLz4b5yvJ3/ls7uMlpg6PXw627
 cYUGw4WXTZDXDksrLaAsFYYXlqqsuLMSnbPEC3GkQPhFXMcKZMVLxQLzzlD61C01Cek0
 sret7EovVoVhnaKEEONSGjoCV65fKTmZa3KclySTJvAm/dF3GlR6DwmjKwt+GbdPKUoc
 bMwOEmImnT0aZM1uFs0T2OelwCFFKU85y844L4sMhjy8Y/xJxn5R23sFeR1o27xwCydP
 sXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bAZ9m90F6Uij1i6GpKxO4ERbqgUw9KDOp0yI+WeIPz0=;
 b=DXptaVN+s65xWzOOmh6S3BVhXey8GrAFsFJwHg5XjcnfOhvLayj1lC4vafAm9dOyfH
 XveWykSkIOb9rfAtB8PQ/nGSl381D5nudIBXAtCghK2bLcWtX2Fe325KICcsDp0n3r4Z
 sbX2TSPJJHyzMDxmHCTSGyPI0LC4aEwZ1VuoA4+Y+kXBxOKXx+NlyXCsjYpwKipMp0Fe
 Zo+musI6BNgU9gKb+ooP5mPF7HUVdsln2kJUs19mKCpy6t3ksE/7fczcFXcgJn1HzWbe
 TNrug3b/OiIQeA2kTH0WPKyPWgUgA3WHzO4fl51FfqeRqjZElIDuKcWGQ4GpJ3SM2QPM
 c4zg==
X-Gm-Message-State: AOAM532ORLZwC0sDnHEnU9EZG61BUFZGUq6UsMqnGjoxeqj4W+E0Ztk7
 2rQa2F+n+BHJPi/KEkzHmq3hwmjS6GXhDvSIhSI=
X-Google-Smtp-Source: ABdhPJyVAu4cYtxGbUX9vpXMrDdrClT6WY+dpJ16SNysTcBFrK6L4bclh6gmoYDgoaWV3zvhzi1Mz7XHmydWuz+MVZ4=
X-Received: by 2002:a25:3b0d:: with SMTP id i13mr18410987yba.314.1598412111840; 
 Tue, 25 Aug 2020 20:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
 <CAFEAcA8=Mf=EPh__tNhJyGv8+ouD-HH+MuMb+HhtTFes+XqUSQ@mail.gmail.com>
 <CAKmqyKNxURXyNSEePPU1jY7FzcZjRThr2qAvwR393+nqUXBxJQ@mail.gmail.com>
 <CAFEAcA8x=ck1mmJ8Y8o-0NQXWhRgOg5Gp7GvHNkNnLb6rDxygg@mail.gmail.com>
 <CAKmqyKP6OUoaR6iZ6SD6qZPvYF0bKqpB_rRNeQOteg8BtcqKeQ@mail.gmail.com>
In-Reply-To: <CAKmqyKP6OUoaR6iZ6SD6qZPvYF0bKqpB_rRNeQOteg8BtcqKeQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 26 Aug 2020 11:21:40 +0800
Message-ID: <CAEUhbmWN93n1JoGszsW6WrkGbdFD6VsGyi7Ji6bS6wF+DbMOBw@mail.gmail.com>
Subject: Re: [PULL 00/18] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 6:41 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 2:50 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 25 Aug 2020 at 22:32, Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Tue, Aug 25, 2020 at 2:24 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> > > > The hypervisor related patches don't seem to have any
> > > > reviewed-by tags, which seems a shame for a fairly significant
> > > > chunk of work. Is there really nobody who can review them
> > > > for you ?
> > >
> > > Unfortunately not. They have been on the list since April and haven't
> > > received any feedback.
> > >
> > > There isn't a lot of people reviewing the RISC-V patches unfortunately.
> >
> > :-(   I'd hoped it was a more active target than that.
>
> There are lots of active contributors, we are just short on reviewers.
>
> Richard and Philippe review patches and some of the RISC-V patches get
> reviewed by the RISC-V community. The main problem (which is a common
> problem in open source) is that large technical patch series just get
> ignored.

Yep, I am only comfortable reviewing patches which I have confidence
in. Right now I am not working on any H- or V - extension for RISC-V
so I cannot contribute to any review of these large numbers of H- or
V- extension related patches. Sorry!

Regards,
Bin

