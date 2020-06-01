Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F02C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD30D20679
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="garHZD5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD30D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjt8-0005FG-44
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfjpF-0001qj-1D
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:45:58 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:44582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfjpE-0005iy-5C
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:45:56 -0400
Received: by mail-ej1-x643.google.com with SMTP id gl26so9045823ejb.11
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jr0xc/2sWUN4QoEyVCv5X8k5gtIoLCiFRIzV6bdie10=;
 b=garHZD5KN3c3SEP1BMXgJr65flVJ8hFgMWza3RBBdVFG+08N/QYHOg29KKz45APoZF
 17MHiur2Nk0OgfDIvqpZiTdM00wUJx3gBvVMx5WHMM/tdvW6L1nUPG0el/igN5fXTTXc
 kmxRJrvw6YHSmDOl3FNGnJIqW+Ys2pcR6GVi/cY37critP3Gaj2HZhCKXd6NY2rftJE0
 Cd0l/ws1zdx8aPo72IvzyZJp2cb4zvhSapcS4QIQYOADoOeQZvtnI1CE/jkZPy0txBDe
 hjWS921gF2x+laqfGMnCdkjOQ0bFIvNGETAHnO7o7BIcmJwk2lwi1eleeNqgC3Ob9rUg
 YueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jr0xc/2sWUN4QoEyVCv5X8k5gtIoLCiFRIzV6bdie10=;
 b=GfBAfmm/JqU+h8eaYWxXHp8tZOCiYoT/Vu61K/tFQl8MTrbZo4LxNEev44OZjfInGQ
 sFdhBVH16/jCyGw/apD28PG0ApYACQm6S8VWEQzjqmfmjyYBHp+ScAzHhbQ1QvD6l2U8
 yVIyGQPUcTALT2DFRR2WWcMZRHOBcTnJou4xTagP7teqG4eXmD0oOwe3tJtOCX9P4VkP
 bq+aWliJ8sNUJ7N7WERi/p0DQcUlc5wfzRYDedPlDVsyjk4V/TjetEJwMXhfeCv8+r6+
 lhwJJm+aQsZEXihhhj1TpR9fWRaD73upJSvqzM6FUFbbfVDw6BppSArDVq/J2nJEL4Fv
 9eMA==
X-Gm-Message-State: AOAM533q4tsQO3PhzfIvrugZ9P9pVdbw0HNHOFmxpF9uMrWEUoqzdyEj
 RewZ6jxhH/tXU/1iujNgFsGnVzGDm63hpoIcd/M=
X-Google-Smtp-Source: ABdhPJwlUnmpSEGgsE7UwohtGV+aHLpQvfCYXpmMKXxh6PNYErt2ujS/PzkgnC9ofn4iNKtgc0LzYUoZuGQ8yCdSWz0=
X-Received: by 2002:a17:906:e47:: with SMTP id
 q7mr5868992eji.279.1591015554700; 
 Mon, 01 Jun 2020 05:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <1591013898-23391-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <CAFEAcA-Z6bcXW3nAqnv+CCTqy1JhZjdqJcdwHApFuUejutH+BA@mail.gmail.com>
In-Reply-To: <CAFEAcA-Z6bcXW3nAqnv+CCTqy1JhZjdqJcdwHApFuUejutH+BA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jun 2020 14:45:43 +0200
Message-ID: <CAL1e-=gLnVJgCWVGBWQZdezBwAGDEpEUHf6MuaVOTvTJFiLHVw@mail.gmail.com>
Subject: Re: [PULL 0/6] MIPS queue for June 1st, 2020
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 1, 2020 at 2:21 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 1 Jun 2020 at 13:18, Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
> >
> > The following changes since commit 4ec2a1f53e8aaa22924614b64dde97321126943e:
> >
> >   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-05-30' into staging (2020-05-31 20:43:45 +0100)
> >
> > are available in the git repository at:
> >
> >   https://github.com/AMarkovic/qemu
> >
> > for you to fetch changes up to a08d60bc6c2b6469368fff3d38dd5ddd16dd36be:
> >
> >   hw/mips: fuloong2e: Set preferred page size to 16KB (2020-06-01 13:28:21 +0200)
>
> Hi; something seems to have gone wrong with your pullreq: it is
> missing the tag name after the git repository URL...
>

True. Wrong "git request-pull" command. My bad, truly sorry. Just sent
v2, since there was no problem with patches by themselves. Hopefully
it will work.

I have recently problems of various kinds related to remote work, and
changing email address(es) (again). I really hope this v2 will be good
for you.

Thanks,
Aleksandar

> thanks
> -- PMM
>

