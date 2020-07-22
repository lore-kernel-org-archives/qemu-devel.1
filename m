Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F576C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDCDE206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4jnb2hU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCDE206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDHi-0005Ux-9K
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyDGc-0004Zs-RR
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:50:34 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:42091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyDGb-0003rm-4C
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:50:34 -0400
Received: by mail-ot1-x335.google.com with SMTP id g37so1505553otb.9
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 04:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7c1GKLGh6kUcP0cXnDe1M01HYdzizw4NSpILlqyDRYA=;
 b=L4jnb2hUFm7bWdAQURCT4BedpC/uNzKyjy9GmwmFt8UcCKmRcX9hUSiaFTWeIu52GD
 XrF6Ki/IVbOgv35vLTzR5uiDwK9VZqBXeznW8me/9Afgu2k/e43RwMxBalkbkzFV8kGf
 n7JOfoy3qauV2FBlmONhHhCnW97gN7cGd2gqmnKVHIZKZoX2Xr/4Q1lAkdHmO5yGE49f
 w/bjcz8MdFJKWwzYauFfoH5UQS5d0O4+KnWkad+5ZRBJJ6bRSU4wa1QLTnfxVMR/TLwy
 MJAahsv19q8MYtQYSr8UwWwkg7jxWolVg0Vxjm+Esj8d96TbPUFiDlIt2VdFgsglodu/
 yX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7c1GKLGh6kUcP0cXnDe1M01HYdzizw4NSpILlqyDRYA=;
 b=nH17/d5FhLAHOrPGKKR2aJMKuvwmx2K2rGdi2YomqxT0mGFckh7oihnc1D/t09aKfd
 kp9CY2NnC0ZGaiA96TaQsVQwb0e+Qe0Yk8ZKr3ciW/C/0MSe5rStLhmCp9PAZYtln2LI
 mEOTiEpLy2CAKCpDvSc5qQOzuDXWMP4md0cVaqGQvlN1tYJ1IVMKTNNpAbVT+UoQIOL0
 0oWhn0hy7qf7Sbfb3XNrK7lMHZHbbng3NsfoflIdwXQxivs7RTxU/g8iI+EJr8HEmDm3
 gb/3GVEC0IkXgRzuGdKFMrUX5jPZrSSY/mpK9KPCYy47nt49upWfHftfhe/XBTyG8V2u
 EnKQ==
X-Gm-Message-State: AOAM5320yQew2sNxcSf9ALcaJnL8vMuMB2ePmTkoRnYiMe/s0cVC+U3k
 308ZDvUNfDpTGzttNgok0hA+e9bMsaN0x7/uWYbloQ==
X-Google-Smtp-Source: ABdhPJwugeOWNorb61CBK7IVT2KtpGCb0KUULCPO+GSv3h3iUu5PysMrIWkjxpMhgs+AoicQB+LbgamqXqU5vAvU7Zw=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr27887160ota.91.1595418631798; 
 Wed, 22 Jul 2020 04:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA9+9ZQY2CxZ9V4bZrkAGR5eUapbwSk6sNyFGyyd39Y=1Q@mail.gmail.com>
 <20200722093621.GA4838@linux.fritz.box>
In-Reply-To: <20200722093621.GA4838@linux.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Jul 2020 12:50:20 +0100
Message-ID: <CAFEAcA93OY0omjoYW7ofH7N6iRFHfboa1DGO1ra3qha0SasVVg@mail.gmail.com>
Subject: Re: please try to avoid sending pullreqs late on release-candidate day
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x335.google.com
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
Cc: Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jul 2020 at 10:36, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 21.07.2020 um 17:56 hat Peter Maydell geschrieben:
> > It is not helpful if everybody sends their pullrequests late
> > on the Tuesday afternoon, as there just isn't enough time in the
> > day to merge test and apply them all before I have to cut the tag.
> > Please, if you can, try to send pullrequests earlier, eg Monday.
>
> I sent the majority of my fixes for -rc1 on Friday, not the least to
> give us some time in case we get a testing failure. However, the earlier
> you send the pull request, the greater the chance that you get some new
> patches after the pull request. In this case, the patches were only
> ready Tuesday afternoon, so even sending on Monday instead of Friday
> wouldn't have helped.

Patches that arrive and are only ready Tuesday afternoon are
naturally at risk of slipping into the next RC. That's OK.
Though when we get to rc2/rc3 you should warn me when you
expect that so I can make a decision about whether it's better
to slip the rc by a day to wait for them.

> The alternative would have been letting them wait for -rc2. I suppose
> you can always says "too late" and make that decision for me, but I
> wouldn't want to unnecessarily move things to a later RC. Do you think
> we shouldn't send a pull request in case of doubt?

Mostly what I mean is "don't assume that because RC day is Tuesday
that you can send a pullreq on Tuesday and have it get into the RC".
If it turns out that you have to do that, that's not a big problem.
What is a problem is if half a dozen submaintainers all send a
pullreq at once on the Tuesday afternoon. So in the situation where
you don't anticipate anything much late arriving then send it earlier.

> Can you test multiple pull requests at once?

I could in theory I guess, but my scripting assumes one at once.

thanks
-- PMM

