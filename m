Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47513C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160B3206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJtfE46z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160B3206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHsx7-0007HZ-4A
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 13:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHsw4-0006cs-BH
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHsw2-0006g7-Vi
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:38:24 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHsw2-0006bw-Qn
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:38:22 -0400
Received: by mail-oi1-x244.google.com with SMTP id q204so9449825oia.13
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+ek7vuE0jvwEfb1ULmOSSIVtDCcD3kfXjm9vu78QMBY=;
 b=hJtfE46zwUNedwaeNZyEMKFhKbiW7SaI+iHwFEfmGhqDWLB7OE4yCaD4lJmP4JBhmw
 TEGs+Si5mr1wsZy0Rk0eS9wnDC2njCsBa3EeXvZAY9q7ocPvDRpYLmstcWokR51OvCZs
 H8bLAUrlEM1I5Se8s5YRVMYDsOneJRzHe7l3NNI9vPwl1wS5r3IDx04E9QDqN9+h/xeP
 V57UjSLmHvwZYZ4o5/rl1EZLuTgsWo8zm6vRPHHMYYCiysUdtV9b0uj8W7fBHzQfKtdd
 id4PZH3uXPmoqvI5Dwsa2lqvt0mZHh9nyj2qDm4b9jUL4ul097OVDUQmfEPca8pN/klA
 21qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+ek7vuE0jvwEfb1ULmOSSIVtDCcD3kfXjm9vu78QMBY=;
 b=cgmJETbZI2jk4AXuj5GxBUnoVxdcnYBGBuiDXVpOxHiLXYi2M8amyJ1cGDF7c3L7N3
 DGb36ktGf0B8EHpqscxNYOCOZ/Y5GbxeF8LO+/vaObTU0rmSc3AJ8faWOh7atPmqeBc/
 WQg7wfvntmzf42fHKneBrTQQxmmdgtRMXqHohIfOuZLY79AniOizingqJOhUsmt/kfxZ
 K6CCN6TN4o5RP0tnKXdzUBGv7AqFHvziai8VTSFtC5r1FTMIFyz6SaCND6VECYnN8l92
 UYhKZguDMI6BeNKlTW9zYHIkgG//X8dziLTlrwxPj2H7gJmKVLunE1QAc6Ue0CkuCXve
 MERA==
X-Gm-Message-State: ANhLgQ0jyzl5ZQgbrsyPIS/Mi//bt+4mUPtdaCfy6ugL8gKSZ95st5Zz
 kh255hAbNW5f60qCprkCjAqEJqw+gIUpBHmfDMfg9A==
X-Google-Smtp-Source: ADFU+vt5KtHlyt4H+a6zGHEqUnaasbEjGpt4UKVrpWT7VoS1Jh2e5wKWF7aKj6MfYa64Y97zXAJk5nc9u4Q5pIYc57A=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr4476212oij.48.1585330700152; 
 Fri, 27 Mar 2020 10:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200327151950.11820-1-kwolf@redhat.com>
In-Reply-To: <20200327151950.11820-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2020 17:38:08 +0000
Message-ID: <CAFEAcA99ozRtwqrTJPdyy+tfH_Cg7vYOaGQmdwEdv058dRu89A@mail.gmail.com>
Subject: Re: [PULL 0/6] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Fri, 27 Mar 2020 at 15:20, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit cfe68ae025f704f336d7dd3d1903ce37b445831d:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pull-request' into staging (2020-03-26 20:55:54 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to df74b1d3dff80983e7a30db1346a4a05847d65fa:
>
>   qcow2: Remove unused fields from BDRVQcow2State (2020-03-27 14:47:23 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Fix another case of mirror block job deadlocks
> - Minor fixes


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

