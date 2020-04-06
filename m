Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320E2C2BA80
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 11:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01521206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 11:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRqRnfab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01521206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLQ4B-0004Dh-4Z
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 07:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLQ3Q-0003it-AQ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 07:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLQ3O-0003il-OY
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 07:36:35 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:33467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLQ3O-0003eV-JW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 07:36:34 -0400
Received: by mail-ot1-x329.google.com with SMTP id 22so14994148otf.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AgYyvnyLa2yNKdyRK6T9gIixGI46huTNHGHZpUWYlWs=;
 b=IRqRnfabfo+Uwl1pHailr4gtOU7RbC5iJg0HYesLpASwRQI/sQTe5U6KkpQwkNjeIy
 k9MLMkH6vh0Tg1eCUsTkI7Phd6vDES3HJ6HEXxyj+btmSGVbwukTf7tOLwQ03f6ZE07G
 +d1YD0Dy+5cMalu6n06lzoZa8UxntkSYP1hMoxAaRS95loTiQRU6eaTzcHqvajJOJMvF
 PCBfggrQjJE9sdfUTwjA291+mJgKSYrQ2E+qSx3cKA10QrlZKQxj/6jwomDqrxWhxCM1
 P2r1og40h/gJY5ae05ypA4pKRlliKHEmrzAndTaRY5xey33mP6XJiFgecm4f1a/8CK+Z
 D2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AgYyvnyLa2yNKdyRK6T9gIixGI46huTNHGHZpUWYlWs=;
 b=qhMuobDRw6QJ9YF9WubH/SQ8mmGmNvL1wjqZyAoDXKRlrPydbYH6dVTKV/+ruKsN69
 wSvnuHbpNR0tce7sD8ZBhYTDAMPn1RAr74qqhZlYcbHlAhD2tlXEuZ+hcGpujvxLRZoG
 tfmUxQdcfGbZcq6yDTv4e0XzdybehhTBCAIHGcIqdyX/1+iwZUDdzvYYkdC+yIvaQgZ7
 MTzU3AATb8QAyfzIijNsfBqYNRqMq/v0b7gFG/Odr30bdRrLW+1HsRVyhGrZiSNa/NmS
 hc/SEcO6hopE22PFXZ9tGpMHelxHD7YtgFrcyhmkErEQDlJkCb2sStwUMMqTWjx9sPRs
 ZW2Q==
X-Gm-Message-State: AGi0PuZ+X/NNoHe7NMoVma79gqgvptbOuzxdKXeR4O1y8fUDjyqk6LDL
 jrLX1AsmLonNveWBzX0RCq5/VAuc37r2LBdmcdNm6Q==
X-Google-Smtp-Source: APiQypJ/XnFAu4yDAF0EMPy0MLvSWpZYTsuAvUKH3tGtNx5Z+UmTNNgxRauPeWdPdKuad/lVPVJw6HU8jX4kjSAGVtU=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr16199075ota.221.1586172993341; 
 Mon, 06 Apr 2020 04:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200404122416.1837-1-armbru@redhat.com>
In-Reply-To: <20200404122416.1837-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Apr 2020 12:36:22 +0100
Message-ID: <CAFEAcA82X1-j=ncq86ORdDWOFA6r09Q4c6K3gm1j8REYBc+k4Q@mail.gmail.com>
Subject: Re: [PULL 0/3] Error reporting patches for 2020-04-04
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 4 Apr 2020 at 13:25, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 146aa0f104bb3bf88e43c4082a0bfc4bbda4fbd8:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-04-03 15:30:11 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2020-04-04
>
> for you to fetch changes up to 6a4a38530e70f3917a58d71d4d08e28bd8146015:
>
>   qga/commands-posix: fix use after free of local_err (2020-04-04 14:15:24 +0200)
>
> ----------------------------------------------------------------
> Error reporting patches for 2020-04-04
>
> ----------------------------------------------------------------
> Vladimir Sementsov-Ogievskiy (3):
>       scripts/coccinelle: add error-use-after-free.cocci
>       dump/win_dump: fix use after free of err
>       qga/commands-posix: fix use after free of local_err


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

