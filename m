Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCD7C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 20:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF21920738
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 20:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxCOUkle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF21920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO5U3-0004Nx-0M
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 16:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO5Qq-0002vt-W0
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 16:44:05 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:35778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO5Qo-0003bq-P2
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 16:44:04 -0400
Received: by mail-ej1-x632.google.com with SMTP id u21so10064833eja.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 13:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5oevqRAFxrqeQWPL5P+j27bB5XvzUmA/h22wi4aIPCo=;
 b=IxCOUklePeIeXsMxrgX6uDT8IWJ2XsFzwv7qinQhG06YYFpi3wdki9fFOwCSm6j6yC
 gaokS9zHGYEPizGKfEjPFt8AA6CBeVOUcr3SbSAKD7m5vCyD/oxclFcqiNWhHvohgPXc
 1Seg/dh1nTfaY7GQ3AjwIqiifnLrRlJvpwngDye1QapY7KkT5pRtScn4qecVBtnlTG2H
 ZLQf4/DZLrFxQYHGcOrELEBSNvfuFfZ3czGCcrgtRF9sbYhuKP50DVMu5FYXL1NwPzYW
 vZEeV3k8j5z0icFNiU0Y5oLE/TY9WT/kJnQKvVIeTcVGjYrUvYAfYlDZjUmfpYX2w1pp
 99Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5oevqRAFxrqeQWPL5P+j27bB5XvzUmA/h22wi4aIPCo=;
 b=Q0BBLezBiqtKYX8MfFCKDazemzGC9BsSzaaQJUNbLrztpPXQed3AFleGnbzETK90pR
 AqvF9V2FRWoGj8bBvgEvPfwGduIv8xFvixLNboEOsswxWgmukjLWICUOQ4SXucJzYcuy
 9OHjMMqJYzWdDQGMtMZ56mX85WefywNjVNUiLEucqjj9e7mE8maN8UD5hNF6q2b/CJDb
 5lA611P5FVlOBVtRZ3Q7at9hUbw1sfByyZ2AZ7Yh8H6jp8ukeu05RUj/5Y0qPZ3g64Bh
 hrjRKn3VCj57EoDoH7Uf2SBmwhNOICZD0sXDW+LvihOqYh4h+hdJfN7NSWM1toPtQ+7h
 FCbA==
X-Gm-Message-State: AOAM530A/iVD85e3V10hD7cmmDuRS9MeYwmoyyvsQv+XlNO0MpmC+dnF
 ZYqfXbu9Dt/atq4a/C7WiyM1TAhVnm+R8kAIwMGa4Q==
X-Google-Smtp-Source: ABdhPJwlTNLMjNFbGpwntkSJRQqS3zDkaMU8Qyof8MyKTuG8R7+52I1RcPPJfU1CH3KoOYQxxCp5zY9Wa2DyCl7WjEA=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr9597536ejb.382.1601585040942; 
 Thu, 01 Oct 2020 13:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201001174649.1911016-1-jsnow@redhat.com>
In-Reply-To: <20201001174649.1911016-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 21:43:50 +0100
Message-ID: <CAFEAcA8PJrX=_R+9Sb1Lb97PfPhgN+qRRjn98VxLrE6u4yjCRQ@mail.gmail.com>
Subject: Re: [PULL 0/9] Ide patches
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Oct 2020 at 18:46, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 37a712a0f969ca2df7f01182409a6c4825cebfb5:
>
>   Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' into staging (2020-10-01 12:23:19 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/jsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to 55adb3c45620c31f29978f209e2a44a08d34e2da:
>
>   ide: cancel pending callbacks on SRST (2020-10-01 13:04:16 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

