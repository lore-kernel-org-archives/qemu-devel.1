Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6E4C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 21:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114AE2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 21:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A00FZ5pF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114AE2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBlxy-0007YN-81
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 17:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBlwo-0006y6-Os
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 17:30:10 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:32885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBlwn-0001yh-2p
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 17:30:10 -0400
Received: by mail-ed1-x534.google.com with SMTP id w14so378803eds.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 14:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VqBB2TZ4VA823PcAcdvf2J67bH96SGWgrYmjP6NwlR4=;
 b=A00FZ5pFGsG5S/Z9hMnkfaHwOtuTc+hHF1a84HcgxKUaavmL//eJYKB9L6wvsaqAZf
 V4fpS4VWwLYFY84Y+Hk+yD1Zc0IiBH9wlaxxwBpHycYMFZQj3EmlPKAnh13FxYKyLde1
 qo1GGMZqySFHDoIGiw/9Twt/GLKMTZmFgRuNbVe1IV8nvu+/heeJWPItOO/hLkEUnmU0
 V0/Wn3nl58z5FJJo9o1O+k1w9tm2wDA1dB5ErZmCV2BazOVDQZgh9zM9SgZVSfayAxO1
 c6JorS6SM0jZu4MEedQu454/OsrEJ/HpIfZk5AJA4HaXovpSI2aZCb7ktjVRfimyzQBI
 o7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VqBB2TZ4VA823PcAcdvf2J67bH96SGWgrYmjP6NwlR4=;
 b=PW3sd21sIb24ya0qCl3kdlguyWO9OH6lqGEemcKzieACTlnLEJ9EJymlTKxVxP8/5v
 qIP+UD6M1WZOb6HbA84giiMo8F4p6pl7D69zj+k0lTQwZbSMjZ9eAv4JFKF7fCzCi1N0
 R80aiEg2HoI9ERGk3GxkxyYXVmG7HqaNVcG7EVVEEWHZraSwGFvfEYj8kiDnAUIYAfg/
 5S1+ALXI8XE0/JVlPVQ0+AnxKnQwmLwE+4psQ3vtaFz8EJwgpSZbPaOz7trzAo8DlrH1
 zCgIP96ul0Nr2xrNPPPQN8gp6FtFibuhZAhM4DBt33k5jTPWxlcYPzcN2A/Gv5yUTJTq
 rucA==
X-Gm-Message-State: AOAM5336PNQQtjLVaW67x+gOvUA8xnAK5ZNL2axruWutYSchkFxXxnlr
 vo5LUKXCkT0DeKfzCCutRj+RL9t9gZ44Dpbwy32/Fw==
X-Google-Smtp-Source: ABdhPJxGLd9xCe+PY3Tx/oHBTm9bm7ECTnuMbLzOx0RGnAb3WXM7ghkI7DI0r4q02WPDP9qEDEWY+oj55qKOw3XleeY=
X-Received: by 2002:aa7:de0e:: with SMTP id h14mr747369edv.146.1598650207240; 
 Fri, 28 Aug 2020 14:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200828124509.311210-1-dgilbert@redhat.com>
In-Reply-To: <20200828124509.311210-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Aug 2020 22:29:55 +0100
Message-ID: <CAFEAcA9xd7h9ZePKa49RzfmCKSpWFNZWZXdLqB1_=CwGLKBjbw@mail.gmail.com>
Subject: Re: [PULL 0/8] migration and virtiofsd queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Sergio Lopez <slp@redhat.com>,
 yezhenyu2@huawei.com, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Longpeng <longpeng2@huawei.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Aug 2020 at 13:47, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 3e39dac0354c39b4b647940e42360c6b1f3edc02:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2020-08-28 11:05:08 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20200828a
>
> for you to fetch changes up to fd9279ec9985d9c8a0b533eff24839f93695b0f4:
>
>   virtiofsd: probe unshare(CLONE_FS) and print an error (2020-08-28 13:34:52 +0100)
>
> ----------------------------------------------------------------
> Migration and virtiofsd pull 2020-08-28
>
> Migration:
>    vsock support for migration
>    minor fixes
>
> virtiofsd:
>    Disable remote posix locks by default - because we
>      never supported blocking variants and this breaks things
>    Some prep work for un/less priviliged modes
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

