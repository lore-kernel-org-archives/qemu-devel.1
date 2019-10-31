Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2385CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 11:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C4A2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 11:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X/FWW4SO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C4A2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ8bz-0004yP-27
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 07:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQ8Gn-0001iO-KH
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 07:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQ8Gm-0003Ar-2U
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 07:05:37 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQ8Gk-00034m-Db
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 07:05:35 -0400
Received: by mail-oi1-x242.google.com with SMTP id k2so4759199oij.12
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QnT5QIhCG8A17AbwIc746y8OFwVM87FRI6MEU/8NzDE=;
 b=X/FWW4SO+4srL09MkB/sbiVIYZZ/wC3zRvfhBKA9g+KLSMNl1pVf1r9R9w1IpyQzAA
 tJtqkt/M2dVZOgOyner+w14wIxngKpKFkv28KqeP3MDrjMrfSZLwlQV7UKjSY9i84ltT
 Emc+kDYqrNua1wjcndi8EelUAyfIyCylLQ2dFfGOIdjfTLlbwYCeZZKiaBpF3csuTBpN
 36Oc4xb6l8a5JMC3Ak3W0ZGva4vksXiuponPugP9/Xw/P91SmDkrx2IY8tkWQCGs+Iuf
 Z+H7cWZ9PklgOY7scEsa1LAlQRWvehkZ3wb4AL8dfWku+P/ffXc2m0itAAntMJF4cTwB
 YVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QnT5QIhCG8A17AbwIc746y8OFwVM87FRI6MEU/8NzDE=;
 b=A/0dUKqe8FOzVhDX7Phtr6D/8WNTZszrXpzXaO0x3wXBVGekYf6QOO6D5L2M/pliTY
 czazpIWV17+q12ZfsQ2I3BeSO5RsLmAwA2IpAn/YCEEuvyBsMLnhISqtYDpIegs+qXDT
 Hrl3vTvmGHBpVwYli2aZTeo/XO7nC1hr77VxEdUiXFDVwe7JAi457VIlw9v0tqq/zyQt
 6S+PLUquRLf8h8p6lf2k+cgc466s3zDSAdkhti3WDUgRTYs6U4I/nvMKsKHdeZZ5bKnI
 yDUrP3eHkPtVowC4Rr7n5awYRLG0FphHXD/B2W8BeaJVv2VddehzegMpgC4ZsixiMYyw
 hElw==
X-Gm-Message-State: APjAAAUBAMPfEvPKSl1idT5HmPXU0AfrCtLlkhaoZHw+/onOOc7LKDzA
 YYM97JlbRu53ctWUbm62gubyHk3tQ1A0dsIpZMSyqQ==
X-Google-Smtp-Source: APXvYqzYPWxPsg86s0khkcycu/NrTSAtfKyU4g+IQHjKMNnhLsGyPlgxhkXdSnceFEZn0z7EJl3gOkG9bnKr9GNfmPA=
X-Received: by 2002:a05:6808:2c6:: with SMTP id a6mr193232oid.48.1572519932779; 
 Thu, 31 Oct 2019 04:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191031100232.21992-1-alex.bennee@linaro.org>
In-Reply-To: <20191031100232.21992-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2019 11:05:21 +0000
Message-ID: <CAFEAcA_8hpDTxy0jqXnQu_VD-O2pE1R+Yqi_cjAaPSj_fpmWNg@mail.gmail.com>
Subject: Re: [PULL 0/3] a couple of CI fixes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

On Thu, 31 Oct 2019 at 10:02, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 68d8ef4ec540682c3538d4963e836e43a211dd=
17:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-tcg-plugins-281=
019-4' into staging (2019-10-30 14:10:32 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-next-311019-1
>
> for you to fetch changes up to 2ecde8b2fb046516a0f2f53fb56b86db92d6fc13:
>
>   Acceptance test: update kernel for m68k/q800 test (2019-10-31 09:58:20 =
+0000)
>
> ----------------------------------------------------------------
> Fixes to get CI green again
>
>   - fix m68k acceptance tests (Cleber)
>   - stop build breakage (Daniel)
>

