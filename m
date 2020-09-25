Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBE1C4727C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6443B20BED
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4cEKLdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6443B20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLkXu-0003Ol-55
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLkVn-0002OQ-Qq
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:59:31 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:42056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLkVl-00057j-Sv
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:59:31 -0400
Received: by mail-ej1-x62f.google.com with SMTP id q13so2799100ejo.9
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yNh+RpeEUUr4EjZ7gP7rx5uAbEZvwY6eJyu2JxulUf8=;
 b=B4cEKLdgrZV7OMbo0eZG+7D9fsa9zMhBQ54gA6AYEbD8Cw1wZmJG3WIBe5DA5gZnOS
 ic6j1NwDSPiOjPgRzGTn1A7rHrBuVoPr3uNeTJkPzwhlGORYqbGa9KQ2HzN/LNSqNIFg
 6uQVIPEf72euqTMNB5l7kcduroOkaBaV/v8re2YYvcWHKOALPDySaXAKty4gdWjm2CPf
 mgbGT++2l4flHrjNbr3xoYaWmDuVfqguAlFepmk7Y/cRINBVczjH5AIjMYxJHFuX5CKP
 kXUPjJovqUumZAXLahyhSuF2do+EwOB4J6wdGxioiF5IL6Eq3a9v6aItTzUNEyVGoILY
 Dy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yNh+RpeEUUr4EjZ7gP7rx5uAbEZvwY6eJyu2JxulUf8=;
 b=mFGgq0X36SnIbmvViX9QTMBqrXNUlQXuvw8MD47eMSeXkiK+OCu5BwHihe7Go561aJ
 1ozHZn9bG+63TqGa/aBEUqGe2lljSyK7x+FNVJL89MpiHVE2f+s8YViv2XQUYReoAruH
 zBksAiyQwtFkuQEAWECCsIly3nyF7Nmf55pu3ymkzyLbB3lsYwHviCC8sjzAFxIFugml
 8uWa6SsNEYwdEfjhCt0TzB4rZojLcCTG2pHoVpKBsQnRjstjxbRrf3REWTlZ/bEwsbeu
 9WaEo56NJWqRcShCYGv69Jzj2XDR8D8T+dD8qNQpB03ksvOIVZ8+Uncbd2V+XhLN0Ejg
 nhvw==
X-Gm-Message-State: AOAM5304pfjnpTLlEi8A+tfzfN4Ry2ckXFgggzYi1MTDcSJM3V/Y67b2
 /5PEQqmTk1CtNZ9WGErZi7XYOll/4CvN4OzWPAxyqA==
X-Google-Smtp-Source: ABdhPJyzXdD4r37IXicrFuwDxCm+LaKHCDjzKcD3LpaSqOgD/WnnHWJK+vV+vGI+eVBwuahK4C6MrxRsHzNMYPVGKRg=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr2000753ejv.56.1601027967777; 
 Fri, 25 Sep 2020 02:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200923161031.69474-1-stefanha@redhat.com>
In-Reply-To: <20200923161031.69474-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Sep 2020 10:59:16 +0100
Message-ID: <CAFEAcA_+3LN9YosRh+J9puDAPWB5B1D4LvsfBpazj393-3r3iQ@mail.gmail.com>
Subject: Re: [PULL 00/13] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Sep 2020 at 17:10, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 0fc0142828b5bc965790a1c5c6e241897d3387cb:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/input-20200921-pull-request' into staging (2020-09-22 21:11:10 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to d73415a315471ac0b127ed3fad45c8ec5d711de1:
>
>   qemu/atomic.h: rename atomic_ to qatomic_ (2020-09-23 16:07:44 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> This includes the atomic_ -> qatomic_ rename that touches many files and is
> prone to conflicts.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

