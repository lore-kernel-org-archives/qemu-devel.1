Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401CBC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 13:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFBE23C1A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 13:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R75TUoRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFBE23C1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFdei-0001Ai-G8
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 09:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFde3-0000lC-Ag
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 09:26:47 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:34048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFde1-0007Dy-LF
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 09:26:47 -0400
Received: by mail-ej1-x632.google.com with SMTP id gr14so21382169ejb.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 06:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BrDgtbFYiuOjZGJZ0nzc5qAuTVSAVTdeMqDO+6qAthg=;
 b=R75TUoRLFKZF/J6xAHwJmJHEx8J+oQALHmU+TzCJbtX9NMPt05QPCE+gbDFi5OtA66
 phZH4MFY0QJq9GQ2hz2EQVSn24U/SUflGJtN4lQAsSMnQvgB4vg3Dlh6IXcmTLH0s9/v
 yz8CBT6Xp7C8oEigOWGhfYTYx0B/FP2t6eJyxXpU+CvoKL3DQSbg1sYDPh9O+NTS/nkA
 r3gOiaBQxQ7F7IR3DJ4UM3QsSGBNl+mxDVwg95Z7y/581R8/FlzOJN9cNrxuxcDyouRh
 hsAKC1dUHXEaOEgd6PexDZQw314gt+aI5oxuQQGMM8CY9rZ07suG+VCSWkvVXwmD/uau
 yxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BrDgtbFYiuOjZGJZ0nzc5qAuTVSAVTdeMqDO+6qAthg=;
 b=MZGb8rlXR6JV5QeuHMgGueqzNLi0Vwc72kDxp0eJlWMy9/aEyH1WBXCGF9jzmGgmTR
 wMzZ4InRmiPpC9qkDefoQAkVXdXVek/rbf3AFL+ZteNWTYPK6LeidFkWRGze/j+rkQiA
 TJT7pcBhZRo2zJ+dzXMqXzPfnYLlY5hrfb8XubLDQxEzyAHGnPAWcCI5LqRI2vW3xVOn
 e7MNPFrxxdsgIfxbIAq60fB4xCifieY64UKDib7Q11RLKqis4JubkdAbcLXJrQMQZr/i
 xVz1bJaqyl2X9TTeJd8ssjaD0vU870RITQGbPcRByjp9yiNpRQEEnQ1o1jYUntk6WSe7
 LokA==
X-Gm-Message-State: AOAM533g0WAgt3kOwsEHGKFQAk9OkgMjOZckfCVewGKtTgtHov+OXufs
 PpRymL5fGdUYJp1mD1wa8Dav0J+P+lv3+cxjqKShMQ==
X-Google-Smtp-Source: ABdhPJzHi+LBpLyUOa2HSUItVhhc9vil4uo+aLBHMSvmU4x5Ua7RzOHW2x3m7OvN3rUxeu7GckoMu2I+/fE7QHsDI6w=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr8559122ejv.56.1599571603795; 
 Tue, 08 Sep 2020 06:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200908094408.27091-1-pbonzini@redhat.com>
In-Reply-To: <20200908094408.27091-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2020 14:26:32 +0100
Message-ID: <CAFEAcA8JZhrxNgayLaCGqQiGLhybvXo7qrXDUpVmkrX5FmjV5A@mail.gmail.com>
Subject: Re: [PULL v5 00/46] Next round of Meson bugfixes and cleanups
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Sep 2020 at 10:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit e11bd71f89649da3cff439c030d2ccac0cc914e3:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-09-07' into staging (2020-09-07 16:51:00 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to ef6a0d6e3927464de67f70cb13abbfe67361e0c9:
>
>   docs: update build system documentation (2020-09-08 07:21:55 +0200)
>
> ----------------------------------------------------------------
> meson related:
> * convert unit tests
> * bugfixes for mtest2make
> * miscellaneous bugfixes
> * dead code removal and configure cleanups
> * oss-fuzz fixes
> * msys fixes


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

