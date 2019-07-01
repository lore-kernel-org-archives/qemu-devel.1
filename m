Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04B3C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D6620881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P3v8Z0fS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D6620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7QF-0007Y8-34
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3u6-0007X6-Ri
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3u4-0001Ms-G9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:32:02 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3u2-0001LY-P6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:32:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id t76so11239510oih.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0WggpwXlDzNRUoFUK2Oir8Ae9RI3n4nXwyIR6nC4YlQ=;
 b=P3v8Z0fSwaskP6Q75nnw+a2cRSAgT8Sm8bFZl3LJ4HMcsil6Ll1g/P70Kv5A5Y3ydq
 fimNUd0sTkY1NJcbqVeknFb1VMGtg21dFljamJ42sNmU6yiOkXz//+8q7qsBtUaLmBeM
 c50rM6fuyryDDQ99p8veL6Fk0apuaKSongpBtoLSZvffiuJdwtkFgbdt2tdVKfV5asEx
 kG/nQO1lQj+IEOBJNo2O6ydb4Xu1edla1ZyTjC7l0FlnKPo/crgMk0Zt+eVX+gTkgChU
 DQKcAygNePBkLojakEPla8qjfOg/QUQoVvOsIaN0SuRhPuuIw6ZbkVwRCe1n+CltuqLL
 qwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0WggpwXlDzNRUoFUK2Oir8Ae9RI3n4nXwyIR6nC4YlQ=;
 b=XUJ8MMTs+Cbeg1I8GjbSMQ9VmGdrRLThS9GWyp0nG6byesWH3J7REpxjU12rimakxl
 TyNRQvzyvmPZmRslaP6T1RQgzrJuRLZ7jpV3+6MT3wd5+J7wut+TxlSa5fctNblynGOO
 dyIDwlPD9jAFkHpYrHzQEWtNIZs59meHzhkJO6btiXSYDZ+84W1vvCnciJNaRmkFNQtS
 h5kTr7p3McTPty8avsb2DrEiMfpv6X+c/G1ki46u9dk7XgYdFHUs2eivL0hk1MeLM86B
 bUVB2dZw8P5Jmzi1ih4UF5hx8Th6/76wcqG17q+yLzQjxjzN2vVVooPIg6aUXq92RqHe
 5idA==
X-Gm-Message-State: APjAAAUeLy4kqdcA1i4J9to/ufaKJZx5F0383Sei6qLQbl2F0wjILz69
 s7Fhfla4pwQbkaRAdu9RPTY2heeocNO6VVcn3VKj3lQIVjU=
X-Google-Smtp-Source: APXvYqyKqAllzlOXtFrs7pLk9OQB2tedJY5vDpEuQHRTJj08K4D6sqdgaZwd+gwEuNnqi0Jw/sXUtu4PCBZMaJKgUiE=
X-Received: by 2002:a05:6808:8c2:: with SMTP id k2mr218073oij.98.1562001196658; 
 Mon, 01 Jul 2019 10:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190626200252.30220-1-laurent@vivier.eu>
In-Reply-To: <20190626200252.30220-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 18:13:05 +0100
Message-ID: <CAFEAcA8PU2Tt9nXUA70vP6g6zRwROTMro16Tu+gPz_ihOimyyg@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.196
Subject: Re: [Qemu-devel] [PULL 0/4] Trivial patches patches
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019 at 21:09, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-patches-pull-request
>
> for you to fetch changes up to b827891d73778eaf962b0536f955194cf4faa424:
>
>   MAINTAINERS: Change maintership of Xen code under hw/9pfs (2019-06-26 18:30:03 +0200)
>
> ----------------------------------------------------------------
> configure improvements and fixes
> MAINTAINERS update
>
> ----------------------------------------------------------------
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

