Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21116C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E310A20724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dTMFxQov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E310A20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jngKk-0008Il-Sr
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jngJz-0007jR-S1
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:38:32 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:36971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jngJy-0000Ph-5f
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:38:31 -0400
Received: by mail-oi1-x233.google.com with SMTP id a3so18435397oid.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 03:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lBKZvbnnxq1MLm9rEc7bMWmmB1rapFIOk4lOYldpFb8=;
 b=dTMFxQovXdqpW4mCRKcJvas/ojG0ZTmSWV4Y7XSodzMnjS7IgEQIDSBZA8h0VP5P6C
 z8vP0C8XtRj6aVaKMJsooZXfCPMu9qYyviPL+MvMvvHIRTCxT285D4eEvf/NMizfTCBW
 Y88VcQ6xhXzS/rQpxbeJ8HDJE7JmysuRR32BccwuSX3kgH+qoqQB8MJE9P8bR3B2w8Vb
 /pleVBE3OZtRwAhwAUW9Ah/LuX2VUwApvOEEyyFx4n7ajR0YbWmFXWqWAo5zgOefrUab
 xljptUdfwaNBPvWXpOfaCOiCW3HonCulNX6arafAVnP3+/erfiNmTROoMCNUwUB/lRYu
 jUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lBKZvbnnxq1MLm9rEc7bMWmmB1rapFIOk4lOYldpFb8=;
 b=FffIFZUepYA4ACoJ1UI221ZAL8URiMz/d6UGbnkRG3lyKYACpM3I/V1oYX/uzC+elN
 opWSmliWo1Etd6cNEbqE98zl8cwBHlHjBe27cm6RbvSoKP+OgcTeQTt4geRNp9mWHj3d
 ZqFmUTSb5Gdp3BtFbsFWoDT8OijQPcBZuxbNq2wcVO5uFRewkQIU9VA7TqOQCFhlM2YU
 p/RNh8eG9N3rqLcT4d4l6ln1nTLjszK8jU7wOWnWDYKdfOyXDZmzsz/OSScPIRCS0qbb
 vAnzBBrPj0lkX33mKgs4YzvFXXbWN1q5056ITDH5ewRg7n+3y+2dqSevRkKdWCn52tN/
 r5FQ==
X-Gm-Message-State: AOAM532PJ6xowaq+bmqbWSySZImfFYDodYe5sPBQjn285AGFauFq+18p
 pqygNsiHZCjLlhcUcw8Ec3u57O1HRJIhwpZawgsKUA==
X-Google-Smtp-Source: ABdhPJwQrZQgyBI31XQaAkA0Klsv8jUQY1M60rnwdIYfibiH+95qX3ivEEvHTEihXy4R2spqJpKG3+rq+e4uH4wzBDg=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr15697471oia.163.1592908708901; 
 Tue, 23 Jun 2020 03:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200622085934.16441-1-philmd@redhat.com>
In-Reply-To: <20200622085934.16441-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2020 11:38:18 +0100
Message-ID: <CAFEAcA9+KwhNP2Ng6mi4wP+aWyOvkYTK+QqREtQD7NjnFng6gA@mail.gmail.com>
Subject: Re: [PULL 0/8] Acceptance testing patches for 2020-06-22
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x233.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jun 2020 at 10:01, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> The following changes since commit 06c4cc3660b366278bdc7bc8b6677032d7b111=
8c:
>
>   qht: Fix threshold rate calculation (2020-06-19 18:29:11 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/acceptance-testing-20200622
>
> for you to fetch changes up to b52d7e216c663ae89c65d656faf3a80b1c05737e:
>
>   tests/acceptance: record/replay tests with advcal images (2020-06-21 13=
:58:=3D
> 52 +0200)
>
> ----------------------------------------------------------------
> Acceptance tests patches
>
> - List acceptance test reviewers in MAINTAINERS
> - Record/Replay tests from Pavel Dovgalyuk
>
> Travis-CI:
> https://travis-ci.org/github/philmd/qemu/jobs/700787719
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

