Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD50DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 12:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE6822CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 12:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbrKFZ9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE6822CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8jGJ-0000CH-Vp
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 08:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8jFF-0007dz-16
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 08:00:37 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:33982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8jFD-0006NB-4e
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 08:00:36 -0400
Received: by mail-ej1-x630.google.com with SMTP id o23so2199565ejr.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 05:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BeYpet8h3FZobcwaRfMWyTpF6M++GL+1VVwUsX6dntU=;
 b=vbrKFZ9WL9T8wFsieeg9Zs1DP2GbkikrA5Tg/PfQh1bMXsfWWzygGMt2Zb1bINTCkK
 54xTO1rZ9xN7sPRVyTXp3j4bzUqwZG3qWYqiAe70r4Wb9EnDzCTcuNBloKi4VbmuTvvb
 N89acrZzujVBFSlPWKTPjC7xolsVKnL6iF0uJ3607wX77fSH5ZiKwl6HYQ9/WOZf8iwP
 VmfKb784eXaJ9wfc9CjIv7vq+btCpvQMsrdFEBJPE1K/mMDFgDsyh7AOkq7Bsj2ZOsJC
 fohQA8KZVYeBw4zFd9+Szy7zGCgpoxd+ALo20hkDoXfQYCN+xF/K/QoUUlnFZjko2bO8
 wy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BeYpet8h3FZobcwaRfMWyTpF6M++GL+1VVwUsX6dntU=;
 b=GPBv/7qrIrXSQru2WyCYiNyQYRUbcW0PAMcpn6PKvwwkmIXbQD7UxaPbMFt3rALo7a
 BZMgC3AqZaqqkM6wSitMLKlbCKVnsVwq3dcAiw0JPzp+eAMCQ8ymcB1lBT5iJszhPdpX
 GA/X/AurRBrJs418INZqxsdJK44mJ85yeooUYG8a2MgAEcrNHEptMkmS7Ro+WZiuBeYW
 bpJJCOy6m2X/JqFeTLl8wk0fY0zkryVJjNZ2AaDDYgqATAeit+GYr8E2EqyY4vWa+nRj
 R/3RjOoF/WvoCq7zx2LCA64C/gsZBeWCWWvu2i8yti0Imb8KiIyXawSIPovRoeaIROjD
 IZdw==
X-Gm-Message-State: AOAM53124mZN8gGi5RtRU4PfqYqqIWS6CIagOnFjX0aPkCfie95+LsQZ
 CgnHtPk4cI3WGDK1/KINVn8zqFSLnLRhkHekk+zYMg==
X-Google-Smtp-Source: ABdhPJy7J3SrOr8gaJsfqTP0jZ4bZnlHEhc+/UOaGWVL4f89ClgQ5MOOBoeMpvWp7JjMB6ef4FgSviYZhKKyCkRhvd8=
X-Received: by 2002:a17:906:b814:: with SMTP id
 dv20mr2253497ejb.4.1597924833119; 
 Thu, 20 Aug 2020 05:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <alpine.BSF.2.22.395.2003212338020.36211@zero.eik.bme.hu>
 <20200323133244.GK261260@stefanha-x1.localdomain>
 <CAFEAcA9VPgQ1MPYhcda4tdxMuhMC5R9fd6D=OVOZKRLMO8n_xw@mail.gmail.com>
 <20200820105401.GA99531@linux.fritz.box>
 <9bdbb3b9-01df-2a6b-0c82-b58ef6e0edf9@redhat.com>
In-Reply-To: <9bdbb3b9-01df-2a6b-0c82-b58ef6e0edf9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Aug 2020 13:00:21 +0100
Message-ID: <CAFEAcA9aUiu8drnUQrV9wke0qW2OJpVGcGUjR3DQO5j8Xn4gJg@mail.gmail.com>
Subject: Re: deprecation of in-tree builds
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Aug 2020 at 12:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 20/08/20 12:54, Kevin Wolf wrote:
> >> Paolo's conversion-to-Meson patchseries is about to land, so now
> >> is the time for people who would like this "automatically create
> >> a build directory and use it" behaviour to write the necessary
> >> patches. Any volunteers ?
> >>
> >> My current plan is to land the Meson series first, because it is
> >> really painful for Paolo to try to keep rebasing it as other
> >> changes to the old build system occur. This would break
> >> in-tree builds temporarily until the "automatic creation and
> >> use of a builddir" patches go in on top of it.
> >
> > Usually, our requirement is that patch series don't break anything. And
> > if something slips through, whoever broke it is supposed to fix it, not
> > whoever is affected.
>
> The Meson conversion was announced in October 2019 as breaking in-tree
> builds, and the deprecation request is from March 2020.  So I don't
> think this is a breakage but rather a widely-announced change.

No, we need to put in the back-compat for making basic in-source-tree
configure/make/make install work. There was a fair amount of discussion
of this on-list and the clear consensus was that it was widely
enough used, that it wouldn't be a huge amount of work to make it
do a behind-the-scenes creation of the buildir, and that we should
retain it.

thanks
-- PMM

