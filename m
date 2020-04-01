Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F268BC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 896C62071A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hb8jER1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896C62071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJfzu-0007Qj-Ow
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 12:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJfz9-0006tS-EP
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJfz7-0005m7-PP
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:12:58 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJfz7-0005iB-DA
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:12:57 -0400
Received: by mail-oi1-x243.google.com with SMTP id u20so17939359oic.4
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6rTdWjxxfBHqXL4GAaIiZ6TeZHsUjfkSpFGdVmkDUm8=;
 b=hb8jER1uPo7WMt3UhoZwMVBqLKg77OKJr0S3dF/tl9uE8Ay9ZYq0CArAUL7N6bfIfb
 YwuxOYKDTKKnRLJIpl3ErkM3zcdsaHSSGwtSV9lEFLVM1zipoMvVBsRO5tmX+c6TMUmI
 C/rHeCx7AJenLUceg/CFx2PAOyu6SSr79oUoe2UFnDb7THf03igbKaII8PndkKRBceQz
 ME0tvsHE+ul0PkrrZlgAykwwkJaoOaCGTqNyyksklD4h+apMMxX/wF4hThPMbreuZ4qO
 5kfyMZiLN8xradx9DfcLIUVmRRMzZZQ+c//NrrxxNoeNLcMBvPhu8A3R3yI4LLkjI3XQ
 RraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6rTdWjxxfBHqXL4GAaIiZ6TeZHsUjfkSpFGdVmkDUm8=;
 b=KWj/1dLfLf28eS5+KtLihU+IhwJ3VlQ5b2O9+jaAHlpToWA5reRIu5Bu1h87zfO7F3
 wiHW1W+fwGOFKhMnk9vbSqTl6aVpwKDo6ErfaZY2LbI79AhPjHCaB13BnhnHIfIifgw5
 zXPhfe+i3EU+xFwFK8E/qCfms+ndncT2uVSTWSaeTNOjdaghw/7A7+3x5S05amZB2dVp
 1n3/CFeE9ObFr8sgK5mQs93Zh9JsBjL7Ho4l0HABkl2U8byq+q7VyQoLzqNm4DxFAID7
 Z2A12M02JP3K/KuIoYwICc6fBJMkq2WPxBMFf19Bvppu2U4Hf9hH1lrYDAuA+Nw1IL4v
 lKcg==
X-Gm-Message-State: AGi0Pubhth/cxan3kZucLKjE2NUfFxcjNLfIVxQjbJTXLVqIYLuUeWAL
 Qq0XEdRYg3gvB6NPGWqzJGO/g944lQ5FWoR2Su4Ifg==
X-Google-Smtp-Source: APiQypIrsrlj2GN+WjPeGIfTjzIghKdO+TtVNU8/BJqWUSSj2BYSCgQGvfGWBq+AFdlsv+zj3ydLNq2lKMGV4C+a4b8=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr3266802oih.146.1585757576135; 
 Wed, 01 Apr 2020 09:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-2-vsementsov@virtuozzo.com>
 <87bloc3nmr.fsf@dusky.pond.sub.org>
 <CAFEAcA-c_gX4=Be0oMLCmQy+PWc4uEHpQatuyNQjbrZXvsv1+w@mail.gmail.com>
 <87wo6zoku0.fsf@dusky.pond.sub.org>
 <CAFEAcA-mZ5nPOoPz0kafmEjUORYQj-DvieMeWqgbFarp1_DhNg@mail.gmail.com>
 <87tv23fepa.fsf@dusky.pond.sub.org>
In-Reply-To: <87tv23fepa.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Apr 2020 16:12:44 +0000
Message-ID: <CAFEAcA82AzhV3DSO=nogJg1YLwKk3RrGPVRe85ByhFbaW=YCJQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] scripts/coccinelle: add error-use-after-free.cocci
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Denis V. Lunev" <den@openvz.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Apr 2020 at 15:44, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > On Wed, 1 Apr 2020 at 06:07, Markus Armbruster <armbru@redhat.com> wrote:
> > But then as a coccinelle script author I need to know which of
> > the options I needed are standard, which are for-this-script-only,
> > and which are just 'workflow'.
>
> If you're capable of writing a Coccinelle script that actually does what
> you want, I bet you dollars to donuts that you can decide which options
> actually affect the patch in comparably no time whatsoever ;)

I use this thing maybe once a month at most, more likely once
every three months, and the documentation is notoriously
impenetrable. I really really don't want to have to start looking in it
and guessing about how the original author ran the script, when
they could have just told me.

> If you prefer to bother your reader with your personal choices, that's
> between you and your reviewers.  Myself, I prefer less noise around the
> signal.

> If you got Coccinelle installed and know the very basics, then the
> incantation in the script should suffice to use the script, and the
> incantation in the commit message should suffice to reproduce the patch.

So I need to now look in the git log for the script to find the commit
message? Why not just put the command in the file and save steps?

> Example:
>
>     commit 4e20c1becba3fd2e8e71a2663cefb9627fd2a6e0
>     Author: Markus Armbruster <armbru@redhat.com>
>     Date:   Thu Dec 13 18:51:54 2018 +0100
>
>         block: Replace qdict_put() by qdict_put_obj() where appropriate
>
>         Patch created mechanically by rerunning:
>
>           $  spatch --sp-file scripts/coccinelle/qobject.cocci \
>                     --macro-file scripts/cocci-macro-file.h \
>                     --dir block --in-place

Yep, that command line would be great to see in the script file.

> scripts/coccinelle/qobject.cocci has no usage comment.  I doubt it needs
> one, but I'd certainly tolerate something like

    // Usage:
    // spatch --sp-file scripts/coccinelle/qobject.cocci \
    //        --macro-file scripts/cocci-macro-file.h \
    //        FILES ...

I think that should be about the minimum. I think every
.cocci file should say how it was used or is supposed to be used.
The least-effort way for the author of the script to do that is to
simply give the command line they used to run it.

> >       That's more work for the author *and* more work for the
> > reader than just "put the command line you used into the script
> > as a comment" -- so who's it benefiting?
>
> Anyone with basic Coccinelle proficiency benefits slightly from the
> reduction of noise.

How 'basic' is basic? I think that being specific is useful for
anybody who's at my level or lower (ie, can write a script, doesn't
do so often enough to be able to write a script or run spatch
without looking at documentation and cribbing from other scripts
as examples). How many people do we have at a higher level
than that for whom this is noise? 2? 3? And people who do
know Coccinelle well should have no difficulty in quickly
looking at a command line and mentally filtering out the options
that they don't feel they need.

thanks
-- PMM

