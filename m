Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F9AC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 20:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AFA920796
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 20:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHROZ1it"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFA920796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPtLn-0003E7-SR
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 16:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPtKz-0002lD-G2
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 16:13:29 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:37581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPtKx-00017A-Mq
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 16:13:29 -0400
Received: by mail-ed1-x52e.google.com with SMTP id o18so951570edq.4
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nHrs+sw0qk6HBdY1WVnVUwessOZjLY+HX9PmW9MnHY0=;
 b=aHROZ1itAZOzbhC0/dIWYDGAZdfd2zgah80+94i9sCguyJdV/DtZ+GwPHAII71Y0K4
 +3HSqIPcbPcw2qyvJLTyLSY6ffxp8gyhFQugdu4vxdgYnEZtr1MfPfff86V0H5HpBfvB
 +4EoUADzn7M1MoA8n0eZj8hqdFBQqiK0ndPHvPFPen+5nX0QTevcxS58EG7NNoRa15Pe
 jjRG/PAW1JhlKJkYbO0uCBQYCmF6bPHQEXaryUERaDU75CjWfo142Ok+5YjMr1hFyonD
 jCqALEVPm4qG3KNWZvuLmKrVTrVqHn0/qur68z/0pjGFEfwAemda/GNHqyok8wwPChdZ
 lBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nHrs+sw0qk6HBdY1WVnVUwessOZjLY+HX9PmW9MnHY0=;
 b=BMXKYdvhmUMda71z0lA81t7mVk0bop9qFLlKDms04MReMaouBZHybIZK/ALAYJejUr
 Cgf5ZH/6xe43OftDJqzsd73sp2hYGUy5igtob1H3FFN2BsjPj01IX00wVEn1xnN+at9J
 mMX3Qy9aMSJp+xbOPoIgFDarFo6ptXOWyNXLIccM+LrgkU3fLXy9SH3m9XJoGMrxKhLG
 q7AABkEt5H/psU1HH1wiXSXrJO0FX/LmX3KLt0fPMpa9WJ86+5WJpB3NXpkOu7jBipd5
 T3KJsCH3wJklsdufzKS6eP6eX0WfQXe3pA6Uq7RTdZTweimb7P8HsMHnwA88jr4Z0+Sq
 oaZg==
X-Gm-Message-State: AOAM533WFLt8mmx6NDZB2+wIsQM4XQAvld0118JmzawxijJ5eyzgQ4yt
 Erye0uvhoL2ppCz+LcSGmtYr+aNpzCiuPpTuOZe4rA==
X-Google-Smtp-Source: ABdhPJwrSu4DX9E6EaWenUMT1rL8WvriH4CunlTngSOxGyxANc6kQQA93y9weclL6Os5vrSMbT9xRtAYdewoTKkWLLo=
X-Received: by 2002:aa7:c302:: with SMTP id l2mr7593900edq.204.1602015205075; 
 Tue, 06 Oct 2020 13:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201006072947.487729-1-pbonzini@redhat.com>
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Oct 2020 21:13:13 +0100
Message-ID: <CAFEAcA8KzN=bS9vJSG6aNtVQRR3uSmmUkyOG60fD3Dm9spGCQg@mail.gmail.com>
Subject: Re: [PULL 00/37] Build system + accel + record/replay patches for
 2020-10-06
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 6 Oct 2020 at 08:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 0ac0b47c44b4be6cbce26777a1a5968cc8f025a5:
>
>   Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' into staging (2020-10-05 13:12:55 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to be52eca309788aa69dc10a8cae63e8a40de7a2f7:
>
>   tests/acceptance: add reverse debugging test (2020-10-06 08:34:50 +0200)
>
> ----------------------------------------------------------------
> * Reverse debugging (Pavel)
> * CFLAGS cleanup (Paolo)
> * ASLR fix (Mark)
> * cpus.c refactoring (Claudio)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

