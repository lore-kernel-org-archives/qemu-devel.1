Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675FEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D5320780
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RAKA1Whl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D5320780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnnBZ-0002pw-D0
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 13:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnnAM-0000vs-US
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:57:02 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:40048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnnAK-0008Fx-M4
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:57:02 -0400
Received: by mail-oi1-x22b.google.com with SMTP id t25so19581204oij.7
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=N44XawT1dX7JDmOj09FiISJWqaouX7823EUyfH6uhyY=;
 b=RAKA1Whlb5m6LWoZ9UyFob61b0ecG3YrJKipSXycJwVBo7DE4mOn7EemUosCwjIx+w
 jmhXMb3wGh9yeUBbezKMEUtZVZh1fzrVQn/CV9OJHodFJIOuCzkKVcWlqY+RWmeTr6LI
 robQXgIwKkMpEq8xq32sV++xrmwJYsNAeM4GxYeSdgMU1W6OFetkrLaBeNN+qI2km7Jr
 qh+5XAoHzlIwonZ9DCV+bZzH/7D8ktQ/YD32XSu3rJkyeoBxeW5sbYy68ru6UgxAxdqq
 hx6+hMDsrPHUbAjEWaOkMR/ACaQ7zt5MDnUkpRQk5Q2JGew7IKC1MhhqEGlVcrV9Qv1X
 p5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=N44XawT1dX7JDmOj09FiISJWqaouX7823EUyfH6uhyY=;
 b=JfHkWbqkSk/kp0bgfDO0hbe0apR0Z5Lwhl07BIaVyiYtUm6peKyXMtwT/6W/WAqITj
 OG0o2gVMXr/Zkzlwii82jA+cNS61i2Pp0iRRKT3P2RtQQS4m+wX399ewbWc4fpnc0Mdy
 A4djDCZ0LvRrUqU96QzmpmZzpI6CsO7U5LoJksyrhhJiWTOc9Br+hPoJ5YZJ4PIRUQr4
 rXproJDUpFgYtYQcPUoju/ra7a4Gbc80eWuckKtooBfa3xpzNS3SVmcZoGuZiIWr2/Co
 Muoqz6fyVansOSpoOfe6oZqU5s7BUSsx1nYwHcRDt7MAlPcF1m7knUr7n9JuTl7wKcII
 Mp5g==
X-Gm-Message-State: AOAM533ADaE3NtwXeZ1pcOhnW0kf7cB9nrHZYmmDjErRWTyTMyQVWnhM
 n48nbsHQBq+X/2iVBgQp8JBSmRl67TWMNfeYGmnmIw==
X-Google-Smtp-Source: ABdhPJy5kfho17Ph5j2+K1PEJnPfWPJUu+Xw4PfQRc8Cr+0/Gx4mM/1MuwAEBzciWr7UGD9whgXq01xLz/d+3/4WZjQ=
X-Received: by 2002:a54:4694:: with SMTP id k20mr1716033oic.146.1592935018574; 
 Tue, 23 Jun 2020 10:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200622191746.18031-1-f4bug@amsat.org>
In-Reply-To: <20200622191746.18031-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2020 18:56:47 +0100
Message-ID: <CAFEAcA98mw_K5j9qcWOXwg_Usy7QdLPj7y66uNpoenv4Lt=foA@mail.gmail.com>
Subject: Re: [PULL v2 00/15] Renesas hardware patches for 2020-06-22
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22b.google.com
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jun 2020 at 20:19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The following changes since commit 171199f56f5f9bdf1e5d670d09ef1351d8f01b=
ae:
>
>   Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-apply=
-202=3D
> 00619-3' into staging (2020-06-22 14:45:25 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/renesas-hw-20200622
>
> for you to fetch changes up to 4adbfa45cc3793fa85157a4813306618f6009f52:
>
>   docs: Document the RX target (2020-06-22 18:37:12 +0200)
>
> Since v1:
> - Fixed format-string issue on 32-bit platforms
>
> ----------------------------------------------------------------
> - Add a common entry for Renesas hardware in MAINTAINERS
> - Trivial SH4 cleanups
> - Add RX GDB simulator from Yoshinori Sato
>
> The Renesas RX target emulation was added in commit c8c35e5f51,
> these patches complete the target by adding the hardware emulation.
>
> Thank you Yoshinori for adding this code to QEMU, and your patience
> during the review process. Now your port is fully integrated.
>
> CI results:
> . https://cirrus-ci.com/build/6140199509950464
> . https://travis-ci.org/github/philmd/qemu/builds/700954881
> . https://app.shippable.com/github/philmd/qemu/runs/812/summary/console
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

