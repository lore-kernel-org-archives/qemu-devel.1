Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93868C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608132072E
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P43UWQe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608132072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJM4n-0001tO-Eu
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 14:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJM48-0001P3-0Y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJM46-0002rW-S3
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:56:47 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJM46-0002qn-FV
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:56:46 -0400
Received: by mail-ot1-x343.google.com with SMTP id 111so23189347oth.13
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 11:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9Tsa7A+OaeKh06Etq7/Y7bolYJrB8iDrm1Hs6njbGac=;
 b=P43UWQe4y3ZinWiv5HPCdk+9Gx7OqhVshk01ZrN+vjjMqRcCkw+6Rr/uB1qtmAMxKY
 kSLwEj3nsOHhEpFR4RJ4eUKRzfkrUdD8VuGUGfvUWqJNEF7JqDzBwQ9hIh6g0HXMthjX
 TRksfNbLeVPjQVRN6MyqjskvfxDe+cPWjqyXXKVg13Hx8fDRhzeBWf41qQHw6Bpic5Ss
 3IWN/6XfrhQpKZbvZp9IpnLuZP0mx4gx+VKIjqFFnERGbTJy+MUM59ODpUXa0/qPUdE3
 oC6JjlLnBxb4XzXOdFGB3SEmQxL/XGmBKxn4QNK5n9hcCH3v9V3+afCA9OABmiRQUyBf
 fUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9Tsa7A+OaeKh06Etq7/Y7bolYJrB8iDrm1Hs6njbGac=;
 b=XNon0hSD/18l8z4Bk6/rlFHJnML6OxV1Z2cWkcem7daFWhKL6KjEjaZwWUhaMH8ocg
 m20b5ZXzqDfrKyLPuuJEkgZre7S+ZK33Fe1QWMWSrTTpy/a6fci/9YebU0wK8fxB4Tf8
 tFMqqx6/qUg4z+2EZCLgO9wHE78DOVqfPcvL1Tj5t7VkRXNqeGBr3LNBbrXCa7D4TzWL
 zIFaQJJpUYeJcwVKi/5H0XGH7DJMk8i6umd5PpZZ9FRVioFvzp3jGmEfEcx5pfqXdn7N
 hq2eVRQaUrbQ6bzDBAloJyDzMB2fSExKRebZS3kLgg0B2gvC1kPlktZNWylMFQYffw1+
 zvvw==
X-Gm-Message-State: ANhLgQ0N7tVyXGrIiTfDeZvlRGVj6gf7QYBdIvaPr670empwywlxsj14
 T2uxAZWnqbmf5CbSURCFX3R+8FiKe/V5BjmOu9j03g==
X-Google-Smtp-Source: ADFU+vuXIeqOrZT+CJL6nQkoNnf4m5uhuqmKhgrfjnY/6rUVCfa1WW8drZaeorXXT66cpwXO60ZZ7gas35iI0G2TW2Y=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr13413079ota.221.1585681005302; 
 Tue, 31 Mar 2020 11:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-2-vsementsov@virtuozzo.com>
 <87bloc3nmr.fsf@dusky.pond.sub.org>
In-Reply-To: <87bloc3nmr.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2020 19:56:34 +0100
Message-ID: <CAFEAcA-c_gX4=Be0oMLCmQy+PWc4uEHpQatuyNQjbrZXvsv1+w@mail.gmail.com>
Subject: Re: [PATCH 1/6] scripts/coccinelle: add error-use-after-free.cocci
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

On Tue, 31 Mar 2020 at 10:01, Markus Armbruster <armbru@redhat.com> wrote:
> I doubt including basic spatch instructions with every script is a good
> idea.  Better explain it in one place, with proper maintenance.
> scripts/coccinelle/README?  We could be a bit more verbose there,
> e.g. to clarify required vs. suggested options.

I find it useful -- you (hopefully) get the actual command line
the original author used, rather than having to guess which
options might be significant. (eg the last one I added uses
--keep-comments --smpl-spacing --include-headers --dir target
which aren't all always used but which do all matter here for
getting the change that went in in the commit that used the script.)
Most of us use coccinelle as an occasional tool, not an
everyday one, so not having to look through the docs to figure
out the right rune is a benefit, even for the options that
we do use on pretty much every spatch run.

thanks
-- PMM

