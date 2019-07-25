Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93577C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC172238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pblBIhMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC172238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqe4B-0002ri-I2
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 09:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53149)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqe3z-0002T6-AM
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqe3y-0007li-0v
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:45:43 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqe3x-0007kQ-R5
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:45:41 -0400
Received: by mail-ot1-x341.google.com with SMTP id j19so13219345otq.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r7oocFUrKIbamQKM5kMA/1c6NYGP8QAL4+tp5mejrdI=;
 b=pblBIhMpRoMn74WzYK6uXDZBHaBdabX9wuvaHBPSCHUAFLK5HuSlqzx47VtGJxATXF
 ce5cjbvNI3vus1WrSaybtJvXC0s/7mzbI3uANmQK6WWgB/WKzdoCZkxG5Z2/UhivRBph
 dv+QyaELLXSumzguNvEjzZy8tZeUAaZeYTvslxdvruESWp0euuRCRBuG0ps7+y0w8y7Z
 Dsl+gY3+8k6/5vkBUuVm5cv3LJrCOgL2wd9KOgetTRG2W8TyOuMc+jUNlTPHyI8Rd2SW
 7SDRnZDXj0lt6Iocj0URUUcgEXdwvD+auTbSTg20q3OQ0YQIyh1qTgJ2k7vBMAOxzqdT
 gviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r7oocFUrKIbamQKM5kMA/1c6NYGP8QAL4+tp5mejrdI=;
 b=S1zbQdAW/4UTFq71Z8TB2oiU/4ryzESJ0ZuZmjoEpZ8hqe9w5Gcxbzl6tBxu5b1oNd
 YhPID0f+HMBmsEno4GlHLae6+QMxhd72JHOsQgSuXT1ED/rOQwZh3PCwzHS1Ll4JJAtw
 P2g4qqKVyJWnpxIilvuceleSwee2l0rZFlZCqpAmGlIsYSORngRarKTv+uC5QWkn+3pM
 8Or13Ly/I2GSBHfwa/kasitYgjRkaRGeWGh06VBMc8CDZDmnqe3HcWpCg3JBJxuOF/uY
 vN84nWc3zYfceea+iEOwd9mNwns5xXkUfXg45EQg43eNFfjeJzZMFhGMsjBmyeW3sONB
 I4MQ==
X-Gm-Message-State: APjAAAV2LTwUMVsMaccmb7OmFWvwOl5V3JI2HieZn2sXrcGnb5tMx0+n
 krq7xJbOBGcKLYEB/6800d9vjLxb3IkZOqpk3MjIAA==
X-Google-Smtp-Source: APXvYqydfdzIjCY1wt7lyjLiQN5TbYj5+eODt2s5C2j+oYe/o/lCCqP1J1OTFDO5tP03H9BvxLbU6IQt/XuMUzBnUFk=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr35582299otn.135.1564062339731; 
 Thu, 25 Jul 2019 06:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190725105724.2562-1-quintela@redhat.com>
In-Reply-To: <20190725105724.2562-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2019 14:45:29 +0100
Message-ID: <CAFEAcA9ZMrRYKDAsVOoFuWhbt6kcMwfSHU6ZsMQHVoW-N8-mEA@mail.gmail.com>
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL 0/4] Migration patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jul 2019 at 11:57, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit bf8b024372bf8abf5a9f40bfa65eeefad23ff988:
>
>   Update version for v4.1.0-rc2 release (2019-07-23 18:28:08 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/migration-pull-request
>
> for you to fetch changes up to f193bc0c5342496ce07355c0c30394560a7f4738:
>
>   migration: fix migrate_cancel multifd migration leads destination hung forever (2019-07-24 14:47:21 +0200)
>
> ----------------------------------------------------------------
> Migration pull request
>
> This series fixes problems with migration-cancel while using multifd.
> In some cases it can hang waiting in a semaphore.
>
> Please apply.
>
> ----------------------------------------------------------------
>
> Ivan Ren (3):
>   migration: fix migrate_cancel leads live_migration thread endless loop
>   migration: fix migrate_cancel leads live_migration thread hung forever
>   migration: fix migrate_cancel multifd migration leads destination hung
>     forever
>
> Juan Quintela (1):
>   migration: Make explicit that we are quitting multifd
>
>  migration/ram.c | 66 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 57 insertions(+), 9 deletions(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

