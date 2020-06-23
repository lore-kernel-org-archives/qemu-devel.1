Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F1DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF0120780
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+0FoqBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF0120780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnsVJ-0006Sh-Om
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 19:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jnsUa-0005FJ-3K
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 19:38:16 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jnsUX-0000sb-7R
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 19:38:15 -0400
Received: by mail-io1-xd41.google.com with SMTP id o5so161110iow.8
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 16:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9bYlMqHOLWYPKQBoZvSGF2HTnYsADWDiU6/R7whPhxE=;
 b=u+0FoqBE3RQDi/qoPeFJTFJHP7P7QPypUsk8GchDgUKOuxVMnGqFU+ytNnb5oM3kSv
 aHU0Sq7gnmqfijojyeF6t46kZmoadQJ9fv5f9D1gi1Wv8l8jj0o9T9dvU4jRaVfjZrZE
 nRkhe/gNx+aqVTtCY7lsSWSoizPlp3ZZAK1cGLv9IQk8NUzV4ndy/yH60FggNhGt94nG
 Mly666RlfqDfjcdBLt56LyIIvwDmqFFTeSDJrDBTgKYOZlhY6sE7ncRcQCWPXfzgNGgr
 DYnCPcsK8K/OsOQKoEP6y7tzrVBXLNbdeQ/sADi460SShS9Njk2KcCBz57FpHGnwzTks
 NacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9bYlMqHOLWYPKQBoZvSGF2HTnYsADWDiU6/R7whPhxE=;
 b=YuYuqsJjtV8I9r8A8XOX61aDr4xU6M/gYoIhBhgah7Z0lIgr3L8pZlCmADy2zQJcmx
 12RaKBPpardOZ8EUJSUAX3gaWV2oo/41RW3izzd/7NrZBRSknDf0LeolFrS8iDO3i1q4
 qHgqH5jQPvmzLqSBeYt9t6Tu30qOboBw4P50ZsLzE3olbSLHcIhnGVhWqBATlHVzmFfx
 dk8Xj8oCHfHtlTDkFuo40zNFwYV9JHckkNZcdM6Vz74TzVAHz5CAQJ+hL/lmD8lld/uV
 WJ34SqibJD9IyNsozWRGaCQg1ywWS2d7E7zqr4RzLTgLBCp8FjbEB3nZSp6xlmhe+hAh
 aUlw==
X-Gm-Message-State: AOAM532GhvaCcLsVx6PqQwAB0ZY1cjwn3Oq/8jz3HlWBZj3BLfZpKBfc
 iJoZdg6ffcH108un1aGdJgtQoGliUStrVLeQWxs=
X-Google-Smtp-Source: ABdhPJwRz9tUA17etAVRtEktrJEsqupVXz+ST6kX08Et0u52J3B+u1iS1BH5c4F9oSZPFeIzH1g4p+X0+DGu+RPlqKk=
X-Received: by 2002:a6b:6412:: with SMTP id t18mr9259666iog.175.1592955492134; 
 Tue, 23 Jun 2020 16:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
 <20200619165817.4144200-4-alistair.francis@wdc.com>
 <CAEUhbmUEREaNBXBP6a0UgAYK6dmVbGFtDu8wLGUjNXHL5mWtoA@mail.gmail.com>
 <87lfkejgjl.fsf@dusky.pond.sub.org>
In-Reply-To: <87lfkejgjl.fsf@dusky.pond.sub.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 23 Jun 2020 16:28:39 -0700
Message-ID: <CAKmqyKOtm7fLq1jUgLpvAX3srsB1cVgOJxnb5bFoCCbRNDagMw@mail.gmail.com>
Subject: Re: [PULL v2 03/32] riscv: Generalize CPU init routine for the base
 CPU
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FREEMAIL_REPLY=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 2:08 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> Bin Meng <bmeng.cn@gmail.com> writes:
>
> > Hi Alistair,
> >
> > On Sat, Jun 20, 2020 at 1:09 AM Alistair Francis
> > <alistair.francis@wdc.com> wrote:
> >>
> >> From: Bin Meng <bin.meng@windriver.com>
> >>
> >> There is no need to have two functions that have exactly the same
> >> codes for 32-bit and 64-bit base CPUs.
> >>
> >> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> >> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >> Message-id: 1591837729-27486-1-git-send-email-bmeng.cn@gmail.com
> >> Message-Id: <1591837729-27486-1-git-send-email-bmeng.cn@gmail.com>
> >
> > I noticed that patches from other people than you have the
> > "Message-id" tags, but your patch [1] does not. Is this intentional?
> >
> > (not sure why we need 2 "Message-id" tags here, with one has <> ?)
>
> We don't.  Looks like an accident.

Yeah, that must have been an accident.

>
> > Just want to know what's the best practice here.
>
> The Message-Id tag's purpose is connecting commits back to the mailing
> list.  Useful when you want to look up their review later.
>
> To get them into git, maintainers should use git-am -m to apply
> patches.  I have
>
>     [am]
>             messageid = true
>
> in my .gitconfig.
>
> Maintainers may be tempted to use git-rebase or git-cherry-pick instead
> for patches they already have in their local git (such as their own
> patches).  No good, because we don't get the Message-Id that way.

Ah, thanks for clarifying that. I was never sure. I'll be sure to not
rebase or cherry-pick my own patches in the future.

Alistair

>
> Patch submissions (as opposed to pull requests) generally do not have
> Message-Id tags in commit messages.
>
> Hope this helps!
>
> >> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> ---
> >>  target/riscv/cpu.c | 18 +++++-------------
> >>  1 file changed, 5 insertions(+), 13 deletions(-)
> >>
> >
> > [1] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06208.html
> >
> > Regards,
> > Bin
>

